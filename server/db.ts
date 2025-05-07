import { Pool, neonConfig } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-serverless';
import ws from "ws";
import * as schema from "@shared/schema";

neonConfig.webSocketConstructor = ws;

// В производственном окружении уже проверили подключение к базе в start.js
if (!process.env.DATABASE_URL) {
  console.warn(
    "DATABASE_URL не задан. Некоторые функции будут недоступны.",
  );
}

// Создаем соединение с базой только если DATABASE_URL существует
let pool: Pool | null = null;
let db: any = null;

try {
  if (process.env.DATABASE_URL) {
    pool = new Pool({ connectionString: process.env.DATABASE_URL });
    db = drizzle({ client: pool, schema });
    console.log("Соединение с базой данных установлено");
  } else {
    console.warn("Запуск без соединения с базой данных");
  }
} catch (err) {
  console.error("Ошибка при подключении к базе данных:", err);
  console.warn("Продолжение работы без базы данных");
}

export { pool, db };