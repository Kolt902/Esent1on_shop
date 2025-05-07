/**
 * Специализированный сервер для запуска в Docker на Railway
 * Полная независимость от внешних модулей
 */

const http = require('http');
const fs = require('fs');
const path = require('path');

// Конфигурация
const PORT = process.env.PORT || 8080;
const STATIC_DIR = process.env.STATIC_DIR || 'dist';

console.log(`\n=== DOCKER SERVER FOR RAILWAY ===`);
console.log(`Порт: ${PORT}`);
console.log(`Директория статических файлов: ${STATIC_DIR}`);
console.log(`Режим: ${process.env.NODE_ENV || 'development'}`);

// MIME-типы для Content-Type
const MIME_TYPES = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'application/javascript',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.eot': 'application/vnd.ms-fontobject',
  '.otf': 'font/otf',
};

// API заглушки
const API_RESPONSES = {
  '/api/categories': JSON.stringify({ 
    categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] 
  }),
  '/api/brands': JSON.stringify({ 
    brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'] 
  }),
  '/api/styles': JSON.stringify({ 
    styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'] 
  }),
  '/api/admin/check': JSON.stringify({ isAdmin: false }),
  '/healthcheck': JSON.stringify({ status: 'ok' }),
};

// Проверка существования директории со статическими файлами
function checkStaticDir() {
  try {
    if (fs.existsSync(STATIC_DIR)) {
      return true;
    }

    console.error(`ОШИБКА: Директория ${STATIC_DIR} не найдена!`);
    return false;
  } catch (err) {
    console.error(`ОШИБКА при проверке директории ${STATIC_DIR}:`, err);
    return false;
  }
}

// Отдача статических файлов
function serveStaticFile(req, res, filePath) {
  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        // Если файл не найден, отдаем index.html для SPA-приложения
        const indexPath = path.join(STATIC_DIR, 'index.html');
        if (fs.existsSync(indexPath)) {
          fs.readFile(indexPath, (err, content) => {
            if (err) {
              res.writeHead(500);
              res.end('500 - Ошибка сервера');
              return;
            }
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.end(content, 'utf-8');
          });
        } else {
          res.writeHead(404);
          res.end('404 - File Not Found');
        }
      } else {
        res.writeHead(500);
        res.end('500 - Ошибка сервера');
      }
      return;
    }

    const ext = path.extname(filePath);
    const contentType = MIME_TYPES[ext] || 'application/octet-stream';
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(content, 'utf-8');
  });
}

// HTTP-сервер
const server = http.createServer((req, res) => {
  console.log(`${req.method} ${req.url}`);

  const url = req.url.split('?')[0]; // Игнорируем параметры запроса

  // Обработка API-запросов
  if (url in API_RESPONSES) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(API_RESPONSES[url]);
    return;
  }

  // Для остальных API-запросов отдаем пустой объект
  if (url.startsWith('/api/')) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end('{}');
    return;
  }

  // Для запросов к статике
  if (checkStaticDir()) {
    let filePath = path.join(STATIC_DIR, url);

    // Если запрос к корню или директории, ищем index.html
    const stats = fs.existsSync(filePath) ? fs.statSync(filePath) : null;
    if (!stats || stats.isDirectory()) {
      filePath = path.join(filePath, 'index.html');
    }

    serveStaticFile(req, res, filePath);
  } else {
    // Если директория со статикой не найдена, показываем диагностическую страницу
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
      <!DOCTYPE html>
      <html>
      <head>
        <title>Railway Docker Server</title>
        <style>
          body { 
            font-family: Arial, sans-serif; 
            max-width: 800px; 
            margin: 0 auto; 
            padding: 20px;
            line-height: 1.6;
          }
          .container {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
          }
          h1 { color: #333; }
          .error { color: #e74c3c; }
          .success { color: #2ecc71; }
          pre {
            background: #f8f8f8;
            padding: 10px;
            border-radius: 4px;
            overflow-x: auto;
          }
        </style>
      </head>
      <body>
        <h1>Docker Server для Railway</h1>
        
        <div class="container">
          <p><strong>Статус:</strong> <span class="success">Сервер запущен</span></p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Режим:</strong> ${process.env.NODE_ENV || 'development'}</p>
          <p><strong>Директория статики:</strong> <span class="error">${STATIC_DIR} (не найдена)</span></p>
          <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
        </div>
        
        <div class="container">
          <h2>Доступные API-заглушки:</h2>
          <ul>
            ${Object.keys(API_RESPONSES).map(path => `<li>${path}</li>`).join('\n')}
          </ul>
        </div>
        
        <div class="container">
          <h2>Содержимое директории:</h2>
          <pre>${fs.readdirSync('.').map(item => {
            try {
              const stat = fs.statSync(item);
              return `${stat.isDirectory() ? 'D' : 'F'} ${item}`;
            } catch (e) {
              return `? ${item} (error: ${e.message})`;
            }
          }).join('\n')}</pre>
        </div>
      </body>
      </html>
    `);
  }
});

// Запуск сервера
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});