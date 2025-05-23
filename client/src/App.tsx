import { Switch, Route } from "wouter";
import { queryClient } from "./lib/queryClient";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import StorePage from "@/pages/StorePage";
import AdminPage from "@/pages/AdminPage";
import ProfilePage from "@/pages/ProfilePage";
import ProfileSettingsPage from "@/pages/ProfileSettingsPage";
import VirtualFittingPage from "@/pages/VirtualFittingPage";
import ProductDetailPage from "@/pages/ProductDetailPage";
import CategoryPage from "@/pages/CategoryPage";
import BrandPage from "@/pages/BrandPage";
import StylePage from "@/pages/StylePage";
import NotFound from "@/pages/not-found";
import { useEffect, useState } from "react";
import { getTelegramWebApp, isRunningInTelegram } from "@/lib/telegram";
import { StoreProvider } from "@/lib/StoreContext";

function Router() {
  return (
    <Switch>
      <Route path="/" component={StorePage}/>
      <Route path="/admin" component={AdminPage}/>
      <Route path="/profile" component={ProfilePage}/>
      <Route path="/settings" component={ProfileSettingsPage}/>
      <Route path="/virtual-fitting" component={VirtualFittingPage}/>
      <Route path="/product/:id" component={ProductDetailPage}/>
      
      {/* Новые маршруты для категорий, брендов и стилей */}
      <Route path="/category/:category" component={CategoryPage}/>
      <Route path="/brand/:brand" component={BrandPage}/>
      <Route path="/style/:style" component={StylePage}/>
      
      {/* Обработка всех остальных маршрутов */}
      <Route component={NotFound} />
    </Switch>
  );
}

function App() {
  // Состояние для отображения загрузки
  const [isAppReady, setIsAppReady] = useState(false);
  const [telegramInitialized, setTelegramInitialized] = useState(false);
  
  // Эффект для инициализации приложения
  useEffect(() => {
    // Проверяем запуск в Telegram
    const inTelegram = isRunningInTelegram();
    console.log(`App running in Telegram: ${inTelegram}`);
    
    // Проверяем наличие query параметра admin=true, чтобы направить на админ-панель
    const urlParams = new URLSearchParams(window.location.search);
    const isAdminRoute = urlParams.get('admin') === 'true';
    
    if (isAdminRoute) {
      console.log("Admin mode detected in URL parameters, will redirect to admin page");
      // Редирект на админ-панель будет выполнен после инициализации
    }
    
    if (inTelegram) {
      // В среде Telegram даем больше времени на инициализацию
      const webApp = getTelegramWebApp();
      
      if (webApp) {
        setTelegramInitialized(true);
        console.log("Telegram WebApp object found, ready to proceed");
        
        // При наличии Telegram UI элементов используем их
        if (webApp.MainButton) {
          webApp.MainButton.hide();
        }
        
        // Настраиваем взаимодействие с Telegram WebApp
        // В версии 6.0 Telegram WebApp некоторые методы устарели, 
        // поэтому добавляем проверки перед вызовом
        
        // Проверяем поддержку функций перед вызовом
        if (typeof webApp.setHeaderColor === 'function') {
          try {
            webApp.setHeaderColor('#FFFFFF');
          } catch (e) {
            console.log("setHeaderColor not supported in this version");
          }
        }
        
        if (typeof webApp.setBackgroundColor === 'function') {
          try {
            webApp.setBackgroundColor('#FFFFFF');
          } catch (e) {
            console.log("setBackgroundColor not supported in this version");
          }
        }
        
        // Если это админ-маршрут, включаем соответствующие UI элементы
        if (isAdminRoute) {
          try {
            // Скрываем кнопку "назад", чтобы пользователь не мог случайно закрыть панель
            if (webApp.BackButton) {
              webApp.BackButton.hide();
            }
          } catch (e) {
            console.log("BackButton operations not supported in this version");
          }
        }
      } else {
        console.warn("Telegram WebApp object not found, but isRunningInTelegram returned true");
      }
    }
    
    // Задержка перед отображением контента
    const timeout = inTelegram ? 800 : 300;
    const timer = setTimeout(() => {
      setIsAppReady(true);
      console.log("App marked as ready after timeout:", timeout);
      
      // Если это запрос на админ-панель, перенаправляем пользователя
      if (isAdminRoute) {
        window.location.href = "/admin?force_admin=true";
      }
    }, timeout);
    
    return () => clearTimeout(timer);
  }, []);
  
  // Если приложение не готово, показываем загрузчик
  if (!isAppReady) {
    return (
      <div className="loading-screen">
        <div className="inline-block h-12 w-12 animate-spin rounded-full border-4 border-solid border-[#0088CC] border-r-transparent"></div>
        <p className="mt-4 text-[#0088CC] font-medium">Загрузка приложения...</p>
        {isRunningInTelegram() && (
          <p className="mt-2 text-sm text-gray-500">
            {telegramInitialized ? "Telegram WebApp инициализирован" : "Инициализация Telegram..."}
          </p>
        )}
      </div>
    );
  }
  
  // Полное приложение
  return (
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <StoreProvider>
          <Toaster />
          <Router />
        </StoreProvider>
      </TooltipProvider>
    </QueryClientProvider>
  );
}

export default App;
