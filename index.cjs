#!/usr/bin/env node

/**
 * Супер простой автономный сервер для Railway с использованием CommonJS
 */

const express = require('express');
const http = require('http');
const path = require('path');
const fs = require('fs');

// Создаем Express приложение
const app = express();
app.use(express.json());

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
process.env.NODE_ENV = 'production';

// Диагностическая информация
console.log('===== MINIMAL SERVER (COMMONJS) =====');
console.log('Working directory: ' + process.cwd());
console.log('__dirname: ' + __dirname);
console.log('Files in directory:');
try {
  fs.readdirSync(process.cwd()).forEach(file => {
    console.log(`- ${file}`);
  });
} catch (err) {
  console.error('Error listing directory:', err);
}

// Найти директорию с клиентскими файлами
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

// Проверка здоровья для Railway
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok' });
});

// Поддержка Telegram Mini App инициализации
app.post('/telegram-init', (req, res) => {
  console.log('Received Telegram WebApp init data');
  res.json({ status: 'ok', telegramInitReceived: true });
});

// API заглушки
app.get('/api/categories', (req, res) => {
  res.json({ categories: ['sneakers', 'hoodies', 'tshirts', 'pants'] });
});

app.get('/api/brands', (req, res) => {
  res.json({ brands: ['Nike', 'Adidas', 'Jordan', 'Puma', 'New Balance'] });
});

app.get('/api/styles', (req, res) => {
  res.json({ styles: ['streetwear', 'casual', 'sport', 'luxury'] });
});

app.get('/api/products', (req, res) => {
  res.json({ products: [] });
});

app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
});

// Раздаем статические файлы
console.log(`Serving static files from: ${staticDir}`);
app.use(express.static(staticDir));

// Для всех остальных запросов отдаем index.html или заглушку
app.get('*', (req, res) => {
  const indexPath = path.join(staticDir, 'index.html');
  
  if (fs.existsSync(indexPath)) {
    res.sendFile(indexPath);
  } else {
    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>Esention Store - API Server</title>
          <script src="https://telegram.org/js/telegram-web-app.js"></script>
          <style>
            body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
            .container { max-width: 800px; margin: 0 auto; }
            h1 { color: #333; }
            .status { padding: 15px; background: #f5f5f5; border-radius: 5px; }
            .status-ok { color: green; }
            .telegram-widget { margin-top: 20px; padding: 15px; background: #f0f8ff; border-radius: 5px; }
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
            <div class="telegram-widget">
              <h2>Telegram Mini App</h2>
              <p>Для корректной работы, пожалуйста откройте приложение через Telegram.</p>
              <div id="telegram-info"></div>
            </div>
          </div>
          <script>
            // Проверяем инициализацию Telegram Mini App
            document.addEventListener('DOMContentLoaded', function() {
              const infoElement = document.getElementById('telegram-info');
              if (window.Telegram && window.Telegram.WebApp) {
                infoElement.innerHTML = '<p style="color: green;">Telegram Mini App инициализирован успешно!</p>';
                
                // Отправляем данные инициализации на сервер
                fetch('/telegram-init', {
                  method: 'POST',
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: JSON.stringify({ 
                    initDataUnsafe: window.Telegram.WebApp.initDataUnsafe,
                    version: window.Telegram.WebApp.version
                  })
                })
                .then(response => response.json())
                .then(data => {
                  console.log('Telegram init data sent to server');
                })
                .catch(error => {
                  console.error('Error sending Telegram init data:', error);
                });
              } else {
                infoElement.innerHTML = '<p style="color: orange;">Telegram Mini App не инициализирован. Возможно, вы открыли страницу напрямую, а не через Telegram.</p>';
              }
            });
          </script>
        </body>
      </html>
    `);
  }
});

// Запускаем сервер
const server = http.createServer(app);
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен в ${process.env.NODE_ENV} режиме на порту ${PORT}`);
});