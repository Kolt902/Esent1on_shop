/**
 * Абсолютно минимальный JavaScript-сервер для Railway без вообще никакой сложности
 * Создан для решения проблемы "Application failed to respond"
 */

const http = require('http');

// Создаем простейший HTTP-сервер
const server = http.createServer((req, res) => {
  // Для лога запросов
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);

  // Проверка здоровья для Railway
  if (req.url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'ok', 
      uptime: process.uptime(),
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // API роуты
  if (req.url === '/api/categories') {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ 
      categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories']
    }));
    return;
  }

  if (req.url === '/api/brands') {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ 
      brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry']
    }));
    return;
  }

  if (req.url === '/api/styles') {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ 
      styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney']
    }));
    return;
  }

  if (req.url === '/api/products') {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ products: [] }));
    return;
  }

  if (req.url === '/api/admin/check') {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
    res.end(JSON.stringify({ isAdmin: false }));
    return;
  }

  // Корневой маршрут - простейшая HTML страница
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Esention Store Server</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
          body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            line-height: 1.6;
            color: #333;
            text-align: center;
          }
          h1 { color: #4CAF50; }
          .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
          }
          .api-link {
            display: inline-block;
            margin: 5px;
            padding: 8px 15px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
          }
          .status {
            margin-top: 30px;
            padding: 15px;
            background-color: #e8f5e9;
            border-radius: 4px;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>✅ Esention Store - Сервер запущен!</h1>
          <p>
            Это базовый сервер для Telegram Mini App магазина Esention Store.
            <br>Он предоставляет необходимые API для взаимодействия приложения.
          </p>
          
          <h2>Доступные API:</h2>
          <a href="/api/categories" class="api-link">Категории</a>
          <a href="/api/brands" class="api-link">Бренды</a>
          <a href="/api/styles" class="api-link">Стили</a>
          <a href="/api/products" class="api-link">Продукты</a>
          <a href="/healthcheck" class="api-link">Health Check</a>
          
          <div class="status">
            <p>Статус: <strong>Онлайн</strong></p>
            <p>Сервер запущен: <strong>${new Date().toLocaleString()}</strong></p>
            <p>Время работы: <strong>${process.uptime().toFixed(2)} секунд</strong></p>
          </div>
        </div>
      </body>
    </html>
  `);
});

// Получаем порт из переменной окружения или используем 3000 по умолчанию
const PORT = process.env.PORT || 3000;

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
  console.log(`Проверка здоровья: http://localhost:${PORT}/healthcheck`);
});