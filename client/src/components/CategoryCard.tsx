import React from 'react';
import { cn } from '@/lib/utils';

interface CategoryCardProps {
  title: string;
  description: string;
  imageUrl: string;
  onClick: () => void;
  isSelected?: boolean;
}

const CategoryCard: React.FC<CategoryCardProps> = ({
  title,
  description,
  imageUrl,
  onClick,
  isSelected = false
}) => {
  return (
    <div 
      onClick={onClick}
      className={cn(
        "relative overflow-hidden rounded-xl cursor-pointer transform transition-all duration-300",
        "hover:shadow-xl hover:scale-[1.02] shadow-md h-40 md:h-48",
        isSelected ? "ring-2 ring-black ring-offset-2 scale-[1.02]" : ""
      )}
    >
      {/* Background Image with Gradient Overlay */}
      <div className="absolute inset-0 w-full h-full bg-gradient-to-t from-black to-transparent opacity-70 z-10"></div>
      
      {/* Image */}
      <img 
        src={imageUrl} 
        alt={title} 
        className="absolute inset-0 w-full h-full object-cover object-center transition-transform duration-700 hover:scale-105"
      />
      
      {/* Content */}
      <div className="absolute bottom-0 left-0 right-0 p-4 z-20">
        <h3 className="text-xl font-bold text-white">{title}</h3>
        <p className="text-sm text-gray-200 mt-1">{description}</p>
      </div>
      
      {/* Selected indicator */}
      {isSelected && (
        <div className="absolute top-2 right-2 z-20 bg-white text-black text-xs px-2 py-0.5 rounded-full font-medium">
          ✓
        </div>
      )}
    </div>
  );
};

export default CategoryCard;