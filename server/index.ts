import express, { type Request, Response, NextFunction } from "express";
import { registerRoutes } from "./routes";
import { setupVite, serveStatic, log } from "./vite";
import { telegramBot } from "./telegram";
import { setupHealthCheck } from "./healthcheck";

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use((req, res, next) => {
  const start = Date.now();
  const path = req.path;
  let capturedJsonResponse: Record<string, any> | undefined = undefined;

  const originalResJson = res.json;
  res.json = function (bodyJson, ...args) {
    capturedJsonResponse = bodyJson;
    return originalResJson.apply(res, [bodyJson, ...args]);
  };

  res.on("finish", () => {
    const duration = Date.now() - start;
    if (path.startsWith("/api")) {
      let logLine = `${req.method} ${path} ${res.statusCode} in ${duration}ms`;
      if (capturedJsonResponse) {
        logLine += ` :: ${JSON.stringify(capturedJsonResponse)}`;
      }

      if (logLine.length > 80) {
        logLine = logLine.slice(0, 79) + "…";
      }

      log(logLine);
    }
  });

  next();
});

(async () => {
  // ВАЖНО: сначала настраиваем API-маршруты и регистрируем сервер
  const server = await registerRoutes(app);

  // затем настраиваем обработку ошибок
  app.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
    const status = err.status || err.statusCode || 500;
    const message = err.message || "Internal Server Error";

    res.status(status).json({ message });
    throw err;
  });

  // затем настраиваем статические файлы и/или Vite в зависимости от среды
  if (app.get("env") === "development") {
    await setupVite(app, server);
  } else {
    serveStatic(app);
  }

  // Для Railway и других хостинг-платформ используем PORT из переменных окружения,
  // а в Replit - порт 5000, который не блокируется фаерволом
  // При использовании Docker, по умолчанию порт 8080
  const port = process.env.PORT ? parseInt(process.env.PORT, 10) : 
    process.env.NODE_ENV === 'production' ? 8080 : 5000;
    
  console.log(`Starting server in ${process.env.NODE_ENV || 'development'} mode on port ${port}`);
  server.listen({
    port,
    host: "0.0.0.0",
    reusePort: true,
  }, async () => {
    log(`serving on port ${port}`);
    
    // Check if bot token is available
    if (process.env.TELEGRAM_BOT_TOKEN) {
      console.log("Bot will be accessible to everyone as requested");
      
      try {
        // Используем метод из класса TelegramBot для получения URL
        const webAppUrl = telegramBot.generateWebAppUrl();
        console.log(`Using Web App URL: ${webAppUrl}`);
        
        // Проверяем доступность URL перед использованием
        try {
          const response = await fetch(webAppUrl, { method: 'HEAD' });
          if (response.ok) {
            console.log(`Web App URL is accessible: ${response.status} ${response.statusText}`);
          } else {
            console.warn(`Web App URL responded with status: ${response.status} ${response.statusText}`);
          }
        } catch (error) {
          console.warn(`Error checking Web App URL accessibility: ${error instanceof Error ? error.message : String(error)}`);
        }
        
        // Настраиваем команды бота с повторными попытками
        const setCommands = async (retries = 3) => {
          for (let i = 0; i < retries; i++) {
            try {
              const response = await fetch(`https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/setMyCommands`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                  commands: [
                    { command: 'start', description: 'Открыть магазин' },
                    { command: 'help', description: 'Показать справку' }
                  ]
                })
              });
              const data = await response.json();
              console.log('Set bot commands result:', data);
              return data;
            } catch (err) {
              console.error(`Error setting bot commands (attempt ${i+1}/${retries}):`, err);
              if (i === retries - 1) throw err;
              await new Promise(r => setTimeout(r, 1000)); // Ждем секунду перед повторной попыткой
            }
          }
        };
        
        // Настраиваем кнопку меню с повторными попытками
        const setMenuButton = async (retries = 3) => {
          for (let i = 0; i < retries; i++) {
            try {
              const response = await fetch(`https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/setChatMenuButton`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                  menu_button: {
                    type: 'web_app',
                    text: 'Открыть магазин',
                    web_app: { url: webAppUrl }
                  }
                })
              });
              const data = await response.json();
              console.log('Set menu button result:', data);
              return data;
            } catch (err) {
              console.error(`Error setting menu button (attempt ${i+1}/${retries}):`, err);
              if (i === retries - 1) throw err;
              await new Promise(r => setTimeout(r, 1000)); // Ждем секунду перед повторной попыткой
            }
          }
        };
        
        // Выполняем настройку параллельно для ускорения
        await Promise.all([
          setCommands().catch(e => console.error('Failed to set commands:', e)),
          setMenuButton().catch(e => console.error('Failed to set menu button:', e))
        ]);
        
        // Запускаем поллинг после настройки команд и меню
        console.log("Starting Telegram polling (long-polling mode)");
        
        // Удаляем webhook перед началом поллинга
        const webhookResponse = await telegramBot.deleteWebhook();
        console.log("Webhook deleted response:", webhookResponse);
        
        // Запускаем поллинг в фоне
        telegramBot.startPolling().catch(error => {
          console.error("Error in polling main loop:", error);
        });
        
        console.log("Telegram bot initialized in polling mode");
      } catch (error) {
        console.error("Error setting up Telegram bot:", error);
      }
    } else {
      console.warn("TELEGRAM_BOT_TOKEN not provided, bot functionality will be limited");
    }
  });
})();
