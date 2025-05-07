/**
 * Абсолютно минимальный сервер для Railway
 * Без дополнительных модулей и зависимостей
 */

const http = require('http');
const fs = require('fs');
const path = require('path');

// Базовая конфигурация
const PORT = process.env.PORT || 8080;
console.log('Минимальный сервер запущен на порту', PORT);
console.log('NODE_ENV:', process.env.NODE_ENV || 'не установлен');
console.log('WEB_APP_URL:', process.env.WEB_APP_URL || 'не установлен');

// Обработчик запросов
const server = http.createServer((req, res) => {
  console.log(`Получен запрос: ${req.method} ${req.url}`);
  
  // Проверка здоровья для Railway
  if (req.url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }

  // Проверка статуса сервера
  if (req.url === '/status') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      status: 'online',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development',
      webAppUrl: process.env.WEB_APP_URL || null
    }));
    return;
  }
  
  // Основная страница или любой другой запрос
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Esention - Диагностика сервера</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      color: #333;
    }
    h1 {
      color: #000;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
    }
    .status-panel {
      background: #f5f5f5;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
    }
    .status-ok {
      color: green;
      font-weight: bold;
    }
    .code {
      background: #f1f1f1;
      padding: 2px 5px;
      border-radius: 3px;
      font-family: monospace;
    }
    .btn {
      display: inline-block;
      background: #4CAF50;
      color: white;
      padding: 8px 16px;
      text-decoration: none;
      border-radius: 4px;
      margin-top: 10px;
    }
    .btn:hover {
      background: #45a049;
    }
  </style>
</head>
<body>
  <h1>Esention Store - Диагностика сервера</h1>
  
  <div class="status-panel">
    <p><strong>Статус сервера:</strong> <span class="status-ok">Работает</span></p>
    <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
    <p><strong>Среда:</strong> ${process.env.NODE_ENV || 'development'}</p>
    <p><strong>WebApp URL:</strong> ${process.env.WEB_APP_URL || 'не установлен'}</p>
  </div>
  
  <h2>Тестирование Telegram WebApp</h2>
  <p>Используйте этот мини-скрипт для тестирования Telegram WebApp:</p>
  
  <div id="telegram-test-result">Проверка Telegram WebApp...</div>
  
  <p>Диагностические страницы:</p>
  <ul>
    <li><a href="/healthcheck" class="btn">Проверка здоровья</a></li>
    <li><a href="/status" class="btn">Статус сервера</a></li>
  </ul>
  
  <script>
    // Проверка наличия Telegram Web App
    const telegramResult = document.getElementById('telegram-test-result');
    
    try {
      if (window.Telegram && window.Telegram.WebApp) {
        telegramResult.innerHTML = '<span class="status-ok">Telegram WebApp доступен! Версия: ' + 
          window.Telegram.WebApp.version + '</span>';
      } else {
        telegramResult.innerText = 'Telegram WebApp не обнаружен. Возможно, вы не в Telegram или скрипт не загрузился.';
      }
    } catch (err) {
      telegramResult.innerText = 'Ошибка при проверке Telegram WebApp: ' + err.message;
    }
  </script>
</body>
</html>
  `);
});

// Запуск сервера
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер успешно запущен на порту ${PORT}`);
});