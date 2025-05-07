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
  
  // Запускаем сборку клиента с помощью Vite
  console.log('🏗️ Сборка клиентской части с Vite...');
  execSync('npx vite build', { stdio: 'inherit' });
  
  // Проверяем, что директория dist существует
  if (!fs.existsSync(resolve(__dirname, 'dist'))) {
    fs.mkdirSync(resolve(__dirname, 'dist'));
  }
  
  // Копируем server/index.ts в dist/index.js с минимальной трансформацией
  console.log('🔄 Копирование server/index.ts в dist/index.js...');
  const serverCode = fs.readFileSync(resolve(__dirname, 'server/index.ts'), 'utf8');
  
  // Заменяем импорты с алиасами на относительные пути
  const transformedCode = serverCode
    .replace(/from\s+["']@shared\/(.*?)["']/g, 'from "../shared/$1"')
    .replace(/from\s+["']@server\/(.*?)["']/g, 'from "./$1"')
    .replace(/\.ts["']/g, '.js"');
  
  fs.writeFileSync(resolve(__dirname, 'dist/index.js'), transformedCode);
  
  // Копируем другие важные файлы сервера
  console.log('📋 Копирование других серверных файлов...');
  const serverFiles = [
    'routes.ts',
    'storage.ts',
    'telegram.ts',
    'vite.ts',
    'dbStorage.ts',
    'db.ts',
    'middleware.ts',
    'healthcheck.ts'
  ];
  
  serverFiles.forEach(file => {
    const content = fs.readFileSync(resolve(__dirname, `server/${file}`), 'utf8');
    const transformed = content
      .replace(/from\s+["']@shared\/(.*?)["']/g, 'from "../shared/$1"')
      .replace(/from\s+["']@server\/(.*?)["']/g, 'from "./$1"')
      .replace(/\.ts["']/g, '.js"');
    
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