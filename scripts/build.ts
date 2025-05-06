/**
 * Скрипт для сборки серверной части приложения для Production
 * Решает проблемы с путями импорта в ESM
 */

import { exec } from 'child_process';
import fs from 'fs/promises';
import path from 'path';

// Путь к корневой директории проекта
const ROOT_DIR = path.resolve(process.cwd());

async function build() {
  // Шаг 1: Сборка серверной части с esbuild
  console.log('⚙️ Building server with esbuild...');
  
  const esbuildCommand = 'esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist';
  
  await new Promise((resolve, reject) => {
    exec(esbuildCommand, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error during esbuild: ${error}`);
        return reject(error);
      }
      if (stderr) console.error(stderr);
      if (stdout) console.log(stdout);
      resolve(null);
    });
  });

  // Шаг 2: Исправление импортов в собранном файле
  console.log('🔄 Fixing import paths in the built server file...');
  
  const serverFilePath = path.join(ROOT_DIR, 'dist', 'index.js');
  let serverContent = await fs.readFile(serverFilePath, 'utf8');
  
  // Исправление импортов shared схемы
  serverContent = serverContent.replace(
    /from\s+["']@shared\/schema["']/g, 
    'from "../shared/schema.js"'
  );
  
  // Сохранение обновленного файла
  await fs.writeFile(serverFilePath, serverContent, 'utf8');
  
  // Шаг 3: Копирование shared директории в dist
  console.log('📁 Copying shared directory to dist...');
  
  await fs.mkdir(path.join(ROOT_DIR, 'dist', 'shared'), { recursive: true });
  
  try {
    const schemaContent = await fs.readFile(
      path.join(ROOT_DIR, 'shared', 'schema.ts'), 
      'utf8'
    );
    
    // Преобразование TypeScript в JavaScript
    let jsContent = schemaContent
      .replace(/import\s+{([^}]*)}\s+from\s+["']drizzle-orm\/pg-core["'];?/g, 
              'import {$1} from "drizzle-orm/pg-core";')
      .replace(/import\s+{([^}]*)}\s+from\s+["']drizzle-zod["'];?/g, 
              'import {$1} from "drizzle-zod";')
      .replace(/import\s+{([^}]*)}\s+from\s+["']zod["'];?/g, 
              'import {$1} from "zod";')
      .replace(/export\s+type\s+[^{]*{[^}]*};?/g, '') // Удаление экспорта типов
      .replace(/:\s*[a-zA-Z<>[\]]+\s*=/g, ' =') // Удаление аннотаций типов
      .replace(/:\s*[a-zA-Z<>[\]]+,/g, ',') // Удаление аннотаций типов в объектах
      .replace(/:\s*[a-zA-Z<>[\]]+\)/g, ')'); // Удаление аннотаций типов в параметрах
      
    await fs.writeFile(
      path.join(ROOT_DIR, 'dist', 'shared', 'schema.js'), 
      jsContent, 
      'utf8'
    );
    
    console.log('✅ Build completed successfully!');
  } catch (error) {
    console.error('❌ Error during build:', error);
    process.exit(1);
  }
}

build().catch(console.error);