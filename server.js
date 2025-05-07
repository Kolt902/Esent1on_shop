#!/usr/bin/env node

/**
 * Автономный сервер для Railway в CommonJS формате
 * Не имеет зависимостей от других файлов проекта
 */

const express = require('express');
const http = require('http');
const path = require('path');
const fs = require('fs');
const { Pool } = require('@neondatabase/serverless');
const ws = require('ws');
const { WebSocketServer } = require('ws');

// Настройка базовых путей и переменных
const __dirname = process.cwd();

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
process.env.NODE_ENV = 'production';

// Конфигурация NeonDB
const { neonConfig } = require('@neondatabase/serverless');
neonConfig.webSocketConstructor = ws;

// Вывод диагностической информации
console.log('===== STANDALONE SERVER =====');
console.log('Working directory: ' + process.cwd());
console.log('NODE_ENV: ' + process.env.NODE_ENV);
console.log('PORT: ' + PORT);
console.log('DATABASE_URL available: ' + !!process.env.DATABASE_URL);
console.log('TELEGRAM_BOT_TOKEN available: ' + !!process.env.TELEGRAM_BOT_TOKEN);

// Выводим список файлов в текущей директории для диагностики
console.log('Files in current directory:');
try {
  const files = fs.readdirSync(process.cwd());
  files.forEach(file => {
    console.log(`- ${file}`);
  });
} catch (err) {
  console.error('Error listing directory:', err);
}

// Найти директорию с собранными статическими файлами
let staticDir = './public';
if (!fs.existsSync(staticDir)) {
  console.log(`Directory ${staticDir} not found, looking for alternatives...`);
  
  const alternatives = [
    '/app/public',
    './dist/public',
    '/app/dist/public',
    './client/dist',
    '/app/client/dist'
  ];
  
  for (const dir of alternatives) {
    if (fs.existsSync(dir)) {
      staticDir = dir;
      console.log(`Found static files in: ${dir}`);
      break;
    }
  }
}

// Создаем Express приложение
const app = express();
app.use(express.json());

// Проверка здоровья для Railway
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok' });
});

// Создаем HTTP сервер
const httpServer = http.createServer(app);

// Создаем WebSocket сервер
const wss = new WebSocketServer({ server: httpServer, path: '/ws' });

// Обработка WebSocket соединений
wss.on('connection', (socket) => {
  console.log('WebSocket client connected');
  
  socket.on('message', (message) => {
    try {
      const data = JSON.parse(message.toString());
      console.log('Received WebSocket message:', data);
      
      // Отправляем эхо обратно
      if (socket.readyState === 1) { // 1 = OPEN
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

// Регистрируем обработчики для API маршрутов

// 1. Категории
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

// 2. Бренды
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

// 3. Стили
app.get('/api/styles', async (req, res) => {
  try {
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    const client = await pool.connect();
    const result = await client.query(`
      SELECT DISTINCT unnest(style) as style FROM products ORDER BY style
    `);
    const styles = result.rows.map(row => row.style);
    client.release();
    res.json({ styles });
  } catch (error) {
    console.error('Ошибка при получении стилей:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// 4. Товары
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

// 5. Один товар
app.get('/api/products/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    const pool = new Pool({ connectionString: process.env.DATABASE_URL });
    const client = await pool.connect();
    const result = await client.query('SELECT * FROM products WHERE id = $1', [id]);
    client.release();
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Товар не найден' });
    }
    
    res.json({ product: result.rows[0] });
  } catch (error) {
    console.error('Ошибка при получении товара:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// 6. Регистрация/вход через Telegram
app.post('/api/auth/telegram', async (req, res) => {
  try {
    const { telegramData } = req.body;
    
    if (!telegramData) {
      return res.status(400).json({ error: 'Отсутствуют данные Telegram' });
    }
    
    // В production будем считать что все хорошо
    res.json({ 
      success: true, 
      user: { 
        id: 1, 
        username: telegramData.username || 'user', 
        isAdmin: false 
      } 
    });
  } catch (error) {
    console.error('Ошибка аутентификации:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// 7. Проверка токена бота
app.get('/api/telegram/bot-info', async (req, res) => {
  try {
    const token = process.env.TELEGRAM_BOT_TOKEN;
    if (!token) {
      return res.status(500).json({ error: 'Токен бота не настроен' });
    }
    
    try {
      const https = require('https');
      
      // Используем стандартный https модуль вместо fetch
      const makeRequest = () => {
        return new Promise((resolve, reject) => {
          const url = `https://api.telegram.org/bot${token}/getMe`;
          https.get(url, (resp) => {
            let data = '';
            resp.on('data', (chunk) => {
              data += chunk;
            });
            resp.on('end', () => {
              resolve(JSON.parse(data));
            });
          }).on("error", (err) => {
            reject(err);
          });
        });
      };
      
      const data = await makeRequest();
      
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
      console.error('Ошибка при запросе к API Telegram:', error);
      res.status(500).json({ error: 'Ошибка при проверке бота' });
    }
  } catch (error) {
    console.error('Ошибка при проверке бота:', error);
    res.status(500).json({ error: 'Ошибка сервера' });
  }
});

// 8. Проверка админа (заглушка)
app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
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

// Раздаем статические файлы (если есть)
console.log(`Serving static files from: ${staticDir}`);
app.use(express.static(staticDir));

// Для всех остальных запросов отдаем index.html (или заглушку, если файл не найден)
app.get('*', (req, res) => {
  const indexPath = path.join(staticDir, 'index.html');
  
  if (fs.existsSync(indexPath)) {
    res.sendFile(indexPath);
  } else {
    // Отдаем простую HTML-страницу как заглушку
    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>Esention Store - API Server</title>
          <style>
            body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
            .container { max-width: 800px; margin: 0 auto; }
            h1 { color: #333; }
            .status { padding: 15px; background: #f5f5f5; border-radius: 5px; }
            .status-ok { color: green; }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Esention Store - API Server</h1>
            <p>Этот сервер предоставляет API для Telegram Mini App Esention Store.</p>
            <div class="status">
              <p><strong>Статус:</strong> <span class="status-ok">API Сервер работает</span></p>
              <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
            </div>
          </div>
        </body>
      </html>
    `);
  }
});

// Запускаем сервер
async function startServer() {
  // Проверяем подключение к базе данных
  await checkDatabaseConnection();
  
  // Запускаем сервер
  httpServer.listen(PORT, '0.0.0.0', () => {
    console.log(`Сервер запущен в ${process.env.NODE_ENV} режиме на порту ${PORT}`);
  });
}

startServer();