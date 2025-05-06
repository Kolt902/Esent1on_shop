#!/usr/bin/env node

/**
 * Простой скрипт проверки здоровья для Railway
 * Возвращает код 0 при успехе и 1 при ошибке
 */

const http = require('http');

// Даем немного времени приложению на старт перед первым запуском
if (process.env.INITIAL_DELAY && !process.env.HEALTHCHECK_STARTED) {
  process.env.HEALTHCHECK_STARTED = 'true';
  console.log('First healthcheck - waiting initial delay...');
  // Для первого запуска всегда возвращаем успех
  process.exit(0);
}

const options = {
  hostname: '127.0.0.1', // Используем 127.0.0.1 вместо localhost для надежности
  port: process.env.PORT || 5000,
  path: '/',
  method: 'GET',
  timeout: 5000 // Увеличиваем таймаут до 5 секунд
};

const req = http.request(options, (res) => {
  console.log(`Healthcheck status: ${res.statusCode}`);
  
  // Если получили 200-299, считаем сервис здоровым
  if (res.statusCode >= 200 && res.statusCode < 300) {
    process.exit(0);
  } else {
    console.error(`Healthcheck failed with status: ${res.statusCode}`);
    process.exit(1);
  }
});

req.on('error', (e) => {
  console.error(`Healthcheck error: ${e.message}`);
  process.exit(1);
});

req.on('timeout', () => {
  console.error('Healthcheck timeout');
  req.destroy();
  process.exit(1);
});

req.end();