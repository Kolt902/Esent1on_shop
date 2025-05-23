import { Home, ShoppingBag, MessageCircle, User, Heart, ShieldCheck, Shirt } from "lucide-react";
import { openTelegramChat, isRunningInTelegram, getCurrentUser } from "@/lib/telegram";
import { useEffect, useState } from "react";
import { apiRequest } from "@/lib/queryClient";
import { useTranslation } from "@/lib/translations";
import { useLocation } from "wouter";

interface FooterProps {
  cartCount: number;
  onCartClick: () => void;
  onHomeClick: () => void;
}

export default function Footer({ cartCount, onCartClick, onHomeClick }: FooterProps) {
  const [activeTab, setActiveTab] = useState<string>("home");
  const [isTelegram, setIsTelegram] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const { t } = useTranslation();
  const [location, setLocation] = useLocation();
  
  // Стили для кнопок меню
  const activeStyle = "text-white scale-110 font-bold transition-transform";
  const inactiveStyle = "text-gray-400 hover:text-gray-200 hover:scale-105";
  
  // Вспомогательный компонент для индикатора активной вкладки
  const ActiveIndicator = () => (
    <div className="absolute -top-2 left-1/2 transform -translate-x-1/2 w-8 h-1 bg-white rounded-full shadow-sm"></div>
  );
  
  // Detect if running in Telegram on mount and set active tab based on current location
  useEffect(() => {
    setIsTelegram(isRunningInTelegram());
    
    // Устанавливаем активный таб в зависимости от текущего местоположения
    if (location === "/") {
      setActiveTab("home");
    } else if (location === "/profile") {
      setActiveTab("profile");
    } else if (location === "/favorites") {
      setActiveTab("favorites");
    } else if (location === "/admin") {
      setActiveTab("admin");
    }
    // Временно отключена виртуальная примерка
    /* else if (location === "/virtual-fitting") {
      setActiveTab("virtual-fitting");
    } */
    
    // Проверка прав администратора
    const checkAdminStatus = async () => {
      try {
        const response = await apiRequest("/api/admin/check", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          }
        });
        
        if (response && response.isAdmin) {
          setIsAdmin(true);
        }
      } catch (error) {
        console.error("Failed to check admin status:", error);
        setIsAdmin(false);
      }
    };
    
    checkAdminStatus();
  }, [location]);
  
  const handleContactClick = () => {
    openTelegramChat();
  };
  
  const handleAdminClick = () => {
    setLocation("/admin");
  };
  
  const handleTabClick = (tab: string) => {
    setActiveTab(tab);
    
    switch(tab) {
      case "home":
        onHomeClick();
        break;
      case "cart":
        onCartClick();
        break;
      case "contact":
        handleContactClick();
        break;
      case "profile":
        // Переход на страницу профиля с использованием wouter
        setLocation("/profile");
        break;
      case "favorites":
        // Переход на страницу избранного с использованием wouter
        setLocation("/favorites");
        break;
      case "admin":
        handleAdminClick();
        break;
      // Временно отключено
      /*
      case "virtual-fitting":
        // Переход на страницу виртуальной примерочной
        setLocation("/virtual-fitting");
        break;
      */
    }
  };
  
  // In Telegram, we might not need all the navigation items
  // as Telegram has its own navigation controls
  return (
    <footer className="bg-black text-white rounded-t-[30px] border-t border-gray-800 py-4 fixed bottom-0 left-0 right-0 shadow-xl z-50 transition-all duration-300" style={{ backgroundColor: '#000000' }}>
      <div className="container mx-auto px-4">
        <div className="flex justify-between items-center">
          <button 
            onClick={() => handleTabClick("home")}
            className={`flex flex-col items-center justify-center transition-all duration-200 relative ${
              activeTab === "home" ? activeStyle : inactiveStyle
            }`}
            aria-label="Home"
          >
            {activeTab === "home" && <ActiveIndicator />}
            <Home className="h-6 w-6" />
            <span className="text-xs font-medium mt-1">{t.common.home}</span>
          </button>

          <button 
            onClick={() => handleTabClick("cart")}
            className={`flex flex-col items-center justify-center relative transition-all duration-200 ${
              activeTab === "cart" ? activeStyle : inactiveStyle
            }`}
            aria-label="Cart"
          >
            {activeTab === "cart" && <ActiveIndicator />}
            <ShoppingBag className="h-6 w-6" />
            {cartCount > 0 && (
              <span className="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] w-5 h-5 flex items-center justify-center rounded-full font-bold shadow-sm animate-pulse">
                {cartCount > 9 ? '9+' : cartCount}
              </span>
            )}
            <span className="text-xs font-medium mt-1">{t.common.cart}</span>
          </button>
          
          <button 
            onClick={() => handleTabClick("favorites")}
            className={`flex flex-col items-center justify-center transition-all duration-200 relative ${
              activeTab === "favorites" ? activeStyle : inactiveStyle
            }`}
            aria-label="Favorites"
          >
            {activeTab === "favorites" && <ActiveIndicator />}
            <Heart className="h-6 w-6" />
            <span className="text-xs font-medium mt-1">{t.profile.favorites}</span>
          </button>
          
          {/* Кнопка связи удалена по запросу пользователя */}

          {/* Показываем профиль всегда, даже в Telegram */}
          <button 
            onClick={() => handleTabClick("profile")}
            className={`flex flex-col items-center justify-center transition-all duration-200 relative ${
              activeTab === "profile" ? activeStyle : inactiveStyle
            }`}
            aria-label="Profile"
          >
            {activeTab === "profile" && <ActiveIndicator />}
            <User className="h-6 w-6" />
            <span className="text-xs font-medium mt-1">{t.profile.title}</span>
          </button>
          
          {/* Кнопка виртуальной примерочной - временно скрыта */}
          {/* 
          <button 
            onClick={() => handleTabClick("virtual-fitting")}
            className={`flex flex-col items-center justify-center transition-all duration-200 relative ${
              activeTab === "virtual-fitting" ? activeStyle : inactiveStyle
            }`}
            aria-label="Virtual Fitting"
          >
            {activeTab === "virtual-fitting" && <ActiveIndicator />}
            <Shirt className="h-6 w-6" />
            <span className="text-xs font-medium mt-1">Примерка</span>
          </button>
          */}
          
          {/* Show admin button if user is admin */}
          {isAdmin && (
            <button 
              onClick={() => handleTabClick("admin")}
              className={`flex flex-col items-center justify-center transition-all duration-200 relative ${
                activeTab === "admin" ? activeStyle : inactiveStyle
              }`}
              aria-label="Admin Panel"
            >
              {activeTab === "admin" && <ActiveIndicator />}
              <ShieldCheck className="h-6 w-6" />
              <span className="text-xs font-medium mt-1">{t.settings?.admin || "Админ"}</span>
            </button>
          )}
        </div>
      </div>
    </footer>
  );
}
