/**
 * Супер простой автономный сервер для Railway с использованием ES модулей
 */

import http from 'http';

const PORT = process.env.PORT || 3000;

// Простейший сервер для проверки здоровья
const server = http.createServer((req, res) => {
  // Логирование запросов
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  
  // CORS заголовки для всех запросов
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  // Обработка OPTIONS запросов для CORS
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  // Специальный маршрут для проверки здоровья (Railway использует его)
  if (req.url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'ok', 
      message: 'Server is healthy',
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // API маршруты приложения
  if (req.url === '/api/categories') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories']
    }));
    return;
  }

  if (req.url === '/api/brands') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier']
    }));
    return;
  }
  
  if (req.url === '/api/styles') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney']
    }));
    return;
  }
  
  if (req.url === '/api/products') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ products: [] }));
    return;
  }
  
  if (req.url === '/api/admin/check') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ isAdmin: false }));
    return;
  }

  // Страница приветствия для корневого маршрута
  if (req.url === '/' || req.url === '/index.html') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
      <!DOCTYPE html>
      <html>
      <head>
        <title>Esention Store API</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
          body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 30px;
            background-color: #f5f5f5;
            color: #333;
            text-align: center;
          }
          .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
          }
          h1 {
            color: #4CAF50;
          }
          .endpoints {
            margin-top: 30px;
            text-align: left;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 6px;
          }
          .endpoint {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #e8f5e9;
            border-radius: 4px;
          }
          .button {
            display: inline-block;
            padding: 10px 15px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 5px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>✅ Esention Store API</h1>
          <p>Сервер успешно запущен и готов обрабатывать запросы от Telegram Mini App.</p>
          
          <div>
            <a href="/api/categories" class="button">Категории</a>
            <a href="/api/brands" class="button">Бренды</a>
            <a href="/api/styles" class="button">Стили</a>
            <a href="/api/products" class="button">Продукты</a>
            <a href="/healthcheck" class="button">Health Check</a>
          </div>
          
          <div class="endpoints">
            <h2>Доступные эндпоинты:</h2>
            <div class="endpoint">/api/categories - список категорий товаров</div>
            <div class="endpoint">/api/brands - список брендов</div>
            <div class="endpoint">/api/styles - список стилей</div>
            <div class="endpoint">/api/products - список продуктов</div>
            <div class="endpoint">/api/admin/check - проверка прав администратора</div>
          </div>
          
          <p>Сервер активен с: ${new Date().toLocaleString()}</p>
        </div>
      </body>
      </html>
    `);
    return;
  }

  // Для всех остальных маршрутов возвращаем 404
  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ 
    error: 'Not Found',
    message: `The requested path '${req.url}' was not found`
  }));
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
  console.log(`Healthcheck URL: http://localhost:${PORT}/healthcheck`);
});