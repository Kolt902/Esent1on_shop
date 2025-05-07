/**
 * Самый примитивный сервер для Railway для тестирования
 * Не имеет никаких зависимостей, кроме Node.js
 */

const http = require('http');

const PORT = process.env.PORT || 8080;

// Создаем HTTP-сервер
const server = http.createServer((req, res) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  
  //Healthcheck для Railway
  if (req.url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }
  
  // Отображаем простую HTML-страницу
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Railway Test Server</title>
      <style>
        body { 
          font-family: Arial, sans-serif; 
          margin: 2rem;
          line-height: 1.6;
        }
        h1 { color: #333; }
        .container {
          max-width: 800px;
          margin: 0 auto;
          padding: 20px;
          border: 1px solid #ddd;
          border-radius: 8px;
        }
        .status { 
          padding: 10px; 
          background-color: #f0f0f0; 
          border-radius: 4px;
          margin-bottom: 20px;
        }
        .ok { color: green; }
        .url { font-family: monospace; }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>Railway Test Server</h1>
        
        <div class="status">
          <p><strong>Статус:</strong> <span class="ok">Работает</span></p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Среда:</strong> ${process.env.NODE_ENV || 'development'}</p>
          <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
        </div>
        
        <p>Этот сервер является минимальной тестовой версией для проверки запуска Node.js на Railway.</p>
        <p>Проверка здоровья доступна по адресу: <span class="url">/healthcheck</span></p>
      </div>
    </body>
    </html>
  `);
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  console.log(`
=====================================
   АБСОЛЮТНО МИНИМАЛЬНЫЙ СЕРВЕР
=====================================
Порт: ${PORT}
Время запуска: ${new Date().toLocaleString()}
Окружение: ${process.env.NODE_ENV || 'development'}
=====================================
  `);
});