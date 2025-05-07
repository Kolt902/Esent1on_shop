// Простой скрипт для сборки приложения в Railway
// Заменяет поведение 'npm run build' на более простое
import { execSync } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Устанавливаем NODE_ENV в production
process.env.NODE_ENV = 'production';

try {
  console.log('📦 Начало сборки для Railway...');
  
  // Запускаем установку всех необходимых пакетов
  console.log('📦 Проверка установки всех зависимостей...');
  execSync('npm ci --production', { stdio: 'inherit' });
  
  // Запускаем сборку клиента с помощью Vite
  console.log('🏗️ Сборка клиентской части с Vite...');
  execSync('npx vite build', { stdio: 'inherit' });
  
  // Проверяем, что директория dist существует
  if (!fs.existsSync(resolve(__dirname, 'dist'))) {
    fs.mkdirSync(resolve(__dirname, 'dist'));
  }
  
  // Создаем минимальный серверный файл
  console.log('🔄 Создание упрощенной версии сервера...');
  
  // Создаем простой Express сервер, который только раздает статические файлы
  const simpleServerCode = `
// Упрощенная версия сервера для Railway - без Vite и других dev-зависимостей
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';
import { db } from './db.js';
import { registerRoutes } from './routes.js';
import { setupHealthCheck } from './healthcheck.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Базовый порт и настройки окружения
const PORT = process.env.PORT || 8080;
process.env.NODE_ENV = 'production';

// Создаем Express приложение
const app = express();
app.use(express.json());

// Настраиваем здоровье приложения
setupHealthCheck(app);

// Раздаем статические файлы из директории 'public'
const publicDir = path.resolve(__dirname, 'public');
app.use(express.static(publicDir));

// Регистрируем API маршруты
const httpServer = await registerRoutes(app);

// Для всех остальных запросов отдаем index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(publicDir, 'index.html'));
});

// Запускаем сервер
httpServer.listen(PORT, '0.0.0.0', () => {
  console.log(\`Сервер запущен в \${process.env.NODE_ENV} режиме на порту \${PORT}\`);
});
`;

  fs.writeFileSync(resolve(__dirname, 'dist/index.js'), simpleServerCode);
  
  // Копируем другие важные файлы сервера
  console.log('📋 Копирование других серверных файлов...');
  const serverFiles = [
    'routes.ts',
    'storage.ts',
    'telegram.ts',
    'dbStorage.ts',
    'db.ts',
    'middleware.ts',
    'healthcheck.ts'
  ];
  
  // Убираем vite.ts из списка копируемых файлов, так как он вызывает ошибку с @vitejs/plugin-react
  
  serverFiles.forEach(file => {
    const content = fs.readFileSync(resolve(__dirname, `server/${file}`), 'utf8');
    let transformed = content
      .replace(/from\s+["']@shared\/(.*?)["']/g, 'from "../shared/$1"')
      .replace(/from\s+["']@server\/(.*?)["']/g, 'from "./$1"')
      .replace(/\.ts["']/g, '.js"');
    
    // Удаляем импорт vite из routes.ts
    if (file === 'routes.ts') {
      transformed = transformed.replace(/import.*from\s+["']\.\/vite\.js["'];?\n?/g, '');
      transformed = transformed.replace(/await\s+setupVite\(app,\s*httpServer\);/g, '// Vite отключен в production');
    }
    
    fs.writeFileSync(resolve(__dirname, `dist/${file.replace('.ts', '.js')}`), transformed);
  });
  
  // Копируем shared директорию
  console.log('📋 Копирование shared директории...');
  if (!fs.existsSync(resolve(__dirname, 'dist/shared'))) {
    fs.mkdirSync(resolve(__dirname, 'dist/shared'));
  }
  
  const sharedFiles = [
    'schema.ts',
  ];
  
  sharedFiles.forEach(file => {
    const content = fs.readFileSync(resolve(__dirname, `shared/${file}`), 'utf8');
    const transformed = content
      .replace(/\.ts["']/g, '.js"');
    
    fs.writeFileSync(resolve(__dirname, `dist/shared/${file.replace('.ts', '.js')}`), transformed);
  });
  
  console.log('✅ Сборка успешно завершена!');
} catch (error) {
  console.error('❌ Ошибка при сборке:', error);
  process.exit(1);
}