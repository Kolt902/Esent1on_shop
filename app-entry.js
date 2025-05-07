#!/usr/bin/env node

/**
 * Упрощенный вход в приложение без дополнительных импортов
 * Файл должен быть скопирован в корень /app
 */

try {
  // Вывод информации о рабочей директории
  console.log('Working directory:', process.cwd());
  console.log('Environment:', process.env.NODE_ENV);
  console.log('Checking for files...');
  
  const fs = require('fs');
  
  // Перечислим содержимое директории
  const files = fs.readdirSync('.');
  console.log('Files in current directory:', files);
  
  // Проверяем основные файлы
  for (const fileToCheck of ['index.js', 'server.js', 'package.json']) {
    console.log(`Checking for ${fileToCheck}:`, files.includes(fileToCheck) ? 'FOUND' : 'NOT FOUND');
  }
  
  // Проверка директорий
  for (const dirToCheck of ['public', 'dist']) {
    try {
      const stat = fs.statSync(dirToCheck);
      console.log(`Checking for ${dirToCheck}:`, stat.isDirectory() ? 'FOUND (directory)' : 'FOUND (not a directory)');
      
      if (stat.isDirectory()) {
        console.log(`Contents of ${dirToCheck}:`, fs.readdirSync(dirToCheck));
      }
    } catch (e) {
      console.log(`Checking for ${dirToCheck}: NOT FOUND`);
    }
  }
  
  // Попытка выполнить index.js
  if (files.includes('index.js')) {
    console.log('Attempting to require ./index.js');
    require('./index.js');
  } 
  // Затем попробовать server.js
  else if (files.includes('server.js')) {
    console.log('Attempting to require ./server.js');
    require('./server.js');
  }
  // Резервный план - минимальный сервер
  else {
    console.log('Neither index.js nor server.js found, starting minimal server');
    
    // Создаем минимальный сервер
    const express = require('express');
    const app = express();
    const PORT = process.env.PORT || 8080;
    
    app.get('/', (req, res) => {
      res.send('Esention API Server is working!');
    });
    
    app.get('/healthcheck', (req, res) => {
      res.json({ status: 'ok' });
    });
    
    app.listen(PORT, '0.0.0.0', () => {
      console.log(`Minimal server running on port ${PORT}`);
    });
  }
} catch (error) {
  console.error('Fatal error:', error);
}