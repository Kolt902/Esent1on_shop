#!/usr/bin/env node

/**
 * Скрипт для экспорта существующей базы данных в SQL-скрипт
 * Это позволит нам переносить данные между инстансами баз данных
 * Используйте его для создания резервной копии перед деплоем на Railway
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

const outputDir = path.join(process.cwd(), 'scripts/db_backup');
const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
const outputFile = path.join(outputDir, `db_backup_${timestamp}.sql`);

// Функция для выполнения pg_dump
async function performExport() {
  try {
    // Создаем директорию для бэкапа, если она не существует
    if (!fs.existsSync(outputDir)) {
      fs.mkdirSync(outputDir, { recursive: true });
      console.log(`Создана директория: ${outputDir}`);
    }

    // Выполняем pg_dump через встроенный psql с явным указанием формата SQL
    console.log('Экспорт базы данных...');
    await execPromise(`pg_dump --schema-only --no-owner --no-privileges ${process.env.DATABASE_URL} > "${outputFile}.schema.sql"`);
    console.log(`Структура базы данных успешно экспортирована в: ${outputFile}.schema.sql`);
    
    // Экспортируем данные
    await execPromise(`pg_dump --data-only --no-owner --no-privileges ${process.env.DATABASE_URL} > "${outputFile}.data.sql"`);
    console.log(`Данные базы данных успешно экспортированы в: ${outputFile}.data.sql`);
    
    // Объединяем файлы
    await execPromise(`cat "${outputFile}.schema.sql" "${outputFile}.data.sql" > "${outputFile}"`);
    console.log(`Полный бэкап создан в: ${outputFile}`);
    
    // Удаляем временные файлы
    fs.unlinkSync(`${outputFile}.schema.sql`);
    fs.unlinkSync(`${outputFile}.data.sql`);
    
    console.log('Экспорт базы данных успешно завершен.');
  } catch (error) {
    console.error('Ошибка при экспорте базы данных:', error);
    process.exit(1);
  }
}

// Запрашиваем подтверждение
rl.question('Это действие создаст резервную копию вашей базы данных. Продолжить? (y/n): ', (answer) => {
  if (answer.toLowerCase() === 'y') {
    performExport().then(() => {
      rl.close();
    });
  } else {
    console.log('Операция отменена.');
    rl.close();
  }
});

rl.on('close', () => {
  process.exit(0);
});