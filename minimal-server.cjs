#!/usr/bin/env node

/**
 * Экстремально минималистичный сервер для Railway
 * Абсолютно никаких зависимостей, даже от Express
 */

const http = require('http');
const fs = require('fs');

// Простейший сервер HTTP
const server = http.createServer((req, res) => {
  console.log(`Получен запрос: ${req.method} ${req.url}`);
  
  // Проверка здоровья - всегда отвечаем OK
  if (req.url === '/healthcheck' || req.url === '/health' || req.url === '/ping') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', timestamp: new Date().toISOString() }));
    return;
  }
  
  // Root страница
  if (req.url === '/' || req.url === '/index.html') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Esention Shop</title>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <script src="https://telegram.org/js/telegram-web-app.js"></script>
          <style>
            body {
              font-family: Arial, sans-serif;
              margin: 0;
              padding: 20px;
              text-align: center;
              background-color: #f8f9fa;
            }
            .container {
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
              background: white;
              border-radius: 10px;
              box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
              color: #333;
              margin-bottom: 20px;
            }
            .info {
              margin: 20px 0;
              padding: 15px;
              background: #e9f5ff;
              border-radius: 5px;
            }
            button {
              background: linear-gradient(45deg, #7e57c2, #2196f3);
              color: white;
              border: none;
              padding: 10px 20px;
              border-radius: 5px;
              cursor: pointer;
              font-size: 16px;
              margin: 10px;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Esention Shop</h1>
            <p>Сервер успешно запущен и работает!</p>
            
            <div class="info">
              <p><strong>Время сервера:</strong> ${new Date().toLocaleString()}</p>
              <p><strong>Окружение:</strong> ${process.env.NODE_ENV || 'development'}</p>
              <p><strong>Порт:</strong> ${process.env.PORT || '8080'}</p>
            </div>
            
            <button id="test-telegram">Проверить Telegram WebApp</button>
            <button id="test-api">Проверить API</button>
            
            <div id="result" style="margin-top: 20px; padding: 10px; background: #f5f5f5; border-radius: 5px;"></div>
          </div>
          
          <script>
            // Проверить интеграцию с Telegram WebApp
            document.getElementById('test-telegram').addEventListener('click', function() {
              const resultDiv = document.getElementById('result');
              
              if (window.Telegram && window.Telegram.WebApp) {
                try {
                  window.Telegram.WebApp.ready();
                  window.Telegram.WebApp.expand();
                  
                  resultDiv.innerHTML = 'Telegram WebApp успешно инициализирован.<br>' +
                    'Версия: ' + window.Telegram.WebApp.version + '<br>' +
                    'Платформа: ' + window.Telegram.WebApp.platform;
                } catch (e) {
                  resultDiv.innerHTML = 'Ошибка при инициализации Telegram WebApp: ' + e.message;
                }
              } else {
                resultDiv.innerHTML = 'Telegram WebApp не найден. Возможно, вы открыли страницу не в Telegram.';
              }
            });
            
            // Проверить работу API
            document.getElementById('test-api').addEventListener('click', async function() {
              const resultDiv = document.getElementById('result');
              resultDiv.innerHTML = 'Отправка запроса к API...';
              
              try {
                const response = await fetch('/api');
                const data = await response.json();
                resultDiv.innerHTML = 'API ответ: ' + JSON.stringify(data);
              } catch (e) {
                resultDiv.innerHTML = 'Ошибка при вызове API: ' + e.message;
              }
            });
            
            // Автоматически инициализируем Telegram WebApp если доступен
            if (window.Telegram && window.Telegram.WebApp) {
              window.Telegram.WebApp.ready();
              window.Telegram.WebApp.expand();
              console.log('Telegram WebApp автоматически инициализирован');
            }
          </script>
        </body>
      </html>
    `);
    return;
  }
  
  // API endpoint
  if (req.url === '/api') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      success: true,
      message: 'API работает',
      serverTime: new Date().toISOString(),
      env: process.env.NODE_ENV || 'development'
    }));
    return;
  }
  
  // Обработка CORS preflight запросов
  if (req.method === 'OPTIONS') {
    res.writeHead(200, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    });
    res.end();
    return;
  }
  
  // Статус сервера
  if (req.url === '/status') {
    const uptime = process.uptime();
    const memoryUsage = process.memoryUsage();
    
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      status: 'running',
      uptime: uptime,
      uptimeFormatted: `${Math.floor(uptime / 3600)}h ${Math.floor((uptime % 3600) / 60)}m ${Math.floor(uptime % 60)}s`,
      memoryUsage: {
        rss: `${Math.round(memoryUsage.rss / 1024 / 1024)} MB`,
        heapTotal: `${Math.round(memoryUsage.heapTotal / 1024 / 1024)} MB`,
        heapUsed: `${Math.round(memoryUsage.heapUsed / 1024 / 1024)} MB`
      },
      env: {
        nodeEnv: process.env.NODE_ENV,
        port: process.env.PORT
      }
    }));
    return;
  }
  
  // Telegram webhook
  if (req.url === '/telegram/webhook') {
    let body = '';
    
    req.on('data', chunk => {
      body += chunk.toString();
    });
    
    req.on('end', () => {
      console.log('Получен webhook от Telegram:', body);
      
      try {
        const update = JSON.parse(body);
        
        // Простая обработка команды /start
        if (update && update.message && update.message.text === '/start' && process.env.TELEGRAM_BOT_TOKEN) {
          const chatId = update.message.chat.id;
          const webAppUrl = process.env.WEB_APP_URL || 'https://esentioshop-production-up.up.railway.app';
          
          // Отправляем ответ
          const telegramApiUrl = `https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/sendMessage`;
          const messageData = {
            chat_id: chatId,
            text: 'Добро пожаловать в Esention Shop! Нажмите кнопку ниже, чтобы открыть магазин:',
            reply_markup: {
              inline_keyboard: [
                [{ text: 'Открыть магазин', web_app: { url: webAppUrl } }]
              ]
            }
          };
          
          fetch(telegramApiUrl, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(messageData)
          }).then(response => {
            console.log('Сообщение отправлено в Telegram');
          }).catch(error => {
            console.error('Ошибка при отправке сообщения в Telegram:', error);
          });
        }
      } catch (e) {
        console.error('Ошибка при обработке webhook от Telegram:', e);
      }
      
      res.writeHead(200);
      res.end('OK');
    });
    
    return;
  }
  
  // Все остальные пути - 404
  res.writeHead(404, { 'Content-Type': 'text/html' });
  res.end(`
    <html>
      <head>
        <title>Страница не найдена</title>
        <meta charset="utf-8">
        <style>
          body { 
            font-family: Arial, sans-serif; 
            text-align: center; 
            padding: 50px;
          }
          h1 { color: #333; }
          a { color: #2196f3; }
        </style>
      </head>
      <body>
        <h1>404 - Страница не найдена</h1>
        <p>Запрошенный путь: ${req.url}</p>
        <a href="/">Вернуться на главную</a>
      </body>
    </html>
  `);
});

// Настройка порта
const PORT = process.env.PORT || 8080;

// Запуск сервера
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Минимальный сервер запущен на порту ${PORT}`);
  console.log(`NODE_ENV: ${process.env.NODE_ENV || 'не установлен'}`);
  console.log(`WEB_APP_URL: ${process.env.WEB_APP_URL || 'не установлен'}`);
  
  // Установка webhook для Telegram
  if (process.env.TELEGRAM_BOT_TOKEN && process.env.WEB_APP_URL) {
    const webhookUrl = `${process.env.WEB_APP_URL}/telegram/webhook`;
    console.log(`Установка webhook для Telegram: ${webhookUrl}`);
    
    fetch(`https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/setWebhook`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url: webhookUrl })
    })
    .then(response => response.json())
    .then(data => {
      console.log('Результат установки webhook:', data);
    })
    .catch(error => {
      console.error('Ошибка при установке webhook:', error);
    });
  }
});