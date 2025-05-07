/**
 * Сверхпростой Express сервер для Railway
 * Используем популярный фреймворк с минимальной конфигурацией
 */

// Используем только критически важные модули
const express = require('express');
const path = require('path');
const fs = require('fs');

// Создаем Express приложение
const app = express();
const PORT = process.env.PORT || 3000;

// Логирование запросов
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// CORS middleware для Telegram
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  
  if (req.method === 'OPTIONS') {
    return res.sendStatus(204);
  }
  next();
});

// Health check для Railway
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok', uptime: process.uptime() });
});

// API заглушки
app.get('/api/categories', (req, res) => {
  res.json({ categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] });
});

app.get('/api/brands', (req, res) => {
  res.json({ brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy'] });
});

app.get('/api/products', (req, res) => {
  res.json({ products: [] });
});

app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
});

// Обработка всех остальных запросов - отдаем базовую страницу
app.get('*', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Esention Store</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          text-align: center;
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          min-height: 100vh;
          background-color: #111;
          color: #fff;
        }
        .container {
          max-width: 600px;
          margin: 0 auto;
          padding: 20px;
        }
        h1 {
          font-size: 32px;
          margin-bottom: 20px;
        }
        .status {
          display: inline-block;
          background: #4CAF50;
          color: white;
          padding: 8px 16px;
          border-radius: 4px;
          margin: 10px 0;
        }
        .info {
          background: rgba(255,255,255,0.1);
          border-radius: 8px;
          padding: 15px;
          text-align: left;
          margin-top: 20px;
        }
        a {
          color: #4CAF50;
          text-decoration: none;
        }
        a:hover {
          text-decoration: underline;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Esention Store</h1>
        <div class="status">Сервер Express успешно запущен</div>
        <p>Минимальный Express сервер для Railway работает.</p>
        
        <div class="info">
          <p><strong>Статус:</strong> Онлайн</p>
          <p><strong>Время запуска:</strong> ${new Date().toLocaleString()}</p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Режим:</strong> ${process.env.NODE_ENV || 'development'}</p>
          <p><strong>Платформа:</strong> ${process.platform}</p>
          <p><strong>Node.js:</strong> ${process.version}</p>
        </div>
        
        <p style="margin-top: 30px;">
          <a href="/healthcheck">Проверить статус сервера</a>
        </p>
        <p>
          <a href="/api/categories">API: Категории</a> | 
          <a href="/api/brands">API: Бренды</a> | 
          <a href="/api/products">API: Продукты</a>
        </p>
      </div>
    </body>
    </html>
  `);
});

// Обработка ошибок
app.use((err, req, res, next) => {
  console.error(`Ошибка: ${err.message}`);
  res.status(500).send('Произошла ошибка на сервере');
});

// Запускаем сервер
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Express сервер запущен на порту ${PORT}`);
});