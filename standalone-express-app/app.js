/**
 * Автономное Express приложение для Railway
 * Оптимизировано для стабильной работы и прохождения проверок здоровья
 */

const express = require('express');
const path = require('path');
const fs = require('fs');
const TelegramBot = require('./telegram-bot');
const app = express();
const PORT = process.env.PORT || 3000;

// Инициализация бота, если есть токен
const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
let bot = null;

if (TELEGRAM_BOT_TOKEN) {
  bot = new TelegramBot(TELEGRAM_BOT_TOKEN);
  console.log('Telegram bot initialized');
} else {
  console.log('No Telegram bot token provided, bot features disabled');
}

// Настройка CORS
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, telegram-data');

  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  }
  next();
});

// Логирование запросов
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// Парсинг JSON и URL-encoded данных
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Статические файлы
let clientBuildPath = path.resolve(__dirname, 'client-build');
if (fs.existsSync(clientBuildPath)) {
  app.use(express.static(clientBuildPath));
  console.log(`Serving static files from ${clientBuildPath}`);
} else {
  console.log(`Static files path not found: ${clientBuildPath}`);
  // Пробуем найти путь к статическим файлам
  const possiblePaths = [
    path.resolve(__dirname, '../client-build'),
    path.resolve(__dirname, '../dist'),
    path.resolve(__dirname, '../build'),
    path.resolve(__dirname, '../public')
  ];
  
  for (const testPath of possiblePaths) {
    if (fs.existsSync(testPath)) {
      clientBuildPath = testPath;
      app.use(express.static(testPath));
      console.log(`Found and serving static files from ${testPath}`);
      break;
    }
  }
}

// Маршрут для проверки здоровья
app.get('/healthcheck', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'production'
  });
});

// API маршруты
const brands = ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'];
const categories = ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'];
const styles = ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'];

app.get('/api/brands', (req, res) => {
  res.json({ brands });
});

app.get('/api/categories', (req, res) => {
  res.json({ categories });
});

app.get('/api/styles', (req, res) => {
  res.json({ styles });
});

app.get('/api/products', (req, res) => {
  // Возвращаем пустой массив, чтобы API работал
  res.json({ products: [] });
});

app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
});

// Маршруты Telegram
app.post('/telegram/webhook', async (req, res) => {
  console.log('Получен запрос webhook:', req.body);
  
  // Обрабатываем запрос только если бот инициализирован
  if (bot && req.body) {
    try {
      const update = req.body;
      
      // Обработка сообщений
      if (update.message) {
        const { chat, text } = update.message;
        
        // Обработка команды /start
        if (text === '/start') {
          await bot.sendMessage(chat.id, 'Добро пожаловать в Esention Store! Нажмите на кнопку ниже, чтобы открыть магазин.', {
            reply_markup: {
              inline_keyboard: [
                [{ text: 'Открыть магазин', web_app: { url: process.env.WEB_APP_URL || 'https://esention-store.up.railway.app' } }]
              ]
            }
          });
        }
      }
    } catch (error) {
      console.error('Ошибка обработки webhook:', error);
    }
  }
  
  // Всегда отвечаем успехом, даже если произошла ошибка обработки
  res.status(200).json({ ok: true });
});

// Настройка бота
app.get('/telegram/setup', async (req, res) => {
  if (!bot) {
    return res.status(400).json({ error: 'Bot not initialized, token missing' });
  }

  try {
    // Настраиваем команды бота
    const commandsResult = await bot.setMyCommands([
      { command: 'start', description: 'Запустить бота' },
      { command: 'help', description: 'Получить помощь' },
      { command: 'shop', description: 'Открыть магазин' }
    ]);

    // Если указан WEB_APP_URL, настраиваем webhook
    const webhookUrl = process.env.WEBHOOK_URL;
    let webhookResult = { ok: false, info: 'Webhook not set - no URL' };
    
    if (webhookUrl) {
      webhookResult = await bot.setWebhook(webhookUrl);
    } else {
      // Если webhook не указан, используем long polling
      webhookResult = await bot.deleteWebhook(true);
    }

    // Получаем информацию о webhook
    const webhookInfo = await bot.getWebhookInfo();

    res.json({
      commands: commandsResult,
      webhook: webhookResult,
      webhookInfo,
      webAppUrl: process.env.WEB_APP_URL || 'Not set'
    });
  } catch (error) {
    console.error('Ошибка настройки бота:', error);
    res.status(500).json({ error: 'Failed to setup bot', message: error.message });
  }
});

// Обслуживание SPA - все неизвестные маршруты отправляют index.html
app.get('*', (req, res) => {
  // Пробуем отправить index.html если он существует
  const indexPath = path.join(clientBuildPath, 'index.html');
  if (fs.existsSync(indexPath)) {
    res.sendFile(indexPath);
  } else {
    // Если файла нет, отправляем базовую HTML страницу
    res.send(`
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Esention Store</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            text-align: center;
          }
          .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
          }
          h1 {
            color: #28a745;
            margin-bottom: 20px;
          }
          p {
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 15px;
          }
          .endpoint {
            display: inline-block;
            margin: 5px;
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
          }
          .status {
            margin-top: 30px;
            font-size: 16px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>✅ Esention Store - Сервер запущен!</h1>
          <p>
            Этот сервер настроен для работы с Telegram Mini App.
            Он предоставляет API для взаимодействия с приложением.
          </p>
          <p>Доступные API-эндпоинты:</p>
          <div>
            <a href="/api/categories" class="endpoint">Categories</a>
            <a href="/api/brands" class="endpoint">Brands</a>
            <a href="/api/styles" class="endpoint">Styles</a>
            <a href="/api/products" class="endpoint">Products</a>
            <a href="/healthcheck" class="endpoint">Health Check</a>
          </div>
          <div class="status">
            <p>Статус: <strong>Онлайн</strong></p>
            <p>Время: <strong>${new Date().toLocaleString()}</strong></p>
          </div>
        </div>
      </body>
      </html>
    `);
  }
});

// Обработка ошибок
app.use((err, req, res, next) => {
  console.error('Server error:', err);
  res.status(500).json({
    error: 'Internal Server Error',
    message: process.env.NODE_ENV === 'production' ? 'Something went wrong' : err.message
  });
});

// Запуск сервера и инициализация бота
app.listen(PORT, '0.0.0.0', async () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Health check available at: http://localhost:${PORT}/healthcheck`);
  
  // Инициализация бота
  if (bot) {
    try {
      const host = process.env.HOST || `localhost:${PORT}`;
      console.log(`Bot initialized. Use ${host}/telegram/setup to configure webhook.`);
      
      // Автоматическая настройка бота, если указан WEBHOOK_URL
      if (process.env.WEBHOOK_URL) {
        console.log(`Setting up webhook to: ${process.env.WEBHOOK_URL}`);
        const webhookResult = await bot.setWebhook(process.env.WEBHOOK_URL);
        console.log('Webhook setup result:', webhookResult);
        
        // Настраиваем команды бота
        const commandsResult = await bot.setMyCommands([
          { command: 'start', description: 'Запустить бота' },
          { command: 'help', description: 'Получить помощь' },
          { command: 'shop', description: 'Открыть магазин' }
        ]);
        console.log('Bot commands setup result:', commandsResult);
      } else {
        console.log('No WEBHOOK_URL provided, webhook not configured automatically.');
      }
    } catch (error) {
      console.error('Failed to initialize bot:', error);
    }
  }
});

module.exports = app;