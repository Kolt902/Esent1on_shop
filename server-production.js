#!/usr/bin/env node

/**
 * Минимальный сервер для Railway без зависимости от Vite
 * Этот файл специально создан без импортов dev-зависимостей
 */

import express from 'express';
import http from 'http';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';
import { Pool } from '@neondatabase/serverless';
import ws from 'ws';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
process.env.NODE_ENV = 'production';

// Конфигурация NeonDB
import { neonConfig } from '@neondatabase/serverless';
neonConfig.webSocketConstructor = ws;

// Создаем Express приложение
const app = express();
app.use(express.json());

// Проверка здоровья для Railway
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok' });
});

// Создаем HTTP сервер
const httpServer = createServer(app);

// Создаем WebSocket сервер
const wss = new WebSocketServer({ server: httpServer, path: '/ws' });

// Обработка WebSocket соединений
wss.on('connection', (socket) => {
  console.log('WebSocket client connected');
  
  socket.on('message', (message) => {
    try {
      const data = JSON.parse(message.toString());
      console.log('Received WebSocket message:', data);
      
      // Сюда можно добавить логику обработки сообщений
      
      // Отправляем эхо обратно
      if (socket.readyState === WebSocketServer.OPEN) {
        socket.send(JSON.stringify({ 
          type: 'echo', 
          data: data,
          timestamp: new Date().toISOString()
        }));
      }
    } catch (error) {
      console.error('Error processing WebSocket message:', error);
    }
  });
  
  socket.on('close', () => {
    console.log('WebSocket client disconnected');
  });
});

// Регистрируем обработчик для API маршрутов
app.get('/api/categories', async (req, res) => {
  try {
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    const client = await pool.connect();
    const result = await client.query(`
      SELECT DISTINCT category FROM products ORDER BY category
    `);
    const categories = result.rows.map(row => row.category);
    client.release();
    res.json({ categories });
  } catch (error) {
    console.error('Ошибка при получении категорий:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

app.get('/api/brands', async (req, res) => {
  try {
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    const client = await pool.connect();
    const result = await client.query(`
      SELECT DISTINCT brand FROM products ORDER BY brand
    `);
    const brands = result.rows.map(row => row.brand);
    client.release();
    res.json({ brands });
  } catch (error) {
    console.error('Ошибка при получении брендов:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

app.get('/api/products', async (req, res) => {
  try {
    const { category, brand, style, gender } = req.query;
    
    console.log(`API запрос с фильтрами: категория=${category}, бренд=${brand}, стиль=${style}, пол=${gender}`);
    
    let query = 'SELECT * FROM products';
    const conditions = [];
    const params = [];
    
    if (category) {
      conditions.push('category = $' + (params.length + 1));
      params.push(category);
    }
    
    if (brand) {
      conditions.push('brand = $' + (params.length + 1));
      params.push(brand);
    }
    
    if (style) {
      conditions.push('style @> ARRAY[$' + (params.length + 1) + ']::text[]');
      params.push(style);
    }
    
    if (gender) {
      conditions.push('gender = $' + (params.length + 1));
      params.push(gender);
    }
    
    if (conditions.length > 0) {
      query += ' WHERE ' + conditions.join(' AND ');
    }
    
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    const client = await pool.connect();
    const result = await client.query(query, params);
    client.release();
    
    res.json({ products: result.rows });
  } catch (error) {
    console.error('Ошибка при получении товаров:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Маршрут для входа и регистрации пользователей через Telegram
app.post('/api/auth/telegram', (req, res) => {
  try {
    // В production будем считать что все хорошо
    res.json({ success: true, user: { id: 1, username: "user", isAdmin: false } });
  } catch (error) {
    console.error('Ошибка аутентификации:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Маршрут для проверки телеграм бота
app.get('/api/telegram/bot-info', async (req, res) => {
  try {
    const token = process.env.TELEGRAM_BOT_TOKEN;
    if (!token) {
      return res.status(500).json({ error: 'Токен бота не настроен' });
    }
    
    const response = await fetch(`https://api.telegram.org/bot${token}/getMe`);
    const data = await response.json();
    
    if (data.ok) {
      const { id, first_name, username, can_join_groups, can_read_all_group_messages } = data.result;
      res.json({ 
        success: true, 
        bot: { 
          id, 
          name: first_name, 
          username, 
          can_join_groups, 
          can_read_all_group_messages 
        } 
      });
    } else {
      res.status(500).json({ error: 'Не удалось получить информацию о боте', details: data.description });
    }
  } catch (error) {
    console.error('Ошибка при проверке бота:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// Проверка администратора (заглушка)
app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
});

// Раздаем статические файлы из директории 'public'
// В Railway корневая директория будет /app
const publicDir = fs.existsSync('/app/public') 
  ? '/app/public' 
  : path.resolve(__dirname, 'public');

console.log(`Serving static files from: ${publicDir}`);
app.use(express.static(publicDir));

// Для всех остальных запросов отдаем index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(publicDir, 'index.html'));
});

// Функция для проверки базы данных
async function checkDatabaseConnection() {
  try {
    if (!process.env.DATABASE_URL) {
      console.error('DATABASE_URL не задан. Приложению требуется база данных PostgreSQL.');
      return false;
    }
    
    console.log('Проверка подключения к базе данных...');
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    
    const client = await pool.connect();
    console.log('Подключение к базе данных успешно!');
    
    // Проверка существования таблиц
    const tableCheck = await client.query(`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'users'
      );
    `);
    
    if (tableCheck.rows[0].exists) {
      console.log('Таблица users найдена в базе данных.');
    } else {
      console.warn('Внимание: таблица users не найдена в базе данных!');
    }
    
    client.release();
    return true;
  } catch (error) {
    console.error('Ошибка при подключении к базе данных:', error);
    return false;
  }
}

// Запускаем сервер
async function startServer() {
  // Проверяем подключение к базе данных
  await checkDatabaseConnection();
  
  // Запускаем сервер
  httpServer.listen(PORT, '0.0.0.0', () => {
    console.log(`Сервер запущен в ${process.env.NODE_ENV} режиме на порту ${PORT}`);
    console.log(`Используется упрощенная версия сервера для Railway`);
  });
}

startServer();