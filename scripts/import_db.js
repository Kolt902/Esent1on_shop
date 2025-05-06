#!/usr/bin/env node

/**
 * Скрипт для импорта SQL-дампа в базу данных
 * Используйте его для восстановления данных из бэкапа на новой базе данных Railway
 */

import { exec } from 'child_process';
import fs from 'fs';
import path from 'path';
import util from 'util';
import readline from 'readline';

const execPromise = util.promisify(exec);

// Создаем интерфейс для чтения ввода пользователя
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Проверяем наличие переменной DATABASE_URL
if (!process.env.DATABASE_URL) {
  console.error('Ошибка: Переменная окружения DATABASE_URL не установлена.');
  process.exit(1);
}

const backupDir = path.join(process.cwd(), 'scripts/db_backup');

// Функция для получения списка доступных бэкапов
function getAvailableBackups() {
  try {
    if (!fs.existsSync(backupDir)) {
      console.error(`Директория ${backupDir} не существует.`);
      return [];
    }
    
    const files = fs.readdirSync(backupDir)
      .filter(file => file.endsWith('.sql'))
      .filter(file => !file.includes('.schema.sql') && !file.includes('.data.sql'));
    
    return files;
  } catch (error) {
    console.error('Ошибка при получении списка бэкапов:', error);
    return [];
  }
}

// Функция для импорта данных из бэкапа
async function importBackup(backupFile) {
  try {
    const fullPath = path.join(backupDir, backupFile);
    
    console.log(`Импорт базы данных из файла: ${fullPath}`);
    console.log('Это может занять некоторое время...');
    
    await execPromise(`psql ${process.env.DATABASE_URL} < "${fullPath}"`);
    
    console.log('Импорт базы данных успешно завершен.');
  } catch (error) {
    console.error('Ошибка при импорте базы данных:', error);
    process.exit(1);
  }
}

// Запрос на выбор файла для импорта
const backups = getAvailableBackups();

if (backups.length === 0) {
  console.log('Не найдено доступных бэкапов для импорта.');
  rl.close();
  process.exit(0);
}

console.log('Доступные бэкапы:');
backups.forEach((backup, index) => {
  console.log(`${index + 1}. ${backup}`);
});

rl.question('Выберите номер бэкапа для импорта (или введите "q" для отмены): ', (answer) => {
  if (answer.toLowerCase() === 'q') {
    console.log('Операция отменена.');
    rl.close();
    return;
  }
  
  const index = parseInt(answer) - 1;
  if (isNaN(index) || index < 0 || index >= backups.length) {
    console.error('Некорректный выбор.');
    rl.close();
    return;
  }
  
  rl.question(`ВНИМАНИЕ: Импорт заменит ВСЕ существующие данные в базе данных. Продолжить? (y/n): `, (confirm) => {
    if (confirm.toLowerCase() === 'y') {
      importBackup(backups[index]).then(() => {
        rl.close();
      });
    } else {
      console.log('Операция отменена.');
      rl.close();
    }
  });
});

rl.on('close', () => {
  process.exit(0);
});