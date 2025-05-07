/**
 * Express-сервер для Railway с поддержкой SPA
 */

const express = require('express');
const path = require('path');
const fs = require('fs');

// Конфигурация
const app = express();
const PORT = process.env.PORT || 8080;
const STATIC_DIR = process.env.STATIC_DIR || 'dist';

// Middleware для логирования запросов
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.path}`);
  next();
});

// Healthcheck для Railway
app.get('/healthcheck', (req, res) => {
  res.json({ status: 'ok' });
});

// API заглушки
app.get('/api/categories', (req, res) => {
  res.json({ categories: ['sneakers', 'hoodies', 'tshirts', 'pants', 'jackets', 'accessories'] });
});

app.get('/api/brands', (req, res) => {
  res.json({ brands: ['Nike', 'Adidas', 'Jordan', 'Gucci', 'Balenciaga', 'Puma', 'Stussy', 'Burberry', 'Chanel', 'Saint Laurent', 'Dior', 'Cartier'] });
});

app.get('/api/styles', (req, res) => {
  res.json({ styles: ['streetwear', 'casual', 'sport', 'luxury', 'oldmoney'] });
});

app.get('/api/admin/check', (req, res) => {
  res.json({ isAdmin: false });
});

// Любые другие API запросы возвращают пустой объект
app.get('/api/*', (req, res) => {
  res.json({});
});

// Проверяем существование директории со статикой
let staticDirExists = false;
try {
  staticDirExists = fs.existsSync(STATIC_DIR) && fs.statSync(STATIC_DIR).isDirectory();
} catch (err) {
  console.error(`Ошибка при проверке директории ${STATIC_DIR}:`, err);
}

// Если директория существует, настраиваем статический сервер
if (staticDirExists) {
  console.log(`Найдена директория статики: ${STATIC_DIR}`);
  
  // Настраиваем статический сервер
  app.use(express.static(STATIC_DIR));
  
  // Настраиваем SPA-роутинг (все запросы к несуществующим файлам направляем на index.html)
  app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, STATIC_DIR, 'index.html'));
  });
} else {
  console.warn(`ВНИМАНИЕ: Директория статики ${STATIC_DIR} не найдена!`);
  
  // Если статика не найдена, покажем информационную страницу
  app.get('*', (req, res) => {
    // Получаем список файлов и директорий
    let fileList = [];
    try {
      fileList = fs.readdirSync('.').map(item => {
        try {
          const stat = fs.statSync(item);
          return `${stat.isDirectory() ? 'D' : 'F'} ${item}`;
        } catch (e) {
          return `? ${item} (error: ${e.message})`;
        }
      });
    } catch (err) {
      fileList = [`Ошибка чтения директории: ${err.message}`];
    }
    
    // Отправляем информационную страницу
    res.send(`
      <!DOCTYPE html>
      <html>
      <head>
        <title>Express Server для Railway</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
          ul { padding-left: 20px; }
        </style>
      </head>
      <body>
        <h1>Express Server для Railway</h1>
        
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
            <li>/healthcheck</li>
            <li>/api/categories</li>
            <li>/api/brands</li>
            <li>/api/styles</li>
            <li>/api/admin/check</li>
          </ul>
        </div>
        
        <div class="container">
          <h2>Содержимое директории:</h2>
          <pre>${fileList.join('\n')}</pre>
        </div>
      </body>
      </html>
    `);
  });
}

// Запуск сервера
app.listen(PORT, '0.0.0.0', () => {
  console.log(`
===========================================
    EXPRESS SERVER FOR RAILWAY STARTED    
===========================================
Порт: ${PORT}
Время запуска: ${new Date().toLocaleString()}
Окружение: ${process.env.NODE_ENV || 'development'}
Директория статики: ${staticDirExists ? STATIC_DIR : STATIC_DIR + ' (не найдена)'}
===========================================
  `);
});