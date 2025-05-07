#!/usr/bin/env node

/**
 * Специализированный сервер для Telegram Mini App 
 * Разработан специально для решения проблемы "The app is currently not running"
 * Версия, не требующая подключения к базе данных
 */

const express = require('express');
const http = require('http');
const path = require('path');
const fs = require('fs');

// Демо-данные для работы без базы данных
const demoProducts = [
  {
    id: 1,
    name: "Nike Air Force 1 '07",
    price: 8990,
    category: "sneakers",
    brand: "Nike",
    description: "Легендарные кроссовки Nike Air Force 1 с классическим дизайном и комфортной подошвой.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/air-force-1-07-mens-shoes-5QFp5Z.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/00375837-849f-4f17-ba24-d201d27be49b/air-force-1-07-mens-shoes-5QFp5Z.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/33533fc1-1e4f-4a76-9dd9-b366d1861e09/air-force-1-07-mens-shoes-5QFp5Z.png"
    ],
    sizes: ["38", "39", "40", "41", "42", "43", "44", "45"],
    gender: "men",
    isNew: false,
    discount: 0,
    rating: 49,
    inStock: true
  },
  {
    id: 2,
    name: "Nike Air Max 270",
    price: 12990,
    category: "sneakers",
    brand: "Nike",
    description: "Кроссовки Nike Air Max 270 с массивной воздушной подушкой для максимального комфорта и стиля.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-max-270-mens-shoes-KkLcGR.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fg3necfcxgccw3ggsjty/air-max-270-mens-shoes-KkLcGR.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/bupxzujeocextn0xr8d7/air-max-270-mens-shoes-KkLcGR.png"
    ],
    sizes: ["40", "41", "42", "43", "44", "45"],
    gender: "men",
    isNew: false,
    discount: 10,
    rating: 46,
    inStock: true
  },
  {
    id: 3,
    name: "Nike Dunk Low Retro",
    price: 10990,
    category: "sneakers",
    brand: "Nike",
    description: "Низкие кроссовки Nike Dunk с подошвой, обеспечивающей отличное сцепление и комфорт на весь день.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9559f730-2e9d-4232-9e89-e8e81ddc8cc4/dunk-low-retro-mens-shoes-76KnBL.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/2c8726a5-624d-4c15-99e6-7df8c9281ee6/dunk-low-retro-mens-shoes-76KnBL.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/53c32a0e-a5de-4e3b-9ca1-d3a96aa4d7c2/dunk-low-retro-mens-shoes-76KnBL.png"
    ],
    sizes: ["38", "39", "40", "41", "42", "43", "44"],
    gender: "men",
    isNew: true,
    discount: 0,
    rating: 45,
    inStock: true
  },
  {
    id: 4,
    name: "Nike Sportswear Club",
    price: 2490,
    category: "tshirts",
    brand: "Nike",
    description: "Классическая футболка Nike Sportswear Club из мягкого хлопка с логотипом на груди.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5c3df1c5-7959-4414-a0f3-41da8bb3a137/sportswear-club-mens-t-shirt-N8Fnn0.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/d0b97b2d-8696-4523-b599-18dca6007fd0/sportswear-club-mens-t-shirt-N8Fnn0.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/4ea23a3c-76a6-4536-9de9-aa493b427970/sportswear-club-mens-t-shirt-N8Fnn0.png"
    ],
    sizes: ["S", "M", "L", "XL", "XXL"],
    gender: "men",
    isNew: false,
    discount: 0,
    rating: 43,
    inStock: true
  },
  {
    id: 5,
    name: "Nike Dri-FIT Run Division",
    price: 3490,
    category: "tshirts",
    brand: "Nike",
    description: "Беговая футболка Nike Dri-FIT Run Division с технологией отвода влаги для максимального комфорта во время тренировок.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/57d21492-0c48-456c-bdfa-cc152a88cf63/dri-fit-run-division-running-t-shirt-TRgJ4V.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/c2c6c6b6-c543-458b-88c8-9cc747ec9fc3/dri-fit-run-division-running-t-shirt-TRgJ4V.png"
    ],
    sizes: ["S", "M", "L", "XL"],
    gender: "men",
    isNew: true,
    discount: 0,
    rating: 41,
    inStock: true
  },
  {
    id: 6,
    name: "Nike Sportswear Club Fleece",
    price: 5490,
    category: "hoodies",
    brand: "Nike",
    description: "Теплая худи Nike Sportswear Club Fleece из мягкого флиса с начесом для комфорта в прохладную погоду.",
    imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/gw1tzq9wrqoqhfvgjnvx/sportswear-club-fleece-mens-pullover-hoodie-p3MkK9.png",
    additionalImages: [
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/ks0tgzwx6vfyi3gzmstl/sportswear-club-fleece-mens-pullover-hoodie-p3MkK9.png",
      "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/ojgskojjxgdsb54ywdn7/sportswear-club-fleece-mens-pullover-hoodie-p3MkK9.png"
    ],
    sizes: ["S", "M", "L", "XL", "XXL"],
    gender: "men",
    isNew: false,
    discount: 15,
    rating: 47,
    inStock: true
  }
];

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
  
  // Создаем минимальную страницу, если ничего не найдём
  const createMinimalPage = () => {
    if (!fs.existsSync('./public')) {
      try {
        fs.mkdirSync('./public', { recursive: true });
        
        // Создаём минимальный index.html
        const minimalHtml = `<!DOCTYPE html>
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
        background-color: #f8f9fa;
        color: #333;
      }
      .header {
        background: linear-gradient(45deg, #7e57c2, #2196f3);
        color: white;
        padding: 1rem;
        text-align: center;
      }
      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 1rem;
      }
      .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
      }
      .product-card {
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        transition: transform 0.3s ease;
      }
      .product-card:hover {
        transform: translateY(-5px);
      }
      .product-image {
        height: 200px;
        width: 100%;
        object-fit: cover;
      }
      .product-info {
        padding: 1rem;
      }
      .product-name {
        font-weight: bold;
        margin: 0;
        font-size: 1.1rem;
      }
      .product-brand {
        color: #666;
        margin: 0.3rem 0;
      }
      .product-price {
        font-weight: bold;
        margin: 0.5rem 0;
        font-size: 1.2rem;
        color: #2196f3;
      }
      .filters {
        background: white;
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      }
      .btn {
        background: linear-gradient(45deg, #7e57c2, #2196f3);
        color: white;
        border: none;
        padding: 0.6rem 1.2rem;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
        transition: opacity 0.3s ease;
      }
      .btn:hover {
        opacity: 0.9;
      }
      @media (max-width: 768px) {
        .product-grid {
          grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
        }
      }
    </style>
  </head>
  <body>
    <div class="header">
      <h1>Esention Shop</h1>
      <p>Модный магазин одежды премиум-класса</p>
    </div>
    
    <div class="container">
      <div class="filters">
        <h3>Фильтры</h3>
        <button class="btn" id="load-products">Показать товары</button>
      </div>
      
      <div class="product-grid" id="product-grid">
        <!-- Здесь будут карточки товаров -->
      </div>
    </div>
    
    <script>
      // Инициализация Telegram Mini App
      if (window.Telegram && window.Telegram.WebApp) {
        window.Telegram.WebApp.ready();
        window.Telegram.WebApp.expand();
      }
      
      // Загрузка товаров
      document.getElementById('load-products').addEventListener('click', async () => {
        try {
          const response = await fetch('/api/products');
          const data = await response.json();
          
          const productGrid = document.getElementById('product-grid');
          productGrid.innerHTML = '';
          
          data.products.forEach(product => {
            const card = document.createElement('div');
            card.className = 'product-card';
            
            const price = product.discount ? 
              (product.price * (1 - product.discount / 100)).toFixed(0) : 
              product.price;
            
            card.innerHTML = \`
              <img class="product-image" src="\${product.imageUrl}" alt="\${product.name}">
              <div class="product-info">
                <h3 class="product-name">\${product.name}</h3>
                <p class="product-brand">\${product.brand}</p>
                <p class="product-price">\${price} ₽</p>
              </div>
            \`;
            
            productGrid.appendChild(card);
          });
        } catch (error) {
          console.error('Error loading products:', error);
        }
      });
    </script>
  </body>
</html>`;
        
        fs.writeFileSync('./public/index.html', minimalHtml);
        console.log('Created minimal page in ./public/');
        return './public';
      } catch (err) {
        console.error('Failed to create minimal page:', err);
      }
    }
    return null;
  };
  
  // Проверяем альтернативные директории или создаём минимальную страницу
  const alternatives = [
    '/app/public',
    './dist/public',
    '/app/dist/public',
    './client/dist',
    '/app/client/dist'
  ];
  
  let found = false;
  for (const dir of alternatives) {
    if (fs.existsSync(dir)) {
      staticDir = dir;
      console.log(`Found static files in: ${dir}`);
      found = true;
      break;
    }
  }
  
  // Если ничего не нашли, создаём минимальную страницу
  if (!found) {
    const minimalDir = createMinimalPage();
    if (minimalDir) {
      staticDir = minimalDir;
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

// API без базы данных
app.get('/api/categories', (req, res) => {
  // Получаем все уникальные категории из демо-продуктов
  const categories = [...new Set(demoProducts.map(product => product.category))];
  res.json({ categories });
});

app.get('/api/brands', (req, res) => {
  // Получаем все уникальные бренды из демо-продуктов
  const brands = [...new Set(demoProducts.map(product => product.brand))];
  res.json({ brands });
});

app.get('/api/styles', (req, res) => {
  // Заглушка для стилей
  res.json({ styles: ['streetwear', 'casual', 'sport', 'luxury'] });
});

app.get('/api/products', (req, res) => {
  // Фильтры из запроса
  const { category, brand, style, gender } = req.query;
  
  // Применяем фильтры если они указаны
  let filteredProducts = [...demoProducts];
  
  if (category) {
    filteredProducts = filteredProducts.filter(p => p.category === category);
  }
  
  if (brand) {
    filteredProducts = filteredProducts.filter(p => p.brand === brand);
  }
  
  if (gender) {
    filteredProducts = filteredProducts.filter(p => p.gender === gender);
  }
  
  // Возвращаем отфильтрованный список
  res.json({ products: filteredProducts });
});

// API для получения данных о конкретном продукте
app.get('/api/products/:id', (req, res) => {
  const productId = parseInt(req.params.id);
  const product = demoProducts.find(p => p.id === productId);
  
  if (product) {
    res.json({ product });
  } else {
    res.status(404).json({ error: 'Продукт не найден' });
  }
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