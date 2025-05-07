/**
 * Прямой запускаемый сервер для Railway без каких-либо зависимостей от Vite
 * CommonJS версия (с расширением .cjs)
 */

const express = require('express');
const http = require('http');
const path = require('path');
const fs = require('fs');
const { Pool } = require('@neondatabase/serverless');
const WebSocket = require('ws');

// Настройка для Neon Database
if (process.env.DATABASE_URL) {
  console.log('Database URL найден, настраиваем подключение к базе данных');
}

// Создаем Express приложение
const app = express();
app.use(express.json());

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
const NODE_ENV = process.env.NODE_ENV || 'development';
const WEB_APP_URL = process.env.WEB_APP_URL || '';

console.log(`===== DIRECT SERVER (RAILWAY) =====`);
console.log(`NODE_ENV: ${NODE_ENV}`);
console.log(`WEB_APP_URL: ${WEB_APP_URL}`);
console.log(`Рабочая директория: ${process.cwd()}`);

// Пытаемся подключиться к базе данных
async function checkDatabaseConnection() {
  if (!process.env.DATABASE_URL) {
    console.log('WARNING: DATABASE_URL не установлен, будет использоваться демонстрационный режим');
    return false;
  }

  try {
    console.log('Проверка подключения к базе данных...');
    
    const pool = new Pool({ 
      connectionString: process.env.DATABASE_URL,
    });
    
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    client.release();
    
    console.log('Подключение к базе данных успешно!', result.rows[0]);
    return true;
  } catch (err) {
    console.error('Ошибка подключения к базе данных:', err.message);
    return false;
  }
}

// Поиск директории со статическими файлами
function findStaticDir() {
  // Сначала проверим стандартные директории
  const directories = [
    './public',
    './dist/public',
    './dist',
    './client/dist'
  ];
  
  for (const dir of directories) {
    if (fs.existsSync(dir)) {
      console.log(`Найдена директория со статикой: ${dir}`);
      return dir;
    }
  }
  
  // Если ничего не нашли, пробуем поискать index.html
  console.log('Стандартные директории не найдены, ищем index.html...');
  
  const possibleIndexPaths = [
    './public/index.html',
    './dist/public/index.html',
    './dist/index.html',
    './client/dist/index.html',
    './index.html'
  ];
  
  for (const indexPath of possibleIndexPaths) {
    if (fs.existsSync(indexPath)) {
      console.log(`Найден index.html в ${indexPath}`);
      return path.dirname(indexPath);
    }
  }
  
  console.warn('ВНИМАНИЕ: Не удалось найти директорию со статическими файлами');
  return '.';
}

// Настройка маршрутов API
function setupApiRoutes() {
  // Заглушка для проверки здоровья сервера (Railway Health Check)
  app.get('/healthcheck', (req, res) => {
    res.status(200).json({ status: 'ok' });
  });
  
  // Заглушки для API
  app.get('/api/categories', (req, res) => {
    res.json({ categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] });
  });
  
  app.get('/api/brands', (req, res) => {
    res.json({ brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'] });
  });
  
  app.get('/api/styles', (req, res) => {
    res.json({ styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'] });
  });
  
  app.get('/api/products', (req, res) => {
    res.json({ products: [] });
  });
  
  app.get('/api/admin/check', (req, res) => {
    res.json({ isAdmin: false });
  });
}

// Запуск сервера
async function startServer() {
  // Проверяем подключение к базе данных
  const dbConnected = await checkDatabaseConnection();
  console.log(`Статус базы данных: ${dbConnected ? 'подключена' : 'не подключена'}`);
  
  // Находим директорию со статическими файлами
  const staticDir = findStaticDir();
  
  // Настраиваем API маршруты
  setupApiRoutes();
  
  // Раздаем статические файлы
  console.log(`Раздаем статические файлы из директории: ${staticDir}`);
  app.use(express.static(staticDir));
  
  // Для всех остальных маршрутов отдаем index.html
  app.get('*', (req, res) => {
    const indexPath = path.join(staticDir, 'index.html');
    
    if (fs.existsSync(indexPath)) {
      res.sendFile(indexPath);
    } else {
      // Если index.html не найден, отдаем заглушку
      res.status(200).send(`
        <!DOCTYPE html>
        <html lang="ru">
        <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Esention - Модный магазин</title>
          <style>
            body {
              font-family: 'Arial', sans-serif;
              margin: 0;
              padding: 20px;
              background: #f8f9fa;
              color: #333;
            }
            .container {
              max-width: 800px;
              margin: 0 auto;
              background: white;
              padding: 20px;
              border-radius: 10px;
              box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            h1 {
              color: #000;
              border-bottom: 2px solid #f0f0f0;
              padding-bottom: 10px;
            }
            .status {
              margin-top: 20px;
              padding: 15px;
              background: #e9f5e9;
              border-radius: 5px;
            }
            .status.error {
              background: #f9e9e9;
            }
            .status-ok {
              color: #28a745;
              font-weight: bold;
            }
            .message {
              margin: 20px 0;
              line-height: 1.6;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Esention Store</h1>
            <div class="message">
              <p>Сервер Esention Store успешно запущен и работает в режиме ${NODE_ENV}.</p>
              <p>Этот сервер обслуживает Telegram Mini App для модного магазина Esention.</p>
            </div>
            <div class="status">
              <p><strong>Статус сервера:</strong> <span class="status-ok">Онлайн</span></p>
              <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
              <p><strong>База данных:</strong> ${dbConnected ? 'Подключена' : 'Не подключена'}</p>
              <p><strong>WebApp URL:</strong> ${WEB_APP_URL || 'Не установлен'}</p>
            </div>
          </div>
        </body>
        </html>
      `);
    }
  });
  
  // Создаем HTTP сервер и запускаем его
  const httpServer = http.createServer(app);
  
  httpServer.listen(PORT, '0.0.0.0', () => {
    console.log(`Сервер запущен на порту ${PORT}`);
    console.log(`Сервер успешно запущен и готов принимать запросы!`);
  });
  
  return httpServer;
}

// Запускаем сервер
startServer().catch(err => {
  console.error('Ошибка при запуске сервера:', err);
  process.exit(1);
});