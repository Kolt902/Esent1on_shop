import { db } from '../server/db.js';
import { products } from '../shared/schema.js';

async function addProducts() {
  const newProducts = [
    // Burberry - трейнч-коут (Casual, Old Money)
    {
      name: "Burberry Chelsea Heritage Trench Coat",
      price: 189000,
      category: "Куртки",
      imageUrl: "https://assets.burberry.com/is/image/Burberryltd/F7D87D2F-5CCD-42F1-B85D-3E6E13A23825.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251",
      additionalImages: [
        "https://assets.burberry.com/is/image/Burberryltd/3B4C25E6-D5DB-4702-9F11-6B4BB193F6BA.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251",
        "https://assets.burberry.com/is/image/Burberryltd/BE0A9F7C-40C0-45A3-8C4F-2714DF23F1AF.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251"
      ],
      sizes: ["36", "38", "40", "42", "44", "46"],
      description: "Классический тренч Burberry Chelsea из водонепроницаемого хлопкового габардина. Культовая модель бренда с фирменной клеткой на подкладке.",
      brand: "Burberry",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 48,
      inStock: true,
      originalUrl: "https://ru.burberry.com/the-waterloo-heritage-trench-coat-p80462971",
      colors: ["Honey", "Black", "Blue"],
      categorySlug: "coats",
      brandSlug: "burberry",
      styleSlug: "old-money"
    },

    // Saint Laurent - куртка-косуха (Streetwear, Casual)
    {
      name: "Saint Laurent Classic Motorcycle Jacket",
      price: 329000,
      category: "Куртки",
      imageUrl: "https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_front.jpg",
      additionalImages: [
        "https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_back.jpg",
        "https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_detail_1.jpg"
      ],
      sizes: ["44", "46", "48", "50", "52"],
      description: "Культовая кожаная косуха Saint Laurent из высококачественной телячьей кожи с классическими байкерскими деталями и легендарным силуэтом.",
      brand: "Saint Laurent",
      style: "Streetwear",
      gender: "men",
      isNew: true,
      discount: 0,
      rating: 47,
      inStock: true,
      originalUrl: "https://www.ysl.com/en-us/leather-motorcycle-jacket-in-black-225935Y5RD21000.html",
      colors: ["Black"],
      categorySlug: "jackets",
      brandSlug: "saint-laurent",
      styleSlug: "streetwear"
    },

    // Chanel - твидовый пиджак (Old Money)
    {
      name: "Chanel Iconic Tweed Jacket",
      price: 399000,
      category: "Пиджаки",
      imageUrl: "https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-default-p82283k17710nf895-8840257896478.jpg",
      additionalImages: [
        "https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-p82283k17710nf895-8840261697566.jpg",
        "https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-a-p82283k17710nf895-8840260550686.jpg"
      ],
      sizes: ["34", "36", "38", "40", "42", "44"],
      description: "Легендарный твидовый пиджак Chanel с фирменными деталями - золотыми пуговицами и отделкой. Символ элегантности и роскоши.",
      brand: "Chanel",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 49,
      inStock: true,
      originalUrl: "https://www.chanel.com/us/fashion/p/P82283K17710NF895/jacket-cotton-tweed-gold-tone-metal/",
      colors: ["Navy Blue", "Black", "Beige"],
      categorySlug: "jackets",
      brandSlug: "chanel",
      styleSlug: "old-money"
    },

    // Loewe - сумка Puzzle (Old Money, Casual)
    {
      name: "Loewe Puzzle Bag Medium",
      price: 285000,
      category: "Сумки",
      imageUrl: "https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-FRONT?fmt=webp&hei=1250",
      additionalImages: [
        "https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_1?fmt=webp&hei=1250",
        "https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_2?fmt=webp&hei=1250"
      ],
      sizes: ["Medium"],
      description: "Культовая модель сумки Puzzle от Loewe из высококачественной кожи с фирменной геометрической конструкцией и трехмерной головоломкой-оригами.",
      brand: "Loewe",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 47,
      inStock: true,
      originalUrl: "https://www.loewe.com/int/en/women/bags/puzzle/puzzle-bag-in-classic-calfskin/A510P22X17-C9990.html",
      colors: ["Black", "Tan", "Ocean Blue"],
      categorySlug: "bags",
      brandSlug: "loewe",
      styleSlug: "old-money"
    },

    // Bottega Veneta - клатч Pouch (Old Money)
    {
      name: "Bottega Veneta The Pouch",
      price: 239000,
      category: "Сумки",
      imageUrl: "https://www.bottegaveneta.com/variants/images/17085864448325636/A/d.jpg",
      additionalImages: [
        "https://www.bottegaveneta.com/variants/images/17085864448325636/A/h.jpg",
        "https://www.bottegaveneta.com/variants/images/17085864448325636/A/e.jpg"
      ],
      sizes: ["One Size"],
      description: "Культовый клатч The Pouch от Bottega Veneta из мягкой кожи наппа с характерным облачным эффектом. Минималистичная роскошь.",
      brand: "Bottega Veneta",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 46,
      inStock: true,
      originalUrl: "https://www.bottegaveneta.com/en-us/the-pouch-black-809639811.html",
      colors: ["Black", "Fondant", "Caramel"],
      categorySlug: "bags",
      brandSlug: "bottega-veneta",
      styleSlug: "old-money"
    },

    // Amiri - джинсы (Streetwear)
    {
      name: "Amiri MX1 Distressed Jeans",
      price: 65000,
      category: "Джинсы",
      imageUrl: "https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_1/amiri-indigo-mx1-jeans.jpg",
      additionalImages: [
        "https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_2/amiri-indigo-mx1-jeans.jpg",
        "https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_3/amiri-indigo-mx1-jeans.jpg"
      ],
      sizes: ["28", "30", "32", "34", "36"],
      description: "Культовые джинсы MX1 от Amiri с кожаными вставками и фирменными потертостями. Идеальное сочетание роскоши и панк-эстетики.",
      brand: "Amiri",
      style: "Streetwear",
      gender: "men",
      isNew: false,
      discount: 0,
      rating: 45,
      inStock: true,
      originalUrl: "https://www.amiriparis.com/us/shopping/mx1-jeans-17107222",
      colors: ["Blue", "Black", "Grey"],
      categorySlug: "jeans",
      brandSlug: "amiri",
      styleSlug: "streetwear"
    },

    // Louis Vuitton - аксессуар (Streetwear, Old Money)
    {
      name: "Louis Vuitton Mini Pochette Accessoires",
      price: 59000,
      category: "Аксессуары",
      imageUrl: "https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM2_Front%20view.jpg",
      additionalImages: [
        "https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Interior%20view.jpg",
        "https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Closeup%20view.jpg"
      ],
      sizes: ["One Size"],
      description: "Легендарная мини-сумочка Mini Pochette Accessoires от Louis Vuitton с фирменным монограммным принтом. Универсальный и культовый аксессуар.",
      brand: "Louis Vuitton",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 48,
      inStock: true,
      originalUrl: "https://eu.louisvuitton.com/eng-e1/products/mini-pochette-accessoires-monogram-001025",
      colors: ["Monogram"],
      categorySlug: "accessories",
      brandSlug: "louis-vuitton",
      styleSlug: "old-money"
    },

    // Bape - худи с акулой (Streetwear)
    {
      name: "BAPE Shark Full Zip Hoodie",
      price: 38900,
      category: "Худи",
      imageUrl: "https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-01_1024x1024.jpg",
      additionalImages: [
        "https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-02_1024x1024.jpg",
        "https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-03_1024x1024.jpg"
      ],
      sizes: ["S", "M", "L", "XL", "XXL"],
      description: "Культовое худи с акулой от BAPE. Знаковый предмет стритвир-культуры с характерным камуфляжным принтом и капюшоном в форме головы акулы.",
      brand: "Bape",
      style: "Streetwear",
      gender: "men",
      isNew: true,
      discount: 0,
      rating: 47,
      inStock: true,
      originalUrl: "https://us.bape.com/products/1i30-115-001",
      colors: ["Camo Green", "Black", "Grey"],
      categorySlug: "hoodies",
      brandSlug: "bape",
      styleSlug: "streetwear"
    },

    // Chrome Hearts - футболка (Streetwear)
    {
      name: "Chrome Hearts Cross Logo T-Shirt",
      price: 28500,
      category: "Футболки",
      imageUrl: "https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_1/chrome-hearts-black-cross-logo-t-shirt.jpg",
      additionalImages: [
        "https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_2/chrome-hearts-black-cross-logo-t-shirt.jpg"
      ],
      sizes: ["S", "M", "L", "XL"],
      description: "Классическая футболка Chrome Hearts с фирменным крестом - популярный предмет гардероба среди знаменитостей и любителей стритвир-культуры.",
      brand: "Chrome Hearts",
      style: "Streetwear",
      gender: "unisex",
      isNew: false,
      discount: 0,
      rating: 45,
      inStock: true,
      originalUrl: "https://www.chromehearts.com/",
      colors: ["Black", "White"],
      categorySlug: "t-shirts",
      brandSlug: "chrome-hearts",
      styleSlug: "streetwear"
    },

    // Hermes - шелковый платок (Old Money)
    {
      name: "Hermès Carré Silk Scarf",
      price: 49500,
      category: "Аксессуары",
      imageUrl: "https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-front-1-300-0-1000-1000_g.jpg",
      additionalImages: [
        "https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-worn-3-300-0-1000-1000_g.jpg"
      ],
      sizes: ["90 x 90 cm"],
      description: "Легендарный шелковый платок Hermès с фирменным принтом. Ручная обработка краев, высочайшее качество шелка и изысканный дизайн.",
      brand: "Hermes",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 48,
      inStock: true,
      originalUrl: "https://www.hermes.com/us/en/product/wash-scarf-90-H003227Sv01/",
      colors: ["Multicolor"],
      categorySlug: "accessories",
      brandSlug: "hermes",
      styleSlug: "old-money"
    },

    // Prada - нейлоновый рюкзак (Casual, Streetwear)
    {
      name: "Prada Re-Nylon Backpack",
      price: 139000,
      category: "Сумки",
      imageUrl: "https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg",
      additionalImages: [
        "https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg"
      ],
      sizes: ["One Size"],
      description: "Знаковый рюкзак Prada из переработанного нейлона Re-Nylon. Практичный, экологичный и стильный аксессуар с фирменным треугольным логотипом.",
      brand: "Prada",
      style: "Casual",
      gender: "unisex",
      isNew: true,
      discount: 0,
      rating: 46,
      inStock: true,
      originalUrl: "https://www.prada.com/us/en/men/bags/backpacks/products.re-nylon_backpack.1BZ811_2DWI_F0002_V_OOO.html",
      colors: ["Black", "Navy"],
      categorySlug: "bags",
      brandSlug: "prada",
      styleSlug: "casual"
    },

    // Dior - сумка Saddle (Old Money)
    {
      name: "Dior Saddle Bag",
      price: 329000,
      category: "Сумки",
      imageUrl: "https://media.dior.com/couture/ecommerce/media/catalog/product/l/v/1659015136_M0446CTZQ_M928_E03_GH.jpg",
      additionalImages: [
        "https://media.dior.com/couture/ecommerce/media/catalog/product/l/v/1659015138_M0446CTZQ_M928_E02_GH.jpg",
        "https://media.dior.com/couture/ecommerce/media/catalog/product/l/v/1659015138_M0446CTZQ_M928_E01_GH.jpg"
      ],
      sizes: ["One Size"],
      description: "Знаменитая сумка Saddle от Dior с фирменной формой седла. Возрожденная Марией Грацией Кьюри классика из линейки 2000-х годов.",
      brand: "Dior",
      style: "Old Money",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 47,
      inStock: true,
      originalUrl: "https://www.dior.com/en_us/fashion/products/M0446CTZQ_M928-medium-dior-saddle-bag-blue-dior-oblique-jacquard",
      colors: ["Blue Oblique", "Black", "Latte"],
      categorySlug: "bags",
      brandSlug: "dior",
      styleSlug: "old-money"
    },

    // Balenciaga - кроссовки Track (Streetwear)
    {
      name: "Balenciaga Track Sneakers",
      price: 96500,
      category: "Кроссовки",
      imageUrl: "https://balenciaga.dam.kering.com/m/76a612eeb5bcad5e/Medium-542023W1GB11000_F.jpg",
      additionalImages: [
        "https://balenciaga.dam.kering.com/m/2ca91dfebb8c1127/Medium-542023W1GB11000_D.jpg",
        "https://balenciaga.dam.kering.com/m/4b63f55c4d5891af/Medium-542023W1GB11000_E.jpg"
      ],
      sizes: ["39", "40", "41", "42", "43", "44", "45"],
      description: "Инновационные кроссовки Balenciaga Track с многослойным дизайном и динамичным силуэтом. 96 элементов для создания технологичного и футуристического образа.",
      brand: "Balenciaga",
      style: "Streetwear",
      gender: "unisex",
      isNew: true,
      discount: 0,
      rating: 46,
      inStock: true,
      originalUrl: "https://www.balenciaga.com/en-us/track-black-542023W1GB11000.html",
      colors: ["Black", "White", "Yellow"],
      categorySlug: "sneakers",
      brandSlug: "balenciaga",
      styleSlug: "streetwear"
    },

    // Fear of God - толстовка (Casual, Streetwear)
    {
      name: "Fear of God Essentials Pullover Hoodie",
      price: 18500,
      category: "Худи",
      imageUrl: "https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809517_1000.jpg",
      additionalImages: [
        "https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809512_1000.jpg",
        "https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809518_1000.jpg"
      ],
      sizes: ["XS", "S", "M", "L", "XL"],
      description: "Оверсайз-худи Fear of God Essentials из высококачественного хлопка с фирменным минималистичным дизайном и культовым логотипом на груди.",
      brand: "Fear of God",
      style: "Streetwear",
      gender: "unisex",
      isNew: false,
      discount: 0,
      rating: 46,
      inStock: true,
      originalUrl: "https://fearofgod.com/collections/essentials/products/essentials-pullover-hoodie-dark-oatmeal",
      colors: ["Oatmeal", "Cement", "Black"],
      categorySlug: "hoodies",
      brandSlug: "fear-of-god",
      styleSlug: "streetwear"
    },

    // Stone Island - свитшот (Streetwear, Casual)
    {
      name: "Stone Island Garment Dyed Sweatshirt",
      price: 24500,
      category: "Свитеры",
      imageUrl: "https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814335_1000.jpg",
      additionalImages: [
        "https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814339_1000.jpg",
        "https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814333_1000.jpg"
      ],
      sizes: ["S", "M", "L", "XL", "XXL"],
      description: "Культовый свитшот Stone Island с фирменным съемным компасом на рукаве. Изготовлен с использованием особой техники окрашивания, создающей эффект выцветания.",
      brand: "Stone Island",
      style: "Casual",
      gender: "men",
      isNew: false,
      discount: 15,
      rating: 46,
      inStock: true,
      originalUrl: "https://www.stoneisland.com/us/stone-island/sweatshirt_cod43202490rv.html",
      colors: ["Olive", "Black", "Navy"],
      categorySlug: "sweaters",
      brandSlug: "stone-island",
      styleSlug: "casual"
    },

    // Jordan - кроссовки Air Jordan 4 (Streetwear, Sport)
    {
      name: "Jordan 4 Retro Bred",
      price: 56500,
      category: "Кроссовки",
      imageUrl: "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-512bfb8c-b242-4d39-a04c-601275584dc4/air-jordan-4-retro-shoes-Rd2G3V.png",
      additionalImages: [
        "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-9c5f2e05-b1c3-4a01-8be5-e5e37b8bad48/air-jordan-4-retro-shoes-Rd2G3V.png",
        "https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-7baec50c-f5eb-4532-b3de-6ebfcf98fb8f/air-jordan-4-retro-shoes-Rd2G3V.png"
      ],
      sizes: ["7", "8", "9", "10", "11", "12", "13"],
      description: "Культовые кроссовки Air Jordan 4 Retro Bred с легендарной расцветкой черно-красной цветовой гаммы Chicago Bulls. Первоначально выпущены в 1989 году, эта модель до сих пор остается одной из самых популярных в линейке Jordan.",
      brand: "Jordan",
      style: "Streetwear",
      gender: "men",
      isNew: false,
      discount: 0,
      rating: 49,
      inStock: true,
      originalUrl: "https://nike.com/air-jordan-4-retro-bred",
      colors: ["Black/Red"],
      categorySlug: "sneakers",
      brandSlug: "jordan",
      styleSlug: "streetwear"
    },

    // Cartier - браслет Love (Old Money)
    {
      name: "Cartier Love Bracelet",
      price: 689000,
      category: "Аксессуары",
      imageUrl: "https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw83b7ba3b/images/large/637709379129519552-2109373.png",
      additionalImages: [
        "https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb5baab51/images/large/637709379133225744-2109374.png"
      ],
      sizes: ["16", "17", "18", "19", "20"],
      description: "Легендарный браслет Love от Cartier из 18-каратного розового золота с фирменным дизайном винтовых элементов. Символ вечной любви и верности.",
      brand: "Cartier",
      style: "Old Money",
      gender: "unisex",
      isNew: false,
      discount: 0,
      rating: 49,
      inStock: true,
      originalUrl: "https://www.cartier.com/en-us/jewelry/bracelets/love-bracelet-B6035617.html",
      colors: ["Rose Gold", "Yellow Gold", "White Gold"],
      categorySlug: "accessories",
      brandSlug: "cartier",
      styleSlug: "old-money"
    },

    // Fendi - сумка Baguette (Old Money, Vintage)
    {
      name: "Fendi Baguette Medium",
      price: 289000,
      category: "Сумки",
      imageUrl: "https://www.fendi.com/medias/sys_master/images/images/h50/h5d/8976184098846/8BR600A72VF19FW-01.jpg",
      additionalImages: [
        "https://www.fendi.com/medias/sys_master/images/images/h3a/h17/8976188620830/8BR600A72VF19FW-02.jpg",
        "https://www.fendi.com/medias/sys_master/images/images/h43/h03/8976189669406/8BR600A72VF19FW-03.jpg"
      ],
      sizes: ["Medium"],
      description: "Культовая сумка Baguette от Fendi, ставшая иконой благодаря сериалу 'Секс в большом городе'. Знаковая модель с характерной формой и узнаваемой пряжкой FF.",
      brand: "Fendi",
      style: "Vintage",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 47,
      inStock: true,
      originalUrl: "https://www.fendi.com/en-us/baguette-medium-brown-leather-bag-8br600a72vf19fw",
      colors: ["Brown", "Black", "Red"],
      categorySlug: "bags",
      brandSlug: "fendi",
      styleSlug: "vintage"
    },

    // Supreme - футболка с лого (Streetwear)
    {
      name: "Supreme Box Logo Tee",
      price: 15500,
      category: "Футболки",
      imageUrl: "https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29138789_1000.jpg",
      additionalImages: [
        "https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29139142_1000.jpg"
      ],
      sizes: ["S", "M", "L", "XL"],
      description: "Культовая футболка Supreme с фирменным прямоугольным логотипом (Box Logo). Одна из самых узнаваемых и желанных моделей в стритвир-культуре.",
      brand: "Supreme",
      style: "Streetwear",
      gender: "unisex",
      isNew: false,
      discount: 0,
      rating: 48,
      inStock: true,
      originalUrl: "https://www.supremenewyork.com/",
      colors: ["White", "Black", "Red"],
      categorySlug: "t-shirts",
      brandSlug: "supreme",
      styleSlug: "streetwear"
    },

    // Jacquemus - маленькая сумка (Old Money, Casual)
    {
      name: "Jacquemus Le Chiquito Bag",
      price: 68000,
      category: "Сумки",
      imageUrl: "https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309399_1000.jpg",
      additionalImages: [
        "https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309398_1000.jpg",
        "https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309402_1000.jpg"
      ],
      sizes: ["One Size"],
      description: "Миниатюрная сумка Le Chiquito от Jacquemus, ставшая вирусным аксессуаром и символом современной моды. Характерная микро-форма и минималистичный дизайн.",
      brand: "Jacquemus",
      style: "Casual",
      gender: "women",
      isNew: true,
      discount: 0,
      rating: 46,
      inStock: true,
      originalUrl: "https://www.jacquemus.com/product/le-chiquito-noeud-leather-tan",
      colors: ["Tan", "Black", "Red"],
      categorySlug: "bags",
      brandSlug: "jacquemus",
      styleSlug: "casual"
    },

    // Miu Miu - мини-юбка (Casual, Old Money)
    {
      name: "Miu Miu Pleated Mini Skirt",
      price: 97000,
      category: "Юбки",
      imageUrl: "https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLF.jpg",
      additionalImages: [
        "https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLR.jpg"
      ],
      sizes: ["36", "38", "40", "42", "44"],
      description: "Знаменитая плиссированная мини-юбка Miu Miu, ставшая вирусной сенсацией и определившая моду 2020-х. Ультракороткая длина и низкая посадка.",
      brand: "Miu Miu",
      style: "Casual",
      gender: "women",
      isNew: true,
      discount: 0,
      rating: 45,
      inStock: true,
      originalUrl: "https://www.miumiu.com/en/p-mob455_1x3f_f0009/ready-to-wear/skirts/gabardine-miniskirt/",
      colors: ["Beige", "Navy", "Grey"],
      categorySlug: "skirts",
      brandSlug: "miu-miu",
      styleSlug: "casual"
    },

    // Vivienne Westwood - ожерелье (Vintage, Streetwear)
    {
      name: "Vivienne Westwood Mini Bas Relief Choker",
      price: 32000,
      category: "Аксессуары",
      imageUrl: "https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913541_1000.jpg",
      additionalImages: [
        "https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913542_1000.jpg"
      ],
      sizes: ["One Size"],
      description: "Культовое ожерелье-чокер Mini Bas Relief от Vivienne Westwood с фирменной планетарной эмблемой. Символ панк-движения и икона альтернативной моды.",
      brand: "Vivienne Westwood",
      style: "Vintage",
      gender: "women",
      isNew: false,
      discount: 0,
      rating: 45,
      inStock: true,
      originalUrl: "https://www.viviennewestwood.com/en/women/jewellery/necklaces/mini-bas-relief-choker-light-gold-crystal-63020004W108W108.html",
      colors: ["Gold", "Silver"],
      categorySlug: "accessories",
      brandSlug: "vivienne-westwood",
      styleSlug: "vintage"
    }
  ];

  // Добавляем товары в базу данных
  for (const product of newProducts) {
    try {
      await db.insert(products).values(product);
      console.log(`Добавлен товар: ${product.name}`);
    } catch (error) {
      console.error(`Ошибка при добавлении товара ${product.name}:`, error);
    }
  }

  console.log('Завершено добавление товаров в каталог');
}

// Запускаем функцию добавления товаров
addProducts().catch(console.error);