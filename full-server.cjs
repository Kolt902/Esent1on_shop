/**
 * Полноценный сервер для Railway с сохранением оригинального дизайна
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { createReadStream } = require('fs');
const { URL } = require('url');

// Базовые настройки
const PORT = process.env.PORT || 8080;
console.log(`\n=== ESENTION STORE SERVER ===`);
console.log(`Запуск серверного приложения...`);
console.log(`Порт: ${PORT}`);
console.log(`Окружение: ${process.env.NODE_ENV || 'development'}`);
console.log(`Текущая директория: ${process.cwd()}\n`);

// Карта MIME-типов для правильных заголовков
const MIME_TYPES = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.css': 'text/css',
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

// API-заглушки для тестирования
const API_STUBS = {
  '/api/categories': { categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] },
  '/api/brands': { brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'] },
  '/api/styles': { styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'] },
  '/api/products': { products: [] },
  '/api/admin/check': { isAdmin: false },
  '/healthcheck': { status: 'ok' },
};

// Поиск директории с клиентскими файлами
function findStaticDir() {
  // Список возможных директорий со статикой в порядке приоритета
  const possibleDirs = [
    'dist/client',
    'public',
    'dist/public',
    'client/dist',
    'dist'
  ];
  
  for (const dir of possibleDirs) {
    if (fs.existsSync(dir)) {
      const indexPath = path.join(dir, 'index.html');
      if (fs.existsSync(indexPath)) {
        console.log(`Найдены клиентские файлы в директории: ${dir}`);
        return dir;
      }
    }
  }
  
  // Если не нашли, ищем в корне
  if (fs.existsSync('index.html')) {
    console.log('Найден index.html в корневой директории');
    return '.';
  }
  
  console.log('ВНИМАНИЕ: Не удалось найти директорию с клиентскими файлами!');
  return null;
}

// Обработка API-запросов
function handleApiRequest(url, res) {
  // Проверяем, есть ли заглушка для данного API
  const stub = API_STUBS[url];
  if (stub) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(stub));
    return true;
  }
  
  // Для других API-запросов отдаем пустой успешный ответ
  if (url.startsWith('/api/')) {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end('{}');
    return true;
  }
  
  return false;
}

// Отдача статических файлов
function serveStaticFile(req, res, staticDir) {
  let filePath = path.join(staticDir, new URL(req.url, 'http://localhost').pathname);
  
  // Если это корневой запрос или директория, пытаемся найти index.html
  if (filePath.endsWith('/') || !path.extname(filePath)) {
    filePath = path.join(filePath, 'index.html');
  }
  
  // Получаем расширение файла
  const extname = path.extname(filePath).toLowerCase();
  const contentType = MIME_TYPES[extname] || 'application/octet-stream';
  
  // Проверяем, существует ли файл
  fs.access(filePath, fs.constants.F_OK, (err) => {
    if (err) {
      // Файл не найден, отдаем index.html для SPA-роутинга
      const indexPath = path.join(staticDir, 'index.html');
      if (fs.existsSync(indexPath)) {
        const stream = createReadStream(indexPath);
        res.writeHead(200, { 'Content-Type': 'text/html' });
        stream.pipe(res);
      } else {
        // Если даже index.html не найден, отдаем 404
        res.writeHead(404, { 'Content-Type': 'text/html' });
        res.end('<h1>404 - File Not Found</h1>');
      }
      return;
    }
    
    // Файл найден, отдаем его
    const stream = createReadStream(filePath);
    res.writeHead(200, { 'Content-Type': contentType });
    stream.pipe(res);
  });
}

// Создаем HTTP-сервер
const server = http.createServer((req, res) => {
  const url = req.url;
  
  console.log(`${req.method} ${url}`);
  
  // Обработка API-запросов и healthcheck
  if (handleApiRequest(url, res)) {
    return;
  }
  
  // Находим директорию со статикой (делаем это при каждом запросе для дев-режима)
  const staticDir = findStaticDir();
  
  if (staticDir) {
    // Отдаем статические файлы
    serveStaticFile(req, res, staticDir);
  } else {
    // Если статики нет, отдаем базовую страницу
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
            font-family: 'Arial', sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            line-height: 1.6;
            color: #333;
          }
          h1 {
            color: #000;
            margin-bottom: 30px;
          }
          .status {
            background: #f8f8f8;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
          }
          .directories {
            background: #f0f0f0;
            padding: 15px;
            border-radius: 4px;
            font-family: monospace;
            white-space: pre;
            overflow-x: auto;
          }
        </style>
      </head>
      <body>
        <h1>Esention Store - Сервер запущен</h1>
        
        <div class="status">
          <p><strong>Статус:</strong> Сервер работает</p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Режим:</strong> ${process.env.NODE_ENV || 'development'}</p>
          <p><strong>Время:</strong> ${new Date().toLocaleString()}</p>
        </div>
        
        <h2>Директории в проекте:</h2>
        <div class="directories">
          ${fs.readdirSync('.').map(item => {
            const stat = fs.statSync(item);
            return `${stat.isDirectory() ? 'D' : 'F'} ${item}`;
          }).join('\n')}
        </div>
      </body>
      </html>
    `);
  }
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
  console.log(`Сервер готов принимать запросы!`);
});