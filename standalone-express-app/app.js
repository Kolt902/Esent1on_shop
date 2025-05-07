/**
 * Супер простой Express.js сервер
 * Не имеет зависимостей от других файлов проекта
 */

const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware для логирования
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// Простые API эндпоинты
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/api/test', (req, res) => {
  res.json({ message: 'API работает!' });
});

// Статическая HTML страница
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Standalone Express App</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <style>
        body {
          font-family: Arial, sans-serif;
          margin: 0;
          padding: 30px;
          line-height: 1.6;
          color: #333;
        }
        .container {
          max-width: 800px;
          margin: 0 auto;
          background-color: #f9f9f9;
          padding: 20px;
          border-radius: 5px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1 {
          color: #2c3e50;
          margin-top: 0;
        }
        .info {
          background-color: #e8f4f8;
          padding: 15px;
          border-radius: 4px;
          margin-bottom: 20px;
        }
        .api-list {
          background-color: #f5f5f5;
          padding: 15px;
          border-radius: 4px;
        }
        code {
          background-color: #eee;
          padding: 2px 4px;
          border-radius: 3px;
          font-family: monospace;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Standalone Express App</h1>
        
        <div class="info">
          <p><strong>Статус:</strong> Работает</p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Окружение:</strong> ${process.env.NODE_ENV || 'development'}</p>
          <p><strong>Время сервера:</strong> ${new Date().toLocaleString()}</p>
        </div>
        
        <div class="api-list">
          <h2>Доступные API эндпоинты:</h2>
          <ul>
            <li><code>/healthcheck</code> - Проверка здоровья сервера</li>
            <li><code>/api/test</code> - Тестовый API эндпоинт</li>
          </ul>
        </div>
      </div>
    </body>
    </html>
  `);
});

// Запуск сервера
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});