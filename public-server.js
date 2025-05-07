/**
 * Максимально простой и стабильный сервер для Railway
 * Создан специально для решения проблемы "Application failed to respond"
 */

const http = require('http');
const fs = require('fs');
const path = require('path');

// Базовые настройки
const PORT = process.env.PORT || 8080;

console.log('=== ESENTION STORE MINIMAL SERVER ===');
console.log(`Запуск минимального сервера...`);
console.log(`Порт: ${PORT}`);
console.log(`Окружение: ${process.env.NODE_ENV || 'development'}`);

// Создаем HTTP-сервер
const server = http.createServer((req, res) => {
  const url = req.url;
  
  console.log(`${req.method} ${url}`);
  
  // Добавляем CORS-заголовки для всех ответов
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  // Поддержка OPTIONS запросов для CORS
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }
  
  // Обработка healthcheck
  if (url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }
  
  // Отдаем статическую HTML-страницу
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Esention Store</title>
      <style>
        body {
          font-family: 'Arial', sans-serif;
          background-color: #f8f9fa;
          color: #333;
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          height: 100vh;
          text-align: center;
        }
        .container {
          max-width: 600px;
          padding: 20px;
          background-color: white;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
          color: #000;
          margin-bottom: 10px;
        }
        .logo {
          font-size: 48px;
          margin-bottom: 20px;
        }
        .status {
          display: inline-block;
          padding: 5px 10px;
          background-color: #4CAF50;
          color: white;
          border-radius: 4px;
          margin: 10px 0;
        }
        .info {
          background-color: #f5f5f5;
          padding: 15px;
          border-radius: 4px;
          margin: 20px 0;
          text-align: left;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="logo">👕</div>
        <h1>Esention Store</h1>
        <div class="status">Сервер работает</div>
        
        <p>Минимальная версия сервера успешно запущена на Railway!</p>
        
        <div class="info">
          <p><strong>Версия:</strong> Минимальный стабильный сервер</p>
          <p><strong>Время запуска:</strong> ${new Date().toLocaleString()}</p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Окружение:</strong> ${process.env.NODE_ENV || 'development'}</p>
        </div>
      </div>
    </body>
    </html>
  `);
});

// Обработка ошибок
server.on('error', (err) => {
  console.error(`Ошибка сервера: ${err.message}`);
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Минимальный сервер запущен на порту ${PORT}`);
  console.log(`Сервер готов принимать запросы!`);
});