/**
 * Простой скрипт проверки здоровья для Railway
 * Возвращает код 0 при успехе и 1 при ошибке
 */

const http = require('http');

// Функция для выполнения HTTP-запроса
const makeRequest = (options) => {
  return new Promise((resolve, reject) => {
    const req = http.request(options, (res) => {
      if (res.statusCode === 200) {
        resolve(true);
      } else {
        reject(new Error(`Health check failed with status: ${res.statusCode}`));
      }
    });

    req.on('error', (err) => {
      reject(err);
    });

    req.setTimeout(5000, () => {
      req.destroy();
      reject(new Error('Request timeout'));
    });

    req.end();
  });
};

// Основная функция проверки
const runHealthCheck = async () => {
  // Даем серверу время на запуск (если это первая проверка)
  await new Promise(resolve => setTimeout(resolve, 2000));

  try {
    await makeRequest({
      host: 'localhost',
      port: 8080,
      path: '/',
      method: 'GET',
      timeout: 5000
    });
    console.log('Health check passed');
    process.exit(0);
  } catch (error) {
    console.error('Health check failed:', error.message);
    process.exit(1);
  }
};

// Запуск проверки
runHealthCheck();