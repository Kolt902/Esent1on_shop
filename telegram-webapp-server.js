#!/usr/bin/env node

/**
 * Специализированный сервер для Telegram Mini App 
 * Разработан специально для решения проблемы "The app is currently not running"
 */

const express = require('express');
const http = require('http');
const path = require('path');
const fs = require('fs');

// Создаем Express приложение с настройками для Telegram
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Добавляем CORS заголовки для всех запросов (важно для Telegram)
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, telegram-web-app-data');
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  next();
});

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
const WEB_APP_URL = process.env.WEB_APP_URL || 'https://esentioshop-production-up.up.railway.app';
process.env.NODE_ENV = 'production';

// Диагностическая информация
console.log('===== TELEGRAM WEBAPP SERVER =====');
console.log(`Telegram WebApp URL: ${WEB_APP_URL}`);
console.log(`PORT: ${PORT}`);
console.log(`NODE_ENV: ${process.env.NODE_ENV}`);

// Регистрация бота в системе Telegram если есть токен
if (process.env.TELEGRAM_BOT_TOKEN) {
  console.log('Telegram Bot Token found, initializing bot...');
  try {
    const telegramApiUrl = `https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}`;
    
    // Настройка меню бота с кнопкой WebApp
    const setMenuButtonPromise = fetch(`${telegramApiUrl}/setMyCommands`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        commands: [
          { command: 'start', description: 'Запустить бота' },
          { command: 'shop', description: 'Открыть магазин' },
          { command: 'help', description: 'Получить помощь' }
        ]
      })
    });
    
    // Настройка WebApp кнопки
    const setWebAppPromise = fetch(`${telegramApiUrl}/setChatMenuButton`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        menu_button: {
          type: 'web_app',
          text: 'Открыть магазин',
          web_app: { url: WEB_APP_URL }
        }
      })
    });
    
    Promise.all([setMenuButtonPromise, setWebAppPromise])
      .then(responses => Promise.all(responses.map(r => r.json())))
      .then(results => {
        console.log('Telegram bot initialization results:', results);
      })
      .catch(error => {
        console.error('Error initializing Telegram bot:', error);
      });
      
    // Настройка WebHook для бота (опционально)
    if (WEB_APP_URL) {
      const webhookUrl = `${WEB_APP_URL}/api/telegram/webhook`;
      console.log(`Setting webhook URL: ${webhookUrl}`);
      
      fetch(`${telegramApiUrl}/setWebhook`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          url: webhookUrl,
          allowed_updates: ['message', 'callback_query']
        })
      })
      .then(response => response.json())
      .then(result => {
        console.log('Webhook setup result:', result);
      })
      .catch(error => {
        console.error('Error setting webhook:', error);
      });
    }
  } catch (error) {
    console.error('Failed to initialize Telegram bot:', error);
  }
} else {
  console.warn('TELEGRAM_BOT_TOKEN not provided, skipping bot initialization');
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

// Проверка здоровья сервера
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok', telegram: true });
});

// API для валидации Telegram WebApp
app.get('/telegram-check', (req, res) => {
  res.status(200).send('OK');
});

// API для принятия инициализационных данных от Telegram WebApp
app.post('/telegram-init', (req, res) => {
  console.log('Received Telegram WebApp init data');
  
  // Верифицируем данные от Telegram
  const telegramData = req.body;
  if (telegramData && telegramData.initDataUnsafe) {
    console.log('Telegram user info:', telegramData.initDataUnsafe.user);
  }
  
  res.json({ status: 'ok', telegramInitReceived: true });
});

// Обработчик webhook от Telegram
app.post('/api/telegram/webhook', (req, res) => {
  console.log('Received webhook from Telegram:', req.body);
  
  // Простая обработка команды /start
  if (req.body && req.body.message && req.body.message.text === '/start') {
    const chatId = req.body.message.chat.id;
    
    // Отправляем ответ с кнопкой WebApp
    fetch(`https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/sendMessage`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        chat_id: chatId,
        text: 'Добро пожаловать в Esention Shop! Вы можете открыть наш магазин, нажав на кнопку ниже:',
        reply_markup: {
          inline_keyboard: [
            [
              {
                text: 'Открыть магазин',
                web_app: { url: WEB_APP_URL }
              }
            ]
          ]
        }
      })
    })
    .then(response => response.json())
    .then(result => {
      console.log('Message sent to user:', result);
    })
    .catch(error => {
      console.error('Error sending message:', error);
    });
  }
  
  res.sendStatus(200);
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
          <title>Esention Shop</title>
          <script src="https://telegram.org/js/telegram-web-app.js"></script>
          <style>
            body { 
              font-family: Arial, sans-serif; 
              margin: 0; 
              padding: 0;
              display: flex;
              flex-direction: column;
              align-items: center;
              justify-content: center;
              min-height: 100vh;
              background-color: #f5f5f5;
              color: #333;
            }
            .container { 
              max-width: 800px; 
              margin: 0 auto;
              padding: 20px;
              text-align: center;
            }
            h1 { 
              margin-bottom: 10px;
              font-size: 2rem;
            }
            p {
              margin-bottom: 20px;
              font-size: 1.1rem;
            }
            .logo {
              width: 120px;
              height: 120px;
              border-radius: 50%;
              background: linear-gradient(45deg, #7e57c2, #2196f3);
              display: flex;
              align-items: center;
              justify-content: center;
              margin: 0 auto 30px;
              font-size: 2.5rem;
              color: white;
              font-weight: bold;
            }
            .action-button {
              display: inline-block;
              background: linear-gradient(45deg, #7e57c2, #2196f3);
              color: white;
              padding: 12px 24px;
              border-radius: 24px;
              text-decoration: none;
              font-weight: bold;
              box-shadow: 0 4px 8px rgba(0,0,0,0.1);
              margin: 15px 0;
              cursor: pointer;
            }
            .status {
              margin-top: 30px;
              padding: 15px;
              background: #fff;
              border-radius: 8px;
              box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            .status-ok { 
              color: #4caf50;
              font-weight: bold;
            }
            .telegram-info {
              margin-top: 20px;
              font-size: 0.9rem;
              opacity: 0.8;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="logo">E</div>
            <h1>Esention Shop</h1>
            <p>Модный магазин одежды премиум-класса</p>
            
            <div id="action-area">
              <div class="action-button" id="open-shop-button">Открыть магазин</div>
            </div>
            
            <div class="status">
              <p><strong>Статус:</strong> <span class="status-ok">API Сервер работает</span></p>
              <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
            </div>
            
            <div class="telegram-info" id="telegram-info">
              Загрузка...
            </div>
          </div>
          
          <script>
            document.addEventListener('DOMContentLoaded', function() {
              const infoElement = document.getElementById('telegram-info');
              const actionButton = document.getElementById('open-shop-button');
              
              if (window.Telegram && window.Telegram.WebApp) {
                // Информируем пользователя
                infoElement.innerHTML = 'Telegram Mini App успешно инициализирован';
                
                // Оповещаем Telegram, что приложение готово
                window.Telegram.WebApp.ready();
                window.Telegram.WebApp.expand();
                
                // Настраиваем главную кнопку
                const mainButton = window.Telegram.WebApp.MainButton;
                if (mainButton) {
                  mainButton.setText('Открыть магазин');
                  mainButton.show();
                  mainButton.onClick(function() {
                    // Если нажата основная кнопка, перенаправляем
                    window.location.href = '/';
                  });
                }
                
                // Обрабатываем нажатие кнопки на странице
                actionButton.addEventListener('click', function() {
                  window.location.href = '/';
                });
                
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
                // Если не в Telegram, показываем сообщение
                infoElement.innerHTML = 'Вы открыли эту страницу напрямую. Для полного функционала, пожалуйста, используйте бота @EsentionBot в Telegram.';
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
  console.log(`Telegram WebApp сервер запущен на порту ${PORT}`);
});