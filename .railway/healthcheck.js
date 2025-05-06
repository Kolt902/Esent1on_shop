/**
 * Простой скрипт проверки здоровья для Railway
 * Возвращает код 0 при успехе и 1 при ошибке
 */

// Проверяем базовую работоспособность приложения
const http = require('node:http');

const options = {
  // Используем localhost и порт 8080 для проверки
  hostname: 'localhost',
  port: process.env.PORT || 8080,
  path: '/healthz',
  method: 'GET',
  timeout: 5000, // 5 секунд таймаут
};

function checkHealth() {
  return new Promise((resolve, reject) => {
    const req = http.request(options, (res) => {
      // Успешным считаем код 200-299
      if (res.statusCode >= 200 && res.statusCode < 300) {
        console.log(`Health check passed with status ${res.statusCode}`);
        resolve(true);
      } else {
        console.error(`Health check failed with status ${res.statusCode}`);
        reject(new Error(`Failed with status ${res.statusCode}`));
      }
    });

    req.on('error', (err) => {
      console.error(`Health check request error: ${err.message}`);
      reject(err);
    });

    req.on('timeout', () => {
      console.error('Health check request timed out');
      req.destroy();
      reject(new Error('Request timed out'));
    });

    req.end();
  });
}

async function main() {
  try {
    // Ждем 5 секунд перед первой проверкой чтобы приложение успело запуститься
    console.log('Waiting for application to start...');
    await new Promise(resolve => setTimeout(resolve, 5000));
    
    // Пробуем до 3 раз с интервалом 2 секунды
    for (let i = 0; i < 3; i++) {
      try {
        await checkHealth();
        // Если дошли сюда - все хорошо, выходим с кодом 0
        process.exit(0);
      } catch (err) {
        console.log(`Attempt ${i+1} failed: ${err.message}`);
        if (i < 2) {
          // Еще есть попытки, ждем 2 секунды и пробуем снова
          await new Promise(resolve => setTimeout(resolve, 2000));
        }
      }
    }
    
    // Если дошли сюда, все проверки провалились
    console.error('Health check failed after 3 attempts');
    process.exit(1);
  } catch (error) {
    console.error('Unexpected error:', error);
    process.exit(1);
  }
}

main();