/**
 * Сверхупрощенный автономный сервер для Railway
 * Абсолютный минимум для запуска и работы
 */

// Импортируем только базовый http модуль
const http = require('http');

// Порт из переменной окружения или 8080 по умолчанию
const PORT = process.env.PORT || 8080;

// Время запуска сервера
const START_TIME = new Date();

// Простой логгер
function log(message) {
  console.log(`[${new Date().toISOString()}] ${message}`);
}

// Вывод информации о запуске
log('=== ESENTION STORE MINIMAL SERVER ===');
log(`Запуск на порту: ${PORT}`);
log(`Окружение: ${process.env.NODE_ENV || 'development'}`);

// Создаем сервер
const server = http.createServer((req, res) => {
  const url = req.url;
  
  // Логируем запрос
  log(`${req.method} ${url}`);
  
  // Обработка CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }
  
  // Обработка проверки здоровья для Railway
  if (url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'ok',
      uptime: Math.floor((new Date() - START_TIME) / 1000) 
    }));
    return;
  }
  
  // Для API-запросов возвращаем заглушки
  if (url.startsWith('/api/')) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    
    // Базовые API-ответы
    if (url === '/api/categories') {
      res.end(JSON.stringify({ 
        categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] 
      }));
    } else if (url === '/api/brands') {
      res.end(JSON.stringify({ 
        brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy'] 
      }));
    } else if (url === '/api/products') {
      res.end(JSON.stringify({ products: [] }));
    } else {
      res.end('{}');
    }
    return;
  }
  
  // Для всех остальных запросов отдаем базовую HTML-страницу
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
          font-family: Arial, sans-serif;
          text-align: center;
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          min-height: 100vh;
          background-color: #111;
          color: #fff;
        }
        .container {
          max-width: 600px;
          margin: 0 auto;
          padding: 20px;
        }
        h1 {
          font-size: 32px;
          margin-bottom: 20px;
        }
        .status {
          display: inline-block;
          background: #4CAF50;
          color: white;
          padding: 8px 16px;
          border-radius: 4px;
          margin: 10px 0;
        }
        .info {
          background: rgba(255,255,255,0.1);
          border-radius: 8px;
          padding: 15px;
          text-align: left;
          margin-top: 20px;
        }
        a {
          color: #4CAF50;
          text-decoration: none;
        }
        a:hover {
          text-decoration: underline;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Esention Store</h1>
        <div class="status">Сервер успешно запущен</div>
        <p>Минимальный сервер для Railway работает.</p>
        
        <div class="info">
          <p><strong>Статус:</strong> Онлайн</p>
          <p><strong>Время запуска:</strong> ${START_TIME.toLocaleString()}</p>
          <p><strong>Uptime:</strong> ${Math.floor((new Date() - START_TIME) / 1000)} секунд</p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Режим:</strong> ${process.env.NODE_ENV || 'development'}</p>
        </div>
        
        <p style="margin-top: 30px;">
          <a href="/healthcheck">Проверить статус сервера</a>
        </p>
      </div>
    </body>
    </html>
  `);
});

// Обработка ошибок
server.on('error', (error) => {
  log(`Ошибка сервера: ${error.message}`);
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  log(`Сервер успешно запущен на порту ${PORT}`);
});