// Ультра-минимальный сервер для тестирования Railway

const http = require('http');

// Создаем простейший HTTP сервер
const server = http.createServer((req, res) => {
  console.log(`Запрос: ${req.method} ${req.url}`);
  
  // Проверка здоровья для Railway
  if (req.url === '/healthcheck') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }
  
  // Отвечаем простой HTML страницей
  res.writeHead(200, { 'Content-Type': 'text/html' });
  res.end(`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Railway Test</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
      <body style="font-family: sans-serif; max-width: 500px; margin: 0 auto; padding: 20px;">
        <h1>Railway Test Server</h1>
        <p>Сервер запущен и работает!</p>
        <p>Время сервера: ${new Date().toLocaleString()}</p>
        <p>NODE_ENV: ${process.env.NODE_ENV || 'не установлен'}</p>
        <hr>
        <p><a href="/healthcheck">Проверка здоровья</a></p>
      </body>
    </html>
  `);
});

// Запускаем сервер
const PORT = process.env.PORT || 8080;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});