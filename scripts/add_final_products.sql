-- Добавляем еще товары в каталог

-- Gucci - Куртка с логотипом (Old Money, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Gucci GG Jacquard Jacket',
  289000,
  'Куртки',
  'https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_001_100_0000_Light-GG-jacquard-jacket.jpg',
  ARRAY['https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_002_100_0000_Light-GG-jacquard-jacket.jpg', 'https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_003_100_0000_Light-GG-jacquard-jacket.jpg'],
  ARRAY['44', '46', '48', '50', '52', '54'],
  'Роскошная куртка Gucci из хлопкового жаккарда с фирменным монограммным принтом GG. Классический крой и знаковый декор бренда создают статусный предмет гардероба.',
  'Gucci',
  'Old Money',
  'men',
  false,
  0,
  48,
  true,
  'https://www.gucci.com/us/en/pr/men/ready-to-wear-for-men/jackets-for-men/gg-jacquard-jacket-p-655002XJDLV4178',
  ARRAY['Beige/Brown', 'Black/Gray'],
  'jackets',
  'gucci',
  'old-money'
);

-- Prada - кожаные лоферы (Old Money, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Prada Brushed Leather Loafers',
  95000,
  'Обувь',
  'https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg',
  ARRAY['https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg', 'https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLB.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg'],
  ARRAY['5', '6', '7', '8', '9', '10', '11', '12'],
  'Элегантные кожаные лоферы Prada с фирменным треугольным логотипом и характерной массивной подошвой. Классическая модель в современной интерпретации.',
  'Prada',
  'Old Money',
  'men',
  false,
  0,
  47,
  true,
  'https://www.prada.com/us/en/men/shoes/loafers/products.brushed_leather_loafers.2DE129_ADS_F0002.html',
  ARRAY['Black', 'Burgundy'],
  'shoes',
  'prada',
  'old-money'
);

-- Raf Simons - оверсайз футболка (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Raf Simons Oversized Printed T-Shirt',
  42000,
  'Футболки',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_1/raf-simons-white-oversized-graphic-t-shirt.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_2/raf-simons-white-oversized-graphic-t-shirt.jpg', 'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_3/raf-simons-white-oversized-graphic-t-shirt.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Авангардная оверсайз футболка Raf Simons с характерным для бренда графическим принтом. Культовый бельгийский дизайн, повлиявший на целое поколение в мире моды.',
  'Raf Simons',
  'Streetwear',
  'unisex',
  true,
  0,
  45,
  true,
  'https://www.rafsimons.com/',
  ARRAY['White', 'Black'],
  't-shirts',
  'raf-simons',
  'streetwear'
);

-- Jacquemus - укороченный топ (Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Jacquemus La Maille Neve Cropped Top',
  24000,
  'Футболки',
  'https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451280_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451278_1000.jpg', 'https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451279_1000.jpg'],
  ARRAY['34', '36', '38', '40', '42'],
  'Стильный укороченный топ Jacquemus из мягкого трикотажа. Минималистичный дизайн с фирменной асимметрией и вырезами, создающий современный и женственный образ.',
  'Jacquemus',
  'Casual',
  'women',
  true,
  0,
  44,
  true,
  'https://www.jacquemus.com/product/la-maille-neve-cropped-top-off-white',
  ARRAY['Off-White', 'Black', 'Pink'],
  't-shirts',
  'jacquemus',
  'casual'
);

-- Yohji Yamamoto - ассиметричная юбка (Vintage, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Yohji Yamamoto Asymmetric Draped Skirt',
  87000,
  'Юбки',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_1/yohji-yamamoto-black-asymmetric-draped-skirt.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_2/yohji-yamamoto-black-asymmetric-draped-skirt.jpg', 'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_3/yohji-yamamoto-black-asymmetric-draped-skirt.jpg'],
  ARRAY['1', '2', '3', '4', '5'],
  'Авангардная асимметричная юбка от легендарного японского дизайнера Yohji Yamamoto. Уникальная драпировка и архитектурный крой создают неповторимый образ.',
  'Yohji Yamamoto',
  'Vintage',
  'women',
  false,
  0,
  44,
  true,
  'https://www.yohjiyamamoto.co.jp/',
  ARRAY['Black'],
  'skirts',
  'yohji-yamamoto',
  'vintage'
);

-- Moncler - пуховик (Streetwear, Sport)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Moncler Maya Puffer Jacket',
  157000,
  'Куртки',
  'https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34301730_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34334542_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34334541_1000.jpg'],
  ARRAY['0', '1', '2', '3', '4', '5', '6'],
  'Культовый пуховик Moncler Maya из глянцевого нейлона с фирменным логотипом бренда. Культовая модель, сочетающая изысканный итальянский дизайн и исключительное качество.',
  'Moncler',
  'Streetwear',
  'men',
  false,
  0,
  47,
  true,
  'https://www.moncler.com/en-us/men/outerwear/short-down-jackets/maya-short-down-jacket-black-G20911A0012053334999.html',
  ARRAY['Black', 'Navy', 'Red'],
  'jackets',
  'moncler',
  'streetwear'
);

-- Celine - кожаные брюки (Old Money, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Celine Leather Pants',
  295000,
  'Брюки',
  'https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_1_FALL16.jpg',
  ARRAY['https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_2_FALL16.jpg', 'https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_3_FALL16.jpg'],
  ARRAY['34', '36', '38', '40', '42', '44'],
  'Роскошные кожаные брюки Celine с высокой посадкой и прямым силуэтом. Безупречный крой и высококачественная кожа создают изысканный образ в характерном для бренда минималистичном стиле.',
  'Celine',
  'Old Money',
  'women',
  false,
  0,
  46,
  true,
  'https://www.celine.com/en-us/celine-shop-women/ready-to-wear/pants/slim-fit-pants-in-lambskin-2X347747D.38NO.html',
  ARRAY['Black'],
  'pants',
  'celine',
  'old-money'
);

-- Valentino - платье с принтом (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Valentino Printed Silk Dress',
  345000,
  'Платья',
  'https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34566057_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34565306_1000.jpg', 'https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34566058_1000.jpg'],
  ARRAY['38', '40', '42', '44', '46'],
  'Элегантное шелковое платье Valentino с художественным принтом. Роскошная модель, воплощающая итальянское мастерство и безупречный вкус.',
  'Valentino',
  'Old Money',
  'women',
  true,
  0,
  47,
  true,
  'https://www.valentino.com/',
  ARRAY['Multicolor'],
  'dresses',
  'valentino',
  'old-money'
);

-- Rick Owens - кожаная куртка (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Rick Owens Leather Biker Jacket',
  320000,
  'Куртки',
  'https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989081_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989082_1000.jpg', 'https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989083_1000.jpg'],
  ARRAY['44', '46', '48', '50', '52'],
  'Легендарная кожаная куртка Rick Owens с характерным авангардным силуэтом. Культовая модель с асимметричной молнией, ставшая визитной карточкой бренда.',
  'Rick Owens',
  'Streetwear',
  'men',
  false,
  0,
  48,
  true,
  'https://www.rickowens.eu/en/US/men/products/ru20f3764lba-09',
  ARRAY['Black'],
  'jackets',
  'rick-owens',
  'streetwear'
);

-- sacai - многослойная футболка (Streetwear, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'sacai Layered T-Shirt',
  47000,
  'Футболки',
  'https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37195954_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37196771_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37196772_1000.jpg'],
  ARRAY['1', '2', '3', '4', '5'],
  'Инновационная многослойная футболка sacai с характерной для бренда гибридной конструкцией. Уникальное сочетание разных тканей и силуэтов в одном предмете гардероба.',
  'sacai',
  'Streetwear',
  'unisex',
  true,
  0,
  45,
  true,
  'https://www.sacai.jp/',
  ARRAY['White/Navy', 'Black/White'],
  't-shirts',
  'sacai',
  'streetwear'
);

-- Hublot - наручные часы (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Hublot Big Bang Ceramic Watch',
  1250000,
  'Аксессуары',
  'https://www.hublot.com/sites/default/files/styles/watch_item_desktop_1x_/public/2022-03/451.CX_.1140.RX-Big-Bang-Unico-ceramic-44-mm-soldier-shot.png',
  ARRAY['https://www.hublot.com/sites/default/files/styles/global_laptop_1x_/public/2022-03/451.CX_.1140.RX-Hublot-Big-Bang-Unico-44mm-black-ceramic-soldier-shot.png', 'https://www.hublot.com/sites/default/files/styles/global_laptop_1x_/public/2022-03/451.CX_.1140.RX-detail-2.png'],
  ARRAY['44mm'],
  'Роскошные часы Hublot Big Bang из черной керамики с фирменной архитектурой корпуса и скелетонизированным циферблатом. Символ статуса и технического совершенства.',
  'Hublot',
  'Old Money',
  'men',
  false,
  0,
  48,
  true,
  'https://www.hublot.com/en-us/watches/big-bang/big-bang-unico-black-magic-44-mm',
  ARRAY['Black/Gold'],
  'accessories',
  'hublot',
  'old-money'
);

-- Tom Ford - солнцезащитные очки (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Tom Ford Newman Sunglasses',
  44000,
  'Очки',
  'https://www.tomford.com/dw/image/v2/AAWH_PRD/on/demandware.static/-/Sites-tomford-master-catalog/default/dw63fea38e/zoom/J1602T_01A_OS_A.jpg',
  ARRAY['https://www.tomford.com/dw/image/v2/AAWH_PRD/on/demandware.static/-/Sites-tomford-master-catalog/default/dwd8fafa9a/zoom/J1602T_01A_OS_B.jpg'],
  ARRAY['One Size'],
  'Элегантные солнцезащитные очки Tom Ford Newman с характерным Т-образным логотипом на дужках. Стильная модель, сочетающая классику и современные тенденции.',
  'Tom Ford',
  'Old Money',
  'men',
  false,
  0,
  46,
  true,
  'https://www.tomford.com/newman-sunglasses/J1602T-01A.html',
  ARRAY['Black', 'Havana'],
  'eyewear',
  'tom-ford',
  'old-money'
);

-- Nike - технологичные кроссовки (Sport, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Nike Air Max 97 OG',
  17900,
  'Кроссовки',
  'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/14ea41ac-f60e-44b5-be12-c7c22f72ab9c/air-max-97-shoes-sKq4eP.png',
  ARRAY['https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/a9d81b6e-8793-4a82-a5af-29d831fdeadf/air-max-97-shoes-sKq4eP.png', 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e31ed404-4d8a-4f3f-8a48-7f7c2ea3c6ad/air-max-97-shoes-sKq4eP.png'],
  ARRAY['US 7', 'US 8', 'US 9', 'US 10', 'US 11', 'US 12'],
  'Культовые кроссовки Nike Air Max 97 с характерным волнообразным дизайном и полноразмерной воздушной подушкой. Модель, вдохновленная высокоскоростными японскими пулевыми поездами.',
  'Nike',
  'Sport',
  'unisex',
  false,
  0,
  47,
  true,
  'https://www.nike.com/t/air-max-97-shoes-sKq4eP/DM0027-001',
  ARRAY['Silver/Red', 'Black/White', 'Gold/Black'],
  'sneakers',
  'nike',
  'sport'
);

-- Vacheron Constantin - часы (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Vacheron Constantin Patrimony',
  2950000,
  'Аксессуары',
  'https://www.vacheron-constantin.com/dam/rcq/vac/16/39/51/9/1639519.png.transform.vacproddetail.png',
  ARRAY['https://www.vacheron-constantin.com/dam/rcq/vac/15/10/30/1/1510301.png.transform.vacproddetail.png', 'https://www.vacheron-constantin.com/dam/rcq/vac/19/16/95/4/1916954.png.transform.vacproddetail.png'],
  ARRAY['40mm'],
  'Элегантные часы Vacheron Constantin Patrimony из розового золота с классическим круглым корпусом. Настоящее произведение швейцарского часового искусства с многовековой историей.',
  'Vacheron Constantin',
  'Old Money',
  'men',
  false,
  0,
  49,
  true,
  'https://www.vacheron-constantin.com/en4/watches/patrimony/patrimony-self-winding-4100u-000r-b180.html',
  ARRAY['Rose Gold/Brown'],
  'accessories',
  'vacheron-constantin',
  'old-money'
);

-- Dior - сумка Saddle (Old Money, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Dior Saddle Bag',
  370000,
  'Сумки',
  'https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E01_ZHC.jpg',
  ARRAY['https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_2/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E02_ZHC.jpg', 'https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_3/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E03_ZHC.jpg'],
  ARRAY['Medium'],
  'Культовая сумка Dior Saddle с характерной формой седла. Легендарная модель, ставшая символом начала 2000-х и пережившая триумфальное возвращение в современной моде.',
  'Dior',
  'Old Money',
  'women',
  false,
  0,
  48,
  true,
  'https://www.dior.com/en_us/products/couture-M0446CTZQ_M928-saddle-bag-blue-dior-oblique-jacquard',
  ARRAY['Blue Monogram', 'Black', 'Brown'],
  'bags',
  'dior',
  'old-money'
);

-- Adidas - кроссовки Samba (Vintage, Sport)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Adidas Samba OG',
  11500,
  'Кроссовки',
  'https://assets.adidas.com/images/w_600,f_auto,q_auto/cb1212403d0944419924aad6009a0497_9366/Samba_OG_Shoes_White_B75806_01_standard.jpg',
  ARRAY['https://assets.adidas.com/images/w_600,f_auto,q_auto/35b654a1eda34f62acaeaad6009a0def_9366/Samba_OG_Shoes_White_B75806_02_standard.jpg', 'https://assets.adidas.com/images/w_600,f_auto,q_auto/fc3fe27e34564a488e9baad6009a18e2_9366/Samba_OG_Shoes_White_B75806_04_standard.jpg'],
  ARRAY['7', '8', '9', '10', '11', '12', '13'],
  'Культовые кроссовки Adidas Samba с характерным T-образным мыском. Классическая модель, созданная для футбола в 1950-х и ставшая иконой городской моды.',
  'Adidas',
  'Vintage',
  'unisex',
  false,
  0,
  48,
  true,
  'https://www.adidas.com/us/samba-og-shoes/B75806.html',
  ARRAY['White/Black', 'Black/White', 'Green/White'],
  'sneakers',
  'adidas',
  'vintage'
);

-- Ambush - серебряный браслет (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Ambush Silver Chain Bracelet',
  35000,
  'Аксессуары',
  'https://cdn-images.farfetch-contents.com/16/33/15/20/16331520_31421003_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/16/33/15/20/16331520_31421999_1000.jpg'],
  ARRAY['S', 'M', 'L'],
  'Массивный серебряный браслет-цепь Ambush с характерным индустриальным дизайном. Яркий аксессуар, сочетающий традиции ювелирного искусства и современную уличную эстетику.',
  'Ambush',
  'Streetwear',
  'unisex',
  true,
  0,
  44,
  true,
  'https://www.ambushdesign.com/',
  ARRAY['Silver'],
  'accessories',
  'ambush',
  'streetwear'
);

-- Fendi - кроссовки с логотипом (Streetwear, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Fendi Flow Sneakers',
  97000,
  'Кроссовки',
  'https://www.fendi.com/medias/sys_master/images/images/h56/h77/8917173747742/7E1392AJT6F1HKR-01.jpg',
  ARRAY['https://www.fendi.com/medias/sys_master/images/images/h33/h1f/8917174337566/7E1392AJT6F1HKR-02.jpg', 'https://www.fendi.com/medias/sys_master/images/images/hf2/h4e/8917175648286/7E1392AJT6F1HKR-03.jpg'],
  ARRAY['6', '7', '8', '9', '10', '11', '12'],
  'Элегантные кроссовки Fendi Flow с характерным монограммным принтом FF. Роскошное сочетание спортивного стиля и итальянского мастерства.',
  'Fendi',
  'Streetwear',
  'unisex',
  false,
  0,
  45,
  true,
  'https://www.fendi.com/us/man/shoes/sneakers/flow-sneakers-7e1392ajt6f1hkr',
  ARRAY['Brown/Black', 'White/Brown'],
  'sneakers',
  'fendi',
  'streetwear'
);

-- Ralph Lauren - кашемировый пуловер (Old Money, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Ralph Lauren Cable-Knit Cashmere Sweater',
  59500,
  'Свитеры',
  'https://www.ralphlauren.com/dw/image/v2/AAFX_PRD/on/demandware.static/-/Sites-RalphLauren_US-Library/default/dw1eb5b1bf/img/202109/20210922-polo-women/modules/w_classics_polosweater.jpg',
  ARRAY['https://www.ralphlauren.com/dw/image/v2/AAFX_PRD/on/demandware.static/-/Sites-PRL_Master_Catalog/default/dw0732e3e2/s7-1380617/large/1380617_229802614001_2.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Роскошный кашемировый свитер Ralph Lauren с фирменным плетением "косичка". Воплощение американской классики и традиционного качества.',
  'Ralph Lauren',
  'Old Money',
  'women',
  false,
  0,
  47,
  true,
  'https://www.ralphlauren.com/women-clothing-sweaters/cable-knit-cashmere-sweater/614001.html',
  ARRAY['Camel', 'Cream', 'Navy'],
  'sweaters',
  'ralph-lauren',
  'old-money'
);

-- Balmain - структурированный блейзер (Old Money, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Balmain Double-Breasted Blazer',
  249000,
  'Пиджаки',
  'https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006347_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006350_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006348_1000.jpg'],
  ARRAY['34', '36', '38', '40', '42', '44'],
  'Структурированный двубортный блейзер Balmain с фирменными золотыми пуговицами. Знаковая модель французского дома, сочетающая военную строгость и парижский шик.',
  'Balmain',
  'Old Money',
  'women',
  false,
  0,
  46,
  true,
  'https://www.balmain.com/us/ready-to-wear-blazer-6-button-double-breasted-blazer-in-grain-de-poudre/VF17110W1100PA.html',
  ARRAY['Black', 'White', 'Navy'],
  'jackets',
  'balmain',
  'old-money'
);

-- MM6 Maison Margiela - сумка-тоут (Streetwear, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'MM6 Maison Margiela Japanese Tote',
  59000,
  'Сумки',
  'https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275201_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275202_1000.jpg', 'https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275203_1000.jpg'],
  ARRAY['Medium', 'Large'],
  'Культовая сумка-тоут MM6 Maison Margiela Japanese из мягкой экокожи. Инновационный дизайн с возможностью трансформации формы и размера.',
  'MM6 Maison Margiela',
  'Streetwear',
  'women',
  false,
  0,
  45,
  true,
  'https://www.maisonmargiela.com/us/mm6-maison-margiela/tote-bag_cod45393025ps.html',
  ARRAY['White', 'Black', 'Navy'],
  'bags',
  'mm6-maison-margiela',
  'streetwear'
);

-- Casablanca - шелковая рубашка (Vintage, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Casablanca Printed Silk Shirt',
  69000,
  'Рубашки',
  'https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073428_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073429_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073427_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Роскошная шелковая рубашка Casablanca с характерным художественным принтом. Уникальное сочетание теннисного стиля и роскошной пляжной эстетики.',
  'Casablanca',
  'Vintage',
  'men',
  true,
  0,
  44,
  true,
  'https://casablancaparis.com/',
  ARRAY['Multicolor'],
  'shirts',
  'casablanca',
  'vintage'
);

-- Chanel - лоферы с логотипом (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Chanel CC Loafers',
  129000,
  'Обувь',
  'https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847029633054.jpg',
  ARRAY['https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847030550542.jpg', 'https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847030583310.jpg'],
  ARRAY['35', '36', '37', '38', '39', '40', '41'],
  'Элегантные лоферы Chanel из мягкой ягнячьей кожи с характерным логотипом CC. Классическая модель, сочетающая комфорт и изысканный французский стиль.',
  'Chanel',
  'Old Money',
  'women',
  false,
  0,
  48,
  true,
  'https://www.chanel.com/us/fashion/p/G36360Y53840C0204/loafers-lambskin/',
  ARRAY['Beige/Black', 'Black'],
  'shoes',
  'chanel',
  'old-money'
);