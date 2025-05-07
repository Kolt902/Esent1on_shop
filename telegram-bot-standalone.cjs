/**
 * Standalone Telegram Bot Server для Railway
 * Этот файл не имеет никаких зависимостей кроме Node.js stdlib
 */

const http = require('http');
const https = require('https');
const querystring = require('querystring');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

// Конфигурация
const PORT = process.env.PORT || 8080;
const BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const WEB_APP_URL = process.env.WEB_APP_URL || 'https://esentioshop-production-up.up.railway.app';

console.log(`=== TELEGRAM BOT STANDALONE SERVER ===`);
console.log(`Порт: ${PORT}`);
console.log(`Токен бота: ${BOT_TOKEN ? 'Установлен' : 'Отсутствует'}`);
console.log(`Web App URL: ${WEB_APP_URL}`);

// Базовые функции для работы с Telegram API
function callTelegramApi(method, params = {}) {
  return new Promise((resolve, reject) => {
    if (!BOT_TOKEN) {
      console.error(`Ошибка: TELEGRAM_BOT_TOKEN не установлен!`);
      reject(new Error('BOT_TOKEN не установлен'));
      return;
    }

    const data = querystring.stringify(params);
    
    const options = {
      hostname: 'api.telegram.org',
      port: 443,
      path: `/bot${BOT_TOKEN}/${method}`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': data.length
      }
    };

    const req = https.request(options, (res) => {
      let responseData = '';
      
      res.on('data', (chunk) => {
        responseData += chunk;
      });
      
      res.on('end', () => {
        try {
          const response = JSON.parse(responseData);
          resolve(response);
        } catch (error) {
          reject(new Error(`Ошибка парсинга JSON: ${error.message}`));
        }
      });
    });

    req.on('error', (error) => {
      reject(error);
    });

    req.write(data);
    req.end();
  });
}

// Установка команд бота для меню
async function setupBotCommands() {
  try {
    console.log('Установка команд бота...');
    
    const commands = [
      { command: 'start', description: 'Запустить бота и открыть магазин' },
      { command: 'help', description: 'Получить справку' },
      { command: 'shop', description: 'Открыть магазин' }
    ];
    
    const result = await callTelegramApi('setMyCommands', {
      commands: JSON.stringify(commands)
    });
    
    console.log('Результат установки команд:', result);
    return result;
  } catch (error) {
    console.error('Ошибка при установке команд бота:', error);
    return null;
  }
}

// Настройка кнопки меню
async function setupMenuButton() {
  try {
    console.log('Настройка кнопки меню...');
    
    const result = await callTelegramApi('setChatMenuButton', {
      menu_button: JSON.stringify({
        type: 'web_app',
        text: 'Открыть магазин',
        web_app: { url: WEB_APP_URL }
      })
    });
    
    console.log('Результат настройки кнопки меню:', result);
    return result;
  } catch (error) {
    console.error('Ошибка при настройке кнопки меню:', error);
    return null;
  }
}

// Обработка входящих сообщений
async function handleUpdate(update) {
  if (!update || !update.message) return;
  
  const { message } = update;
  const chatId = message.chat.id;
  
  console.log(`Получено сообщение от ${message.from.username || message.from.first_name}: ${message.text}`);
  
  // Обработка команды /start
  if (message.text === '/start' || message.text === '/shop') {
    await callTelegramApi('sendMessage', {
      chat_id: chatId,
      text: 'Добро пожаловать в Esention Store! Нажмите кнопку ниже, чтобы открыть магазин.',
      reply_markup: JSON.stringify({
        inline_keyboard: [
          [
            {
              text: '🛍️ Открыть магазин',
              web_app: { url: WEB_APP_URL }
            }
          ]
        ]
      })
    });
  } 
  // Обработка команды /help
  else if (message.text === '/help') {
    await callTelegramApi('sendMessage', {
      chat_id: chatId,
      text: 'Esention Store - модный онлайн-магазин одежды.\n\nДоступные команды:\n/start - Запустить бота\n/shop - Открыть магазин\n/help - Получить справку'
    });
  }
  // Для всех остальных сообщений
  else {
    await callTelegramApi('sendMessage', {
      chat_id: chatId,
      text: 'Используйте команду /shop, чтобы открыть магазин.'
    });
  }
}

// Проверка доступности Telegram API
async function checkTelegramApi() {
  try {
    console.log('Проверка подключения к Telegram API...');
    
    const result = await callTelegramApi('getMe');
    
    if (result && result.ok) {
      console.log(`Бот успешно подключен! Имя: ${result.result.first_name}, Username: @${result.result.username}`);
      return true;
    } else {
      console.error('Ошибка подключения к Telegram API:', result);
      return false;
    }
  } catch (error) {
    console.error('Ошибка при проверке Telegram API:', error);
    return false;
  }
}

// Удаление вебхука
async function deleteWebhook() {
  try {
    console.log('Удаление вебхука...');
    const result = await callTelegramApi('deleteWebhook');
    console.log('Результат удаления вебхука:', result);
    return result;
  } catch (error) {
    console.error('Ошибка при удалении вебхука:', error);
    return null;
  }
}

// Запуск long polling
async function startPolling() {
  console.log('Запуск Long Polling...');
  
  let offset = 0;
  
  // Функция для получения обновлений
  async function getUpdates() {
    try {
      const updates = await callTelegramApi('getUpdates', {
        offset,
        timeout: 30,
        allowed_updates: JSON.stringify(['message', 'callback_query'])
      });
      
      if (updates && updates.ok && updates.result.length > 0) {
        console.log(`Получено ${updates.result.length} обновлений`);
        
        // Обрабатываем каждое обновление
        for (const update of updates.result) {
          await handleUpdate(update);
          offset = update.update_id + 1;
        }
      }
      
      // Продолжаем цикл
      setTimeout(getUpdates, 1000);
      
    } catch (error) {
      console.error('Ошибка при получении обновлений:', error);
      // В случае ошибки повторяем попытку через некоторое время
      setTimeout(getUpdates, 5000);
    }
  }
  
  // Запускаем получение обновлений
  getUpdates();
}

// HTTP сервер
const server = http.createServer((req, res) => {
  const url = req.url;
  
  // Проверка здоровья для Railway
  if (url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }
  
  // Информационная страница
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Esention Store - Telegram Bot</title>
      <style>
        body {
          font-family: 'Arial', sans-serif;
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
        .info {
          background: #f5f5f5;
          padding: 20px;
          border-radius: 8px;
          margin-bottom: 20px;
        }
        .success {
          color: green;
          font-weight: bold;
        }
        .error {
          color: red;
          font-weight: bold;
        }
        a {
          display: inline-block;
          background: #4CAF50;
          color: white;
          text-decoration: none;
          padding: 10px 15px;
          border-radius: 4px;
          margin-top: 10px;
        }
      </style>
    </head>
    <body>
      <h1>Esention Store - Telegram Bot</h1>
      
      <div class="info">
        <p><strong>Статус сервера:</strong> <span class="success">Работает</span></p>
        <p><strong>Порт:</strong> ${PORT}</p>
        <p><strong>Режим:</strong> ${process.env.NODE_ENV || 'development'}</p>
        <p><strong>Токен бота:</strong> ${BOT_TOKEN ? '<span class="success">Установлен</span>' : '<span class="error">Отсутствует</span>'}</p>
        <p><strong>WebApp URL:</strong> ${WEB_APP_URL}</p>
        <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
      </div>
      
      <p>Этот сервер обслуживает Telegram-бота для магазина Esention Store. Он работает в режиме Long Polling и не требует установки вебхука.</p>
      
      <p>Для использования магазина, найдите бота в Telegram и отправьте команду /start.</p>
      
      <a href="/healthcheck">Проверка здоровья</a>
    </body>
    </html>
  `);
});

// Инициализация бота
async function initBot() {
  if (!BOT_TOKEN) {
    console.warn('ВНИМАНИЕ: TELEGRAM_BOT_TOKEN не установлен! Бот не будет работать.');
    return;
  }
  
  try {
    // Проверяем подключение к Telegram API
    const apiAvailable = await checkTelegramApi();
    
    if (!apiAvailable) {
      console.error('Не удалось подключиться к Telegram API. Бот не будет работать.');
      return;
    }
    
    // Удаляем вебхук, чтобы использовать long polling
    await deleteWebhook();
    
    // Настраиваем команды бота и кнопку меню
    await setupBotCommands();
    await setupMenuButton();
    
    // Запускаем long polling
    startPolling();
    
  } catch (error) {
    console.error('Ошибка при инициализации бота:', error);
  }
}

// Запускаем сервер и инициализируем бота
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
  initBot();
});