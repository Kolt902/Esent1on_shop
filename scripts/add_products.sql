-- Добавляем новые товары в каталог

-- Burberry - тренч-коут (Casual, Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Burberry Chelsea Heritage Trench Coat',
  189000,
  'Куртки',
  'https://assets.burberry.com/is/image/Burberryltd/F7D87D2F-5CCD-42F1-B85D-3E6E13A23825.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251',
  ARRAY['https://assets.burberry.com/is/image/Burberryltd/3B4C25E6-D5DB-4702-9F11-6B4BB193F6BA.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251', 'https://assets.burberry.com/is/image/Burberryltd/BE0A9F7C-40C0-45A3-8C4F-2714DF23F1AF.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251'],
  ARRAY['36', '38', '40', '42', '44', '46'],
  'Классический тренч Burberry Chelsea из водонепроницаемого хлопкового габардина. Культовая модель бренда с фирменной клеткой на подкладке.',
  'Burberry',
  'Old Money',
  'women',
  false,
  0,
  48,
  true,
  'https://ru.burberry.com/the-waterloo-heritage-trench-coat-p80462971',
  ARRAY['Honey', 'Black', 'Blue'],
  'coats',
  'burberry',
  'old-money'
);

-- Saint Laurent - куртка-косуха (Streetwear, Casual)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Saint Laurent Classic Motorcycle Jacket',
  329000,
  'Куртки',
  'https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_front.jpg',
  ARRAY['https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_back.jpg', 'https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_detail_1.jpg'],
  ARRAY['44', '46', '48', '50', '52'],
  'Культовая кожаная косуха Saint Laurent из высококачественной телячьей кожи с классическими байкерскими деталями и легендарным силуэтом.',
  'Saint Laurent',
  'Streetwear',
  'men',
  true,
  0,
  47,
  true,
  'https://www.ysl.com/en-us/leather-motorcycle-jacket-in-black-225935Y5RD21000.html',
  ARRAY['Black'],
  'jackets',
  'saint-laurent',
  'streetwear'
);

-- Chanel - твидовый пиджак (Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Chanel Iconic Tweed Jacket',
  399000,
  'Пиджаки',
  'https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-default-p82283k17710nf895-8840257896478.jpg',
  ARRAY['https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-p82283k17710nf895-8840261697566.jpg', 'https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-a-p82283k17710nf895-8840260550686.jpg'],
  ARRAY['34', '36', '38', '40', '42', '44'],
  'Легендарный твидовый пиджак Chanel с фирменными деталями - золотыми пуговицами и отделкой. Символ элегантности и роскоши.',
  'Chanel',
  'Old Money',
  'women',
  false,
  0,
  49,
  true,
  'https://www.chanel.com/us/fashion/p/P82283K17710NF895/jacket-cotton-tweed-gold-tone-metal/',
  ARRAY['Navy Blue', 'Black', 'Beige'],
  'jackets',
  'chanel',
  'old-money'
);

-- Loewe - сумка Puzzle (Old Money, Casual)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Loewe Puzzle Bag Medium',
  285000,
  'Сумки',
  'https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-FRONT?fmt=webp&hei=1250',
  ARRAY['https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_1?fmt=webp&hei=1250', 'https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_2?fmt=webp&hei=1250'],
  ARRAY['Medium'],
  'Культовая модель сумки Puzzle от Loewe из высококачественной кожи с фирменной геометрической конструкцией и трехмерной головоломкой-оригами.',
  'Loewe',
  'Old Money',
  'women',
  false,
  0,
  47,
  true,
  'https://www.loewe.com/int/en/women/bags/puzzle/puzzle-bag-in-classic-calfskin/A510P22X17-C9990.html',
  ARRAY['Black', 'Tan', 'Ocean Blue'],
  'bags',
  'loewe',
  'old-money'
);

-- Bottega Veneta - клатч Pouch (Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Bottega Veneta The Pouch',
  239000,
  'Сумки',
  'https://www.bottegaveneta.com/variants/images/17085864448325636/A/d.jpg',
  ARRAY['https://www.bottegaveneta.com/variants/images/17085864448325636/A/h.jpg', 'https://www.bottegaveneta.com/variants/images/17085864448325636/A/e.jpg'],
  ARRAY['One Size'],
  'Культовый клатч The Pouch от Bottega Veneta из мягкой кожи наппа с характерным облачным эффектом. Минималистичная роскошь.',
  'Bottega Veneta',
  'Old Money',
  'women',
  false,
  0,
  46,
  true,
  'https://www.bottegaveneta.com/en-us/the-pouch-black-809639811.html',
  ARRAY['Black', 'Fondant', 'Caramel'],
  'bags',
  'bottega-veneta',
  'old-money'
);

-- Amiri - джинсы (Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Amiri MX1 Distressed Jeans',
  65000,
  'Джинсы',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_1/amiri-indigo-mx1-jeans.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_2/amiri-indigo-mx1-jeans.jpg', 'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_3/amiri-indigo-mx1-jeans.jpg'],
  ARRAY['28', '30', '32', '34', '36'],
  'Культовые джинсы MX1 от Amiri с кожаными вставками и фирменными потертостями. Идеальное сочетание роскоши и панк-эстетики.',
  'Amiri',
  'Streetwear',
  'men',
  false,
  0,
  45,
  true,
  'https://www.amiriparis.com/us/shopping/mx1-jeans-17107222',
  ARRAY['Blue', 'Black', 'Grey'],
  'jeans',
  'amiri',
  'streetwear'
);

-- Louis Vuitton - аксессуар (Streetwear, Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Louis Vuitton Mini Pochette Accessoires',
  59000,
  'Аксессуары',
  'https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM2_Front%20view.jpg',
  ARRAY['https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Interior%20view.jpg', 'https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Closeup%20view.jpg'],
  ARRAY['One Size'],
  'Легендарная мини-сумочка Mini Pochette Accessoires от Louis Vuitton с фирменным монограммным принтом. Универсальный и культовый аксессуар.',
  'Louis Vuitton',
  'Old Money',
  'women',
  false,
  0,
  48,
  true,
  'https://eu.louisvuitton.com/eng-e1/products/mini-pochette-accessoires-monogram-001025',
  ARRAY['Monogram'],
  'accessories',
  'louis-vuitton',
  'old-money'
);

-- Bape - худи с акулой (Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'BAPE Shark Full Zip Hoodie',
  38900,
  'Худи',
  'https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-01_1024x1024.jpg',
  ARRAY['https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-02_1024x1024.jpg', 'https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-03_1024x1024.jpg'],
  ARRAY['S', 'M', 'L', 'XL', 'XXL'],
  'Культовое худи с акулой от BAPE. Знаковый предмет стритвир-культуры с характерным камуфляжным принтом и капюшоном в форме головы акулы.',
  'Bape',
  'Streetwear',
  'men',
  true,
  0,
  47,
  true,
  'https://us.bape.com/products/1i30-115-001',
  ARRAY['Camo Green', 'Black', 'Grey'],
  'hoodies',
  'bape',
  'streetwear'
);

-- Chrome Hearts - футболка (Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Chrome Hearts Cross Logo T-Shirt',
  28500,
  'Футболки',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_1/chrome-hearts-black-cross-logo-t-shirt.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_2/chrome-hearts-black-cross-logo-t-shirt.jpg'],
  ARRAY['S', 'M', 'L', 'XL'],
  'Классическая футболка Chrome Hearts с фирменным крестом - популярный предмет гардероба среди знаменитостей и любителей стритвир-культуры.',
  'Chrome Hearts',
  'Streetwear',
  'unisex',
  false,
  0,
  45,
  true,
  'https://www.chromehearts.com/',
  ARRAY['Black', 'White'],
  't-shirts',
  'chrome-hearts',
  'streetwear'
);

-- Hermes - шелковый платок (Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Hermès Carré Silk Scarf',
  49500,
  'Аксессуары',
  'https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-front-1-300-0-1000-1000_g.jpg',
  ARRAY['https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-worn-3-300-0-1000-1000_g.jpg'],
  ARRAY['90 x 90 cm'],
  'Легендарный шелковый платок Hermès с фирменным принтом. Ручная обработка краев, высочайшее качество шелка и изысканный дизайн.',
  'Hermes',
  'Old Money',
  'women',
  false,
  0,
  48,
  true,
  'https://www.hermes.com/us/en/product/wash-scarf-90-H003227Sv01/',
  ARRAY['Multicolor'],
  'accessories',
  'hermes',
  'old-money'
);

-- Prada - нейлоновый рюкзак (Casual, Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Prada Re-Nylon Backpack',
  139000,
  'Сумки',
  'https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg',
  ARRAY['https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg'],
  ARRAY['One Size'],
  'Знаковый рюкзак Prada из переработанного нейлона Re-Nylon. Практичный, экологичный и стильный аксессуар с фирменным треугольным логотипом.',
  'Prada',
  'Casual',
  'unisex',
  true,
  0,
  46,
  true,
  'https://www.prada.com/us/en/men/bags/backpacks/products.re-nylon_backpack.1BZ811_2DWI_F0002_V_OOO.html',
  ARRAY['Black', 'Navy'],
  'bags',
  'prada',
  'casual'
);

-- Balenciaga - кроссовки Track (Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Balenciaga Track Sneakers',
  96500,
  'Кроссовки',
  'https://balenciaga.dam.kering.com/m/76a612eeb5bcad5e/Medium-542023W1GB11000_F.jpg',
  ARRAY['https://balenciaga.dam.kering.com/m/2ca91dfebb8c1127/Medium-542023W1GB11000_D.jpg', 'https://balenciaga.dam.kering.com/m/4b63f55c4d5891af/Medium-542023W1GB11000_E.jpg'],
  ARRAY['39', '40', '41', '42', '43', '44', '45'],
  'Инновационные кроссовки Balenciaga Track с многослойным дизайном и динамичным силуэтом. 96 элементов для создания технологичного и футуристического образа.',
  'Balenciaga',
  'Streetwear',
  'unisex',
  true,
  0,
  46,
  true,
  'https://www.balenciaga.com/en-us/track-black-542023W1GB11000.html',
  ARRAY['Black', 'White', 'Yellow'],
  'sneakers',
  'balenciaga',
  'streetwear'
);

-- Fear of God - толстовка (Casual, Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Fear of God Essentials Pullover Hoodie',
  18500,
  'Худи',
  'https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809517_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809512_1000.jpg', 'https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809518_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Оверсайз-худи Fear of God Essentials из высококачественного хлопка с фирменным минималистичным дизайном и культовым логотипом на груди.',
  'Fear of God',
  'Streetwear',
  'unisex',
  false,
  0,
  46,
  true,
  'https://fearofgod.com/collections/essentials/products/essentials-pullover-hoodie-dark-oatmeal',
  ARRAY['Oatmeal', 'Cement', 'Black'],
  'hoodies',
  'fear-of-god',
  'streetwear'
);

-- Stone Island - свитшот (Streetwear, Casual)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Stone Island Garment Dyed Sweatshirt',
  24500,
  'Свитеры',
  'https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814335_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814339_1000.jpg', 'https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814333_1000.jpg'],
  ARRAY['S', 'M', 'L', 'XL', 'XXL'],
  'Культовый свитшот Stone Island с фирменным съемным компасом на рукаве. Изготовлен с использованием особой техники окрашивания, создающей эффект выцветания.',
  'Stone Island',
  'Casual',
  'men',
  false,
  15,
  46,
  true,
  'https://www.stoneisland.com/us/stone-island/sweatshirt_cod43202490rv.html',
  ARRAY['Olive', 'Black', 'Navy'],
  'sweaters',
  'stone-island',
  'casual'
);

-- Jordan - кроссовки Air Jordan 4 (Streetwear, Sport)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Jordan 4 Retro Bred',
  56500,
  'Кроссовки',
  'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-512bfb8c-b242-4d39-a04c-601275584dc4/air-jordan-4-retro-shoes-Rd2G3V.png',
  ARRAY['https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-9c5f2e05-b1c3-4a01-8be5-e5e37b8bad48/air-jordan-4-retro-shoes-Rd2G3V.png', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-7baec50c-f5eb-4532-b3de-6ebfcf98fb8f/air-jordan-4-retro-shoes-Rd2G3V.png'],
  ARRAY['7', '8', '9', '10', '11', '12', '13'],
  'Культовые кроссовки Air Jordan 4 Retro Bred с легендарной расцветкой черно-красной цветовой гаммы Chicago Bulls. Первоначально выпущены в 1989 году, эта модель до сих пор остается одной из самых популярных в линейке Jordan.',
  'Jordan',
  'Streetwear',
  'men',
  false,
  0,
  49,
  true,
  'https://nike.com/air-jordan-4-retro-bred',
  ARRAY['Black/Red'],
  'sneakers',
  'jordan',
  'streetwear'
);

-- Cartier - браслет Love (Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Cartier Love Bracelet',
  689000,
  'Аксессуары',
  'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw83b7ba3b/images/large/637709379129519552-2109373.png',
  ARRAY['https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb5baab51/images/large/637709379133225744-2109374.png'],
  ARRAY['16', '17', '18', '19', '20'],
  'Легендарный браслет Love от Cartier из 18-каратного розового золота с фирменным дизайном винтовых элементов. Символ вечной любви и верности.',
  'Cartier',
  'Old Money',
  'unisex',
  false,
  0,
  49,
  true,
  'https://www.cartier.com/en-us/jewelry/bracelets/love-bracelet-B6035617.html',
  ARRAY['Rose Gold', 'Yellow Gold', 'White Gold'],
  'accessories',
  'cartier',
  'old-money'
);

-- Fendi - сумка Baguette (Old Money, Vintage)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Fendi Baguette Medium',
  289000,
  'Сумки',
  'https://www.fendi.com/medias/sys_master/images/images/h50/h5d/8976184098846/8BR600A72VF19FW-01.jpg',
  ARRAY['https://www.fendi.com/medias/sys_master/images/images/h3a/h17/8976188620830/8BR600A72VF19FW-02.jpg', 'https://www.fendi.com/medias/sys_master/images/images/h43/h03/8976189669406/8BR600A72VF19FW-03.jpg'],
  ARRAY['Medium'],
  'Культовая сумка Baguette от Fendi, ставшая иконой благодаря сериалу ''Секс в большом городе''. Знаковая модель с характерной формой и узнаваемой пряжкой FF.',
  'Fendi',
  'Vintage',
  'women',
  false,
  0,
  47,
  true,
  'https://www.fendi.com/en-us/baguette-medium-brown-leather-bag-8br600a72vf19fw',
  ARRAY['Brown', 'Black', 'Red'],
  'bags',
  'fendi',
  'vintage'
);

-- Supreme - футболка с лого (Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Supreme Box Logo Tee',
  15500,
  'Футболки',
  'https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29138789_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29139142_1000.jpg'],
  ARRAY['S', 'M', 'L', 'XL'],
  'Культовая футболка Supreme с фирменным прямоугольным логотипом (Box Logo). Одна из самых узнаваемых и желанных моделей в стритвир-культуре.',
  'Supreme',
  'Streetwear',
  'unisex',
  false,
  0,
  48,
  true,
  'https://www.supremenewyork.com/',
  ARRAY['White', 'Black', 'Red'],
  't-shirts',
  'supreme',
  'streetwear'
);

-- Jacquemus - маленькая сумка (Old Money, Casual)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Jacquemus Le Chiquito Bag',
  68000,
  'Сумки',
  'https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309399_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309398_1000.jpg', 'https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309402_1000.jpg'],
  ARRAY['One Size'],
  'Миниатюрная сумка Le Chiquito от Jacquemus, ставшая вирусным аксессуаром и символом современной моды. Характерная микро-форма и минималистичный дизайн.',
  'Jacquemus',
  'Casual',
  'women',
  true,
  0,
  46,
  true,
  'https://www.jacquemus.com/product/le-chiquito-noeud-leather-tan',
  ARRAY['Tan', 'Black', 'Red'],
  'bags',
  'jacquemus',
  'casual'
);

-- Miu Miu - мини-юбка (Casual, Old Money)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Miu Miu Pleated Mini Skirt',
  97000,
  'Юбки',
  'https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLF.jpg',
  ARRAY['https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLR.jpg'],
  ARRAY['36', '38', '40', '42', '44'],
  'Знаменитая плиссированная мини-юбка Miu Miu, ставшая вирусной сенсацией и определившая моду 2020-х. Ультракороткая длина и низкая посадка.',
  'Miu Miu',
  'Casual',
  'women',
  true,
  0,
  45,
  true,
  'https://www.miumiu.com/en/p-mob455_1x3f_f0009/ready-to-wear/skirts/gabardine-miniskirt/',
  ARRAY['Beige', 'Navy', 'Grey'],
  'skirts',
  'miu-miu',
  'casual'
);

-- Vivienne Westwood - ожерелье (Vintage, Streetwear)
INSERT INTO products (name, price, category, imageUrl, additionalImages, sizes, description, brand, style, gender, isNew, discount, rating, inStock, originalUrl, colors, categorySlug, brandSlug, styleSlug)
VALUES (
  'Vivienne Westwood Mini Bas Relief Choker',
  32000,
  'Аксессуары',
  'https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913541_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913542_1000.jpg'],
  ARRAY['One Size'],
  'Культовое ожерелье-чокер Mini Bas Relief от Vivienne Westwood с фирменной планетарной эмблемой. Символ панк-движения и икона альтернативной моды.',
  'Vivienne Westwood',
  'Vintage',
  'women',
  false,
  0,
  45,
  true,
  'https://www.viviennewestwood.com/en/women/jewellery/necklaces/mini-bas-relief-choker-light-gold-crystal-63020004W108W108.html',
  ARRAY['Gold', 'Silver'],
  'accessories',
  'vivienne-westwood',
  'vintage'
);