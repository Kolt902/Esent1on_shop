-- Добавляем еще товары в каталог

-- The Row - платье (Old Money, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'The Row Wool Blend Knit Dress',
  247000,
  'Платья',
  'https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657048_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657049_1000.jpg', 'https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657047_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L'],
  'Элегантное трикотажное платье The Row из шерстяного смесового материала. Олицетворение минималистичной роскоши с безупречным кроем и высочайшим качеством исполнения.',
  'The Row',
  'Old Money',
  'women',
  false,
  0,
  47,
  true,
  'https://www.therow.com/',
  ARRAY['Black', 'Ivory'],
  'dresses',
  'the-row',
  'old-money'
);

-- Celine - солнцезащитные очки (Old Money, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Celine Triomphe 01 Sunglasses',
  42000,
  'Очки',
  'https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_0.jpg',
  ARRAY['https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_1.jpg', 'https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_2.jpg'],
  ARRAY['One Size'],
  'Культовые солнцезащитные очки Celine Triomphe 01 в ацетатной оправе с характерным логотипом на дужке. Классическая модель, полюбившаяся знаменитостям по всему миру.',
  'Celine',
  'Old Money',
  'women',
  false,
  0,
  46,
  true,
  'https://www.celine.com/en-us/celine-shop-women/accessories/sunglasses/triomphe-01-acetate-sunglasses-with-mineral-lenses-4811671NEAC.38NO.html',
  ARRAY['Black', 'Tortoise', 'Champagne'],
  'eyewear',
  'celine',
  'old-money'
);

-- Acne Studios - объемный шарф (Streetwear, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Acne Studios Oversized Wool Scarf',
  22500,
  'Аксессуары',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222129F013001_1/acne-studios-pink-and-burgundy-striped-wool-scarf.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222129F013001_2/acne-studios-pink-and-burgundy-striped-wool-scarf.jpg'],
  ARRAY['One Size'],
  'Знаменитый шарф Acne Studios из мягкой шерсти с характерной бахромой и культовой прямоугольной нашивкой с логотипом. Объемная модель, которая согреет в холодную погоду.',
  'Acne Studios',
  'Casual',
  'unisex',
  false,
  0,
  45,
  true,
  'https://www.acnestudios.com/us/en/oversized-wool-scarf-pink-burgundy-striped/CA0102-BCT.html',
  ARRAY['Pink/Burgundy', 'Grey/Black', 'Blue/Green'],
  'accessories',
  'acne-studios',
  'casual'
);

-- Toteme - джинсы (Casual, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Toteme Original Denim',
  29500,
  'Джинсы',
  'https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175018_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175016_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175017_1000.jpg'],
  ARRAY['24', '25', '26', '27', '28', '29', '30', '31'],
  'Элегантные прямые джинсы Toteme с высокой посадкой из высококачественного денима. Минималистичный скандинавский дизайн для образа в стиле quiet luxury.',
  'Toteme',
  'Old Money',
  'women',
  false,
  0,
  46,
  true,
  'https://toteme-studio.com/product/original-denim-washed-blue/',
  ARRAY['Washed Blue', 'Black', 'Ecru'],
  'jeans',
  'toteme',
  'old-money'
);

-- Stussy - худи с логотипом (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Stussy Stock Logo Hoodie',
  19000,
  'Худи',
  'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_1_720x.jpg',
  ARRAY['https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_2_720x.jpg', 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_3_720x.jpg'],
  ARRAY['S', 'M', 'L', 'XL', 'XXL'],
  'Классическое худи Stussy с фирменным логотипом. Легендарная модель от одного из пионеров уличной моды, которая остается актуальной десятилетиями.',
  'Stussy',
  'Streetwear',
  'unisex',
  false,
  0,
  46,
  true,
  'https://www.stussy.com/products/stock-logo-hood-1?variant=42390797525196',
  ARRAY['Black', 'Grey', 'Navy'],
  'hoodies',
  'stussy',
  'streetwear'
);

-- Palm Angels - спортивные брюки (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Palm Angels Track Pants',
  42000,
  'Брюки',
  'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_1/palm-angels-black-classic-track-pants.jpg',
  ARRAY['https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_2/palm-angels-black-classic-track-pants.jpg', 'https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_3/palm-angels-black-classic-track-pants.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Культовые спортивные брюки Palm Angels с характерными белыми лампасами и логотипом. Роскошная интерпретация классических тренировочных штанов от итальянского бренда.',
  'Palm Angels',
  'Streetwear',
  'men',
  true,
  0,
  45,
  true,
  'https://www.palmangels.com/en-us/shopping/track-pants-15573452',
  ARRAY['Black', 'Red', 'Purple'],
  'pants',
  'palm-angels',
  'streetwear'
);

-- Maison Margiela - сумка Glam Slam (Streetwear, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Maison Margiela Glam Slam Bag',
  198000,
  'Сумки',
  'https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460834_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460836_1000.jpg', 'https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460835_1000.jpg'],
  ARRAY['Medium'],
  'Культовая стеганая сумка Glam Slam от Maison Margiela из мягкой кожи с характерной объемной пуфовой структурой. Авангардный дизайн с фирменной белой нашивкой.',
  'Maison Margiela',
  'Streetwear',
  'women',
  false,
  0,
  45,
  true,
  'https://www.maisonmargiela.com/en-us/glam-slam-bag-MM6521.html',
  ARRAY['Black', 'White', 'Beige'],
  'bags',
  'maison-margiela',
  'streetwear'
);

-- New Balance - кроссовки 990v5 (Sport, Vintage)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'New Balance 990v5 Made in USA',
  22000,
  'Кроссовки',
  'https://nb.scene7.com/is/image/NB/m990gl5_nb_02_i?$pdpflexf2$&wid=440&hei=440',
  ARRAY['https://nb.scene7.com/is/image/NB/m990gl5_nb_05_i?$pdpflexf2$&wid=440&hei=440', 'https://nb.scene7.com/is/image/NB/m990gl5_nb_06_i?$pdpflexf2$&wid=440&hei=440'],
  ARRAY['7', '8', '9', '10', '11', '12', '13'],
  'Легендарные кроссовки New Balance 990v5, произведенные в США. Пятое поколение культовой модели, которая сочетает в себе комфорт, стабильность и стиль.',
  'New Balance',
  'Vintage',
  'unisex',
  false,
  0,
  48,
  true,
  'https://www.newbalance.com/pd/made-in-usa-990v5/M990V5-32152.html',
  ARRAY['Grey', 'Navy', 'Black'],
  'sneakers',
  'new-balance',
  'vintage'
);

-- A.P.C. - джинсы Petit Standard (Casual, Vintage)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'A.P.C. Petit Standard Jeans',
  26500,
  'Джинсы',
  'https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_01_grande.jpg',
  ARRAY['https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_10_grande.jpg', 'https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_30_grande.jpg'],
  ARRAY['28', '29', '30', '31', '32', '33', '34', '36'],
  'Культовые узкие джинсы A.P.C. Petit Standard из жесткого сырого денима. Эталон минималистичного французского стиля, которые со временем приобретают уникальную патину.',
  'A.P.C.',
  'Casual',
  'men',
  false,
  0,
  45,
  true,
  'https://www.apc-us.com/products/petit-standard-jeans-cocvhm09047',
  ARRAY['Indigo', 'Black', 'Stonewashed'],
  'jeans',
  'apc',
  'casual'
);

-- JW Anderson - сумка-тоут Chain (Streetwear, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'JW Anderson Medium Chain Tote Bag',
  75000,
  'Сумки',
  'https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075093_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075094_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075095_1000.jpg'],
  ARRAY['Medium'],
  'Знаковая сумка-тоут JW Anderson с характерной золотистой цепью в качестве ручки. Авангардный, но практичный дизайн, ставший символом современной моды.',
  'JW Anderson',
  'Streetwear',
  'unisex',
  true,
  0,
  45,
  true,
  'https://www.jwanderson.com/us/shopping/medium-chain-tote-15628325',
  ARRAY['Black', 'Navy', 'Tan'],
  'bags',
  'jw-anderson',
  'streetwear'
);

-- Versace - солнцезащитные очки Medusa (Vintage, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Versace Medusa Biggie Sunglasses',
  38500,
  'Очки',
  'https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw02285159/original/90_O4361-O17BKKN_ONUL_20_MedusaBiggieSunglasses-Sunglasses-versace-online-store_0_1.jpg',
  ARRAY['https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw58f08190/original/90_O4361-O17BKKN_ONUL_22_MedusaBiggieSunglasses-Sunglasses-versace-online-store_0_1.jpg'],
  ARRAY['One Size'],
  'Роскошные солнцезащитные очки Versace с культовым символом Медузы. Эффектная модель, которая мгновенно придает образу элемент роскоши и статуса.',
  'Versace',
  'Vintage',
  'unisex',
  false,
  0,
  44,
  true,
  'https://www.versace.com/us/en-us/medusa-biggie-sunglasses-onul/O4361-O17BKKN_ONUL.html',
  ARRAY['Black/Gold', 'Tortoise/Gold'],
  'eyewear',
  'versace',
  'vintage'
);

-- Jil Sander - минималистичный свитер (Old Money, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Jil Sander Cashmere Crewneck Sweater',
  84000,
  'Свитеры',
  'https://cdn-images.farfetch-contents.com/18/08/41/46/18084146_40735366_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/18/08/41/46/18084146_40735367_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Минималистичный кашемировый свитер Jil Sander с круглым вырезом. Образец безупречного немецкого минимализма с акцентом на высочайшее качество материалов и исполнения.',
  'Jil Sander',
  'Old Money',
  'unisex',
  false,
  0,
  45,
  true,
  'https://www.jilsander.com/en-us/cashmere-crewneck-sweater-JSMR751305_MRYG203_102.html',
  ARRAY['Cream', 'Black', 'Navy'],
  'sweaters',
  'jil-sander',
  'old-money'
);

-- Comme des Garçons - кардиган с сердцем (Streetwear, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Comme des Garçons PLAY Heart Cardigan',
  43500,
  'Свитеры',
  'https://cdn.shopify.com/s/files/1/0043/9642/products/cdg-play-p1n073-black_04.jpg',
  ARRAY['https://cdn.shopify.com/s/files/1/0043/9642/products/cdg-play-p1n073-black_05.jpg'],
  ARRAY['S', 'M', 'L', 'XL'],
  'Культовый кардиган Comme des Garçons PLAY с фирменным сердцем с глазами. Знаковая модель японского бренда, сочетающая классический силуэт с авангардными деталями.',
  'Comme des Garçons',
  'Streetwear',
  'unisex',
  false,
  0,
  46,
  true,
  'https://shop.doverstreetmarket.com/collections/comme-des-garcons-play-knitwear/products/play-mens-red-heart-cardigan-black-red-p1n073',
  ARRAY['Black', 'Navy', 'Grey'],
  'sweaters',
  'comme-des-garcons',
  'streetwear'
);

-- Stella McCartney - сумка Falabella (Casual, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Stella McCartney Falabella Tote',
  96500,
  'Сумки',
  'https://stellamccartneyuk.vtexassets.com/arquivos/ids/252877-800-800?v=638232152325270000&width=800&height=800&aspect=true',
  ARRAY['https://stellamccartneyuk.vtexassets.com/arquivos/ids/252876-800-800?v=638232152320970000&width=800&height=800&aspect=true', 'https://stellamccartneyuk.vtexassets.com/arquivos/ids/252874-800-800?v=638232152312230000&width=800&height=800&aspect=true'],
  ARRAY['Medium'],
  'Культовая экологичная сумка-тоут Stella McCartney Falabella с характерной отделкой цепочкой. Знаковая модель, созданная из инновационных экоматериалов без использования натуральной кожи.',
  'Stella McCartney',
  'Casual',
  'women',
  false,
  0,
  45,
  true,
  'https://www.stellamccartney.com/us/en/falabella-tote-bag-700158W91321000.html',
  ARRAY['Black', 'Grey', 'Burgundy'],
  'bags',
  'stella-mccartney',
  'casual'
);

-- Y-3 - кроссовки Qasa (Sport, Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Y-3 Qasa High Sneakers',
  38000,
  'Кроссовки',
  'https://assets.adidas.com/images/w_600,f_auto,q_auto/2bf8c4fb3bd6468ba3c1ad610113a50a_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_01_standard.jpg',
  ARRAY['https://assets.adidas.com/images/w_600,f_auto,q_auto/7be9be0f5f88494581e0ad610113b6d3_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_02_standard.jpg', 'https://assets.adidas.com/images/w_600,f_auto,q_auto/d15a5bb32c2d4d939be5ad610113ce44_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_03_standard.jpg'],
  ARRAY['7', '8', '9', '10', '11', '12'],
  'Легендарные футуристические кроссовки Y-3 Qasa High от Йоджи Ямамото и Adidas. Революционный дизайн с характерной округлой подошвой и неопреновым верхом, который перевернул представление о спортивной обуви.',
  'Y-3',
  'Streetwear',
  'unisex',
  true,
  0,
  46,
  true,
  'https://www.y-3.com/en-us/y-3-qasa-high-GZ9827.html',
  ARRAY['Black', 'White'],
  'sneakers',
  'y-3',
  'streetwear'
);

-- Alexander McQueen - кроссовки Oversized (Streetwear, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Alexander McQueen Oversized Sneakers',
  59000,
  'Кроссовки',
  'https://media.alexandermcqueen.com/product/553680/WHGP7/9061_c.jpg',
  ARRAY['https://media.alexandermcqueen.com/product/553680/WHGP7/9061_b.jpg', 'https://media.alexandermcqueen.com/product/553680/WHGP7/9061_a.jpg'],
  ARRAY['35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45'],
  'Культовые кроссовки Alexander McQueen с характерной увеличенной подошвой. Роскошная интерпретация классических белых кед из высококачественной кожи с контрастной пяткой.',
  'Alexander McQueen',
  'Streetwear',
  'unisex',
  false,
  0,
  47,
  true,
  'https://www.alexandermcqueen.com/en-us/oversized-sneaker-553680WHGP79061.html',
  ARRAY['White/Black', 'White/Red', 'White/Blue'],
  'sneakers',
  'alexander-mcqueen',
  'streetwear'
);

-- Thom Browne - классический кардиган (Casual, Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Thom Browne 4-Bar Merino Cardigan',
  89000,
  'Свитеры',
  'https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522153_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522151_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522156_1000.jpg'],
  ARRAY['1', '2', '3', '4', '5'],
  'Элегантный кардиган Thom Browne из тонкой мериносовой шерсти с характерными четырьмя полосками на рукаве. Классический силуэт с фирменным трехцветным гросгрейном.',
  'Thom Browne',
  'Old Money',
  'men',
  false,
  0,
  45,
  true,
  'https://www.thombrowne.com/us/shopping/4-bar-merino-cardigan-15962284',
  ARRAY['Navy', 'Grey', 'Black'],
  'sweaters',
  'thom-browne',
  'old-money'
);

-- Marni - кроссовки Fussbett (Casual, Vintage)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Marni Fussbett Sneakers',
  65000,
  'Кроссовки',
  'https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034284_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034285_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034286_1000.jpg'],
  ARRAY['36', '37', '38', '39', '40', '41', '42', '43', '44', '45'],
  'Оригинальные кроссовки Marni Fussbett из комбинации материалов с характерной анатомической подошвой. Эксцентричная модель с необычными пропорциями и характерной для бренда нестандартной эстетикой.',
  'Marni',
  'Vintage',
  'unisex',
  false,
  0,
  44,
  true,
  'https://www.marni.com/en-us/fussbett-sneakers-SNZU004201P2963Z100.html',
  ARRAY['Cream/Black', 'Green/Brown', 'White/Blue'],
  'sneakers',
  'marni',
  'vintage'
);

-- Givenchy - свитшот с логотипом (Streetwear)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Givenchy Embroidered Logo Sweatshirt',
  75000,
  'Свитеры',
  'https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37198536_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37197826_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37198545_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL', 'XXL'],
  'Роскошный свитшот Givenchy из высококачественного хлопка с вышитым логотипом. Элегантная интерпретация классической спортивной модели в характерном для бренда люксовом исполнении.',
  'Givenchy',
  'Streetwear',
  'men',
  false,
  0,
  45,
  true,
  'https://www.givenchy.com/us/en-US/embroidered-logo-sweatshirt-in-cotton-fleece/BMJ04K3Y6P-001.html',
  ARRAY['Black', 'White', 'Red'],
  'sweaters',
  'givenchy',
  'streetwear'
);

-- Dries Van Noten - рубашка с принтом (Vintage, Casual)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Dries Van Noten Printed Shirt',
  57000,
  'Рубашки',
  'https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37730372_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37729643_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37730389_1000.jpg'],
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  'Эффектная рубашка Dries Van Noten с характерным для бренда художественным принтом. Уникальное сочетание классического кроя и экспрессивного дизайна от бельгийского мастера.',
  'Dries Van Noten',
  'Vintage',
  'men',
  true,
  0,
  44,
  true,
  'https://www.driesvannoten.com/en-us/men/shirts/printed-shirt-13815752',
  ARRAY['Multi', 'Blue', 'Green'],
  'shirts',
  'dries-van-noten',
  'vintage'
);

-- Cecilie Bahnsen - юбка с объемной отделкой (Old Money)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Cecilie Bahnsen Pleated Skirt',
  127000,
  'Юбки',
  'https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417991_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417995_1000.jpg', 'https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417990_1000.jpg'],
  ARRAY['34', '36', '38', '40', '42'],
  'Роскошная юбка Cecilie Bahnsen с характерной для бренда объемной фактурной отделкой. Неповторимый скандинавский дизайн с элементами романтизма и скульптурными силуэтами.',
  'Cecilie Bahnsen',
  'Old Money',
  'women',
  true,
  0,
  44,
  true,
  'https://www.ceciliebahnsen.com/products/pleated-skirt-white',
  ARRAY['White', 'Black'],
  'skirts',
  'cecilie-bahnsen',
  'old-money'
);

-- Martine Rose - объемная футболка (Streetwear, Vintage)
INSERT INTO products (name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug)
VALUES (
  'Martine Rose Oversized T-Shirt',
  29000,
  'Футболки',
  'https://cdn-images.farfetch-contents.com/17/63/91/20/17639120_41028841_1000.jpg',
  ARRAY['https://cdn-images.farfetch-contents.com/17/63/91/20/17639120_41028842_1000.jpg'],
  ARRAY['S', 'M', 'L', 'XL'],
  'Объемная футболка Martine Rose с фирменной деконструкцией и смещенными пропорциями. Авангардный британский дизайн, переосмысляющий классические предметы гардероба.',
  'Martine Rose',
  'Streetwear',
  'unisex',
  false,
  0,
  43,
  true,
  'https://martine-rose.com/collections/t-shirts/products/classic-t-shirt-beige',
  ARRAY['Beige', 'Black', 'White'],
  't-shirts',
  'martine-rose',
  'streetwear'
);