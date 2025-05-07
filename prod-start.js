#!/usr/bin/env node

/**
 * Скрипт для запуска production-сервера
 */

// Вывод информации о директориях для диагностики
console.log('===== PRODUCTION STARTUP DIAGNOSTICS =====');
console.log('Working directory: ' + process.cwd());
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Пробуем выдать файлу server-production.js права на исполнение
try {
  console.log('Trying to make server-production.js executable...');
  execSync('chmod +x server-production.js', { stdio: 'inherit' });
} catch (err) {
  console.warn('Failed to make file executable:', err.message);
}

// Проверяем существование server-production.js
if (fs.existsSync('./server-production.js')) {
  console.log('Server production file exists.');
} else {
  console.error('server-production.js not found in the current directory!');
  if (fs.existsSync('/app/server-production.js')) {
    console.log('Found at /app/server-production.js');
  } else {
    console.error('server-production.js not found in /app directory either!');
  }
}

// Непосредственно запускаем production-сервер
console.log('Starting production server...');
try {
  execSync('node server-production.js', { stdio: 'inherit' });
} catch (err) {
  console.error('Failed to start server from server-production.js:', err.message);
  
  // Пробуем альтернативный путь
  try {
    console.log('Trying alternative path: /app/server-production.js');
    execSync('node /app/server-production.js', { stdio: 'inherit' });
  } catch (altErr) {
    console.error('Failed to start server from alternative path:', altErr.message);
    process.exit(1);
  }
}