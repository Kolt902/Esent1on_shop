--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: avatar_params; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avatar_params (
    id integer NOT NULL,
    user_id integer NOT NULL,
    height integer DEFAULT 175 NOT NULL,
    weight integer DEFAULT 70 NOT NULL,
    body_type text DEFAULT 'regular'::text NOT NULL,
    gender text DEFAULT 'male'::text NOT NULL,
    measurements jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: avatar_params_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.avatar_params_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avatar_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.avatar_params_id_seq OWNED BY public.avatar_params.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    logo_url text NOT NULL,
    website_url text,
    featured boolean DEFAULT false NOT NULL,
    slug text NOT NULL
);


--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    size text
);


--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    image_url text NOT NULL,
    slug text NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: delivery_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    full_name text NOT NULL,
    phone_number text NOT NULL,
    country text NOT NULL,
    city text NOT NULL,
    address text NOT NULL,
    postal_code text NOT NULL,
    is_default boolean DEFAULT false
);


--
-- Name: delivery_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_addresses_id_seq OWNED BY public.delivery_addresses.id;


--
-- Name: online_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.online_users (
    id integer NOT NULL,
    user_id integer NOT NULL,
    telegram_id text NOT NULL,
    username text NOT NULL,
    last_active text NOT NULL
);


--
-- Name: online_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.online_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: online_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.online_users_id_seq OWNED BY public.online_users.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    total_price integer NOT NULL,
    items jsonb NOT NULL,
    created_at text NOT NULL,
    full_name text NOT NULL,
    phone_number text NOT NULL,
    country text NOT NULL,
    city text NOT NULL,
    address text NOT NULL,
    postal_code text NOT NULL,
    delivery_notes text,
    payment_method text NOT NULL,
    referral_code text
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    category text NOT NULL,
    image_url text NOT NULL,
    additional_images text[] DEFAULT '{}'::text[] NOT NULL,
    sizes text[] NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    brand text DEFAULT ''::text NOT NULL,
    style text,
    gender text DEFAULT 'unisex'::text NOT NULL,
    is_new boolean DEFAULT false NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    rating integer DEFAULT 0 NOT NULL,
    in_stock boolean DEFAULT true NOT NULL,
    original_url text,
    colors text[] DEFAULT '{}'::text[] NOT NULL,
    category_slug text,
    brand_slug text,
    style_slug text
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: referral_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.referral_codes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    code text NOT NULL,
    discount_percentage integer DEFAULT 10 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    usage_count integer DEFAULT 0 NOT NULL,
    created_at text NOT NULL,
    expires_at text
);


--
-- Name: referral_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.referral_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referral_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.referral_codes_id_seq OWNED BY public.referral_codes.id;


--
-- Name: referral_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.referral_usage (
    id integer NOT NULL,
    referral_code_id integer NOT NULL,
    referrer_id integer NOT NULL,
    referred_user_id integer NOT NULL,
    order_id integer NOT NULL,
    discount_amount integer NOT NULL,
    used_at text NOT NULL
);


--
-- Name: referral_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.referral_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referral_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.referral_usage_id_seq OWNED BY public.referral_usage.id;


--
-- Name: styles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.styles (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    image_url text NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    slug text NOT NULL
);


--
-- Name: styles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.styles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.styles_id_seq OWNED BY public.styles.id;


--
-- Name: user_favorites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_favorites (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    date_added text NOT NULL,
    notes text
);


--
-- Name: user_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_favorites_id_seq OWNED BY public.user_favorites.id;


--
-- Name: user_virtual_wardrobe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_virtual_wardrobe (
    id integer NOT NULL,
    user_id integer NOT NULL,
    clothing_item_id integer NOT NULL,
    selected_color text NOT NULL,
    selected_size text NOT NULL,
    is_favorite boolean DEFAULT false NOT NULL,
    date_added text NOT NULL
);


--
-- Name: user_virtual_wardrobe_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_virtual_wardrobe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_virtual_wardrobe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_virtual_wardrobe_id_seq OWNED BY public.user_virtual_wardrobe.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    telegram_id text,
    is_admin boolean DEFAULT false NOT NULL,
    email text,
    full_name text,
    phone text,
    avatar_url text,
    last_login text,
    registration_date text,
    referral_code text,
    referred_by text,
    referral_count integer DEFAULT 0 NOT NULL,
    referral_discount integer DEFAULT 0 NOT NULL,
    notification_settings jsonb DEFAULT '{"priceDrops": false, "promotions": true, "newArrivals": true, "orderUpdates": true}'::jsonb NOT NULL,
    preferences jsonb DEFAULT '{"theme": "auto", "currency": "EUR", "language": "en"}'::jsonb,
    created_at text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: virtual_clothing_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.virtual_clothing_items (
    id integer NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    category text NOT NULL,
    product_id integer NOT NULL,
    model_path text NOT NULL,
    thumbnail_url text NOT NULL,
    colors text[] DEFAULT '{}'::text[] NOT NULL,
    sizes text[] DEFAULT '{}'::text[] NOT NULL
);


--
-- Name: virtual_clothing_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.virtual_clothing_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: virtual_clothing_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.virtual_clothing_items_id_seq OWNED BY public.virtual_clothing_items.id;


--
-- Name: avatar_params id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avatar_params ALTER COLUMN id SET DEFAULT nextval('public.avatar_params_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: delivery_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_addresses ALTER COLUMN id SET DEFAULT nextval('public.delivery_addresses_id_seq'::regclass);


--
-- Name: online_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_users ALTER COLUMN id SET DEFAULT nextval('public.online_users_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: referral_codes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_codes ALTER COLUMN id SET DEFAULT nextval('public.referral_codes_id_seq'::regclass);


--
-- Name: referral_usage id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_usage ALTER COLUMN id SET DEFAULT nextval('public.referral_usage_id_seq'::regclass);


--
-- Name: styles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.styles ALTER COLUMN id SET DEFAULT nextval('public.styles_id_seq'::regclass);


--
-- Name: user_favorites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_favorites ALTER COLUMN id SET DEFAULT nextval('public.user_favorites_id_seq'::regclass);


--
-- Name: user_virtual_wardrobe id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_virtual_wardrobe ALTER COLUMN id SET DEFAULT nextval('public.user_virtual_wardrobe_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: virtual_clothing_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_clothing_items ALTER COLUMN id SET DEFAULT nextval('public.virtual_clothing_items_id_seq'::regclass);


--
-- Name: avatar_params avatar_params_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avatar_params
    ADD CONSTRAINT avatar_params_pkey PRIMARY KEY (id);


--
-- Name: avatar_params avatar_params_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avatar_params
    ADD CONSTRAINT avatar_params_user_id_unique UNIQUE (user_id);


--
-- Name: brands brands_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_name_unique UNIQUE (name);


--
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: brands brands_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_slug_unique UNIQUE (slug);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_unique UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: delivery_addresses delivery_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_addresses
    ADD CONSTRAINT delivery_addresses_pkey PRIMARY KEY (id);


--
-- Name: online_users online_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_users
    ADD CONSTRAINT online_users_pkey PRIMARY KEY (id);


--
-- Name: online_users online_users_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.online_users
    ADD CONSTRAINT online_users_user_id_unique UNIQUE (user_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: referral_codes referral_codes_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_codes
    ADD CONSTRAINT referral_codes_code_unique UNIQUE (code);


--
-- Name: referral_codes referral_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_codes
    ADD CONSTRAINT referral_codes_pkey PRIMARY KEY (id);


--
-- Name: referral_codes referral_codes_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_codes
    ADD CONSTRAINT referral_codes_user_id_unique UNIQUE (user_id);


--
-- Name: referral_usage referral_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_usage
    ADD CONSTRAINT referral_usage_pkey PRIMARY KEY (id);


--
-- Name: styles styles_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_name_unique UNIQUE (name);


--
-- Name: styles styles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_pkey PRIMARY KEY (id);


--
-- Name: styles styles_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_slug_unique UNIQUE (slug);


--
-- Name: user_favorites user_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT user_favorites_pkey PRIMARY KEY (id);


--
-- Name: user_virtual_wardrobe user_virtual_wardrobe_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_virtual_wardrobe
    ADD CONSTRAINT user_virtual_wardrobe_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: virtual_clothing_items virtual_clothing_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_clothing_items
    ADD CONSTRAINT virtual_clothing_items_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: avatar_params; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.avatar_params (id, user_id, height, weight, body_type, gender, measurements) FROM stdin;
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.brands (id, name, description, logo_url, website_url, featured, slug) FROM stdin;
1	Nike	Американский бренд спортивной одежды и обуви, известный инновационными технологиями и дизайном.	https://i.imgur.com/JUAvQhH.png	https://www.nike.com	t	nike
2	Jordan	Легендарный бренд баскетбольной обуви и одежды, созданный в сотрудничестве с Майклом Джорданом.	https://i.imgur.com/kUXgIlT.png	https://www.nike.com/jordan	t	jordan
3	Adidas	Немецкий спортивный бренд с богатой историей, создающий инновационную одежду, обувь и аксессуары.	https://i.imgur.com/q3jmMMS.png	https://www.adidas.com	t	adidas
4	Stussy	Культовый стритвир-бренд, оказавший огромное влияние на уличную моду и субкультуру.	https://i.imgur.com/KBTO5m5.png	https://www.stussy.com	t	stussy
5	Chrome Hearts	Люксовый бренд, известный готической эстетикой и ручной работой с серебром и кожей.	https://i.imgur.com/2HZzRuT.png	https://www.chromehearts.com	t	chrome-hearts
6	GRAB	Современный бренд с фокусом на минималистичном дизайне и качественных материалах.	https://i.imgur.com/hZBQMvK.png	\N	f	grab
7	Balenciaga	Французский люксовый дом моды, сочетающий аванградный дизайн с роскошью.	https://i.imgur.com/XzpJREJ.png	https://www.balenciaga.com	t	balenciaga
8	Gucci	Итальянский люксовый бренд, символ роскоши и эклектичного стиля.	https://i.imgur.com/TjGk9lA.png	https://www.gucci.com	t	gucci
9	Diesel	Итальянский бренд, известный инновационным подходом к дениму и повседневной одежде.	https://i.imgur.com/njsVIbG.png	https://www.diesel.com	f	diesel
10	Celine	Французский люксовый бренд, известный минимализмом и элегантной эстетикой.	https://i.imgur.com/86DcUT5.png	https://www.celine.com	f	celine
11	Miu Miu	Итальянский бренд, предлагающий игривый и провокационный подход к женской моде.	https://i.imgur.com/CQ8vfcX.png	https://www.miumiu.com	f	miu-miu
12	Prada	Итальянский дом моды с богатой историей, символ интеллектуальной роскоши.	https://i.imgur.com/JkbHmZZ.png	https://www.prada.com	t	prada
13	Rick Owens	Авангардный дизайнер с уникальной эстетикой на стыке гранжа и архитектурных форм.	https://i.imgur.com/iUAXXLl.png	https://www.rickowens.eu	f	rick-owens
14	Yeezy	Коллаборационный бренд Канье Уэста, известный минималистичным дизайном и инновационными силуэтами.	https://i.imgur.com/Y0gKyAk.png	\N	t	yeezy
15	Palm Angels	Итальянский бренд, объединяющий калифорнийскую скейт-культуру с роскошью.	https://i.imgur.com/C8vPY9M.png	https://www.palmangels.com	f	palm-angels
16	Amiri	Американский бренд, сочетающий рок-н-ролльную эстетику с тщательным вниманием к деталям и качеству.	https://i.imgur.com/5rlQXrK.png	https://www.amiri.com	f	amiri
17	Louis Vuitton	Французский дом моды с богатейшей историей, икона роскоши и изысканного стиля.	https://i.imgur.com/fzlMbQl.png	https://www.louisvuitton.com	t	louis-vuitton
18	Off-White	Инновационный бренд Вирджила Абло, смешивающий уличную моду с высокой модой.	https://i.imgur.com/7HyEFP0.png	https://www.off---white.com	t	off-white
19	Stone Island	Итальянский бренд, известный техническими инновациями и экспериментами с тканями и красителями.	https://i.imgur.com/ArhPhbT.png	https://www.stoneisland.com	f	stone-island
20	New Balance	Американский бренд спортивной обуви и одежды, известный комфортом и винтажным стилем.	https://i.imgur.com/VCsYJiM.png	https://www.newbalance.com	f	new-balance
21	Reebok	Спортивный бренд с богатой историей, создающий стильную и функциональную обувь и одежду.	https://i.imgur.com/ixiY9LC.png	https://www.reebok.com	f	reebok
22	Fear of God	Американский бренд роскошной уличной одежды с минималистичной эстетикой.	https://i.imgur.com/FJIvWm5.png	https://fearofgod.com	t	fear-of-god
23	Drew House	Бренд, основанный Джастином Бибером, предлагающий унисекс-коллекции с расслабленным стилем.	https://i.imgur.com/2BzI0CS.png	https://www.drewhouse.com	f	drew-house
24	Bape	Японский стритвир-бренд с узнаваемым камуфляжным принтом и яркой графикой.	https://i.imgur.com/Ke3zEcD.png	https://www.bape.com	f	bape
25	Essentials	Минималистичная линия Fear of God, предлагающая базовую одежду высокого качества.	https://i.imgur.com/SGwj5cN.png	https://fearofgod.com/collections/essentials	f	essentials
26	Supreme	Культовый нью-йоркский скейт-бренд, ставший иконой уличной моды.	https://i.imgur.com/wWXNR2k.png	https://www.supremenewyork.com	t	supreme
27	Maison Margiela	Авангардный французский бренд, известный деконструкцией и концептуальным дизайном.	https://i.imgur.com/xCLPZFb.png	https://www.maisonmargiela.com	f	maison-margiela
28	A-COLD-WALL	Британский бренд, сочетающий индустриальную эстетику с авангардными формами.	https://i.imgur.com/NVXLx8Q.png	https://www.a-cold-wall.com	f	a-cold-wall
29	Represent	Британский бренд, создающий современную интерпретацию классической мужской одежды.	https://i.imgur.com/S6bOoky.png	https://representclo.com	f	represent
30	Ader Error	Корейский бренд с уникальным подходом к современной уличной моде и графическому дизайну.	https://i.imgur.com/lRuEEST.png	https://www.adererror.com	f	ader-error
32	Levi's	Американский бренд с более чем 150-летней историей, известный своими высококачественными джинсами.	https://i.imgur.com/q7K7CKD.png	https://www.levi.com	f	levis
33	Champion	Американский бренд спортивной одежды, основанный в 1919 году и известный своими толстовками и спортивными костюмами.	https://i.imgur.com/qkOVx3K.png	https://www.champion.com	f	champion
34	Ralph Lauren	Американский бренд, символ классического стиля и роскоши.	https://i.imgur.com/JXvD2Kg.png	https://www.ralphlauren.com	t	ralph-lauren
35	H&M	Шведский бренд быстрой моды, предлагающий современную одежду по доступным ценам.	https://i.imgur.com/UFzFY1w.png	https://www2.hm.com	f	h-and-m
36	Uniqlo	Японский бренд повседневной одежды с фокусом на простоту, качество и долговечность.	https://i.imgur.com/7eaZQLx.png	https://www.uniqlo.com	f	uniqlo
37	Zara	Испанский бренд быстрой моды с трендовыми дизайнами и быстрым циклом обновления коллекций.	https://i.imgur.com/tQrJnlX.png	https://www.zara.com	f	zara
38	DSquared2	Итальянский люксовый бренд, созданный братьями-близнецами Дином и Дэном Кейтенами, известный своей дерзкой и сексуальной одеждой.	https://i.imgur.com/dj1Yh5U.png	https://www.dsquared2.com	f	dsquared2
39	AMI Paris	Французский бренд, основанный Александром Матюсси, предлагающий современную мужскую и женскую одежду с парижским шиком.	https://i.imgur.com/2lWqbYO.png	https://www.amiparis.com	f	ami-paris
40	Alexander McQueen	Британский люксовый бренд, основанный дизайнером Александром МакКуином, известный своим авангардным подходом к моде.	https://i.imgur.com/iKhMFfT.png	https://www.alexandermcqueen.com	f	alexander-mcqueen
41	Burberry	Британский люксовый бренд с богатой историей, известный своим клетчатым узором и элегантным классическим стилем.	https://i.imgur.com/nTwkJyv.png	https://www.burberry.com	f	burberry
42	Dior	Французский люксовый дом моды, основанный Кристианом Диором, известный элегантными и изысканными коллекциями.	https://i.imgur.com/P1DwMAv.png	https://www.dior.com	t	dior
43	Versace	Итальянский модный дом, основанный Джанни Версаче, известный яркими принтами и роскошной эстетикой.	https://i.imgur.com/wR1YQuK.png	https://www.versace.com	f	versace
44	Fendi	Итальянский модный дом с богатой историей, известный своими меховыми изделиями, сумками и инновационным подходом к дизайну.	https://i.imgur.com/TKmOMXZ.png	https://www.fendi.com	f	fendi
45	Saint Laurent	Французский люксовый дом моды, известный своим элегантным рок-н-ролльным стилем и безупречным качеством.	https://i.imgur.com/yz0JSkQ.png	https://www.ysl.com	t	saint-laurent
46	Chanel	Легендарный французский модный дом, символ роскоши и элегантности, основанный Коко Шанель.	https://i.imgur.com/rDMU3kk.png	https://www.chanel.com	t	chanel
47	Moncler	Итальянский люксовый бренд, известный своими высокотехнологичными пуховиками и верхней одеждой.	https://i.imgur.com/pPEHzPa.png	https://www.moncler.com	f	moncler
48	Cartier	Французский дом роскоши, специализирующийся на ювелирных украшениях, часах и аксессуарах, символ элегантности и утонченности.	https://i.imgur.com/Fx1bMAB.png	https://www.cartier.com	f	cartier
49	Thom Browne	Американский бренд от дизайнера Тома Брауна, известный своим уникальным подходом к классическому мужскому гардеробу.	https://i.imgur.com/45WTjJl.png	https://www.thombrowne.com	f	thom-browne
50	Hermes	Французский дом высокой моды, символ роскоши и качества, известный своими кожаными изделиями, шелковыми шарфами и эксклюзивными сумками.	https://i.imgur.com/q5C3XXE.png	https://www.hermes.com	t	hermes
51	Bottega Veneta	Итальянский люксовый бренд, известный своим плетеным узором intrecciato и безупречным качеством кожаных изделий.	https://i.imgur.com/nH7DGSD.png	https://www.bottegaveneta.com	f	bottega-veneta
52	Canada Goose	Канадский бренд верхней одежды премиум-класса, специализирующийся на пуховиках и парках для экстремальных погодных условий.	https://i.imgur.com/6Y9y4YK.png	https://www.canadagoose.com	f	canada-goose
53	Vivienne Westwood	Британский модный бренд, основанный дизайнером Вивьен Вествуд, известный своим авангардным подходом и элементами панк-культуры.	https://i.imgur.com/uOgUl2v.png	https://www.viviennewestwood.com	f	vivienne-westwood
54	Acne Studios	Шведский модный дом, известный своим современным, минималистичным подходом к дизайну и высоким качеством.	https://i.imgur.com/J7HvOGp.png	https://www.acnestudios.com	f	acne-studios
57	JW Anderson	Британский бренд, основанный Джонатаном Андерсоном, известный своими гендерно-нейтральными коллекциями и культовыми аксессуарами.	https://i.imgur.com/XAyv3wO.png	https://www.jwanderson.com	f	jw-anderson
58	Jacquemus	Французский бренд, созданный Симоном Портом Жакмю, известный яркими, асимметричными силуэтами и культовыми миниатюрными сумками.	https://i.imgur.com/yd3hmXK.png	https://www.jacquemus.com	f	jacquemus
62	Marine Serre	Французский бренд, основанный Марин Серр, сочетающий устойчивый подход с футуристическим дизайном и символом полумесяца.	https://i.imgur.com/o9b9Zrd.png	https://marineserre.com	f	marine-serre
64	Jil Sander	Немецкий модный дом, основанный Жиль Сандер, известный своим минималистичным, сдержанным подходом к роскоши и безупречному крою.	https://i.imgur.com/6kWHKLm.png	https://www.jilsander.com	f	jil-sander
65	Loewe	Испанский люксовый дом, основанный в 1846 году, сочетающий мастерство работы с кожей, авангардный дизайн и культурное наследие.	https://i.imgur.com/Uv83ZKz.png	https://www.loewe.com	f	loewe
67	Coperni	Парижский бренд, основанный Себастьеном Мейером и Арно Вайяном, сочетающий современные технологии с футуристическим дизайном и четкими силуэтами.	https://i.imgur.com/sZvKlEr.png	https://coperniparis.com	f	coperni
68	Lemaire	Французский бренд, основанный Кристофом Лемэром, известный своим минималистичным, вневременным дизайном и безупречным качеством.	https://i.imgur.com/tBPkHLZ.png	https://us.lemaire.fr	f	lemaire
69	The Row	Американский люксовый бренд, основанный Мэри-Кейт и Эшли Олсен, известный своим минималистичным подходом, исключительным качеством и концепцией "тихой роскоши".	https://i.imgur.com/B31o4dN.png	https://www.therow.com	f	the-row
70	Casablanca	Французско-марокканский бренд, основанный Шарифом Таззи, сочетающий роскошную эстетику теннисных клубов и экзотических курортов с яркими принтами.	https://i.imgur.com/kYBK3Fc.png	https://casablancaparis.com	f	casablanca
71	Y/Project	Парижский бренд, руководимый бельгийским дизайнером Гленном Мартенсом, известный своим деконструктивным подходом к дизайну и переосмыслением классических предметов гардероба.	https://i.imgur.com/0Z3lVXt.png	https://www.yproject.fr	f	y-project
72	Raf Simons	Бельгийский бренд, основанный дизайнером Рафом Симонсом, известный своим авангардным подходом, влиянием молодежной культуры и субкультур на высокую моду.	https://i.imgur.com/XCJmwAj.png	https://www.rafsimons.com	f	raf-simons
73	Junya Watanabe	Японский дизайнерский бренд, принадлежащий к семье Comme des Garçons, известный своими инновационными техниками кроя, сложными конструкциями и экспериментами с материалами.	https://i.imgur.com/hV6yZDW.png	https://shop.doverstreetmarket.com/collections/junya-watanabe-man	f	junya-watanabe
74	Nanushka	Венгерский бренд, основанный Сандрой Сандор, сочетающий современный минимализм с восточноевропейскими влияниями и этичный подход к производству.	https://i.imgur.com/R9VaJzK.png	https://nanushka.com	f	nanushka
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items (id, user_id, product_id, quantity, size) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, description, image_url, slug) FROM stdin;
1	Кроссовки	Спортивная и повседневная обувь разных брендов	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-max-270-mens-shoes-KkLcGR.png	sneakers
2	Худи	Толстовки с капюшоном разных брендов и стилей	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/33f458b3-9079-4e71-8ece-28cfc95a4383/sportswear-club-fleece-mens-pullover-hoodie-mRm6FD.png	hoodies
3	Футболки	Футболки разных брендов и стилей	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5fcc600c-8afb-41b0-bc1e-2b427836ec9a/sportswear-mens-t-shirt-mwTdHb.png	tshirts
4	Брюки	Брюки и джинсы разных брендов и стилей	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/2f6ca908-f593-461b-b1b2-40ee9be57ff6/sportswear-club-fleece-joggers-KflRdQ.png	pants
5	Очки	Солнцезащитные и имиджевые очки разных брендов	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1616065208/663748_I0330_1268_001_100_0000_Light-Lunettes-de-soleil-rondes-en-mtal.jpg	glasses
6	Сумки	Сумки, рюкзаки, кошельки разных брендов	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1674060324/631685_17QDT_1000_001_100_0000_Light-Mini-sac-The-Jackie-1961.jpg	bags
7	Аксессуары	Шапки, шарфы, перчатки и другие аксессуары	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1661538015/698817_4HAG9_1000_001_100_0000_Light-Chapeau-fedora-GG-en-toile.jpg	accessories
8	Джинсы	Джинсы различных фасонов и стилей от ведущих мировых брендов	https://i.imgur.com/S7oHxza.jpg	jeans
11	Куртки	Куртки и верхняя одежда от ведущих мировых брендов	https://i.imgur.com/GYcBYiA.jpg	jackets
12	Свитеры	Свитеры, джемперы и кардиганы для создания стильного образа	https://i.imgur.com/sSFJ5bj.jpg	sweaters
13	Пиджаки	Элегантные пиджаки и блейзеры для формальных и повседневных образов	https://i.imgur.com/2G5hUw9.jpg	blazers
14	Платья	Элегантные платья на любой случай от ведущих мировых брендов	https://i.imgur.com/TqJXxGn.jpg	dresses
15	Обувь	Стильная обувь для мужчин и женщин от ведущих мировых брендов	https://i.imgur.com/NXjA0Kk.jpg	shoes
16	Юбки	Стильные юбки разной длины от ведущих мировых брендов	https://i.imgur.com/Q5zJZHm.jpg	skirts
\.


--
-- Data for Name: delivery_addresses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_addresses (id, user_id, full_name, phone_number, country, city, address, postal_code, is_default) FROM stdin;
\.


--
-- Data for Name: online_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.online_users (id, user_id, telegram_id, username, last_active) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, user_id, status, total_price, items, created_at, full_name, phone_number, country, city, address, postal_code, delivery_notes, payment_method, referral_code) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, name, price, category, image_url, additional_images, sizes, description, brand, style, gender, is_new, discount, rating, in_stock, original_url, colors, category_slug, brand_slug, style_slug) FROM stdin;
1	Nike Air Max 270	12990	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/skwgyqrbfzhu6uyeh0gg/air-max-270-mens-shoes-KkLcGR.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/fg3necfcxgccw3ggsjty/air-max-270-mens-shoes-KkLcGR.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/bupxzujeocextn0xr8d7/air-max-270-mens-shoes-KkLcGR.png"}	{40,41,42,43,44,45}	Кроссовки Nike Air Max 270 с массивной воздушной подушкой для максимального комфорта и стиля.	Nike	Sport	men	f	10	46	t	https://www.nike.com/t/air-max-270-mens-shoes-KkLcGR/AH8050-002	{black,white}	sneakers	nike	sport
2	Nike Dunk Low Retro	10990	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9559f730-2e9d-4232-9e89-e8e81ddc8cc4/dunk-low-retro-mens-shoes-76KnBL.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/2c8726a5-624d-4c15-99e6-7df8c9281ee6/dunk-low-retro-mens-shoes-76KnBL.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/53c32a0e-a5de-4e3b-9ca1-d3a96aa4d7c2/dunk-low-retro-mens-shoes-76KnBL.png"}	{38,39,40,41,42,43,44}	Низкие кроссовки Nike Dunk с подошвой, обеспечивающей отличное сцепление и комфорт на весь день.	Nike	Casual	men	t	0	45	t	https://www.nike.com/t/dunk-low-retro-mens-shoes-76KnBL/DJ6188-100	{white,blue}	sneakers	nike	casual
3	Nike Air Force 1 07	11990	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/7cd0a8e1-1a27-442c-9f25-a2e093150e6c/air-force-1-07-womens-shoes-GCkPzr.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/8cce908d-d3aa-4034-bc8a-06c13b1c24a9/air-force-1-07-womens-shoes-GCkPzr.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e2d0d3c3-5b54-4223-b1c0-7c1aca94c069/air-force-1-07-womens-shoes-GCkPzr.png"}	{36,37,38,39,40,41}	Классические кроссовки Nike Air Force 1 из кожи с низким профилем и мягкой амортизацией для комфорта на весь день.	Nike	Casual	women	f	0	48	t	https://www.nike.com/t/air-force-1-07-womens-shoes-GCkPzr/DD8959-100	{white,black}	sneakers	nike	casual
4	Adidas Ultraboost 22	15990	Кроссовки	https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fbaf991a78bc4896a3e9ad7800abcec6_9366/Ultraboost_22_Shoes_Black_GZ0127_01_standard.jpg	{"https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/d0720712d81e4553a036ad7800abd927_9366/Ultraboost_22_Shoes_Black_GZ0127_02_standard_hover.jpg","https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/0fbed4646cdc4944b355ad7800abea1d_9366/Ultraboost_22_Shoes_Black_GZ0127_03_standard.jpg"}	{40,41,42,43,44,45}	Кроссовки Adidas Ultraboost 22 с инновационной технологией амортизации для бега и повседневной носки.	Adidas	Sport	men	t	0	47	t	https://www.adidas.com/us/ultraboost-22-shoes/GZ0127.html	{black,white}	sneakers	adidas	sport
5	Adidas Originals Superstar	9990	Кроссовки	https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/7ed0855435194229a525aad6009a0497_9366/Superstar_Shoes_White_EG4958_01_standard.jpg	{"https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/8a358bcd6fa847d7b0f7aad6009a249e_9366/Superstar_Shoes_White_EG4958_02_standard_hover.jpg","https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c7f3f199b4b446dcba7faad6009a2e3a_9366/Superstar_Shoes_White_EG4958_03_standard.jpg"}	{36,37,38,39,40,41,42,43,44}	Классические кроссовки Adidas Superstar с характерным дизайном и фирменными тремя полосками.	Adidas	Casual	unisex	f	0	49	t	https://www.adidas.com/us/superstar-shoes/EG4958.html	{white,black}	sneakers	adidas	casual
6	Adidas Essentials Fleece Hoodie	5990	Худи	https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/a5cc6be8512a4b27ae85ae2101449b62_9366/Essentials_Fleece_3-Stripes_Full-Zip_Hoodie_Grey_H46096_01_laydown.jpg	{"https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/81a3ec6fb4994c04ad06ae21014518a6_9366/Essentials_Fleece_3-Stripes_Full-Zip_Hoodie_Grey_H46096_21_model.jpg","https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/1ad47abf31e848498e51ae2101452bc7_9366/Essentials_Fleece_3-Stripes_Full-Zip_Hoodie_Grey_H46096_23_hover_model.jpg"}	{S,M,L,XL,XXL}	Мужская толстовка Adidas Essentials Fleece с капюшоном и фирменными тремя полосками на рукавах.	Adidas	Casual	men	f	15	42	t	https://www.adidas.com/us/essentials-fleece-3-stripes-full-zip-hoodie/H46096.html	{grey,black}	hoodies	adidas	casual
7	Air Jordan 1 Retro High OG	17990	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/5e4a0ef6-666b-4267-9013-c847653cf5b3/air-jordan-1-retro-high-og-shoes-Pz5Hk5.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/2ecbb014-6761-4115-a17f-9596ef7ab171/air-jordan-1-retro-high-og-shoes-Pz5Hk5.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/2e4a6d4d-0b41-4743-be92-13c7671baad7/air-jordan-1-retro-high-og-shoes-Pz5Hk5.png"}	{40,41,42,43,44,45}	Легендарные высокие кроссовки Air Jordan 1 Retro с классическим дизайном и высококачественными материалами.	Jordan	Streetwear	men	t	0	49	t	https://www.nike.com/t/air-jordan-1-retro-high-og-shoes-Pz5Hk5/555088-180	{red,black,white}	sneakers	jordan	streetwear
8	Gucci GG Marmont Small Shoulder Bag	159900	Сумки	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1501707305/443497_DTDID_1000_001_063_0000_Light-GG-Marmont-small-matelass-shoulder-bag.jpg	{https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1501707308/443497_DTDID_1000_002_063_0000_Light-GG-Marmont-small-matelass-shoulder-bag.jpg,https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1501707310/443497_DTDID_1000_003_063_0000_Light-GG-Marmont-small-matelass-shoulder-bag.jpg}	{"one size"}	Элегантная маленькая стеганая сумка Gucci GG Marmont с характерной пряжкой Double G и цепочкой.	Gucci	Old Money	women	f	0	46	t	https://www.gucci.com/us/en/pr/women/handbags/shoulder-bags-for-women/gg-marmont-small-matelasse-shoulder-bag-p-443497DTDID1000	{black}	bags	gucci	old-money
9	Balenciaga Triple S Sneakers	89900	Кроссовки	https://balenciaga.dam.kering.com/m/1c2d0caf022816cb/Large-524037W2CA19000_F.jpg	{https://balenciaga.dam.kering.com/m/51ef5e0c416b4c23/Large-524037W2CA19000_D.jpg,https://balenciaga.dam.kering.com/m/7528c823ef3b3c89/Large-524037W2CA19000_B.jpg}	{39,40,41,42,43,44,45}	Массивные кроссовки Balenciaga Triple S с многослойной подошвой и сложным дизайном.	Balenciaga	Streetwear	unisex	f	0	44	t	https://www.balenciaga.com/en-us/triple-s-black-524037W2CA19000.html	{black,white}	sneakers	balenciaga	streetwear
10	Stussy 8 Ball T-Shirt	7990	Футболки	https://cdn.shopify.com/s/files/1/0087/6193/3920/products/1904649_NATURAL_1_720x.jpg	{https://cdn.shopify.com/s/files/1/0087/6193/3920/products/1904649_NATURAL_2_720x.jpg,https://cdn.shopify.com/s/files/1/0087/6193/3920/products/1904649_NATURAL_3_720x.jpg}	{S,M,L,XL}	Культовая футболка Stussy с принтом 8 Ball из чистого хлопка.	Stussy	Streetwear	unisex	t	0	46	t	https://www.stussy.com/collections/tees/products/8-ball-tee	{white,black}	tshirts	stussy	streetwear
11	Stone Island Garment Dyed Hoodie	28990	Худи	https://cdn.shopify.com/s/files/1/0987/0298/products/751564113-V0030_1_720x.jpg	{https://cdn.shopify.com/s/files/1/0987/0298/products/751564113-V0030_2_720x.jpg,https://cdn.shopify.com/s/files/1/0987/0298/products/751564113-V0030_3_720x.jpg}	{S,M,L,XL,XXL}	Премиальная толстовка Stone Island из высококачественного хлопка с фирменным патчем на рукаве.	Stone Island	Casual	men	f	0	47	t	https://www.stoneisland.com/en-us/hooded-sweatshirt_cod14046335gh.html	{blue,black}	hoodies	stone-island	casual
12	Ralph Lauren Polo Shirt	9990	Футболки	https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dw0cba4ab2/products/1084675/1084675_01F_PDH.jpg	{https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dw50291ad6/products/1084675/1084675_01F_PDH1.jpg,https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dw7b5bf19c/products/1084675/1084675_01F_PDH2.jpg}	{S,M,L,XL}	Классическая рубашка-поло Ralph Lauren из 100% хлопка с фирменным логотипом.	Ralph Lauren	Old Money	men	f	0	48	t	https://www.ralphlauren.com/men-clothing-polo-shirts/custom-slim-fit-mesh-polo-shirt/1084675.html	{navy,white,black,red}	tshirts	ralph-lauren	old-money
13	Gucci Square Sunglasses	39900	Очки	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1584995404/595206_I3330_1078_001_100_0000_Light-Square-frame-acetate-sunglasses.jpg	{https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1584995407/595206_I3330_1078_002_100_0000_Light-Square-frame-acetate-sunglasses.jpg,https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1584995410/595206_I3330_1078_003_100_0000_Light-Square-frame-acetate-sunglasses.jpg}	{"one size"}	Квадратные солнцезащитные очки Gucci из ацетата с фирменными деталями на дужках.	Gucci	Old Money	unisex	f	0	45	t	https://www.gucci.com/us/en/pr/men/accessories-for-men/sunglasses-for-men/square-rectangle/square-frame-acetate-sunglasses-p-595206I33301078	{black,tortoise}	glasses	gucci	old-money
14	Balenciaga Logo Track Pants	76900	Брюки	https://balenciaga.dam.kering.com/m/33a310dad0220be1/Large-641670TLM011000_F.jpg	{https://balenciaga.dam.kering.com/m/5c9e13e22ba7ff47/Large-641670TLM011000_D.jpg,https://balenciaga.dam.kering.com/m/74ce54efdfe6a4d9/Large-641670TLM011000_B.jpg}	{S,M,L,XL}	Спортивные брюки Balenciaga с логотипом и эластичным поясом, выполненные в минималистичном дизайне.	Balenciaga	Streetwear	men	t	0	44	t	https://www.balenciaga.com/en-us/logo-tracksuit-pants-black-641670TLM011000.html	{black}	pants	balenciaga	streetwear
15	Off-White Arrow Logo Hoodie	39900	Худи	https://cdn-images.farfetch-contents.com/18/28/99/00/18289900_39116394_1000.jpg	{https://cdn-images.farfetch-contents.com/18/28/99/00/18289900_39116395_1000.jpg,https://cdn-images.farfetch-contents.com/18/28/99/00/18289900_39116396_1000.jpg}	{S,M,L,XL}	Худи Off-White с характерным принтом стрел на спине из мягкого хлопкового флиса.	Off-White	Streetwear	unisex	f	15	47	t	https://www.off---white.com/en-us/shopping/off-white-arrows-logo-hoodie-18289900	{black,white}	hoodies	off-white	streetwear
16	Ralph Lauren Cashmere Sweater	32990	Свитеры	https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dwa9dac1e1/products/526817/526817_020E_FH.jpg	{https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dw7e4a9a8e/products/526817/526817_020E_B1H.jpg,https://www.ralphlauren.com/dw/image/v2/BFQN_PRD/on/demandware.static/-/Sites-polo-master-catalog/default/dwd1c0b85a/products/526817/526817_020E_M1.jpg}	{S,M,L,XL}	Роскошный мужской свитер Ralph Lauren из 100% кашемира с классическим силуэтом и отделкой в тон.	Ralph Lauren	Old Money	men	f	0	48	t	https://www.ralphlauren.com/men-clothing-sweaters/cashmere-crewneck-sweater/526817.html	{grey,navy,black}	sweaters	ralph-lauren	old-money
17	Louis Vuitton Dauphine MM Bag	249900	Сумки	https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-dauphine-mm-monogram-handbags--M44391_PM2_Front%20view.jpg	{https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-dauphine-mm-monogram-handbags--M44391_PM1_Interior%20view.jpg,https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-dauphine-mm-monogram-handbags--M44391_PM1_Interior%20details.jpg}	{"one size"}	Элегантная сумка Louis Vuitton Dauphine MM с фирменным монограммным узором и кожаной отделкой.	Louis Vuitton	Old Money	women	t	0	47	t	https://eu.louisvuitton.com/eng-e1/products/dauphine-mm-monogram-nvprod1280195v	{brown}	bags	louis-vuitton	old-money
18	Celine Classic Blazer	179900	Пиджаки	https://www.celine.com/dw/image/v2/BBST_PRD/on/demandware.static/-/Sites-masterCatalog/default/dw2ba89d14/images/large/2X327916N.38NO_1_MAIN_ZP.jpg	{https://www.celine.com/dw/image/v2/BBST_PRD/on/demandware.static/-/Sites-masterCatalog/default/dwe6b2bcb2/images/large/2X327916N.38NO_2_WORN_ZP.jpg,https://www.celine.com/dw/image/v2/BBST_PRD/on/demandware.static/-/Sites-masterCatalog/default/dw34df0bb5/images/large/2X327916N.38NO_3_WORN_ZP.jpg}	{34,36,38,40,42}	Изысканный женский блейзер Celine из шерсти с элегантным силуэтом и минималистичным дизайном.	Celine	Old Money	women	f	0	45	t	https://www.celine.com/en-int/celine-shop-women/ready-to-wear/jackets-and-coats/flannel-blazer-in-wool-2X327916N.38NO.html	{black,navy}	jackets	celine	old-money
19	Levi's 501 Original Jeans	10990	Джинсы	https://lsco.scene7.com/is/image/lsco/levis/clothing/005010114-front-pdp.jpg	{https://lsco.scene7.com/is/image/lsco/levis/clothing/005010114-back-pdp.jpg,https://lsco.scene7.com/is/image/lsco/levis/clothing/005010114-detail-pdp.jpg}	{28,30,32,34,36}	Классические джинсы Levi's 501 с прямым кроем, фирменными заклепками и знаменитым патчем сзади.	Levi's	Vintage	men	f	0	49	t	https://www.levi.com/US/en_US/clothing/men/jeans/501-original-fit-mens-jeans/p/005010114	{blue,black}	jeans	levis	vintage
20	Champion Reverse Weave Hoodie	8990	Худи	https://cdn.shopify.com/s/files/1/0017/4223/9527/products/s1051-oxfordgrey-champion-reverseweave-hoodie-front_720x.jpg	{https://cdn.shopify.com/s/files/1/0017/4223/9527/products/s1051-oxfordgrey-champion-reverseweave-hoodie-back_720x.jpg,https://cdn.shopify.com/s/files/1/0017/4223/9527/products/s1051-oxfordgrey-champion-reverseweave-hoodie-detail_720x.jpg}	{S,M,L,XL}	Винтажная толстовка Champion Reverse Weave с капюшоном, выполненная по фирменной технологии.	Champion	Vintage	unisex	f	0	46	t	https://www.champion.com/reverse-weave-hoodie.html	{grey,navy,black}	hoodies	champion	vintage
21	New Balance 574 Sneakers	11990	Кроссовки	https://nb.scene7.com/is/image/NB/ml574evn_nb_02_i?$dw_detail_main_lg$	{https://nb.scene7.com/is/image/NB/ml574evn_nb_05_i?$dw_detail_main_lg$,https://nb.scene7.com/is/image/NB/ml574evn_nb_03_i?$dw_detail_main_lg$}	{40,41,42,43,44,45}	Культовые кроссовки New Balance 574 с винтажным дизайном и комфортной амортизацией ENCAP.	New Balance	Vintage	unisex	f	10	47	t	https://www.newbalance.com/pd/574-core/ML574-EGN.html	{navy,grey,black}	sneakers	new-balance	vintage
22	Supreme Box Logo Hoodie	49990	Худи	https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/071/322/954/original/973332_01.jpg.jpeg	{https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/071/322/953/original/973332_02.jpg.jpeg,https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/071/322/972/original/973332_03.jpg.jpeg}	{S,M,L,XL}	Культовая толстовка Supreme с вышитым Box Logo на груди из премиального хлопка.	Supreme	Streetwear	unisex	t	0	48	t	https://www.supremenewyork.com/	{red,black,grey}	hoodies	supreme	streetwear
23	Fear of God Essentials Sweatpants	19990	Брюки	https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-SWEATPANTS-MOSS_720x.jpg	{https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-SWEATPANTS-MOSS-2_720x.jpg,https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-SWEATPANTS-MOSS-3_720x.jpg}	{S,M,L,XL}	Минималистичные спортивные брюки Fear of God Essentials из мягкого хлопкового флиса с брендированной отделкой.	Fear of God	Streetwear	unisex	f	0	45	t	https://fearofgod.com/collections/essentials/products/essentials-sweatpants-moss	{green,black,grey}	pants	fear-of-god	streetwear
24	Fear of God Essentials Hoodie	19990	Худи	https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-HOODIE-MOSS_720x.jpg	{https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-HOODIE-MOSS-2_720x.jpg,https://cdn.shopify.com/s/files/1/0051/7042/products/ESSENTIALS-SS24-CORE-HOODIE-MOSS-3_720x.jpg}	{S,M,L,XL}	Фирменная толстовка Fear of God Essentials с объемным силуэтом и минималистичным дизайном.	Fear of God	Streetwear	unisex	f	0	47	t	https://fearofgod.com/collections/essentials/products/essentials-hoodie-moss	{green,black,grey}	hoodies	fear-of-god	streetwear
25	Nike Dri-FIT Run Division Jacket	12990	Куртки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/a3e7dead-1ad2-4c40-909d-ba3d2c6e1138/dri-fit-run-division-running-jacket-h4Kn0Q.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/4b78c6ca-ee3c-4fc0-9983-e0c307e0527a/dri-fit-run-division-running-jacket-h4Kn0Q.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e4e0e9e8-4617-48e1-aa07-e5cff4b28c49/dri-fit-run-division-running-jacket-h4Kn0Q.png"}	{S,M,L,XL}	Легкая ветрозащитная куртка Nike Dri-FIT для бега с технологией отвода влаги.	Nike	Sport	men	t	0	45	t	https://www.nike.com/t/dri-fit-run-division-running-jacket-h4Kn0Q/DD4888-438	{blue,black}	jackets	nike	sport
26	Adidas Techfit Compression Shirt	4990	Футболки	https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/1d83836f0346412b9fe8aad701105c29_9366/Techfit_Compression_Tee_Black_GL8923_01_laydown.jpg	{"https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fe96077401e94d36ae5eaad701106f56_9366/Techfit_Compression_Tee_Black_GL8923_02_laydown_hover.jpg","https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/2b6cf30f4c0f4df5aa8baad701107bce_9366/Techfit_Compression_Tee_Black_GL8923_41_detail.jpg"}	{S,M,L,XL}	Компрессионная футболка Adidas Techfit для спортивных тренировок с технологией поддержки мышц.	Adidas	Sport	men	f	0	46	t	https://www.adidas.com/us/techfit-compression-tee/GL8923.html	{black,white}	tshirts	adidas	sport
27	Nike Pro Dri-FIT Leggings	5990	Брюки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/c8b6d857-0a9b-4c54-9404-399a4dd0d7f4/pro-dri-fit-womens-mid-rise-7-8-leggings-8c82Xl.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e176b5a3-4d8a-4cee-9254-7e3d92a67a91/pro-dri-fit-womens-mid-rise-7-8-leggings-8c82Xl.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/8b8ed0c0-ca9c-439d-8b37-aac7ac11e4f2/pro-dri-fit-womens-mid-rise-7-8-leggings-8c82Xl.png"}	{XS,S,M,L,XL}	Женские леггинсы Nike Pro Dri-FIT для тренировок высокой интенсивности с технологией отвода влаги.	Nike	Sport	women	f	10	47	t	https://www.nike.com/t/pro-dri-fit-womens-mid-rise-7-8-leggings-8c82Xl/CZ9779-010	{black,grey}	pants	nike	sport
28	H&M Cotton T-shirt	1990	Футболки	https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fd1%2F28%2Fd1284694e4367bc80d6b13de616aab76d0d0fc45.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bmen_tshirtstanks_shortsleeve%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url[file:/product/main]	{https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F5c%2F2c%2F5c2c896a2c0a9b9a7b4fc2b9a1a67e16dfb83232.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bmen_tshirtstanks_shortsleeve%5D%2Ctype%5BLOOKBOOK%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]}	{S,M,L,XL,XXL}	Базовая футболка H&M из хлопка с круглым вырезом для повседневной носки.	H&M	Casual	men	f	0	42	t	https://www2.hm.com/en_us/productpage.0318395029.html	{white,black,grey,navy}	tshirts	h-and-m	casual
29	Uniqlo Ultra Light Down Jacket	8990	Куртки	https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/439814/item/goods_69_439814.jpg	{https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/439814/sub/goods_439814_sub9.jpg,https://image.uniqlo.com/UQ/ST3/WesternCommon/imagesgoods/439814/sub/goods_439814_sub18.jpg}	{S,M,L,XL}	Ультралегкая пуховая куртка Uniqlo с технологией компактного хранения, идеальная для прохладной погоды.	Uniqlo	Casual	unisex	f	0	46	t	https://www.uniqlo.com/us/en/products/E439814-000/00	{black,navy,grey,green}	jackets	uniqlo	casual
30	Zara Slim Fit Jeans	4990	Джинсы	https://static.zara.net/photos///2022/I/0/2/p/6688/340/406/2/w/750/6688340406_1_1_1.jpg	{https://static.zara.net/photos///2022/I/0/2/p/6688/340/406/2/w/750/6688340406_2_1_1.jpg,https://static.zara.net/photos///2022/I/0/2/p/6688/340/406/2/w/750/6688340406_6_1_1.jpg}	{28,30,32,34,36}	Мужские джинсы Zara с зауженным кроем и средней посадкой из эластичного денима для комфорта.	Zara	Casual	men	f	0	44	t	https://www.zara.com/us/en/slim-fit-jeans-p06688340.html	{blue,black}	jeans	zara	casual
31	Prada Re-Nylon Gabardine Dress	229900	Платья	https://www.prada.com/content/dam/pradanux_products/P/P3D/P3D59H/1XX2F0002/P3D59H_1XX2_F0002_S_221_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.2000.2000.jpg	{https://www.prada.com/content/dam/pradanux_products/P/P3D/P3D59H/1XX2F0002/P3D59H_1XX2_F0002_S_221_MDF.png/jcr:content/renditions/cq5dam.web.hebebed.2000.2000.jpg,https://www.prada.com/content/dam/pradanux_products/P/P3D/P3D59H/1XX2F0002/P3D59H_1XX2_F0002_S_221_ABF.png/jcr:content/renditions/cq5dam.web.hebebed.2000.2000.jpg}	{36,38,40,42,44}	Элегантное женское платье Prada из инновационного материала Re-Nylon с минималистичным дизайном.	Prada	Old Money	women	t	0	46	t	https://www.prada.com/us/en/women/ready_to_wear/dresses/products.re_nylon_gabardine_dress.P3D59H_1XX2_F0002_S_221.html	{black}	dresses	prada	old-money
32	Miu Miu Crystal Embellished Pumps	109900	Обувь	https://www.miumiu.com/content/dam/miumiu_products/M/M06/M06I47/KTZF0002/M06I47_KTZ_F0002_F_B050_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg	{https://www.miumiu.com/content/dam/miumiu_products/M/M06/M06I47/KTZF0002/M06I47_KTZ_F0002_F_B050_MDR.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg,https://www.miumiu.com/content/dam/miumiu_products/M/M06/M06I47/KTZF0002/M06I47_KTZ_F0002_F_B050_ABR.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg}	{35,36,37,38,39,40}	Роскошные туфли-лодочки Miu Miu с кристаллами на каблуке из мягкой замши.	Miu Miu	Old Money	women	f	0	45	t	https://www.miumiu.com/us/en/shoes/pumps/products.crystal_embellished_suede_pumps.5I246D_KTZ_F0002_F_B050.html	{black}	shoes	miu-miu	old-money
33	Palm Angels Track Jacket	59900	Куртки	https://cdn-images.farfetch-contents.com/18/04/33/35/18043335_44626101_1000.jpg	{https://cdn-images.farfetch-contents.com/18/04/33/35/18043335_44626104_1000.jpg,https://cdn-images.farfetch-contents.com/18/04/33/35/18043335_44626105_1000.jpg}	{S,M,L,XL}	Спортивная куртка Palm Angels с контрастными полосами и логотипом на груди.	Palm Angels	Streetwear	unisex	t	0	44	t	https://www.palmangels.com/en-us/shopping/classic-track-jacket-18043335	{black,white}	jackets	palm-angels	streetwear
34	Chrome Hearts Forever Ring	69900	Аксессуары	https://i.imgur.com/Jt6zuTc.jpg	{https://i.imgur.com/5F9yiUO.jpg,https://i.imgur.com/rQJXnm0.jpg}	{7,8,9,10,11}	Серебряное кольцо Chrome Hearts Forever с выгравированным логотипом и характерным готическим дизайном.	Chrome Hearts	Streetwear	unisex	f	0	46	t	https://www.chromehearts.com/	{silver}	accessories	chrome-hearts	streetwear
35	Louis Vuitton Monogram Scarf	59900	Аксессуары	https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-monogram-gradient-shawl-scarves-and-more--M75864_PM2_Front%20view.jpg	{https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-monogram-gradient-shawl-scarves-and-more--M75864_PM1_Ambiance%20view.jpg,https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-monogram-gradient-shawl-scarves-and-more--M75864_PM1_Interior%20view.jpg}	{"one size"}	Роскошный кашемировый шарф Louis Vuitton с фирменным монограммным узором и мягким градиентным переходом цвета.	Louis Vuitton	Old Money	unisex	f	0	47	t	https://eu.louisvuitton.com/eng-e1/products/monogram-gradient-shawl-nvprod3360027v/M75864	{blue,pink,brown}	accessories	louis-vuitton	old-money
36	Rick Owens Oversized Sunglasses	39900	Очки	https://i.imgur.com/sQTk0pX.jpg	{https://i.imgur.com/7bXdjA7.jpg,https://i.imgur.com/fqMTGYA.jpg}	{"one size"}	Авангардные солнцезащитные очки Rick Owens с массивной оправой и темными линзами, дополняющие уникальную эстетику бренда.	Rick Owens	Streetwear	unisex	t	0	43	t	https://www.rickowens.eu/	{black}	glasses	rick-owens	streetwear
37	Nike x Off-White Air Jordan 1	249900	Кроссовки	https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/008/487/310/original/136666_01.jpg.jpeg	{https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/008/487/315/original/136666_06.jpg.jpeg,https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/008/487/312/original/136666_03.jpg.jpeg}	{40,41,42,43,44,45}	Коллаборационные кроссовки Nike и Off-White, созданные Вирджилом Абло с деконструктивным дизайном и фирменными деталями.	Off-White	Streetwear	unisex	f	0	49	t	https://www.nike.com/launch/t/air-jordan-1-off-white-chicago	{red,white}	sneakers	off-white	streetwear
38	Dior x Air Jordan 1 High	399900	Кроссовки	https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/035/062/978/original/488879_01.jpg.jpeg	{https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/035/062/982/original/488879_04.jpg.jpeg,https://image.goat.com/transform/v1/attachments/product_template_additional_pictures/images/035/062/987/original/488879_06.jpg.jpeg}	{40,41,42,43,44,45}	Эксклюзивная коллаборация Dior и Air Jordan с премиальными материалами и фирменным узором Dior Oblique на панелях Swoosh.	Jordan	Streetwear	men	f	0	50	t	https://www.dior.com/en_us/fashion/products/3SH118YJP_H000-air-jordan-1-og-dior-high-top-sneaker-gray-and-white-dior-oblique-technical-textile	{grey,white}	sneakers	jordan	streetwear
39	Louis Vuitton x Supreme Hoodie	299900	Худи	https://i.imgur.com/3F0DHq9.jpg	{https://i.imgur.com/tJMQd7c.jpg,https://i.imgur.com/Zw9HUqQ.jpg}	{S,M,L,XL}	Эксклюзивная толстовка из коллаборации Louis Vuitton и Supreme с вышитыми логотипами обоих брендов.	Louis Vuitton	Streetwear	unisex	f	0	48	t	https://eu.louisvuitton.com/eng-e1/products/supreme-hoodie-nvprod1630170v	{red,white}	hoodies	louis-vuitton	streetwear
40	Maison Margiela Tabi Boots	119900	Обувь	https://www.maisonmargiela.com/assets/2020-01/MaisonMargiela_ICONS_TABI_BOOTS_PACKSHOT.jpg	{https://cdn-images.farfetch-contents.com/12/13/32/19/12133219_10215968_1000.jpg,https://cdn-images.farfetch-contents.com/12/13/32/19/12133219_10215973_1000.jpg}	{36,37,38,39,40,41}	Культовые ботинки Tabi от Maison Margiela с характерным раздвоенным мыском, вдохновленные традиционной японской обувью.	Maison Margiela	Streetwear	women	f	0	46	t	https://www.maisonmargiela.com/en-us/tabi-boots-in-calfskin-S58WU0260P3753T8013.html	{black,white}	shoes	maison-margiela	streetwear
41	Bape Shark Full Zip Hoodie	49900	Худи	https://us.bape.com/cdn/shop/files/1I30-115-014-BLK-A.jpg	{https://us.bape.com/cdn/shop/files/1I30-115-014-BLK-B.jpg,https://us.bape.com/cdn/shop/files/1I30-115-014-BLK-C.jpg}	{S,M,L,XL}	Знаковая толстовка Bape с капюшоном в форме акульей морды с зубами на молнии.	Bape	Streetwear	unisex	f	0	47	t	https://us.bape.com/products/1i30-115-014	{black,camo,grey}	hoodies	bape	streetwear
42	A-COLD-WALL* Logo T-shirt	25990	Футболки	https://cdn-images.farfetch-contents.com/19/04/89/09/19048909_41730166_1000.jpg	{https://cdn-images.farfetch-contents.com/19/04/89/09/19048909_41731402_1000.jpg,https://cdn-images.farfetch-contents.com/19/04/89/09/19048909_41730168_1000.jpg}	{S,M,L,XL}	Футболка A-COLD-WALL* с минималистичным дизайном и фирменным логотипом.	A-COLD-WALL	Streetwear	men	t	0	44	t	https://www.a-cold-wall.com/collections/t-shirts/products/bracket-logo-t-shirt-slate	{grey,black,white}	tshirts	a-cold-wall	streetwear
43	Prada Re-Nylon Gabardine Mini Skirt	139900	Юбки	https://www.prada.com/content/dam/pradanux_products/2/21U/21U919/1WQ8F0002/21U919_1WQ8_F0002_S_212_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg	{https://www.prada.com/content/dam/pradanux_products/2/21U/21U919/1WQ8F0002/21U919_1WQ8_F0002_S_212_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg,https://www.prada.com/content/dam/pradanux_products/2/21U/21U919/1WQ8F0002/21U919_1WQ8_F0002_S_212_SLB.png/jcr:content/renditions/cq5dam.web.hebebed.800.1000.jpg}	{36,38,40,42,44}	Стильная мини-юбка Prada из экологичного материала Re-Nylon с узнаваемым треугольным логотипом.	Prada	Old Money	women	t	0	45	t	https://www.prada.com/us/en/women/ready_to_wear/skirts/products.re_nylon_gabardine_mini_skirt.21U919_1WQ8_F0002_S_212.html	{black}	skirts	prada	old-money
44	Represent Owners Club Hoodie	28990	Худи	https://cdn.shopify.com/s/files/1/0970/9262/products/owners_club_hoodie_-_washed_black_front_1000x.jpg	{https://cdn.shopify.com/s/files/1/0970/9262/products/owners_club_hoodie_-_washed_black_back_1000x.jpg,https://cdn.shopify.com/s/files/1/0970/9262/products/owners_club_hoodie_-_washed_black_detail_1000x.jpg}	{S,M,L,XL}	Премиальная толстовка Represent Owners Club с капюшоном из мягкого хлопкового флиса с фирменным логотипом.	Represent	Streetwear	men	f	0	44	t	https://representclo.com/collections/hoodies-crewnecks/products/owners-club-hoodie-washed-black	{black}	hoodies	represent	streetwear
45	Amiri Skel-Top Sneakers	69900	Кроссовки	https://cdn-images.farfetch-contents.com/17/35/32/56/17353256_37945444_1000.jpg	{https://cdn-images.farfetch-contents.com/17/35/32/56/17353256_37945446_1000.jpg,https://cdn-images.farfetch-contents.com/17/35/32/56/17353256_37945445_1000.jpg}	{40,41,42,43,44,45}	Высокие кроссовки Amiri Skel-Top с фирменным скелетным мотивом и премиальной кожаной отделкой.	Amiri	Streetwear	men	t	0	45	t	https://www.amiri.com/collections/footwear/products/skel-top-high-bianco	{white,black}	sneakers	amiri	streetwear
46	Ader Error Oversized Logo T-shirt	19900	Футболки	https://cdn-images.farfetch-contents.com/15/69/12/58/15691258_34328391_1000.jpg	{https://cdn-images.farfetch-contents.com/15/69/12/58/15691258_34328392_1000.jpg,https://cdn-images.farfetch-contents.com/15/69/12/58/15691258_34328393_1000.jpg}	{S,M,L,XL}	Объемная футболка Ader Error с ярким графическим логотипом и характерным для бренда необработанным краем.	Ader Error	Streetwear	unisex	f	10	43	t	https://www.adererror.com/collections/t-shirts/products/oversized-logo-t-shirt-blue	{blue,white}	tshirts	ader-error	streetwear
47	Diesel 1DR Mini Bag	19900	Сумки	https://cdn-images.farfetch-contents.com/18/09/56/82/18095682_41066542_1000.jpg	{https://cdn-images.farfetch-contents.com/18/09/56/82/18095682_41066543_1000.jpg,https://cdn-images.farfetch-contents.com/18/09/56/82/18095682_41066545_1000.jpg}	{"one size"}	Компактная сумка Diesel 1DR с фирменным логотипом и регулируемым ремнем для ношения через плечо.	Diesel	Casual	women	t	0	44	t	https://www.diesel.com/en/bags/shoulder-bags/1dr-mini-crossbody-bag/00SBXH0BAXM.html	{black,red,white}	bags	diesel	casual
48	Drew House Mascot Hoodie	29900	Худи	https://i.imgur.com/DNMgQsw.jpg	{https://i.imgur.com/jGRVKQP.jpg,https://i.imgur.com/LlHtzX7.jpg}	{S,M,L,XL}	Свободная толстовка Drew House с фирменным смайликом-маскотом и характерным для бренда свободным кроем.	Drew House	Streetwear	unisex	f	0	45	t	https://www.drewhouse.com/	{yellow,black}	hoodies	drew-house	streetwear
49	Essentials Knit Sweater	17990	Свитеры	https://i.imgur.com/vZjZr5Y.jpg	{https://i.imgur.com/0qHcvZJ.jpg,https://i.imgur.com/JjxU4Kn.jpg}	{S,M,L,XL}	Минималистичный свитер Essentials из высококачественной вязаной ткани с фирменным тегом на рукаве.	Essentials	Casual	unisex	f	0	46	t	https://fearofgod.com/collections/essentials/products/essentials-knit-sweater-dark-oatmeal	{beige,black,grey}	sweaters	essentials	casual
50	GRAB Logo Hoodie	11990	Худи	https://i.imgur.com/NMjgRIu.jpg	{https://i.imgur.com/4QwJd8z.jpg,https://i.imgur.com/eQ2NzIj.jpg}	{S,M,L,XL}	Минималистичная толстовка GRAB с объемным капюшоном и контрастным логотипом на груди.	GRAB	Casual	unisex	t	0	43	t	https://grab-club.ru/	{black,white,grey}	hoodies	grab	casual
51	Rick Owens DRKSHDW Cargo Pants	79900	Брюки	https://cdn-images.farfetch-contents.com/18/78/87/09/18788709_41043234_1000.jpg	{https://cdn-images.farfetch-contents.com/18/78/87/09/18788709_41043236_1000.jpg,https://cdn-images.farfetch-contents.com/18/78/87/09/18788709_41043238_1000.jpg}	{28,30,32,34,36}	Авангардные брюки-карго Rick Owens DRKSHDW с объемными карманами и характерным для дизайнера нестандартным кроем.	Rick Owens	Streetwear	men	f	0	44	t	https://www.rickowens.eu/en/US/men/products/du02a3378-09-09-15-34	{black}	pants	rick-owens	streetwear
52	Yeezy GAP Hoodie	24990	Худи	https://i.imgur.com/g8p7Uzm.jpg	{https://i.imgur.com/Jb4UGx4.jpg,https://i.imgur.com/sGuwcMF.jpg}	{S,M,L,XL}	Объемная толстовка Yeezy GAP с минималистичным дизайном и характерным для коллаборации современным кроем.	Yeezy	Streetwear	unisex	f	0	46	t	https://www.yeezygap.com/	{blue,black,brown}	hoodies	yeezy	streetwear
53	Stone Island Shadow Project Jacket	89900	Куртки	https://cdn-images.farfetch-contents.com/18/19/80/92/18198092_38752364_1000.jpg	{https://cdn-images.farfetch-contents.com/18/19/80/92/18198092_38752365_1000.jpg,https://cdn-images.farfetch-contents.com/18/19/80/92/18198092_38752366_1000.jpg}	{S,M,L,XL}	Технологичная куртка Stone Island Shadow Project с инновационными материалами и современным урбанистическим дизайном.	Stone Island	Streetwear	men	t	0	45	t	https://www.stoneisland.com/en-us/shadow-project	{black,navy}	jackets	stone-island	streetwear
54	Reebok Club C 85 Vintage	8990	Кроссовки	https://assets.reebok.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy,c_fill,g_auto/cd215eeef97b4858a6ddab45001c5e4e_9366/Club_C_85_Vintage_Shoes_White_V67899_01_standard.jpg	{"https://assets.reebok.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy,c_fill,g_auto/e28bbd9bd8d74e42a07dab45001c7215_9366/Club_C_85_Vintage_Shoes_White_V67899_02_standard.jpg","https://assets.reebok.com/images/h_840,f_auto,q_auto:sensitive,fl_lossy,c_fill,g_auto/44b44bed93df45a8bedbab45001c8b2c_9366/Club_C_85_Vintage_Shoes_White_V67899_03_standard.jpg"}	{40,41,42,43,44,45}	Классические кроссовки Reebok Club C 85 Vintage с винтажной отделкой и мягкой кожаной верхней частью.	Reebok	Vintage	unisex	f	10	45	t	https://www.reebok.com/us/club-c-85-vintage-shoes/V67899.html	{white,green}	sneakers	reebok	vintage
55	Off-White Industrial Belt	24900	Аксессуары	https://cdn-images.farfetch-contents.com/12/69/52/83/12695283_12250564_1000.jpg	{https://cdn-images.farfetch-contents.com/12/69/52/83/12695283_12250561_1000.jpg,https://cdn-images.farfetch-contents.com/12/69/52/83/12695283_12250563_1000.jpg}	{"one size"}	Знаковый ремень Off-White Industrial с характерным дизайном и принтом в индустриальном стиле.	Off-White	Streetwear	unisex	f	0	47	t	https://www.off---white.com/en-us/shopping/off-white-industrial-belt-12695283	{yellow,black}	accessories	off-white	streetwear
56	DSquared2 Cool Guy Jeans	31990	Джинсы	https://cdn-images.farfetch-contents.com/13/55/87/37/13558737_16161560_1000.jpg	{https://cdn-images.farfetch-contents.com/13/55/87/37/13558737_16161561_1000.jpg,https://cdn-images.farfetch-contents.com/13/55/87/37/13558737_16161562_1000.jpg}	{28,30,32,34,36}	Джинсы DSquared2 Cool Guy с зауженным кроем и характерными потертостями, придающими винтажный вид.	DSquared2	Casual	men	f	15	44	t	https://www.dsquared2.com/us/en/men/apparel/denim/cool-guy-jeans-blue-denim-S74LB0953S30342470.html	{blue}	jeans	dsquared2	casual
57	AMI Paris Logo Sweatshirt	19900	Свитеры	https://cdn-images.farfetch-contents.com/16/96/87/23/16968723_33781873_1000.jpg	{https://cdn-images.farfetch-contents.com/16/96/87/23/16968723_33781874_1000.jpg,https://cdn-images.farfetch-contents.com/16/96/87/23/16968723_33781872_1000.jpg}	{S,M,L,XL}	Свитшот AMI Paris с вышитым логотипом Ami de Coeur (сердце с буквой A) и свободным кроем.	AMI Paris	Casual	unisex	t	0	45	t	https://www.amiparis.com/us/shopping/ami-de-coeur-sweatshirt-16968723	{grey,black,navy}	sweaters	ami-paris	casual
58	NIGO x Human Made x Adidas T-shirt	7990	Футболки	https://i.imgur.com/N0H8Tnx.jpg	{https://i.imgur.com/7nHmOXa.jpg,https://i.imgur.com/UtO2C7L.jpg}	{S,M,L,XL}	Коллаборационная футболка NIGO x Human Made x Adidas с уникальным графическим принтом и высококачественным хлопком.	Adidas	Streetwear	unisex	t	0	44	t	https://www.adidas.com/us/nigo	{white,black}	tshirts	adidas	streetwear
59	Alexander McQueen Tread Slick Boots	89900	Обувь	https://cdn-images.farfetch-contents.com/16/41/89/48/16418948_31658993_1000.jpg	{https://cdn-images.farfetch-contents.com/16/41/89/48/16418948_31658994_1000.jpg,https://cdn-images.farfetch-contents.com/16/41/89/48/16418948_31658995_1000.jpg}	{40,41,42,43,44,45}	Массивные ботинки Alexander McQueen Tread Slick с прочной резиновой подошвой и фирменным дизайном.	Alexander McQueen	Streetwear	men	f	0	45	t	https://www.alexandermcqueen.com/en-us/boots/tread-slick-boot-635715WHZ801000.html	{black}	shoes	alexander-mcqueen	streetwear
60	Burberry Check Cashmere Scarf	39900	Аксессуары	https://assets.burberry.com/is/image/Burberryltd/9CFD1373-83B5-4CB6-BB38-E9D49DB3A081?$BBY_V2_ML_1x1$&wid=2500&hei=2500	{https://assets.burberry.com/is/image/Burberryltd/B1014DA2-A3EC-4909-B17D-FCE45A4CF00F?$BBY_V2_SL_1x1$&wid=1920&hei=1920,https://assets.burberry.com/is/image/Burberryltd/AC3A51E7-C20D-45E2-B3AE-C13DD2DA1C5D?$BBY_V2_SL_1x1$&wid=1920&hei=1920}	{"one size"}	Знаковый кашемировый шарф Burberry с классическим клетчатым узором и бахромой по краям.	Burberry	Old Money	unisex	f	0	47	t	https://us.burberry.com/the-classic-check-cashmere-scarf-p80060031	{beige,black,navy}	accessories	burberry	old-money
61	Dior B23 High-Top Sneakers	109900	Кроссовки	https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/w/H/1585221019_3SH118YJP_H963_E01_ZH.jpg	{https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/w/H/1585221019_3SH118YJP_H963_E02_ZH.jpg,https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_2/870x580/17f82f742ffe127f42dca9de82fb58b1/w/H/1585221019_3SH118YJP_H963_E03_ZH.jpg}	{40,41,42,43,44,45}	Высокие кроссовки Dior B23 с прозрачной верхней частью и фирменным узором Dior Oblique.	Dior	Streetwear	unisex	f	0	47	t	https://www.dior.com/en_int/products/couture-3SH118YJP_H963-b23-high-top-sneaker-dior-oblique	{beige,white}	sneakers	dior	streetwear
62	Versace Barocco Print Shirt	59900	Футболки	https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw8a21d234/original/90_A82662-A233429_A7008_10_BaroccoPrintSilkShirt-Shirts-versace-online-store_0_1.jpg	{https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw4f85543b/original/90_A82662-A233429_A7008_20_BaroccoPrintSilkShirt-Shirts-versace-online-store_0_2.jpg,https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw0ed0660d/original/90_A82662-A233429_A7008_30_BaroccoPrintSilkShirt-Shirts-versace-online-store_0_3.jpg}	{S,M,L,XL}	Роскошная шелковая рубашка Versace с фирменным барочным принтом и классическим воротником.	Versace	Old Money	men	t	0	45	t	https://www.versace.com/international/en/men/clothing/shirts/barocco-print-silk-shirt-a7008/A82662-A233429_A7008.html	{gold,black}	tshirts	versace	old-money
63	Fendi Baguette Bag	269900	Сумки	https://www.fendi.com/dam/fendi/8BR600/8BR600ABVLF19VQ/8BR600ABV4F19VQ-01.jpg/jcr:content/renditions/cq5dam.web.2560.2560.jpg	{https://www.fendi.com/dam/fendi/8BR600/8BR600ABVLF19VQ/8BR600ABV4F19VQ-02.jpg/jcr:content/renditions/cq5dam.web.2560.2560.jpg,https://www.fendi.com/dam/fendi/8BR600/8BR600ABVLF19VQ/8BR600ABV4F19VQ-03.jpg/jcr:content/renditions/cq5dam.web.2560.2560.jpg}	{"one size"}	Культовая сумка Fendi Baguette из мягкой кожи с характерной FF-застежкой и возможностью носить на плече или в руке.	Fendi	Old Money	women	f	0	48	t	https://www.fendi.com/us-en/woman/bags/baguette/baguette-medium-brown-leather-bag-8br600abvlf19vq	{brown,black}	bags	fendi	old-money
64	Saint Laurent Teddy Jacket	199900	Куртки	https://www.ysl.com/variants/images/1647597307089213/v1/2009402841/1/w2000.jpg	{https://www.ysl.com/variants/images/1647597307089213/v1/2009402843/1/w2000.jpg,https://www.ysl.com/variants/images/1647597307089213/v1/2009402847/1/w2000.jpg}	{46,48,50,52,54}	Культовая бомбер-куртка Saint Laurent Teddy из шерсти с контрастной кожаной отделкой и фирменными полосатыми манжетами.	Saint Laurent	Streetwear	men	f	0	47	t	https://www.ysl.com/en-us/jackets/teddy-jacket-in-wool-and-leather-685629Y1B091000.html	{black,navy}	jackets	saint-laurent	streetwear
65	Chanel Classic Flap Bag	799900	Сумки	https://i.imgur.com/86yRfK8.jpg	{https://i.imgur.com/QGaM0u0.jpg,https://i.imgur.com/AjIQe1Q.jpg}	{"one size"}	Легендарная стеганая сумка Chanel Classic Flap Bag с двойной CC-застежкой и цепной ручкой для ношения на плече.	Chanel	Old Money	women	f	0	49	t	https://www.chanel.com/us/fashion/p/A01112Y01864C3906/classic-handbag-lambskin-gold-tone-metal/	{black,beige}	bags	chanel	old-money
66	Moncler Puffer Jacket	139900	Куртки	https://cdn-images.farfetch-contents.com/16/93/17/04/16931704_33622902_1000.jpg	{https://cdn-images.farfetch-contents.com/16/93/17/04/16931704_33622903_1000.jpg,https://cdn-images.farfetch-contents.com/16/93/17/04/16931704_33622905_1000.jpg}	{S,M,L,XL}	Высокотехнологичная пуховая куртка Moncler с фирменным логотипом и водоотталкивающим покрытием для защиты от непогоды.	Moncler	Casual	men	t	0	46	t	https://www.moncler.com/en-us/men/outerwear/puffer-jackets/cluny-puffer-jacket-F20911A5360068950-778.html	{black,navy,red}	jackets	moncler	casual
67	Cartier Love Bracelet	699900	Аксессуары	https://www.cartier.com/variants/images/44733502307701932/img1/w400_tpadding11.jpg	{https://www.cartier.com/variants/images/44733502307701932/img2/w400.jpg,https://www.cartier.com/variants/images/44733502307701932/img3/w400.jpg}	{16,17,18,19}	Культовый браслет Cartier Love из 18-каратного золота с характерными винтовыми элементами, символизирующими вечную любовь.	Cartier	Old Money	unisex	f	0	48	t	https://www.cartier.com/en-us/jewelry/bracelets/love-bracelet-B6035517.html	{gold,white-gold}	accessories	cartier	old-money
68	Thom Browne 4-Bar Sweatshirt	69900	Свитеры	https://cdn-images.farfetch-contents.com/17/95/37/87/17953787_37967326_1000.jpg	{https://cdn-images.farfetch-contents.com/17/95/37/87/17953787_37967325_1000.jpg,https://cdn-images.farfetch-contents.com/17/95/37/87/17953787_37967324_1000.jpg}	{S,M,L,XL}	Хлопковый свитшот Thom Browne с фирменными 4 полосками на рукаве и минималистичным дизайном.	Thom Browne	Old Money	men	f	0	45	t	https://www.thombrowne.com/us/shopping/4-bar-loopback-sweatshirt-17953787	{grey,navy}	sweaters	thom-browne	old-money
69	Hermes Kelly Bag	1299900	Сумки	https://i.imgur.com/uLUDhcH.jpg	{https://i.imgur.com/K6O7Zl9.jpg,https://i.imgur.com/82qXcnZ.jpg}	{"one size"}	Легендарная сумка Hermes Kelly из высококачественной кожи с характерной застежкой-замком, названная в честь Грейс Келли.	Hermes	Old Money	women	f	0	50	t	https://www.hermes.com/us/en/category/women/bags-and-small-leather-goods/bags-and-clutches/#|	{black,tan,red}	bags	hermes	old-money
70	Bottega Veneta Cassette Bag	259900	Сумки	https://www.bottegaveneta.com/variants/images/15046495636478068/A/h135.jpg	{https://www.bottegaveneta.com/variants/images/15046495636478068/A/e01.jpg,https://www.bottegaveneta.com/variants/images/15046495636478068/A/e02.jpg}	{"one size"}	Знаковая сумка Bottega Veneta Cassette с фирменным плетеным узором Intrecciato и современным дизайном.	Bottega Veneta	Old Money	women	t	0	46	t	https://www.bottegaveneta.com/en-us/cassette-black-809963582.html	{black,green,brown}	bags	bottega-veneta	old-money
71	Canada Goose Expedition Parka	129900	Куртки	https://i.imgur.com/q6xEldF.jpg	{https://i.imgur.com/xdgSlQm.jpg,https://i.imgur.com/l7JsRwP.jpg}	{S,M,L,XL,XXL}	Ультратеплая пуховая парка Canada Goose Expedition, разработанная для экстремально холодных условий с защитой от ветра и влаги.	Canada Goose	Casual	unisex	f	0	47	t	https://www.canadagoose.com/us/en/expedition-parka-4660M.html	{black,navy,red}	jackets	canada-goose	casual
72	Vivienne Westwood Pearl Choker	39900	Аксессуары	https://i.imgur.com/hPgDUdG.jpg	{https://i.imgur.com/lklDG1w.jpg,https://i.imgur.com/sTLzkF3.jpg}	{"one size"}	Культовое жемчужное колье-чокер Vivienne Westwood с фирменным логотипом-орбом из золотистого металла.	Vivienne Westwood	Vintage	women	f	0	45	t	https://www.viviennewestwood.com/en/jewellery/necklaces/mayfair-bas-relief-pendant-63020067W111W111.html	{gold,silver}	accessories	vivienne-westwood	vintage
73	Acne Studios Oversized Sweater	39900	Свитеры	https://www.acnestudios.com/dw/image/v2/AAXV_PRD/on/demandware.static/-/Sites-acne-product-catalog/default/dw2951f853/images/A60227-ABH/A60227-ABH_view_6.jpg	{https://www.acnestudios.com/dw/image/v2/AAXV_PRD/on/demandware.static/-/Sites-acne-product-catalog/default/dw095ebd46/images/A60227-ABH/A60227-ABH_view_1.jpg,https://www.acnestudios.com/dw/image/v2/AAXV_PRD/on/demandware.static/-/Sites-acne-product-catalog/default/dw4c6bf2a4/images/A60227-ABH/A60227-ABH_view_2.jpg}	{XS,S,M,L,XL}	Объемный шерстяной свитер Acne Studios с минималистичным дизайном и фирменной нашивкой-смайликом.	Acne Studios	Casual	unisex	t	0	46	t	https://www.acnestudios.com/us/en/oversized-sweater-black/A60227-ABH.html	{black,beige,orange}	sweaters	acne-studios	casual
74	Alexander McQueen Skull Scarf	29900	Аксессуары	https://i.imgur.com/lPjRDOT.jpg	{https://i.imgur.com/7mzeBOX.jpg,https://i.imgur.com/vjzZkRE.jpg}	{"one size"}	Знаковый шелковый шарф Alexander McQueen с фирменным принтом в виде черепов - культовый аксессуар бренда.	Alexander McQueen	Old Money	unisex	f	0	46	t	https://www.alexandermcqueen.com/en-us/scarves/classic-silk-skull-scarf-black-6108103001Q1078.html	{black,white,red}	accessories	alexander-mcqueen	old-money
75	Celine Triomphe Belt	69900	Аксессуары	https://i.imgur.com/nJjf1ck.jpg	{https://i.imgur.com/ZqmHaqK.jpg,https://i.imgur.com/2xAtDHU.jpg}	{70,75,80,85,90,95}	Элегантный кожаный ремень Celine с культовой пряжкой Triomphe - символом бренда, созданным на основе парижской архитектуры.	Celine	Old Money	unisex	f	0	47	t	https://www.celine.com/en-int/celine-shop-women/small-leather-goods/belts/triomphe-belt-in-shiny-calfskin-46108502A.38NO.70.html	{black,tan}	accessories	celine	old-money
76	JW Anderson Chain Loafers	89900	Обувь	https://i.imgur.com/7OU9bFC.jpg	{https://i.imgur.com/B5MDKkG.jpg,https://i.imgur.com/Wfvuyt3.jpg}	{36,37,38,39,40,41,42}	Знаковые лоферы JW Anderson с золотистой цепью - современная реинтерпретация классической обуви, создавшая настоящий тренд.	JW Anderson	Old Money	unisex	f	0	47	t	https://www.jwanderson.com/us/shopping/women/jw-anderson-women-s-chain-loafer-18029326	{black,brown}	shoes	jw-anderson	old-money
77	Jacquemus Le Chiquito Bag	59900	Сумки	https://i.imgur.com/jg6gvdk.jpg	{https://i.imgur.com/GFFMKyf.jpg,https://i.imgur.com/yyeVmRF.jpg}	{"one size"}	Культовая миниатюрная сумка Jacquemus Le Chiquito, превратившаяся из эксцентричного аксессуара в настоящий символ современной моды.	Jacquemus	Casual	women	t	0	46	t	https://www.jacquemus.com/product/le-chiquito-noeud-black	{black,white,pink}	bags	jacquemus	casual
78	Burberry Check Cashmere Scarf	49900	Аксессуары	https://assets.burberry.com/is/image/Burberryltd/DF32D0E8-9D51-49F1-81B9-905B14E763C8.jpg	{https://assets.burberry.com/is/image/Burberryltd/F0773A8D-FAB3-45FC-828E-84A14FB8BD74.jpg,https://assets.burberry.com/is/image/Burberryltd/33BA0B2F-B6AA-46F2-94FB-B4A94CFFD5AB.jpg}	{"one size"}	Культовый кашемировый шарф Burberry с классическим клетчатым принтом - символ британской элегантности и традиций.	Burberry	Old Money	unisex	f	0	48	t	https://us.burberry.com/the-classic-check-cashmere-scarf-p80153371	{beige,black}	accessories	burberry	old-money
79	Maison Margiela Tabi Boots	109900	Обувь	https://cdn-images.farfetch-contents.com/12/96/00/42/12960042_13261761_1000.jpg	{https://cdn-images.farfetch-contents.com/12/96/00/42/12960042_13261762_1000.jpg,https://cdn-images.farfetch-contents.com/12/96/00/42/12960042_13261765_1000.jpg}	{36,37,38,39,40,41,42}	Культовые ботинки Maison Margiela Tabi с характерным раздвоенным мыском, вдохновленные традиционной японской обувью.	Maison Margiela	Vintage	women	f	0	47	t	https://www.maisonmargiela.com/us/maison-margiela/tabi-boots_cod11696631rb.html	{black,white}	shoes	maison-margiela	vintage
80	Rick Owens DRKSHDW Hoodie	59900	Худи	https://i.imgur.com/q5KrGRX.jpg	{https://i.imgur.com/F0ZhGJa.jpg,https://i.imgur.com/u5sTBF4.jpg}	{XS,S,M,L,XL}	Авангардное худи Rick Owens DRKSHDW с характерным для бренда неординарным кроем и минималистичным дизайном.	Rick Owens	Streetwear	unisex	f	0	46	t	https://www.rickowens.eu/en/US/men/products/du02a3289-f-09	{black,dust}	hoodies	rick-owens	streetwear
81	Marine Serre Crescent Moon Top	29900	Футболки	https://i.imgur.com/uPxWDuS.jpg	{https://i.imgur.com/PqI8SFl.jpg,https://i.imgur.com/TGnqzrV.jpg}	{XS,S,M,L}	Культовый топ Marine Serre с узнаваемым принтом в виде полумесяца, ставшим символом бренда и ее футуристического видения.	Marine Serre	Streetwear	women	t	0	45	t	https://marineserre.com/collections/t-shirts/products/regenerated-t-shirt-with-all-over-moon	{black,red}	tshirts	marine-serre	streetwear
82	Ami de Coeur Sweatshirt	29900	Свитеры	https://i.imgur.com/aqcTRqu.jpg	{https://i.imgur.com/aOGmhD7.jpg,https://i.imgur.com/mC1nO4F.jpg}	{S,M,L,XL}	Стильный свитшот AMI Paris с вышитым логотипом Ami de Coeur (сердце), олицетворяющим дружелюбный и расслабленный парижский стиль.	AMI Paris	Casual	unisex	f	0	45	t	https://www.amiparis.com/us/shopping/ami-de-coeur-sweatshirt-18395325	{navy,black,grey}	sweaters	ami-paris	casual
83	Jil Sander Tailored Blazer	129900	Пиджаки	https://cdn-images.farfetch-contents.com/16/40/42/15/16404215_31685334_1000.jpg	{https://cdn-images.farfetch-contents.com/16/40/42/15/16404215_31685332_1000.jpg,https://cdn-images.farfetch-contents.com/16/40/42/15/16404215_31685333_1000.jpg}	{34,36,38,40,42,44}	Безупречно скроенный пиджак Jil Sander с характерным для бренда минималистичным дизайном и безупречным качеством.	Jil Sander	Old Money	women	f	0	46	t	https://www.jilsander.com/en-us/tailored-blazer/JSPS420023-WS201800-999.html	{black,navy}	blazers	jil-sander	old-money
84	Loewe Puzzle Bag	279900	Сумки	https://i.imgur.com/g2kzJC9.jpg	{https://i.imgur.com/mWJQ5iA.jpg,https://i.imgur.com/pWK5Qpm.jpg}	{"one size"}	Культовая сумка Loewe Puzzle с уникальной геометрической структурой, позволяющей складывать ее плоско - олицетворение инновационного дизайна и ремесленного мастерства.	Loewe	Old Money	women	f	0	47	t	https://www.loewe.com/usa/en/women/bags/puzzle/puzzle-small-bag-in-classic-calfskin/32212AC21-2530.html	{tan,black,blue}	bags	loewe	old-money
85	A-COLD-WALL* Utility Vest	49900	Куртки	https://i.imgur.com/lCPdQyu.jpg	{https://i.imgur.com/dE9Xc3r.jpg,https://i.imgur.com/J3WfqtL.jpg}	{S,M,L,XL}	Технологичный жилет A-COLD-WALL* с многочисленными карманами и утилитарными деталями, отражающий футуристический и индустриальный эстетика бренда.	A-COLD-WALL*	Streetwear	men	t	0	46	t	https://www.a-cold-wall.com/collections/vests/products/mission-statement-utility-vest-black	{black,grey}	jackets	a-cold-wall	streetwear
86	Coperni Swipe Bag	69900	Сумки	https://i.imgur.com/SZv2R8p.jpg	{https://i.imgur.com/0IEdM1t.jpg,https://i.imgur.com/SmnSpbU.jpg}	{"one size"}	Культовая сумка Coperni Swipe с характерной закругленной формой, вдохновленной иконкой разблокировки смартфона - символ современного дизайна и инноваций.	Coperni	Casual	women	t	0	46	t	https://coperniparis.com/en-us/products/swipe-bag-black	{black,white,silver}	bags	coperni	casual
87	Lemaire Croissant Bag	89900	Сумки	https://cdn-images.farfetch-contents.com/17/01/06/82/17010682_34128082_1000.jpg	{https://cdn-images.farfetch-contents.com/17/01/06/82/17010682_34128079_1000.jpg,https://cdn-images.farfetch-contents.com/17/01/06/82/17010682_34128081_1000.jpg}	{"one size"}	Элегантная сумка Lemaire Croissant с мягкой полукруглой формой и минималистичным дизайном, олицетворяющая французскую утонченность и функциональность.	Lemaire	Old Money	women	f	0	45	t	https://us.lemaire.fr/collections/woman-bags-small-leather-goods/products/croissant-bag-black-w213ac254ll083999	{black,tan,cream}	bags	lemaire	old-money
88	The Row Margaux Bag	399900	Сумки	https://i.imgur.com/tNFFWLC.jpg	{https://i.imgur.com/jkEa2qc.jpg,https://i.imgur.com/D9L8ZPO.jpg}	{"one size"}	Элегантная сумка The Row Margaux из высококачественной кожи с минималистичным дизайном и безупречным исполнением - образец тихой роскоши.	The Row	Old Money	women	f	0	48	t	https://www.therow.com/us/shop/bags/margaux-10-bag-leather-black_14026582	{black,tan,navy}	bags	the-row	old-money
89	Casablanca Silk Shirt	59900	Футболки	https://i.imgur.com/iCt1iJL.jpg	{https://i.imgur.com/fI6KiLu.jpg,https://i.imgur.com/oN9X2YK.jpg}	{S,M,L,XL}	Роскошная шелковая рубашка Casablanca с фирменным ярким принтом, передающая дух престижных курортов и средиземноморского отдыха.	Casablanca	Casual	men	t	0	46	t	https://casablancaparis.com/collections/shirts/products/casa-tennis-club-silk-shirt-white	{white,multicolor}	tshirts	casablanca	casual
90	Y/Project Layered Jeans	79900	Джинсы	https://i.imgur.com/HY1q9wS.jpg	{https://i.imgur.com/LUQbN3r.jpg,https://i.imgur.com/KAMQljK.jpg}	{28,30,32,34,36}	Авангардные джинсы Y/Project с многослойной конструкцией и деконструированным дизайном, бросающие вызов традиционным представлениям о классической одежде.	Y/Project	Streetwear	unisex	f	0	45	t	https://www.yproject.fr/en/Y-project/P-JEAN-CLASSIC-LAYERED-JEAN_WHITE	{blue,black}	jeans	y-project	streetwear
91	Raf Simons Archive Redux Sweater	89900	Свитеры	https://i.imgur.com/PK39MYb.jpg	{https://i.imgur.com/HNNI9ow.jpg,https://i.imgur.com/GqfK0dq.jpg}	{S,M,L,XL}	Культовый свитер из коллекции Archive Redux, переиздание знаковых работ Рафа Симонса, с характерными для дизайнера деконструктивными элементами и отсылками к молодежной культуре.	Raf Simons	Streetwear	men	f	0	47	t	https://www.rafsimons.com/shopping/men/archive-redux-oversized-sweater-18428644	{black,blue}	sweaters	raf-simons	streetwear
92	Junya Watanabe Comme des Garçons Patchwork Jacket	119900	Куртки	https://i.imgur.com/8qPLRdV.jpg	{https://i.imgur.com/qxF7V4r.jpg,https://i.imgur.com/8xJbwz0.jpg}	{S,M,L,XL}	Инновационная куртка Junya Watanabe с характерной лоскутной техникой, сочетающая различные ткани и текстуры в уникальной интерпретации классической верхней одежды.	Junya Watanabe	Vintage	men	t	0	46	t	https://shop.doverstreetmarket.com/collections/junya-watanabe-man	{blue,multicolor}	jackets	junya-watanabe	vintage
93	Nanushka Vegan Leather Shirt	39900	Футболки	https://i.imgur.com/7UyxrjB.jpg	{https://i.imgur.com/fMm93ZY.jpg,https://i.imgur.com/PrbIX4c.jpg}	{XS,S,M,L,XL}	Стильная рубашка Nanushka из веганской кожи с безупречной текстурой, сочетающая этичный подход к производству с современной эстетикой.	Nanushka	Casual	women	f	0	45	t	https://nanushka.com/collections/shirts/products/elpi-vegan-leather-shirt-black	{black,burgundy}	tshirts	nanushka	casual
94	Burberry Chelsea Heritage Trench Coat	189000	Куртки	https://assets.burberry.com/is/image/Burberryltd/F7D87D2F-5CCD-42F1-B85D-3E6E13A23825.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251	{https://assets.burberry.com/is/image/Burberryltd/3B4C25E6-D5DB-4702-9F11-6B4BB193F6BA.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251,https://assets.burberry.com/is/image/Burberryltd/BE0A9F7C-40C0-45A3-8C4F-2714DF23F1AF.jpg?$BBY_V2_SL_1x1$&wid=1251&hei=1251}	{36,38,40,42,44,46}	Классический тренч Burberry Chelsea из водонепроницаемого хлопкового габардина. Культовая модель бренда с фирменной клеткой на подкладке.	Burberry	Old Money	women	f	0	48	t	https://ru.burberry.com/the-waterloo-heritage-trench-coat-p80462971	{Honey,Black,Blue}	coats	burberry	old-money
95	Saint Laurent Classic Motorcycle Jacket	329000	Куртки	https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_front.jpg	{https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_back.jpg,https://media.ysl.com/product/l/e/leather-motorcycle-jacket-in-black_section_11_16455_detail_1.jpg}	{44,46,48,50,52}	Культовая кожаная косуха Saint Laurent из высококачественной телячьей кожи с классическими байкерскими деталями и легендарным силуэтом.	Saint Laurent	Streetwear	men	t	0	47	t	https://www.ysl.com/en-us/leather-motorcycle-jacket-in-black-225935Y5RD21000.html	{Black}	jackets	saint-laurent	streetwear
104	Prada Re-Nylon Backpack	139000	Сумки	https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg	{https://www.prada.com/content/dam/pradanux_products/1/1BZ/1BZ811/2DWIF0002/1BZ811_2DWI_F0002_V_OOO_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg}	{"One Size"}	Знаковый рюкзак Prada из переработанного нейлона Re-Nylon. Практичный, экологичный и стильный аксессуар с фирменным треугольным логотипом.	Prada	Casual	unisex	t	0	46	t	https://www.prada.com/us/en/men/bags/backpacks/products.re-nylon_backpack.1BZ811_2DWI_F0002_V_OOO.html	{Black,Navy}	bags	prada	casual
96	Chanel Iconic Tweed Jacket	399000	Пиджаки	https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-default-p82283k17710nf895-8840257896478.jpg	{"https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-p82283k17710nf895-8840261697566.jpg","https://www.chanel.com/images/t_one//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_1240/jacket-navy-blue-white-red-gold-cotton-tweed-gold-tone-metal-cotton-tweed-gold-tone-metal-packshot-alternative-a-p82283k17710nf895-8840260550686.jpg"}	{34,36,38,40,42,44}	Легендарный твидовый пиджак Chanel с фирменными деталями - золотыми пуговицами и отделкой. Символ элегантности и роскоши.	Chanel	Old Money	women	f	0	49	t	https://www.chanel.com/us/fashion/p/P82283K17710NF895/jacket-cotton-tweed-gold-tone-metal/	{"Navy Blue",Black,Beige}	jackets	chanel	old-money
97	Loewe Puzzle Bag Medium	285000	Сумки	https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-FRONT?fmt=webp&hei=1250	{https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_1?fmt=webp&hei=1250,https://cdn-images.loewe.com/is/image/loewe/A510P22X17-C9990-DETAIL_2?fmt=webp&hei=1250}	{Medium}	Культовая модель сумки Puzzle от Loewe из высококачественной кожи с фирменной геометрической конструкцией и трехмерной головоломкой-оригами.	Loewe	Old Money	women	f	0	47	t	https://www.loewe.com/int/en/women/bags/puzzle/puzzle-bag-in-classic-calfskin/A510P22X17-C9990.html	{Black,Tan,"Ocean Blue"}	bags	loewe	old-money
98	Bottega Veneta The Pouch	239000	Сумки	https://www.bottegaveneta.com/variants/images/17085864448325636/A/d.jpg	{https://www.bottegaveneta.com/variants/images/17085864448325636/A/h.jpg,https://www.bottegaveneta.com/variants/images/17085864448325636/A/e.jpg}	{"One Size"}	Культовый клатч The Pouch от Bottega Veneta из мягкой кожи наппа с характерным облачным эффектом. Минималистичная роскошь.	Bottega Veneta	Old Money	women	f	0	46	t	https://www.bottegaveneta.com/en-us/the-pouch-black-809639811.html	{Black,Fondant,Caramel}	bags	bottega-veneta	old-money
99	Amiri MX1 Distressed Jeans	65000	Джинсы	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_1/amiri-indigo-mx1-jeans.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_2/amiri-indigo-mx1-jeans.jpg","https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221886M186004_3/amiri-indigo-mx1-jeans.jpg"}	{28,30,32,34,36}	Культовые джинсы MX1 от Amiri с кожаными вставками и фирменными потертостями. Идеальное сочетание роскоши и панк-эстетики.	Amiri	Streetwear	men	f	0	45	t	https://www.amiriparis.com/us/shopping/mx1-jeans-17107222	{Blue,Black,Grey}	jeans	amiri	streetwear
100	Louis Vuitton Mini Pochette Accessoires	59000	Аксессуары	https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM2_Front%20view.jpg	{https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Interior%20view.jpg,https://eu.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-mini-pochette-accessoires-monogram-handbags--M58009_PM1_Closeup%20view.jpg}	{"One Size"}	Легендарная мини-сумочка Mini Pochette Accessoires от Louis Vuitton с фирменным монограммным принтом. Универсальный и культовый аксессуар.	Louis Vuitton	Old Money	women	f	0	48	t	https://eu.louisvuitton.com/eng-e1/products/mini-pochette-accessoires-monogram-001025	{Monogram}	accessories	louis-vuitton	old-money
101	BAPE Shark Full Zip Hoodie	38900	Худи	https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-01_1024x1024.jpg	{https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-02_1024x1024.jpg,https://us.bape.com/cdn/shop/products/1I30-115-001-WEB-03_1024x1024.jpg}	{S,M,L,XL,XXL}	Культовое худи с акулой от BAPE. Знаковый предмет стритвир-культуры с характерным камуфляжным принтом и капюшоном в форме головы акулы.	Bape	Streetwear	men	t	0	47	t	https://us.bape.com/products/1i30-115-001	{"Camo Green",Black,Grey}	hoodies	bape	streetwear
102	Chrome Hearts Cross Logo T-Shirt	28500	Футболки	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_1/chrome-hearts-black-cross-logo-t-shirt.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/202404M213008_2/chrome-hearts-black-cross-logo-t-shirt.jpg"}	{S,M,L,XL}	Классическая футболка Chrome Hearts с фирменным крестом - популярный предмет гардероба среди знаменитостей и любителей стритвир-культуры.	Chrome Hearts	Streetwear	unisex	f	0	45	t	https://www.chromehearts.com/	{Black,White}	t-shirts	chrome-hearts	streetwear
103	Hermès Carré Silk Scarf	49500	Аксессуары	https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-front-1-300-0-1000-1000_g.jpg	{https://assets.hermes.com/is/image/hermesproduct/wash-scarf-90--003227S%2001-worn-3-300-0-1000-1000_g.jpg}	{"90 x 90 cm"}	Легендарный шелковый платок Hermès с фирменным принтом. Ручная обработка краев, высочайшее качество шелка и изысканный дизайн.	Hermes	Old Money	women	f	0	48	t	https://www.hermes.com/us/en/product/wash-scarf-90-H003227Sv01/	{Multicolor}	accessories	hermes	old-money
105	Balenciaga Track Sneakers	96500	Кроссовки	https://balenciaga.dam.kering.com/m/76a612eeb5bcad5e/Medium-542023W1GB11000_F.jpg	{https://balenciaga.dam.kering.com/m/2ca91dfebb8c1127/Medium-542023W1GB11000_D.jpg,https://balenciaga.dam.kering.com/m/4b63f55c4d5891af/Medium-542023W1GB11000_E.jpg}	{39,40,41,42,43,44,45}	Инновационные кроссовки Balenciaga Track с многослойным дизайном и динамичным силуэтом. 96 элементов для создания технологичного и футуристического образа.	Balenciaga	Streetwear	unisex	t	0	46	t	https://www.balenciaga.com/en-us/track-black-542023W1GB11000.html	{Black,White,Yellow}	sneakers	balenciaga	streetwear
106	Fear of God Essentials Pullover Hoodie	18500	Худи	https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809517_1000.jpg	{https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809512_1000.jpg,https://cdn-images.farfetch-contents.com/16/47/22/72/16472272_31809518_1000.jpg}	{XS,S,M,L,XL}	Оверсайз-худи Fear of God Essentials из высококачественного хлопка с фирменным минималистичным дизайном и культовым логотипом на груди.	Fear of God	Streetwear	unisex	f	0	46	t	https://fearofgod.com/collections/essentials/products/essentials-pullover-hoodie-dark-oatmeal	{Oatmeal,Cement,Black}	hoodies	fear-of-god	streetwear
107	Stone Island Garment Dyed Sweatshirt	24500	Свитеры	https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814335_1000.jpg	{https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814339_1000.jpg,https://cdn-images.farfetch-contents.com/15/21/38/36/15213836_29814333_1000.jpg}	{S,M,L,XL,XXL}	Культовый свитшот Stone Island с фирменным съемным компасом на рукаве. Изготовлен с использованием особой техники окрашивания, создающей эффект выцветания.	Stone Island	Casual	men	f	15	46	t	https://www.stoneisland.com/us/stone-island/sweatshirt_cod43202490rv.html	{Olive,Black,Navy}	sweaters	stone-island	casual
108	Jordan 4 Retro Bred	56500	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-512bfb8c-b242-4d39-a04c-601275584dc4/air-jordan-4-retro-shoes-Rd2G3V.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-9c5f2e05-b1c3-4a01-8be5-e5e37b8bad48/air-jordan-4-retro-shoes-Rd2G3V.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/i1-7baec50c-f5eb-4532-b3de-6ebfcf98fb8f/air-jordan-4-retro-shoes-Rd2G3V.png"}	{7,8,9,10,11,12,13}	Культовые кроссовки Air Jordan 4 Retro Bred с легендарной расцветкой черно-красной цветовой гаммы Chicago Bulls. Первоначально выпущены в 1989 году, эта модель до сих пор остается одной из самых популярных в линейке Jordan.	Jordan	Streetwear	men	f	0	49	t	https://nike.com/air-jordan-4-retro-bred	{Black/Red}	sneakers	jordan	streetwear
109	Cartier Love Bracelet	689000	Аксессуары	https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw83b7ba3b/images/large/637709379129519552-2109373.png	{https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb5baab51/images/large/637709379133225744-2109374.png}	{16,17,18,19,20}	Легендарный браслет Love от Cartier из 18-каратного розового золота с фирменным дизайном винтовых элементов. Символ вечной любви и верности.	Cartier	Old Money	unisex	f	0	49	t	https://www.cartier.com/en-us/jewelry/bracelets/love-bracelet-B6035617.html	{"Rose Gold","Yellow Gold","White Gold"}	accessories	cartier	old-money
110	Fendi Baguette Medium	289000	Сумки	https://www.fendi.com/medias/sys_master/images/images/h50/h5d/8976184098846/8BR600A72VF19FW-01.jpg	{https://www.fendi.com/medias/sys_master/images/images/h3a/h17/8976188620830/8BR600A72VF19FW-02.jpg,https://www.fendi.com/medias/sys_master/images/images/h43/h03/8976189669406/8BR600A72VF19FW-03.jpg}	{Medium}	Культовая сумка Baguette от Fendi, ставшая иконой благодаря сериалу 'Секс в большом городе'. Знаковая модель с характерной формой и узнаваемой пряжкой FF.	Fendi	Vintage	women	f	0	47	t	https://www.fendi.com/en-us/baguette-medium-brown-leather-bag-8br600a72vf19fw	{Brown,Black,Red}	bags	fendi	vintage
111	Supreme Box Logo Tee	15500	Футболки	https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29138789_1000.jpg	{https://cdn-images.farfetch-contents.com/15/06/61/28/15066128_29139142_1000.jpg}	{S,M,L,XL}	Культовая футболка Supreme с фирменным прямоугольным логотипом (Box Logo). Одна из самых узнаваемых и желанных моделей в стритвир-культуре.	Supreme	Streetwear	unisex	f	0	48	t	https://www.supremenewyork.com/	{White,Black,Red}	t-shirts	supreme	streetwear
112	Jacquemus Le Chiquito Bag	68000	Сумки	https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309399_1000.jpg	{https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309398_1000.jpg,https://cdn-images.farfetch-contents.com/14/30/16/49/14301649_21309402_1000.jpg}	{"One Size"}	Миниатюрная сумка Le Chiquito от Jacquemus, ставшая вирусным аксессуаром и символом современной моды. Характерная микро-форма и минималистичный дизайн.	Jacquemus	Casual	women	t	0	46	t	https://www.jacquemus.com/product/le-chiquito-noeud-leather-tan	{Tan,Black,Red}	bags	jacquemus	casual
113	Miu Miu Pleated Mini Skirt	97000	Юбки	https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLF.jpg	{https://www.miumiu.com/content/dam/miumiu_products/M/M0/MO/MOB/MOB455/1X3FF0009/MOB455_1X3F_F0009_S_212_SLR.jpg}	{36,38,40,42,44}	Знаменитая плиссированная мини-юбка Miu Miu, ставшая вирусной сенсацией и определившая моду 2020-х. Ультракороткая длина и низкая посадка.	Miu Miu	Casual	women	t	0	45	t	https://www.miumiu.com/en/p-mob455_1x3f_f0009/ready-to-wear/skirts/gabardine-miniskirt/	{Beige,Navy,Grey}	skirts	miu-miu	casual
114	Vivienne Westwood Mini Bas Relief Choker	32000	Аксессуары	https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913541_1000.jpg	{https://cdn-images.farfetch-contents.com/12/09/51/88/12095188_9913542_1000.jpg}	{"One Size"}	Культовое ожерелье-чокер Mini Bas Relief от Vivienne Westwood с фирменной планетарной эмблемой. Символ панк-движения и икона альтернативной моды.	Vivienne Westwood	Vintage	women	f	0	45	t	https://www.viviennewestwood.com/en/women/jewellery/necklaces/mini-bas-relief-choker-light-gold-crystal-63020004W108W108.html	{Gold,Silver}	accessories	vivienne-westwood	vintage
115	The Row Wool Blend Knit Dress	247000	Платья	https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657048_1000.jpg	{https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657049_1000.jpg,https://cdn-images.farfetch-contents.com/19/51/52/12/19515212_43657047_1000.jpg}	{XS,S,M,L}	Элегантное трикотажное платье The Row из шерстяного смесового материала. Олицетворение минималистичной роскоши с безупречным кроем и высочайшим качеством исполнения.	The Row	Old Money	women	f	0	47	t	https://www.therow.com/	{Black,Ivory}	dresses	the-row	old-money
116	Celine Triomphe 01 Sunglasses	42000	Очки	https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_0.jpg	{https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_1.jpg,https://twicpics.celine.com/product-prd/images/large/46SC01_ACETATE_0807_2.jpg}	{"One Size"}	Культовые солнцезащитные очки Celine Triomphe 01 в ацетатной оправе с характерным логотипом на дужке. Классическая модель, полюбившаяся знаменитостям по всему миру.	Celine	Old Money	women	f	0	46	t	https://www.celine.com/en-us/celine-shop-women/accessories/sunglasses/triomphe-01-acetate-sunglasses-with-mineral-lenses-4811671NEAC.38NO.html	{Black,Tortoise,Champagne}	eyewear	celine	old-money
117	Acne Studios Oversized Wool Scarf	22500	Аксессуары	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222129F013001_1/acne-studios-pink-and-burgundy-striped-wool-scarf.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222129F013001_2/acne-studios-pink-and-burgundy-striped-wool-scarf.jpg"}	{"One Size"}	Знаменитый шарф Acne Studios из мягкой шерсти с характерной бахромой и культовой прямоугольной нашивкой с логотипом. Объемная модель, которая согреет в холодную погоду.	Acne Studios	Casual	unisex	f	0	45	t	https://www.acnestudios.com/us/en/oversized-wool-scarf-pink-burgundy-striped/CA0102-BCT.html	{Pink/Burgundy,Grey/Black,Blue/Green}	accessories	acne-studios	casual
118	Toteme Original Denim	29500	Джинсы	https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175018_1000.jpg	{https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175016_1000.jpg,https://cdn-images.farfetch-contents.com/17/38/44/29/17384429_37175017_1000.jpg}	{24,25,26,27,28,29,30,31}	Элегантные прямые джинсы Toteme с высокой посадкой из высококачественного денима. Минималистичный скандинавский дизайн для образа в стиле quiet luxury.	Toteme	Old Money	women	f	0	46	t	https://toteme-studio.com/product/original-denim-washed-blue/	{"Washed Blue",Black,Ecru}	jeans	toteme	old-money
119	Stussy Stock Logo Hoodie	19000	Худи	https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_1_720x.jpg	{https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_2_720x.jpg,https://cdn.shopify.com/s/files/1/0087/6193/3920/products/118457_BLACK_3_720x.jpg}	{S,M,L,XL,XXL}	Классическое худи Stussy с фирменным логотипом. Легендарная модель от одного из пионеров уличной моды, которая остается актуальной десятилетиями.	Stussy	Streetwear	unisex	f	0	46	t	https://www.stussy.com/products/stock-logo-hood-1?variant=42390797525196	{Black,Grey,Navy}	hoodies	stussy	streetwear
120	Palm Angels Track Pants	42000	Брюки	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_1/palm-angels-black-classic-track-pants.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_2/palm-angels-black-classic-track-pants.jpg","https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221695M190005_3/palm-angels-black-classic-track-pants.jpg"}	{XS,S,M,L,XL}	Культовые спортивные брюки Palm Angels с характерными белыми лампасами и логотипом. Роскошная интерпретация классических тренировочных штанов от итальянского бренда.	Palm Angels	Streetwear	men	t	0	45	t	https://www.palmangels.com/en-us/shopping/track-pants-15573452	{Black,Red,Purple}	pants	palm-angels	streetwear
121	Maison Margiela Glam Slam Bag	198000	Сумки	https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460834_1000.jpg	{https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460836_1000.jpg,https://cdn-images.farfetch-contents.com/13/15/78/84/13157884_30460835_1000.jpg}	{Medium}	Культовая стеганая сумка Glam Slam от Maison Margiela из мягкой кожи с характерной объемной пуфовой структурой. Авангардный дизайн с фирменной белой нашивкой.	Maison Margiela	Streetwear	women	f	0	45	t	https://www.maisonmargiela.com/en-us/glam-slam-bag-MM6521.html	{Black,White,Beige}	bags	maison-margiela	streetwear
122	New Balance 990v5 Made in USA	22000	Кроссовки	https://nb.scene7.com/is/image/NB/m990gl5_nb_02_i?$pdpflexf2$&wid=440&hei=440	{https://nb.scene7.com/is/image/NB/m990gl5_nb_05_i?$pdpflexf2$&wid=440&hei=440,https://nb.scene7.com/is/image/NB/m990gl5_nb_06_i?$pdpflexf2$&wid=440&hei=440}	{7,8,9,10,11,12,13}	Легендарные кроссовки New Balance 990v5, произведенные в США. Пятое поколение культовой модели, которая сочетает в себе комфорт, стабильность и стиль.	New Balance	Vintage	unisex	f	0	48	t	https://www.newbalance.com/pd/made-in-usa-990v5/M990V5-32152.html	{Grey,Navy,Black}	sneakers	new-balance	vintage
123	A.P.C. Petit Standard Jeans	26500	Джинсы	https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_01_grande.jpg	{https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_10_grande.jpg,https://cdn.shopify.com/s/files/1/0624/0465/products/COCVH-M09047_IAI_30_grande.jpg}	{28,29,30,31,32,33,34,36}	Культовые узкие джинсы A.P.C. Petit Standard из жесткого сырого денима. Эталон минималистичного французского стиля, которые со временем приобретают уникальную патину.	A.P.C.	Casual	men	f	0	45	t	https://www.apc-us.com/products/petit-standard-jeans-cocvhm09047	{Indigo,Black,Stonewashed}	jeans	apc	casual
124	JW Anderson Medium Chain Tote Bag	75000	Сумки	https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075093_1000.jpg	{https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075094_1000.jpg,https://cdn-images.farfetch-contents.com/17/62/85/54/17628554_37075095_1000.jpg}	{Medium}	Знаковая сумка-тоут JW Anderson с характерной золотистой цепью в качестве ручки. Авангардный, но практичный дизайн, ставший символом современной моды.	JW Anderson	Streetwear	unisex	t	0	45	t	https://www.jwanderson.com/us/shopping/medium-chain-tote-15628325	{Black,Navy,Tan}	bags	jw-anderson	streetwear
125	Versace Medusa Biggie Sunglasses	38500	Очки	https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw02285159/original/90_O4361-O17BKKN_ONUL_20_MedusaBiggieSunglasses-Sunglasses-versace-online-store_0_1.jpg	{https://www.versace.com/dw/image/v2/ABAO_PRD/on/demandware.static/-/Sites-ver-master-catalog/default/dw58f08190/original/90_O4361-O17BKKN_ONUL_22_MedusaBiggieSunglasses-Sunglasses-versace-online-store_0_1.jpg}	{"One Size"}	Роскошные солнцезащитные очки Versace с культовым символом Медузы. Эффектная модель, которая мгновенно придает образу элемент роскоши и статуса.	Versace	Vintage	unisex	f	0	44	t	https://www.versace.com/us/en-us/medusa-biggie-sunglasses-onul/O4361-O17BKKN_ONUL.html	{Black/Gold,Tortoise/Gold}	eyewear	versace	vintage
126	Jil Sander Cashmere Crewneck Sweater	84000	Свитеры	https://cdn-images.farfetch-contents.com/18/08/41/46/18084146_40735366_1000.jpg	{https://cdn-images.farfetch-contents.com/18/08/41/46/18084146_40735367_1000.jpg}	{XS,S,M,L,XL}	Минималистичный кашемировый свитер Jil Sander с круглым вырезом. Образец безупречного немецкого минимализма с акцентом на высочайшее качество материалов и исполнения.	Jil Sander	Old Money	unisex	f	0	45	t	https://www.jilsander.com/en-us/cashmere-crewneck-sweater-JSMR751305_MRYG203_102.html	{Cream,Black,Navy}	sweaters	jil-sander	old-money
127	Comme des Garçons PLAY Heart Cardigan	43500	Свитеры	https://cdn.shopify.com/s/files/1/0043/9642/products/cdg-play-p1n073-black_04.jpg	{https://cdn.shopify.com/s/files/1/0043/9642/products/cdg-play-p1n073-black_05.jpg}	{S,M,L,XL}	Культовый кардиган Comme des Garçons PLAY с фирменным сердцем с глазами. Знаковая модель японского бренда, сочетающая классический силуэт с авангардными деталями.	Comme des Garçons	Streetwear	unisex	f	0	46	t	https://shop.doverstreetmarket.com/collections/comme-des-garcons-play-knitwear/products/play-mens-red-heart-cardigan-black-red-p1n073	{Black,Navy,Grey}	sweaters	comme-des-garcons	streetwear
128	Stella McCartney Falabella Tote	96500	Сумки	https://stellamccartneyuk.vtexassets.com/arquivos/ids/252877-800-800?v=638232152325270000&width=800&height=800&aspect=true	{https://stellamccartneyuk.vtexassets.com/arquivos/ids/252876-800-800?v=638232152320970000&width=800&height=800&aspect=true,https://stellamccartneyuk.vtexassets.com/arquivos/ids/252874-800-800?v=638232152312230000&width=800&height=800&aspect=true}	{Medium}	Культовая экологичная сумка-тоут Stella McCartney Falabella с характерной отделкой цепочкой. Знаковая модель, созданная из инновационных экоматериалов без использования натуральной кожи.	Stella McCartney	Casual	women	f	0	45	t	https://www.stellamccartney.com/us/en/falabella-tote-bag-700158W91321000.html	{Black,Grey,Burgundy}	bags	stella-mccartney	casual
129	Y-3 Qasa High Sneakers	38000	Кроссовки	https://assets.adidas.com/images/w_600,f_auto,q_auto/2bf8c4fb3bd6468ba3c1ad610113a50a_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_01_standard.jpg	{"https://assets.adidas.com/images/w_600,f_auto,q_auto/7be9be0f5f88494581e0ad610113b6d3_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_02_standard.jpg","https://assets.adidas.com/images/w_600,f_auto,q_auto/d15a5bb32c2d4d939be5ad610113ce44_9366/Y-3_Qasa_High_Shoes_Black_GZ9827_03_standard.jpg"}	{7,8,9,10,11,12}	Легендарные футуристические кроссовки Y-3 Qasa High от Йоджи Ямамото и Adidas. Революционный дизайн с характерной округлой подошвой и неопреновым верхом, который перевернул представление о спортивной обуви.	Y-3	Streetwear	unisex	t	0	46	t	https://www.y-3.com/en-us/y-3-qasa-high-GZ9827.html	{Black,White}	sneakers	y-3	streetwear
130	Alexander McQueen Oversized Sneakers	59000	Кроссовки	https://media.alexandermcqueen.com/product/553680/WHGP7/9061_c.jpg	{https://media.alexandermcqueen.com/product/553680/WHGP7/9061_b.jpg,https://media.alexandermcqueen.com/product/553680/WHGP7/9061_a.jpg}	{35,36,37,38,39,40,41,42,43,44,45}	Культовые кроссовки Alexander McQueen с характерной увеличенной подошвой. Роскошная интерпретация классических белых кед из высококачественной кожи с контрастной пяткой.	Alexander McQueen	Streetwear	unisex	f	0	47	t	https://www.alexandermcqueen.com/en-us/oversized-sneaker-553680WHGP79061.html	{White/Black,White/Red,White/Blue}	sneakers	alexander-mcqueen	streetwear
131	Thom Browne 4-Bar Merino Cardigan	89000	Свитеры	https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522153_1000.jpg	{https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522151_1000.jpg,https://cdn-images.farfetch-contents.com/17/28/29/10/17282910_35522156_1000.jpg}	{1,2,3,4,5}	Элегантный кардиган Thom Browne из тонкой мериносовой шерсти с характерными четырьмя полосками на рукаве. Классический силуэт с фирменным трехцветным гросгрейном.	Thom Browne	Old Money	men	f	0	45	t	https://www.thombrowne.com/us/shopping/4-bar-merino-cardigan-15962284	{Navy,Grey,Black}	sweaters	thom-browne	old-money
132	Marni Fussbett Sneakers	65000	Кроссовки	https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034284_1000.jpg	{https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034285_1000.jpg,https://cdn-images.farfetch-contents.com/17/01/27/68/17012768_35034286_1000.jpg}	{36,37,38,39,40,41,42,43,44,45}	Оригинальные кроссовки Marni Fussbett из комбинации материалов с характерной анатомической подошвой. Эксцентричная модель с необычными пропорциями и характерной для бренда нестандартной эстетикой.	Marni	Vintage	unisex	f	0	44	t	https://www.marni.com/en-us/fussbett-sneakers-SNZU004201P2963Z100.html	{Cream/Black,Green/Brown,White/Blue}	sneakers	marni	vintage
133	Givenchy Embroidered Logo Sweatshirt	75000	Свитеры	https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37198536_1000.jpg	{https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37197826_1000.jpg,https://cdn-images.farfetch-contents.com/17/63/84/16/17638416_37198545_1000.jpg}	{XS,S,M,L,XL,XXL}	Роскошный свитшот Givenchy из высококачественного хлопка с вышитым логотипом. Элегантная интерпретация классической спортивной модели в характерном для бренда люксовом исполнении.	Givenchy	Streetwear	men	f	0	45	t	https://www.givenchy.com/us/en-US/embroidered-logo-sweatshirt-in-cotton-fleece/BMJ04K3Y6P-001.html	{Black,White,Red}	sweaters	givenchy	streetwear
134	Dries Van Noten Printed Shirt	57000	Рубашки	https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37730372_1000.jpg	{https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37729643_1000.jpg,https://cdn-images.farfetch-contents.com/17/83/45/25/17834525_37730389_1000.jpg}	{XS,S,M,L,XL}	Эффектная рубашка Dries Van Noten с характерным для бренда художественным принтом. Уникальное сочетание классического кроя и экспрессивного дизайна от бельгийского мастера.	Dries Van Noten	Vintage	men	t	0	44	t	https://www.driesvannoten.com/en-us/men/shirts/printed-shirt-13815752	{Multi,Blue,Green}	shirts	dries-van-noten	vintage
135	Cecilie Bahnsen Pleated Skirt	127000	Юбки	https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417991_1000.jpg	{https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417995_1000.jpg,https://cdn-images.farfetch-contents.com/17/58/22/88/17582288_37417990_1000.jpg}	{34,36,38,40,42}	Роскошная юбка Cecilie Bahnsen с характерной для бренда объемной фактурной отделкой. Неповторимый скандинавский дизайн с элементами романтизма и скульптурными силуэтами.	Cecilie Bahnsen	Old Money	women	t	0	44	t	https://www.ceciliebahnsen.com/products/pleated-skirt-white	{White,Black}	skirts	cecilie-bahnsen	old-money
136	Martine Rose Oversized T-Shirt	29000	Футболки	https://cdn-images.farfetch-contents.com/17/63/91/20/17639120_41028841_1000.jpg	{https://cdn-images.farfetch-contents.com/17/63/91/20/17639120_41028842_1000.jpg}	{S,M,L,XL}	Объемная футболка Martine Rose с фирменной деконструкцией и смещенными пропорциями. Авангардный британский дизайн, переосмысляющий классические предметы гардероба.	Martine Rose	Streetwear	unisex	f	0	43	t	https://martine-rose.com/collections/t-shirts/products/classic-t-shirt-beige	{Beige,Black,White}	t-shirts	martine-rose	streetwear
137	Gucci GG Jacquard Jacket	289000	Куртки	https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_001_100_0000_Light-GG-jacquard-jacket.jpg	{https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_002_100_0000_Light-GG-jacquard-jacket.jpg,https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1620147904/655002_XJDLV_4178_003_100_0000_Light-GG-jacquard-jacket.jpg}	{44,46,48,50,52,54}	Роскошная куртка Gucci из хлопкового жаккарда с фирменным монограммным принтом GG. Классический крой и знаковый декор бренда создают статусный предмет гардероба.	Gucci	Old Money	men	f	0	48	t	https://www.gucci.com/us/en/pr/men/ready-to-wear-for-men/jackets-for-men/gg-jacquard-jacket-p-655002XJDLV4178	{Beige/Brown,Black/Gray}	jackets	gucci	old-money
138	Prada Brushed Leather Loafers	95000	Обувь	https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLF.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg	{https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLR.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg,https://www.prada.com/content/dam/pradanux_products/2/2DE/2DE129/ADSF0002/2DE129_ADS_F0002_SLB.png/jcr:content/renditions/cq5dam.web.hebebed.1000.1000.jpg}	{5,6,7,8,9,10,11,12}	Элегантные кожаные лоферы Prada с фирменным треугольным логотипом и характерной массивной подошвой. Классическая модель в современной интерпретации.	Prada	Old Money	men	f	0	47	t	https://www.prada.com/us/en/men/shoes/loafers/products.brushed_leather_loafers.2DE129_ADS_F0002.html	{Black,Burgundy}	shoes	prada	old-money
139	Raf Simons Oversized Printed T-Shirt	42000	Футболки	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_1/raf-simons-white-oversized-graphic-t-shirt.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_2/raf-simons-white-oversized-graphic-t-shirt.jpg","https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/221287M213001_3/raf-simons-white-oversized-graphic-t-shirt.jpg"}	{XS,S,M,L,XL}	Авангардная оверсайз футболка Raf Simons с характерным для бренда графическим принтом. Культовый бельгийский дизайн, повлиявший на целое поколение в мире моды.	Raf Simons	Streetwear	unisex	t	0	45	t	https://www.rafsimons.com/	{White,Black}	t-shirts	raf-simons	streetwear
140	Jacquemus La Maille Neve Cropped Top	24000	Футболки	https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451280_1000.jpg	{https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451278_1000.jpg,https://cdn-images.farfetch-contents.com/16/80/12/93/16801293_34451279_1000.jpg}	{34,36,38,40,42}	Стильный укороченный топ Jacquemus из мягкого трикотажа. Минималистичный дизайн с фирменной асимметрией и вырезами, создающий современный и женственный образ.	Jacquemus	Casual	women	t	0	44	t	https://www.jacquemus.com/product/la-maille-neve-cropped-top-off-white	{Off-White,Black,Pink}	t-shirts	jacquemus	casual
141	Yohji Yamamoto Asymmetric Draped Skirt	87000	Юбки	https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_1/yohji-yamamoto-black-asymmetric-draped-skirt.jpg	{"https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_2/yohji-yamamoto-black-asymmetric-draped-skirt.jpg","https://img.ssensemedia.com/images/b_white,c_lpad,g_south,h_1086,w_724/c_scale,h_480/f_auto,q_auto/222573F090000_3/yohji-yamamoto-black-asymmetric-draped-skirt.jpg"}	{1,2,3,4,5}	Авангардная асимметричная юбка от легендарного японского дизайнера Yohji Yamamoto. Уникальная драпировка и архитектурный крой создают неповторимый образ.	Yohji Yamamoto	Vintage	women	f	0	44	t	https://www.yohjiyamamoto.co.jp/	{Black}	skirts	yohji-yamamoto	vintage
142	Moncler Maya Puffer Jacket	157000	Куртки	https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34301730_1000.jpg	{https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34334542_1000.jpg,https://cdn-images.farfetch-contents.com/17/04/89/27/17048927_34334541_1000.jpg}	{0,1,2,3,4,5,6}	Культовый пуховик Moncler Maya из глянцевого нейлона с фирменным логотипом бренда. Культовая модель, сочетающая изысканный итальянский дизайн и исключительное качество.	Moncler	Streetwear	men	f	0	47	t	https://www.moncler.com/en-us/men/outerwear/short-down-jackets/maya-short-down-jacket-black-G20911A0012053334999.html	{Black,Navy,Red}	jackets	moncler	streetwear
143	Celine Leather Pants	295000	Брюки	https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_1_FALL16.jpg	{https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_2_FALL16.jpg,https://twicpics.celine.com/product-prd/images/large/2X347747D.38NO_3_FALL16.jpg}	{34,36,38,40,42,44}	Роскошные кожаные брюки Celine с высокой посадкой и прямым силуэтом. Безупречный крой и высококачественная кожа создают изысканный образ в характерном для бренда минималистичном стиле.	Celine	Old Money	women	f	0	46	t	https://www.celine.com/en-us/celine-shop-women/ready-to-wear/pants/slim-fit-pants-in-lambskin-2X347747D.38NO.html	{Black}	pants	celine	old-money
144	Valentino Printed Silk Dress	345000	Платья	https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34566057_1000.jpg	{https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34565306_1000.jpg,https://cdn-images.farfetch-contents.com/16/81/26/32/16812632_34566058_1000.jpg}	{38,40,42,44,46}	Элегантное шелковое платье Valentino с художественным принтом. Роскошная модель, воплощающая итальянское мастерство и безупречный вкус.	Valentino	Old Money	women	t	0	47	t	https://www.valentino.com/	{Multicolor}	dresses	valentino	old-money
145	Rick Owens Leather Biker Jacket	320000	Куртки	https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989081_1000.jpg	{https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989082_1000.jpg,https://cdn-images.farfetch-contents.com/15/89/53/91/15895391_30989083_1000.jpg}	{44,46,48,50,52}	Легендарная кожаная куртка Rick Owens с характерным авангардным силуэтом. Культовая модель с асимметричной молнией, ставшая визитной карточкой бренда.	Rick Owens	Streetwear	men	f	0	48	t	https://www.rickowens.eu/en/US/men/products/ru20f3764lba-09	{Black}	jackets	rick-owens	streetwear
146	sacai Layered T-Shirt	47000	Футболки	https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37195954_1000.jpg	{https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37196771_1000.jpg,https://cdn-images.farfetch-contents.com/17/63/96/92/17639692_37196772_1000.jpg}	{1,2,3,4,5}	Инновационная многослойная футболка sacai с характерной для бренда гибридной конструкцией. Уникальное сочетание разных тканей и силуэтов в одном предмете гардероба.	sacai	Streetwear	unisex	t	0	45	t	https://www.sacai.jp/	{White/Navy,Black/White}	t-shirts	sacai	streetwear
147	Hublot Big Bang Ceramic Watch	1250000	Аксессуары	https://www.hublot.com/sites/default/files/styles/watch_item_desktop_1x_/public/2022-03/451.CX_.1140.RX-Big-Bang-Unico-ceramic-44-mm-soldier-shot.png	{https://www.hublot.com/sites/default/files/styles/global_laptop_1x_/public/2022-03/451.CX_.1140.RX-Hublot-Big-Bang-Unico-44mm-black-ceramic-soldier-shot.png,https://www.hublot.com/sites/default/files/styles/global_laptop_1x_/public/2022-03/451.CX_.1140.RX-detail-2.png}	{44mm}	Роскошные часы Hublot Big Bang из черной керамики с фирменной архитектурой корпуса и скелетонизированным циферблатом. Символ статуса и технического совершенства.	Hublot	Old Money	men	f	0	48	t	https://www.hublot.com/en-us/watches/big-bang/big-bang-unico-black-magic-44-mm	{Black/Gold}	accessories	hublot	old-money
148	Tom Ford Newman Sunglasses	44000	Очки	https://www.tomford.com/dw/image/v2/AAWH_PRD/on/demandware.static/-/Sites-tomford-master-catalog/default/dw63fea38e/zoom/J1602T_01A_OS_A.jpg	{https://www.tomford.com/dw/image/v2/AAWH_PRD/on/demandware.static/-/Sites-tomford-master-catalog/default/dwd8fafa9a/zoom/J1602T_01A_OS_B.jpg}	{"One Size"}	Элегантные солнцезащитные очки Tom Ford Newman с характерным Т-образным логотипом на дужках. Стильная модель, сочетающая классику и современные тенденции.	Tom Ford	Old Money	men	f	0	46	t	https://www.tomford.com/newman-sunglasses/J1602T-01A.html	{Black,Havana}	eyewear	tom-ford	old-money
149	Nike Air Max 97 OG	17900	Кроссовки	https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/14ea41ac-f60e-44b5-be12-c7c22f72ab9c/air-max-97-shoes-sKq4eP.png	{"https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/a9d81b6e-8793-4a82-a5af-29d831fdeadf/air-max-97-shoes-sKq4eP.png","https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/e31ed404-4d8a-4f3f-8a48-7f7c2ea3c6ad/air-max-97-shoes-sKq4eP.png"}	{"US 7","US 8","US 9","US 10","US 11","US 12"}	Культовые кроссовки Nike Air Max 97 с характерным волнообразным дизайном и полноразмерной воздушной подушкой. Модель, вдохновленная высокоскоростными японскими пулевыми поездами.	Nike	Sport	unisex	f	0	47	t	https://www.nike.com/t/air-max-97-shoes-sKq4eP/DM0027-001	{Silver/Red,Black/White,Gold/Black}	sneakers	nike	sport
150	Vacheron Constantin Patrimony	2950000	Аксессуары	https://www.vacheron-constantin.com/dam/rcq/vac/16/39/51/9/1639519.png.transform.vacproddetail.png	{https://www.vacheron-constantin.com/dam/rcq/vac/15/10/30/1/1510301.png.transform.vacproddetail.png,https://www.vacheron-constantin.com/dam/rcq/vac/19/16/95/4/1916954.png.transform.vacproddetail.png}	{40mm}	Элегантные часы Vacheron Constantin Patrimony из розового золота с классическим круглым корпусом. Настоящее произведение швейцарского часового искусства с многовековой историей.	Vacheron Constantin	Old Money	men	f	0	49	t	https://www.vacheron-constantin.com/en4/watches/patrimony/patrimony-self-winding-4100u-000r-b180.html	{"Rose Gold/Brown"}	accessories	vacheron-constantin	old-money
151	Dior Saddle Bag	370000	Сумки	https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/cover_image_1/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E01_ZHC.jpg	{https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_2/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E02_ZHC.jpg,https://wwws.dior.com/couture/ecommerce/media/catalog/product/cache/1/zoom_image_3/870x580/17f82f742ffe127f42dca9de82fb58b1/V/W/1612528363_M0446CTZQ_M928_E03_ZHC.jpg}	{Medium}	Культовая сумка Dior Saddle с характерной формой седла. Легендарная модель, ставшая символом начала 2000-х и пережившая триумфальное возвращение в современной моде.	Dior	Old Money	women	f	0	48	t	https://www.dior.com/en_us/products/couture-M0446CTZQ_M928-saddle-bag-blue-dior-oblique-jacquard	{"Blue Monogram",Black,Brown}	bags	dior	old-money
152	Adidas Samba OG	11500	Кроссовки	https://assets.adidas.com/images/w_600,f_auto,q_auto/cb1212403d0944419924aad6009a0497_9366/Samba_OG_Shoes_White_B75806_01_standard.jpg	{"https://assets.adidas.com/images/w_600,f_auto,q_auto/35b654a1eda34f62acaeaad6009a0def_9366/Samba_OG_Shoes_White_B75806_02_standard.jpg","https://assets.adidas.com/images/w_600,f_auto,q_auto/fc3fe27e34564a488e9baad6009a18e2_9366/Samba_OG_Shoes_White_B75806_04_standard.jpg"}	{7,8,9,10,11,12,13}	Культовые кроссовки Adidas Samba с характерным T-образным мыском. Классическая модель, созданная для футбола в 1950-х и ставшая иконой городской моды.	Adidas	Vintage	unisex	f	0	48	t	https://www.adidas.com/us/samba-og-shoes/B75806.html	{White/Black,Black/White,Green/White}	sneakers	adidas	vintage
153	Ambush Silver Chain Bracelet	35000	Аксессуары	https://cdn-images.farfetch-contents.com/16/33/15/20/16331520_31421003_1000.jpg	{https://cdn-images.farfetch-contents.com/16/33/15/20/16331520_31421999_1000.jpg}	{S,M,L}	Массивный серебряный браслет-цепь Ambush с характерным индустриальным дизайном. Яркий аксессуар, сочетающий традиции ювелирного искусства и современную уличную эстетику.	Ambush	Streetwear	unisex	t	0	44	t	https://www.ambushdesign.com/	{Silver}	accessories	ambush	streetwear
154	Fendi Flow Sneakers	97000	Кроссовки	https://www.fendi.com/medias/sys_master/images/images/h56/h77/8917173747742/7E1392AJT6F1HKR-01.jpg	{https://www.fendi.com/medias/sys_master/images/images/h33/h1f/8917174337566/7E1392AJT6F1HKR-02.jpg,https://www.fendi.com/medias/sys_master/images/images/hf2/h4e/8917175648286/7E1392AJT6F1HKR-03.jpg}	{6,7,8,9,10,11,12}	Элегантные кроссовки Fendi Flow с характерным монограммным принтом FF. Роскошное сочетание спортивного стиля и итальянского мастерства.	Fendi	Streetwear	unisex	f	0	45	t	https://www.fendi.com/us/man/shoes/sneakers/flow-sneakers-7e1392ajt6f1hkr	{Brown/Black,White/Brown}	sneakers	fendi	streetwear
155	Ralph Lauren Cable-Knit Cashmere Sweater	59500	Свитеры	https://www.ralphlauren.com/dw/image/v2/AAFX_PRD/on/demandware.static/-/Sites-RalphLauren_US-Library/default/dw1eb5b1bf/img/202109/20210922-polo-women/modules/w_classics_polosweater.jpg	{https://www.ralphlauren.com/dw/image/v2/AAFX_PRD/on/demandware.static/-/Sites-PRL_Master_Catalog/default/dw0732e3e2/s7-1380617/large/1380617_229802614001_2.jpg}	{XS,S,M,L,XL}	Роскошный кашемировый свитер Ralph Lauren с фирменным плетением "косичка". Воплощение американской классики и традиционного качества.	Ralph Lauren	Old Money	women	f	0	47	t	https://www.ralphlauren.com/women-clothing-sweaters/cable-knit-cashmere-sweater/614001.html	{Camel,Cream,Navy}	sweaters	ralph-lauren	old-money
156	Balmain Double-Breasted Blazer	249000	Пиджаки	https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006347_1000.jpg	{https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006350_1000.jpg,https://cdn-images.farfetch-contents.com/17/66/63/51/17666351_37006348_1000.jpg}	{34,36,38,40,42,44}	Структурированный двубортный блейзер Balmain с фирменными золотыми пуговицами. Знаковая модель французского дома, сочетающая военную строгость и парижский шик.	Balmain	Old Money	women	f	0	46	t	https://www.balmain.com/us/ready-to-wear-blazer-6-button-double-breasted-blazer-in-grain-de-poudre/VF17110W1100PA.html	{Black,White,Navy}	jackets	balmain	old-money
157	MM6 Maison Margiela Japanese Tote	59000	Сумки	https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275201_1000.jpg	{https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275202_1000.jpg,https://cdn-images.farfetch-contents.com/15/19/85/30/15198530_30275203_1000.jpg}	{Medium,Large}	Культовая сумка-тоут MM6 Maison Margiela Japanese из мягкой экокожи. Инновационный дизайн с возможностью трансформации формы и размера.	MM6 Maison Margiela	Streetwear	women	f	0	45	t	https://www.maisonmargiela.com/us/mm6-maison-margiela/tote-bag_cod45393025ps.html	{White,Black,Navy}	bags	mm6-maison-margiela	streetwear
158	Casablanca Printed Silk Shirt	69000	Рубашки	https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073428_1000.jpg	{https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073429_1000.jpg,https://cdn-images.farfetch-contents.com/17/40/58/24/17405824_36073427_1000.jpg}	{XS,S,M,L,XL}	Роскошная шелковая рубашка Casablanca с характерным художественным принтом. Уникальное сочетание теннисного стиля и роскошной пляжной эстетики.	Casablanca	Vintage	men	t	0	44	t	https://casablancaparis.com/	{Multicolor}	shirts	casablanca	vintage
159	Chanel CC Loafers	129000	Обувь	https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847029633054.jpg	{"https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847030550542.jpg","https://www.chanel.com/images/t_fashionselector//q_auto:good,f_auto,fl_lossy,dpr_1.2/w_620/loafers-beige-black-lambskin-lambskin-packshot-alternative-g36360y538400k0661-8847030583310.jpg"}	{35,36,37,38,39,40,41}	Элегантные лоферы Chanel из мягкой ягнячьей кожи с характерным логотипом CC. Классическая модель, сочетающая комфорт и изысканный французский стиль.	Chanel	Old Money	women	f	0	48	t	https://www.chanel.com/us/fashion/p/G36360Y53840C0204/loafers-lambskin/	{Beige/Black,Black}	shoes	chanel	old-money
\.


--
-- Data for Name: referral_codes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.referral_codes (id, user_id, code, discount_percentage, active, usage_count, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: referral_usage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.referral_usage (id, referral_code_id, referrer_id, referred_user_id, order_id, discount_amount, used_at) FROM stdin;
\.


--
-- Data for Name: styles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.styles (id, name, description, image_url, featured, slug) FROM stdin;
1	Old Money	Элегантный стиль, вдохновленный аристократической эстетикой. Классические силуэты, нейтральные цвета и благородные ткани.	https://i.imgur.com/xYtZVqx.jpg	t	old-money
2	Vintage	Ретро-эстетика с элементами моды прошлых десятилетий. Уникальные винтажные элементы и текстуры.	https://i.imgur.com/qW3jD5P.jpg	t	vintage
3	Streetwear	Уличный стиль с влиянием хип-хоп культуры и скейтбординга. Свободные силуэты, графические принты и яркие цвета.	https://i.imgur.com/lZ7XwQ0.jpg	t	streetwear
4	Sport	Спортивный стиль, объединяющий функциональность и моду. Технологичные ткани и удобный крой для активного образа жизни.	https://i.imgur.com/DZnKUWX.jpg	t	sport
5	Casual	Повседневный стиль для комфортной жизни в городе. Практичные, но стильные вещи для ежедневного использования.	https://i.imgur.com/4wqEHsC.jpg	t	casual
\.


--
-- Data for Name: user_favorites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_favorites (id, user_id, product_id, date_added, notes) FROM stdin;
\.


--
-- Data for Name: user_virtual_wardrobe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_virtual_wardrobe (id, user_id, clothing_item_id, selected_color, selected_size, is_favorite, date_added) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password, telegram_id, is_admin, email, full_name, phone, avatar_url, last_login, registration_date, referral_code, referred_by, referral_count, referral_discount, notification_settings, preferences, created_at) FROM stdin;
\.


--
-- Data for Name: virtual_clothing_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.virtual_clothing_items (id, name, type, category, product_id, model_path, thumbnail_url, colors, sizes) FROM stdin;
\.


--
-- Name: avatar_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.avatar_params_id_seq', 1, false);


--
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.brands_id_seq', 74, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 16, true);


--
-- Name: delivery_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_addresses_id_seq', 1, false);


--
-- Name: online_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.online_users_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 159, true);


--
-- Name: referral_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.referral_codes_id_seq', 1, false);


--
-- Name: referral_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.referral_usage_id_seq', 1, false);


--
-- Name: styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.styles_id_seq', 10, true);


--
-- Name: user_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_favorites_id_seq', 1, false);


--
-- Name: user_virtual_wardrobe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_virtual_wardrobe_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: virtual_clothing_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.virtual_clothing_items_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

