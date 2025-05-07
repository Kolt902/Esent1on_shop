/**
 * Полноценный сервер для Railway с сохранением оригинального дизайна
 * Улучшенная версия с дополнительной обработкой ошибок и мониторингом
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { URL } = require('url');

// Базовые настройки
const PORT = process.env.PORT || 8080;
const NODE_ENV = process.env.NODE_ENV || 'development';
const START_TIME = new Date();

// Настройка логирования
function log(type, message) {
  const time = new Date().toISOString();
  const prefix = type === 'ERROR' ? '\x1b[31m[ERROR]\x1b[0m' : type === 'WARN' ? '\x1b[33m[WARN]\x1b[0m' : '\x1b[32m[INFO]\x1b[0m';
  console.log(`${prefix} ${time} - ${message}`);
}

// Логируем информацию о запуске сервера
log('INFO', '=== ESENTION STORE SERVER ===');
log('INFO', `Запуск серверного приложения...`);
log('INFO', `Порт: ${PORT}`);
log('INFO', `Окружение: ${NODE_ENV}`);
log('INFO', `Текущая директория: ${process.cwd()}`);

// Карта MIME-типов для правильных заголовков
const MIME_TYPES = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.mjs': 'application/javascript',
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
  '.map': 'application/json',
  '.txt': 'text/plain',
};

// API-заглушки с расширенными данными
const API_STUBS = {
  '/api/categories': { 
    categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] 
  },
  '/api/brands': { 
    brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'] 
  },
  '/api/styles': { 
    styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'] 
  },
  '/api/products': { 
    products: [] 
  },
  '/api/admin/check': { 
    isAdmin: false 
  },
  '/healthcheck': { 
    status: 'ok',
    uptime: () => {
      const uptime = new Date() - START_TIME;
      return Math.floor(uptime / 1000);
    },
    environment: NODE_ENV
  },
};

// Поиск и проверка всех статических директорий
function findStaticDirectories() {
  const results = [];
  // Список возможных директорий со статикой в порядке приоритета
  const possibleDirs = [
    'dist/client',
    'dist',
    'client/dist',
    'client/build',
    'public',
    'dist/public',
    'static',
    'build',
    '.'
  ];
  
  for (const dir of possibleDirs) {
    try {
      if (fs.existsSync(dir)) {
        const indexPath = path.join(dir, 'index.html');
        if (fs.existsSync(indexPath)) {
          const size = fs.statSync(indexPath).size;
          results.push({ 
            path: dir, 
            hasIndex: true, 
            indexSize: size, 
            files: fs.readdirSync(dir).length
          });
        } else {
          results.push({ 
            path: dir, 
            hasIndex: false, 
            files: fs.readdirSync(dir).length
          });
        }
      }
    } catch (err) {
      log('WARN', `Ошибка при проверке директории ${dir}: ${err.message}`);
    }
  }
  
  return results;
}

// Выбор лучшей директории со статикой
function findBestStaticDir() {
  const dirs = findStaticDirectories();
  
  // Логируем найденные директории
  if (dirs.length > 0) {
    log('INFO', 'Найдены следующие потенциальные директории со статикой:');
    dirs.forEach(dir => {
      log('INFO', `  - ${dir.path} (${dir.hasIndex ? 'имеет index.html' : 'без index.html'}, файлов: ${dir.files})`);
    });
  } else {
    log('WARN', 'Не найдено ни одной директории со статикой!');
  }
  
  // Выбираем директорию с index.html и максимальным количеством файлов
  const withIndex = dirs.filter(dir => dir.hasIndex);
  if (withIndex.length > 0) {
    const bestDir = withIndex.sort((a, b) => b.files - a.files)[0];
    log('INFO', `Выбрана оптимальная директория: ${bestDir.path} (${bestDir.files} файлов)`);
    return bestDir.path;
  }
  
  // Если нет ни одной директории с index.html
  log('WARN', 'Не найдено директории с index.html, будет использован резервный вариант');
  return null;
}

// Получение содержимого статического файла
function readFileAsync(filePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, (err, data) => {
      if (err) reject(err);
      else resolve(data);
    });
  });
}

// Обработка API-запросов с поддержкой динамических значений
function handleApiRequest(url, res) {
  // Проверяем, есть ли заглушка для данного API
  const stub = API_STUBS[url];
  if (stub) {
    // Обрабатываем динамические свойства
    const responseData = {};
    for (const [key, value] of Object.entries(stub)) {
      if (typeof value === 'function') {
        responseData[key] = value();
      } else {
        responseData[key] = value;
      }
    }
    
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Cache-Control': 'no-cache'
    });
    res.end(JSON.stringify(responseData));
    return true;
  }
  
  // Для других API-запросов отдаем пустой успешный ответ
  if (url.startsWith('/api/')) {
    res.writeHead(200, { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Cache-Control': 'no-cache' 
    });
    res.end('{}');
    return true;
  }
  
  return false;
}

// Отдача статических файлов с улучшенной обработкой ошибок
async function serveStaticFile(req, res, staticDir) {
  const urlPath = new URL(req.url, 'http://localhost').pathname;
  let filePath = path.join(staticDir, urlPath);
  
  // Если это корневой запрос или директория, используем index.html
  let isDirectory = false;
  try {
    if (fs.existsSync(filePath)) {
      const stats = fs.statSync(filePath);
      isDirectory = stats.isDirectory();
    }
  } catch (error) {
    // Файл не существует или ошибка доступа
  }
  
  if (urlPath === '/' || isDirectory || !path.extname(filePath)) {
    filePath = path.join(staticDir, 'index.html');
    log('INFO', `SPA routing: ${urlPath} -> index.html`);
  }
  
  // Получаем расширение файла для определения Content-Type
  const extname = path.extname(filePath).toLowerCase();
  const contentType = MIME_TYPES[extname] || 'application/octet-stream';
  
  try {
    // Проверяем, существует ли файл
    const fileExists = fs.existsSync(filePath);
    
    if (!fileExists) {
      // Файл не найден, отдаем index.html для SPA-роутинга
      const indexPath = path.join(staticDir, 'index.html');
      if (fs.existsSync(indexPath)) {
        const content = await readFileAsync(indexPath);
        res.writeHead(200, { 
          'Content-Type': 'text/html',
          'Cache-Control': 'no-cache' 
        });
        res.end(content);
        return;
      } else {
        throw new Error('index.html не найден');
      }
    }
    
    // Файл существует, отдаем его
    const content = await readFileAsync(filePath);
    res.writeHead(200, { 
      'Content-Type': contentType,
      'Cache-Control': extname === '.html' ? 'no-cache' : 'max-age=86400'
    });
    res.end(content);
  } catch (error) {
    log('ERROR', `Ошибка при обработке файла ${filePath}: ${error.message}`);
    
    // Отдаем индексный файл (если файл не найден) или ошибку 500
    try {
      const indexPath = path.join(staticDir, 'index.html');
      if (fs.existsSync(indexPath)) {
        const content = await readFileAsync(indexPath);
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(content);
      } else {
        res.writeHead(500, { 'Content-Type': 'text/html' });
        res.end(`
          <h1>500 - Ошибка сервера</h1>
          <p>Произошла ошибка при обработке запроса.</p>
          <p>Информация об ошибке: ${error.message}</p>
        `);
      }
    } catch (err) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('500 - Server Error');
    }
  }
}

// Обработка запроса с CORS
function handleRequest(req, res) {
  const url = req.url;
  const method = req.method;
  
  // Логгируем запрос
  log('INFO', `${method} ${url}`);
  
  // Обработка CORS preflight запросов
  if (method === 'OPTIONS') {
    res.writeHead(204, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      'Access-Control-Max-Age': '86400' // 24 часа
    });
    res.end();
    return;
  }
  
  // Добавляем базовые CORS-заголовки ко всем ответам
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  // Обработка API-запросов и healthcheck
  if (handleApiRequest(url, res)) {
    return;
  }
  
  // Выбираем лучшую директорию со статикой (кэшируем результат)
  if (!handleRequest.staticDir) {
    handleRequest.staticDir = findBestStaticDir();
  }
  
  const staticDir = handleRequest.staticDir;
  
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
          .error { color: #e74c3c; }
          .success { color: #2ecc71; }
        </style>
      </head>
      <body>
        <h1>Esention Store - Сервер запущен</h1>
        
        <div class="status">
          <p><strong>Статус:</strong> <span class="success">Сервер работает</span></p>
          <p><strong>Порт:</strong> ${PORT}</p>
          <p><strong>Режим:</strong> ${NODE_ENV}</p>
          <p><strong>Время запуска:</strong> ${START_TIME.toLocaleString()}</p>
          <p><strong>Uptime:</strong> ${Math.floor((new Date() - START_TIME) / 1000)} секунд</p>
          <p><strong>Статические файлы:</strong> <span class="error">Не найдены</span></p>
        </div>
        
        <h2>Директории в проекте:</h2>
        <div class="directories">
          ${fs.readdirSync('.').map(item => {
            try {
              const stat = fs.statSync(item);
              return `${stat.isDirectory() ? 'D' : 'F'} ${item}`;
            } catch (err) {
              return `? ${item} (ошибка: ${err.message})`;
            }
          }).join('\n')}
        </div>
      </body>
      </html>
    `);
  }
}

// Создаем HTTP-сервер с обработкой ошибок
const server = http.createServer((req, res) => {
  try {
    handleRequest(req, res);
  } catch (error) {
    log('ERROR', `Необработанная ошибка: ${error.message}\n${error.stack}`);
    
    try {
      res.writeHead(500, { 'Content-Type': 'text/html' });
      res.end(`
        <h1>500 - Внутренняя ошибка сервера</h1>
        <p>Произошла непредвиденная ошибка при обработке вашего запроса.</p>
        ${NODE_ENV === 'development' ? `<pre>${error.stack}</pre>` : ''}
      `);
    } catch (e) {
      // В случае если не удалось отправить ответ об ошибке
      log('ERROR', `Не удалось отправить ответ об ошибке: ${e.message}`);
    }
  }
});

// Обработка неожиданного завершения запросов
server.on('clientError', (err, socket) => {
  log('WARN', `Ошибка клиентского соединения: ${err.message}`);
  socket.end('HTTP/1.1 400 Bad Request\r\n\r\n');
});

// Обработка необработанных исключений
process.on('uncaughtException', (err) => {
  log('ERROR', `Необработанное исключение: ${err.message}\n${err.stack}`);
  // Не завершаем процесс для сохранения работоспособности сервера
});

process.on('unhandledRejection', (reason, promise) => {
  log('ERROR', `Необработанное отклонение промиса: ${reason}`);
});

// Запускаем сервер
server.listen(PORT, '0.0.0.0', () => {
  log('INFO', `Сервер успешно запущен на порту ${PORT}`);
  log('INFO', `Для проверки работоспособности откройте: http://localhost:${PORT}/`);
  log('INFO', `Для проверки health-check: http://localhost:${PORT}/healthcheck`);
  log('INFO', `Сервер готов принимать запросы!`);
});