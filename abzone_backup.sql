--
-- PostgreSQL database dump
--

\restrict 4eYo9ddcBe224hlF31zfrbcLAe6dEU07pggva7g9WCByB3D4Nk5Ffp75feDEFdG

-- Dumped from database version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)

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
-- Name: branch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.branch (
    id integer NOT NULL,
    name character varying NOT NULL,
    location character varying NOT NULL,
    created_at timestamp without time zone,
    image_url character varying
);


ALTER TABLE public.branch OWNER TO postgres;

--
-- Name: branch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.branch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.branch_id_seq OWNER TO postgres;

--
-- Name: branch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.branch_id_seq OWNED BY public.branch.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone,
    image_url character varying
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliveries (
    id integer NOT NULL,
    order_id integer NOT NULL,
    delivery_amount numeric(10,2) NOT NULL,
    delivery_location character varying NOT NULL,
    customer_phone character varying NOT NULL,
    delivery_status character varying,
    payment_status character varying,
    agreed_delivery_time timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    notes character varying
);


ALTER TABLE public.deliveries OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deliveries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deliveries_id_seq OWNER TO postgres;

--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deliveries_id_seq OWNED BY public.deliveries.id;


--
-- Name: delivery_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_payments (
    id integer NOT NULL,
    delivery_id integer NOT NULL,
    user_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying NOT NULL,
    payment_status character varying NOT NULL,
    transaction_id character varying,
    reference_number character varying,
    notes character varying,
    payment_date timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.delivery_payments OWNER TO postgres;

--
-- Name: delivery_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.delivery_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delivery_payments_id_seq OWNER TO postgres;

--
-- Name: delivery_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.delivery_payments_id_seq OWNED BY public.delivery_payments.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    amount numeric(10,2) NOT NULL,
    category character varying NOT NULL,
    expense_date date NOT NULL,
    payment_method character varying,
    receipt_url character varying,
    branch_id integer,
    user_id integer NOT NULL,
    approved_by integer,
    status character varying,
    approval_notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_id_seq OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    orderid integer NOT NULL,
    invoice_number character varying NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    tax_amount numeric(10,2),
    discount_amount numeric(10,2),
    subtotal numeric(10,2) NOT NULL,
    status character varying,
    due_date timestamp without time zone,
    notes character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoices_id_seq OWNER TO postgres;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: orderitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderitems (
    id integer NOT NULL,
    orderid integer,
    productid integer,
    quantity numeric(10,2) NOT NULL,
    buying_price numeric(10,2),
    original_price numeric(10,2),
    negotiated_price numeric(10,2),
    final_price numeric(10,2),
    negotiation_notes character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    product_name character varying(255)
);


ALTER TABLE public.orderitems OWNER TO postgres;

--
-- Name: orderitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orderitems_id_seq OWNER TO postgres;

--
-- Name: orderitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderitems_id_seq OWNED BY public.orderitems.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    userid integer NOT NULL,
    ordertypeid integer NOT NULL,
    branchid integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    approvalstatus boolean,
    approved_at timestamp without time zone,
    payment_status character varying
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: ordertypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordertypes (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.ordertypes OWNER TO postgres;

--
-- Name: ordertypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordertypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordertypes_id_seq OWNER TO postgres;

--
-- Name: ordertypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordertypes_id_seq OWNED BY public.ordertypes.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.password_resets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.password_resets_id_seq OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_resets_id_seq OWNED BY public.password_resets.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    orderid integer NOT NULL,
    userid integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying NOT NULL,
    payment_status character varying NOT NULL,
    transaction_id character varying,
    reference_number character varying,
    notes character varying,
    payment_date timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: product_descriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_descriptions (
    id integer NOT NULL,
    product_id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    content_type character varying,
    language character varying,
    is_active boolean,
    sort_order integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.product_descriptions OWNER TO postgres;

--
-- Name: product_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_descriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_descriptions_id_seq OWNER TO postgres;

--
-- Name: product_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_descriptions_id_seq OWNED BY public.product_descriptions.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    branchid integer NOT NULL,
    name character varying NOT NULL,
    image_url character varying,
    buyingprice integer,
    sellingprice integer,
    stock numeric(10,2),
    productcode character varying,
    display boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    subcategory_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: purchase_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_items (
    id integer NOT NULL,
    purchase_order_id integer NOT NULL,
    product_code character varying,
    product_name character varying,
    quantity numeric(10,3) NOT NULL,
    unit_price numeric(10,2),
    total_price numeric(10,2),
    received_quantity numeric(10,3) DEFAULT 0 NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.purchase_order_items OWNER TO postgres;

--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_order_items_id_seq OWNER TO postgres;

--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_order_items_id_seq OWNED BY public.purchase_order_items.id;


--
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id integer NOT NULL,
    po_number character varying NOT NULL,
    supplier_id integer NOT NULL,
    branch_id integer NOT NULL,
    user_id integer NOT NULL,
    order_date date NOT NULL,
    expected_delivery_date date,
    delivery_date date,
    subtotal numeric(10,2) NOT NULL,
    tax_amount numeric(10,2) NOT NULL,
    discount_amount numeric(10,2) NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying,
    payment_status character varying,
    payment_method character varying,
    notes text,
    approved_by integer,
    approved_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_orders_id_seq OWNER TO postgres;

--
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_orders_id_seq OWNED BY public.purchase_orders.id;


--
-- Name: quotationitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotationitems (
    id integer NOT NULL,
    quotation_id integer NOT NULL,
    product_id integer,
    quantity numeric(10,3) NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) NOT NULL,
    notes text,
    created_at timestamp without time zone,
    product_name character varying(255)
);


ALTER TABLE public.quotationitems OWNER TO postgres;

--
-- Name: quotationitems_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quotationitems_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotationitems_id_seq OWNER TO postgres;

--
-- Name: quotationitems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quotationitems_id_seq OWNED BY public.quotationitems.id;


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotations (
    id integer NOT NULL,
    quotation_number character varying NOT NULL,
    customer_name character varying NOT NULL,
    customer_email character varying,
    customer_phone character varying,
    created_by integer NOT NULL,
    branch_id integer NOT NULL,
    subtotal numeric(10,2) NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying,
    valid_until timestamp without time zone,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.quotations OWNER TO postgres;

--
-- Name: quotations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quotations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quotations_id_seq OWNER TO postgres;

--
-- Name: quotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quotations_id_seq OWNED BY public.quotations.id;


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receipts (
    id integer NOT NULL,
    paymentid integer NOT NULL,
    orderid integer NOT NULL,
    receipt_number character varying NOT NULL,
    payment_amount numeric(10,2) NOT NULL,
    previous_balance numeric(10,2) NOT NULL,
    remaining_balance numeric(10,2) NOT NULL,
    payment_method character varying NOT NULL,
    reference_number character varying,
    transaction_id character varying,
    notes character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.receipts OWNER TO postgres;

--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.receipts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.receipts_id_seq OWNER TO postgres;

--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.receipts_id_seq OWNED BY public.receipts.id;


--
-- Name: stock_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_transactions (
    id integer NOT NULL,
    productid integer NOT NULL,
    userid integer NOT NULL,
    transaction_type character varying NOT NULL,
    quantity numeric(10,3) NOT NULL,
    previous_stock numeric(10,3) NOT NULL,
    new_stock numeric(10,3) NOT NULL,
    notes character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.stock_transactions OWNER TO postgres;

--
-- Name: stock_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_transactions_id_seq OWNER TO postgres;

--
-- Name: stock_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_transactions_id_seq OWNED BY public.stock_transactions.id;


--
-- Name: sub_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub_category (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    image_url character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.sub_category OWNER TO postgres;

--
-- Name: sub_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sub_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sub_category_id_seq OWNER TO postgres;

--
-- Name: sub_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sub_category_id_seq OWNED BY public.sub_category.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    name character varying NOT NULL,
    contact_person character varying,
    email character varying,
    phone character varying,
    address text,
    tax_number character varying,
    payment_terms character varying,
    credit_limit numeric(10,2),
    is_active boolean,
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL,
    created_at timestamp without time zone,
    phone character varying,
    accessible_branch_ids json DEFAULT '[]'::json
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: branch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch ALTER COLUMN id SET DEFAULT nextval('public.branch_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: deliveries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries ALTER COLUMN id SET DEFAULT nextval('public.deliveries_id_seq'::regclass);


--
-- Name: delivery_payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_payments ALTER COLUMN id SET DEFAULT nextval('public.delivery_payments_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: orderitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems ALTER COLUMN id SET DEFAULT nextval('public.orderitems_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: ordertypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertypes ALTER COLUMN id SET DEFAULT nextval('public.ordertypes_id_seq'::regclass);


--
-- Name: password_resets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN id SET DEFAULT nextval('public.password_resets_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: product_descriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_descriptions ALTER COLUMN id SET DEFAULT nextval('public.product_descriptions_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: purchase_order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_items_id_seq'::regclass);


--
-- Name: purchase_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders ALTER COLUMN id SET DEFAULT nextval('public.purchase_orders_id_seq'::regclass);


--
-- Name: quotationitems id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotationitems ALTER COLUMN id SET DEFAULT nextval('public.quotationitems_id_seq'::regclass);


--
-- Name: quotations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations ALTER COLUMN id SET DEFAULT nextval('public.quotations_id_seq'::regclass);


--
-- Name: receipts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts ALTER COLUMN id SET DEFAULT nextval('public.receipts_id_seq'::regclass);


--
-- Name: stock_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_transactions ALTER COLUMN id SET DEFAULT nextval('public.stock_transactions_id_seq'::regclass);


--
-- Name: sub_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_category ALTER COLUMN id SET DEFAULT nextval('public.sub_category_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.branch (id, name, location, created_at, image_url) FROM stdin;
1	ABZ Hardware Main Branch	Gikomba, Kombo Munyiri.	2025-08-07 13:39:03.247617	\N
2	ABZ Hardware Amazing	Gikomba, Kombo Munyiri.	2025-08-07 13:39:33.933429	\N
3	ABZ ELECTRICALS	NYAMAKIMA	2025-08-12 16:06:12.212215	\N
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name, description, created_at, image_url) FROM stdin;
1	Toilets		2025-08-08 12:27:59.100448	\N
3	Cabinet		2025-08-08 12:40:09.393765	\N
4	Cistern		2025-08-08 12:43:03.188193	\N
5	Urinal Bowls		2025-08-08 12:48:16.936329	\N
6	Kitchen Sink		2025-08-08 12:50:04.152143	\N
7	Mirrors		2025-08-08 12:51:37.989021	\N
8	Taps		2025-08-08 12:51:55.005234	\N
9	Mixer Taps		2025-08-08 12:59:14.625122	\N
11	Showers		2025-08-08 13:07:31.50877	\N
12	Bathroom Accessories		2025-08-08 13:14:34.899688	\N
13	Soap Dish		2025-08-08 13:15:36.611038	\N
14	Tissue Holder 		2025-08-08 13:16:04.719016	\N
15	Towel Bars		2025-08-08 13:16:26.234489	\N
16	Toilet Brush		2025-08-08 13:16:47.150598	\N
17	ToothBrush Holder		2025-08-08 13:17:45.457659	\N
18	Soap Dispenser		2025-08-08 13:18:53.89258	\N
19	Towel Rings		2025-08-08 13:19:11.554219	\N
20	Bathroom Corner Shelves		2025-08-08 13:20:28.210028	\N
21	Bathroom Rectangular Shelves		2025-08-08 13:21:13.183819	\N
22	Floor Drain		2025-08-08 13:21:37.960724	\N
23	Grab Bars		2025-08-08 13:26:44.842517	\N
24	Water Meters		2025-08-08 13:27:29.323747	\N
25	Angle Valves		2025-08-08 13:28:50.051551	\N
26	Seat Covers		2025-08-08 13:31:43.821524	\N
27	Gate Valves		2025-08-08 13:32:53.620499	\N
28	Magic Connector		2025-08-08 13:34:19.650605	\N
29	Bottle Trap		2025-08-08 13:36:51.871774	\N
10	Non Mixer Taps		2025-08-08 12:59:32.227924	\N
30	PIPES		2025-08-08 14:06:52.016387	\N
2	Wash Hand Basin		2025-08-08 12:32:10.631844	\N
31	Bathroom Accessories Set		2025-08-20 13:04:59.849412	\N
32	Flex Tube		2025-08-21 10:55:09.6055	\N
33	ELECTRICAL	ALL ELECTRICAL ITEMS 	2025-08-21 17:53:00.644185	\N
34	BOARDS 		2025-08-23 12:41:49.638818	\N
35	GRANITE		2025-08-23 12:54:18.233329	\N
37	SHOWER CUBICLE		2025-08-24 12:49:49.060705	\N
38	Bathtub		2025-08-24 14:25:01.158703	\N
39	MANHOLE COVER		2025-08-24 14:35:51.704333	\N
40	SHELVES		2025-08-24 14:41:05.646784	\N
41	FLOOR DRAIN		2025-08-24 15:01:24.600636	\N
42	Silicone		2025-08-24 15:15:53.14151	\N
43	Heaters		2025-08-24 15:25:24.448625	\N
44	Screws		2025-08-24 15:45:00.469025	\N
45	Tape		2025-08-24 15:53:25.585555	\N
46	Tile Cleaner		2025-08-30 17:08:56.559868	\N
47	Pop Up		2025-08-30 17:22:26.719433	\N
48	Electricals		2025-09-03 11:39:19.919175	\N
\.


--
-- Data for Name: deliveries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliveries (id, order_id, delivery_amount, delivery_location, customer_phone, delivery_status, payment_status, agreed_delivery_time, created_at, updated_at, notes) FROM stdin;
\.


--
-- Data for Name: delivery_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_payments (id, delivery_id, user_id, amount, payment_method, payment_status, transaction_id, reference_number, notes, payment_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (id, title, description, amount, category, expense_date, payment_method, receipt_url, branch_id, user_id, approved_by, status, approval_notes, created_at, updated_at) FROM stdin;
3	TRANSPORT	MOTORBIKE TRANSPORT	700.00	transport	2025-08-26	mobile_money	https://res.cloudinary.com/dxyewzvnr/image/upload/v1756216472/abz_products/ixb1zenlhsfxgxpbg6ju.pdf	1	10	10	approved		2025-08-26 13:53:10.174463	2025-08-27 05:23:45.256671
4	SALARY FOR CATHERINE		33000.00	salaries	2025-09-02	cash	\N	1	10	10	approved		2025-09-03 05:18:10.87345	2025-09-03 05:18:58.647179
5	SALARY FOR HAFSA		17500.00	salaries	2025-09-02	cash	\N	1	10	10	approved		2025-09-03 05:18:46.265025	2025-09-03 05:19:06.62333
6	SALARY FOR COLLINS		18500.00	salaries	2025-09-02	cash	\N	1	10	10	approved		2025-09-03 05:20:12.910668	2025-09-03 05:20:22.375351
7	SALARY  FOR NIKOLE		9000.00	salaries	2025-09-02	cash	\N	1	10	10	approved		2025-09-03 05:21:28.874416	2025-09-03 05:21:36.134135
8	SALARY FOR DONALD		7500.00	salaries	2025-09-02	cash	\N	1	10	10	approved		2025-09-03 05:22:25.479249	2025-09-03 05:22:33.696775
9	Payment to the security company	18,000 paid to SOS Security	18000.00	other	2025-09-09	mobile_money	\N	1	10	10	approved		2025-09-09 12:06:22.010436	2025-09-09 12:07:42.692276
10	RENT PAYMENT	130000 Was paid through equity to MUTHOKI Land lord 	130000.00	rent	2025-09-09	bank_transfer	\N	1	10	10	approved		2025-09-09 12:07:34.04084	2025-09-09 12:08:25.274333
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (id, orderid, invoice_number, total_amount, tax_amount, discount_amount, subtotal, status, due_date, notes, created_at, updated_at) FROM stdin;
24	26	INV-20250826-0001	16800.00	0.00	0.00	16800.00	pending	2025-09-25 13:32:06.132133	Invoice generated for Order #26	2025-08-26 13:32:06.13719	2025-08-26 13:32:06.137209
27	30	INV-20250827-0002	24000.00	0.00	0.00	24000.00	pending	2025-09-26 13:46:46.043456	Invoice generated for Order #30	2025-08-27 13:46:46.045989	2025-08-27 13:46:46.045998
28	31	INV-20250827-0003	1300.00	0.00	0.00	1300.00	pending	2025-09-26 13:50:20.940871	Invoice generated for Order #31	2025-08-27 13:50:20.944468	2025-08-27 13:50:20.944479
30	33	INV-20250827-0004	6800.00	0.00	0.00	6800.00	pending	2025-09-26 14:02:53.392766	Invoice generated for Order #33	2025-08-27 14:02:53.395098	2025-08-27 14:02:53.395112
31	34	INV-20250827-0005	450.00	0.00	0.00	450.00	pending	2025-09-26 14:04:36.682805	Invoice generated for Order #34	2025-08-27 14:04:36.684741	2025-08-27 14:04:36.684759
32	35	INV-20250828-0001	17700.00	0.00	0.00	17700.00	pending	2025-09-27 08:10:10.628328	Invoice generated for Order #35	2025-08-28 08:10:10.629844	2025-08-28 08:10:10.629852
33	36	INV-20250828-0002	49670.00	0.00	0.00	49670.00	pending	2025-09-27 12:33:40.552166	Invoice generated for Order #36	2025-08-28 12:33:40.555511	2025-08-28 12:33:40.555549
34	37	INV-20250828-0003	4300.00	0.00	0.00	4300.00	pending	2025-09-27 12:39:43.116911	Invoice generated for Order #37	2025-08-28 12:39:43.119291	2025-08-28 12:39:43.119309
35	38	INV-20250828-0004	9600.00	0.00	0.00	9600.00	pending	2025-09-27 13:06:41.578856	Invoice generated for Order #38	2025-08-28 13:06:41.580421	2025-08-28 13:06:41.58043
36	39	INV-20250828-0005	3000.00	0.00	0.00	3000.00	pending	2025-09-27 13:56:14.361873	Invoice generated for Order #39	2025-08-28 13:56:14.36337	2025-08-28 13:56:14.363382
37	40	INV-20250828-0006	1800.00	0.00	0.00	1800.00	pending	2025-09-27 14:55:17.43863	Invoice generated for Order #40	2025-08-28 14:55:17.442333	2025-08-28 14:55:17.442364
38	41	INV-20250829-0001	400.00	0.00	0.00	400.00	pending	2025-09-28 13:17:32.637819	Invoice generated for Order #41	2025-08-29 13:17:32.640423	2025-08-29 13:17:32.64043
42	46	INV-20250830-0002	4200.00	0.00	0.00	4200.00	pending	2025-09-29 10:48:43.199258	Invoice generated for Order #46	2025-08-30 10:48:43.200697	2025-08-30 10:48:43.200707
43	47	INV-20250830-0003	5500.00	0.00	0.00	5500.00	pending	2025-09-29 11:02:46.366287	Invoice generated for Order #47	2025-08-30 11:02:46.367608	2025-08-30 11:02:46.36762
44	48	INV-20250830-0004	55200.00	0.00	0.00	55200.00	pending	2025-09-29 11:09:43.789803	Invoice generated for Order #48	2025-08-30 11:09:43.791535	2025-08-30 11:09:43.791545
45	49	INV-20250830-0005	1110.00	0.00	0.00	1110.00	pending	2025-09-29 11:44:30.900395	Invoice generated for Order #49	2025-08-30 11:44:30.902181	2025-08-30 11:44:30.90219
46	50	INV-20250830-0006	3000.00	0.00	0.00	3000.00	pending	2025-09-29 11:46:41.458798	Invoice generated for Order #50	2025-08-30 11:46:41.460394	2025-08-30 11:46:41.460402
47	51	INV-20250830-0007	110.00	0.00	0.00	110.00	pending	2025-09-29 11:47:51.384635	Invoice generated for Order #51	2025-08-30 11:47:51.385931	2025-08-30 11:47:51.385938
48	52	INV-20250830-0008	120600.00	0.00	0.00	120600.00	pending	2025-09-29 12:35:05.81408	Invoice generated for Order #52	2025-08-30 12:35:05.815833	2025-08-30 12:35:05.815841
49	53	INV-20250901-0001	900.00	0.00	0.00	900.00	pending	2025-10-01 13:29:45.470671	Invoice generated for Order #53	2025-09-01 13:29:45.473881	2025-09-01 13:29:45.473889
50	54	INV-20250901-0002	13500.00	0.00	0.00	13500.00	pending	2025-10-01 13:38:35.97441	Invoice generated for Order #54	2025-09-01 13:38:35.975736	2025-09-01 13:38:35.975747
52	56	INV-20250902-0001	49050.00	0.00	0.00	49050.00	pending	2025-10-02 13:23:00.360665	Invoice generated for Order #56	2025-09-02 13:23:00.362186	2025-09-02 13:23:00.362195
53	57	INV-20250902-0002	44400.00	0.00	0.00	44400.00	pending	2025-10-02 13:25:44.449408	Invoice generated for Order #57	2025-09-02 13:25:44.451076	2025-09-02 13:25:44.451085
54	58	INV-20250902-0003	18350.00	0.00	0.00	18350.00	pending	2025-10-02 13:25:47.910355	Invoice generated for Order #58	2025-09-02 13:25:47.911618	2025-09-02 13:25:47.911625
55	59	INV-20250902-0004	10100.00	0.00	0.00	10100.00	pending	2025-10-02 13:29:49.909488	Invoice generated for Order #59	2025-09-02 13:29:49.910944	2025-09-02 13:29:49.910951
56	60	INV-20250902-0005	200.00	0.00	0.00	200.00	pending	2025-10-02 13:59:03.79709	Invoice generated for Order #60	2025-09-02 13:59:03.798676	2025-09-02 13:59:03.798683
57	61	INV-20250902-0006	300.00	0.00	0.00	300.00	pending	2025-10-02 14:00:45.523489	Invoice generated for Order #61	2025-09-02 14:00:45.525224	2025-09-02 14:00:45.525237
58	62	INV-20250903-0001	18430.00	0.00	0.00	18430.00	pending	2025-10-03 13:06:13.830515	Invoice generated for Order #62	2025-09-03 13:06:13.831927	2025-09-03 13:06:13.831936
59	63	INV-20250903-0002	1500.00	0.00	0.00	1500.00	pending	2025-10-03 13:25:33.896391	Invoice generated for Order #63	2025-09-03 13:25:33.89795	2025-09-03 13:25:33.897959
60	64	INV-20250903-0003	3900.00	0.00	0.00	3900.00	pending	2025-10-03 13:45:12.186308	Invoice generated for Order #64	2025-09-03 13:45:12.187873	2025-09-03 13:45:12.187887
63	67	INV-20250904-0001	2000.00	0.00	0.00	2000.00	pending	2025-10-04 13:17:45.011991	Invoice generated for Order #67	2025-09-04 13:17:45.013739	2025-09-04 13:17:45.013746
64	69	INV-20250904-0002	2100.00	0.00	0.00	2100.00	pending	2025-10-04 13:21:02.331126	Invoice generated for Order #69	2025-09-04 13:21:02.332358	2025-09-04 13:21:02.332365
65	70	INV-20250904-0003	2500.00	0.00	0.00	2500.00	pending	2025-10-04 13:21:22.356683	Invoice generated for Order #70	2025-09-04 13:21:22.357614	2025-09-04 13:21:22.35762
66	71	INV-20250904-0004	1100.00	0.00	0.00	1100.00	pending	2025-10-04 13:45:05.385892	Invoice generated for Order #71	2025-09-04 13:45:05.387438	2025-09-04 13:45:05.387445
67	72	INV-20250904-0005	6780.00	0.00	0.00	6780.00	pending	2025-10-04 13:46:08.871248	Invoice generated for Order #72	2025-09-04 13:46:08.87257	2025-09-04 13:46:08.872583
68	73	INV-20250905-0001	7000.00	0.00	0.00	7000.00	pending	2025-10-05 09:02:31.799457	Invoice generated for Order #73	2025-09-05 09:02:31.801448	2025-09-05 09:02:31.801462
69	74	INV-20250905-0002	103290.00	0.00	0.00	103290.00	pending	2025-10-05 12:13:55.244751	Invoice generated for Order #74	2025-09-05 12:13:55.245965	2025-09-05 12:13:55.245972
70	75	INV-20250905-0003	183680.00	0.00	0.00	183680.00	pending	2025-10-05 13:52:48.465982	Invoice generated for Order #75	2025-09-05 13:52:48.467134	2025-09-05 13:52:48.467141
71	76	INV-20250905-0004	11500.00	0.00	0.00	11500.00	pending	2025-10-05 16:42:27.278947	Invoice generated for Order #76	2025-09-05 16:42:27.282583	2025-09-05 16:42:27.282594
72	77	INV-20250906-0001	19700.00	0.00	0.00	19700.00	pending	2025-10-06 10:34:54.477157	Invoice generated for Order #77	2025-09-06 10:34:54.480867	2025-09-06 10:34:54.480877
73	78	INV-20250906-0002	2820.00	0.00	0.00	2820.00	pending	2025-10-06 10:35:47.802944	Invoice generated for Order #78	2025-09-06 10:35:47.804126	2025-09-06 10:35:47.804133
75	80	INV-20250906-0003	450.00	0.00	0.00	450.00	pending	2025-10-06 10:39:56.411688	Invoice generated for Order #80	2025-09-06 10:39:56.414329	2025-09-06 10:39:56.414339
82	87	INV-20250906-0010	34540.00	0.00	0.00	34540.00	pending	2025-10-06 15:35:17.358009	Invoice generated for Order #87	2025-09-06 15:35:17.359722	2025-09-06 15:35:17.359732
83	88	INV-20250906-0011	3120.00	0.00	0.00	3120.00	pending	2025-10-06 16:08:44.511429	Invoice generated for Order #88	2025-09-06 16:08:44.513001	2025-09-06 16:08:44.513015
84	89	INV-20250908-0001	390000.00	0.00	0.00	390000.00	pending	2025-10-08 12:14:17.395613	Invoice generated for Order #89	2025-09-08 12:14:17.397506	2025-09-08 12:14:17.397521
85	90	INV-20250908-0002	53200.00	0.00	0.00	53200.00	pending	2025-10-08 13:35:53.167784	Invoice generated for Order #90	2025-09-08 13:35:53.168884	2025-09-08 13:35:53.168891
86	91	INV-20250908-0003	150.00	0.00	0.00	150.00	pending	2025-10-08 13:36:53.309884	Invoice generated for Order #91	2025-09-08 13:36:53.311514	2025-09-08 13:36:53.311521
87	92	INV-20250908-0004	2230.00	0.00	0.00	2230.00	pending	2025-10-08 17:04:49.439047	Invoice generated for Order #92	2025-09-08 17:04:49.440192	2025-09-08 17:04:49.440199
88	94	INV-20250909-0001	7700.00	0.00	0.00	7700.00	pending	2025-10-09 13:22:20.993501	Invoice generated for Order #94	2025-09-09 13:22:20.995192	2025-09-09 13:22:20.995206
89	95	INV-20250909-0002	150.00	0.00	0.00	150.00	pending	2025-10-09 13:24:24.589833	Invoice generated for Order #95	2025-09-09 13:24:24.591415	2025-09-09 13:24:24.591423
90	96	INV-20250909-0003	1840.00	0.00	0.00	1840.00	pending	2025-10-09 14:41:40.484731	Invoice generated for Order #96	2025-09-09 14:41:40.486198	2025-09-09 14:41:40.48621
91	97	INV-20250909-0004	38350.00	0.00	0.00	38350.00	pending	2025-10-09 14:58:17.793698	Invoice generated for Order #97	2025-09-09 14:58:17.794849	2025-09-09 14:58:17.794859
93	99	INV-20250909-0006	1970.00	0.00	0.00	1970.00	pending	2025-10-09 15:54:13.163841	Invoice generated for Order #99	2025-09-09 15:54:13.165415	2025-09-09 15:54:13.165422
98	104	INV-20250910-0004	8110.00	0.00	0.00	8110.00	pending	2025-10-10 15:21:54.726978	Invoice generated for Order #104	2025-09-10 15:21:54.728268	2025-09-10 15:21:54.728275
100	106	INV-20250911-0002	8100.00	0.00	0.00	8100.00	pending	2025-10-11 13:36:00.412313	Invoice generated for Order #106	2025-09-11 13:36:00.413536	2025-09-11 13:36:00.413544
102	108	INV-20250911-0004	700.00	0.00	0.00	700.00	pending	2025-10-11 15:33:06.202866	Invoice generated for Order #108	2025-09-11 15:33:06.204198	2025-09-11 15:33:06.204253
94	100	INV-20250910-0001	8500.00	0.00	0.00	8500.00	pending	2025-10-10 06:51:22.878791	Invoice generated for Order #100	2025-09-10 06:51:22.879887	2025-09-10 06:51:22.8799
96	102	INV-20250910-0003	1550.00	0.00	0.00	1550.00	pending	2025-10-10 13:19:15.607057	Invoice generated for Order #102	2025-09-10 13:19:15.608589	2025-09-10 13:19:15.608601
101	107	INV-20250911-0003	600.00	0.00	0.00	600.00	pending	2025-10-11 15:19:22.855706	Invoice generated for Order #107	2025-09-11 15:19:22.857633	2025-09-11 15:19:22.857647
104	110	INV-20250912-0001	1700.00	0.00	0.00	1700.00	pending	2025-10-12 13:30:35.196098	Invoice generated for Order #110	2025-09-12 13:30:35.197964	2025-09-12 13:30:35.197977
106	112	INV-20250912-0003	2900.00	0.00	0.00	2900.00	pending	2025-10-12 15:39:08.526655	Invoice generated for Order #112	2025-09-12 15:39:08.528403	2025-09-12 15:39:08.528416
108	114	INV-20250913-0002	2920.00	0.00	0.00	2920.00	pending	2025-10-13 10:26:51.36965	Invoice generated for Order #114	2025-09-13 10:26:51.371383	2025-09-13 10:26:51.371402
109	115	INV-20250913-0003	2500.00	0.00	0.00	2500.00	pending	2025-10-13 10:33:14.063187	Invoice generated for Order #115	2025-09-13 10:33:14.06479	2025-09-13 10:33:14.064802
111	117	INV-20250913-0005	36200.00	0.00	0.00	36200.00	pending	2025-10-13 11:32:27.341612	Invoice generated for Order #117	2025-09-13 11:32:27.34324	2025-09-13 11:32:27.343252
95	101	INV-20250910-0002	29000.00	0.00	0.00	29000.00	pending	2025-10-10 09:24:32.363928	Invoice generated for Order #101	2025-09-10 09:24:32.36576	2025-09-10 09:24:32.365768
99	105	INV-20250911-0001	1800.00	0.00	0.00	1800.00	pending	2025-10-11 13:17:07.568878	Invoice generated for Order #105	2025-09-11 13:17:07.571129	2025-09-11 13:17:07.57114
105	111	INV-20250912-0002	2550.00	0.00	0.00	2550.00	pending	2025-10-12 13:34:20.578054	Invoice generated for Order #111	2025-09-12 13:34:20.579392	2025-09-12 13:34:20.579399
107	113	INV-20250913-0001	1080.00	0.00	0.00	1080.00	pending	2025-10-13 07:17:51.988832	Invoice generated for Order #113	2025-09-13 07:17:51.990407	2025-09-13 07:17:51.990414
110	116	INV-20250913-0004	6500.00	0.00	0.00	6500.00	pending	2025-10-13 11:25:02.64722	Invoice generated for Order #116	2025-09-13 11:25:02.649331	2025-09-13 11:25:02.649341
112	118	INV-20250913-0006	910.00	0.00	0.00	910.00	pending	2025-10-13 13:07:35.19106	Invoice generated for Order #118	2025-09-13 13:07:35.191973	2025-09-13 13:07:35.191979
114	120	INV-20250915-0001	21600.00	0.00	0.00	21600.00	pending	2025-10-15 12:44:15.853547	Invoice generated for Order #120	2025-09-15 12:44:15.856556	2025-09-15 12:44:15.856564
115	121	INV-20250915-0002	1000.00	0.00	0.00	1000.00	pending	2025-10-15 12:47:38.990199	Invoice generated for Order #121	2025-09-15 12:47:38.992971	2025-09-15 12:47:38.992984
116	122	INV-20250915-0003	2000.00	0.00	0.00	2000.00	pending	2025-10-15 12:50:15.914425	Invoice generated for Order #122	2025-09-15 12:50:15.915517	2025-09-15 12:50:15.915523
117	123	INV-20250915-0004	5280.00	0.00	0.00	5280.00	pending	2025-10-15 13:47:06.840997	Invoice generated for Order #123	2025-09-15 13:47:06.84512	2025-09-15 13:47:06.845129
118	124	INV-20250915-0005	2000.00	0.00	0.00	2000.00	pending	2025-10-15 13:49:16.905904	Invoice generated for Order #124	2025-09-15 13:49:16.906784	2025-09-15 13:49:16.906791
119	125	INV-20250915-0006	270950.00	0.00	0.00	270950.00	pending	2025-10-15 14:43:48.582333	Invoice generated for Order #125	2025-09-15 14:43:48.584392	2025-09-15 14:43:48.584402
120	126	INV-20250915-0007	2000.00	0.00	0.00	2000.00	pending	2025-10-15 14:48:49.186941	Invoice generated for Order #126	2025-09-15 14:48:49.189308	2025-09-15 14:48:49.189315
121	127	INV-20250915-0008	400.00	0.00	0.00	400.00	pending	2025-10-15 14:49:27.176129	Invoice generated for Order #127	2025-09-15 14:49:27.17744	2025-09-15 14:49:27.177447
122	128	INV-20250915-0009	21390.00	0.00	0.00	21390.00	pending	2025-10-15 15:37:03.974273	Invoice generated for Order #128	2025-09-15 15:37:03.975571	2025-09-15 15:37:03.975578
\.


--
-- Data for Name: orderitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderitems (id, orderid, productid, quantity, buying_price, original_price, negotiated_price, final_price, negotiation_notes, created_at, updated_at, product_name) FROM stdin;
497	75	\N	5.00	1350.00	1650.00	\N	1650.00		2025-09-05 14:39:08.669667	2025-09-05 14:39:08.669683	Kitchen sink SBSD
498	75	143	5.00	180.00	300.00	\N	300.00		2025-09-05 14:39:08.70481	2025-09-05 14:39:08.704824	Magic 4'' Kenplastic 
499	75	164	10.00	120.00	250.00	\N	250.00		2025-09-05 14:39:08.71871	2025-09-05 14:39:08.718733	Soap Dish
500	75	\N	5.00	90.00	150.00	\N	150.00		2025-09-05 14:39:08.718734	2025-09-05 14:39:08.718736	Gi stand pipe 1 1/2
501	75	601	5.00	380.00	700.00	600.00	600.00		2025-09-05 14:39:08.731869	2025-09-05 14:39:08.731886	Wall Knob Short Neck Lirlee
502	75	551	15.00	140.00	300.00	\N	300.00		2025-09-05 14:39:08.740172	2025-09-05 14:39:08.740191	Ezuri Single Valve
64	26	539	14.00	240.00	240.00	350.00	350.00		2025-08-26 13:32:06.094503	2025-08-26 13:32:06.094518	\N
65	26	598	14.00	700.00	700.00	850.00	850.00		2025-08-26 13:32:06.10236	2025-08-26 13:32:06.102417	\N
72	30	157	8.00	2290.00	3500.00	3000.00	3000.00		2025-08-27 13:46:46.019928	2025-08-27 13:46:46.019941	Bathroom Accessory Set
73	31	\N	1.00	600.00	1300.00	\N	1300.00		2025-08-27 13:50:20.91806	2025-08-27 13:50:20.918071	1*4 Crown Paint
75	33	47	1.00	1200.00	2500.00	1750.00	1750.00		2025-08-27 14:02:53.34983	2025-08-27 14:02:53.349866	Basin Mixer Lirlee
76	33	150	1.00	190.00	350.00	200.00	200.00		2025-08-27 14:02:53.370843	2025-08-27 14:02:53.370869	Magic 1 1/4'' chrome
77	33	\N	1.00	3800.00	4850.00	\N	4850.00		2025-08-27 14:02:53.370874	2025-08-27 14:02:53.370876	Counter basin zaba
78	34	\N	1.00	250.00	450.00	\N	450.00		2025-08-27 14:04:36.651529	2025-08-27 14:04:36.651573	Pop up 1 1/2
79	35	\N	11.00	1380.00	1500.00	\N	1500.00		2025-08-28 08:10:10.608247	2025-08-28 08:10:10.60826	Sbsd white
80	35	\N	1.00	1050.00	1200.00	\N	1200.00		2025-08-28 08:10:10.608262	2025-08-28 08:10:10.608263	Square bowl white
81	36	379	1.00	170.00	280.00	250.00	250.00		2025-08-28 12:33:40.417974	2025-08-28 12:33:40.417995	FLOOR TRAP 4 WAY PVC 
82	36	368	4.00	25.00	50.00	\N	50.00		2025-08-28 12:33:40.428621	2025-08-28 12:33:40.428637	PVC BEND 1 1/2*90
83	36	360	4.00	90.00	150.00	\N	150.00		2025-08-28 12:33:40.438939	2025-08-28 12:33:40.43896	PVC BEND 4*90
84	36	\N	2.00	1000.00	1300.00	\N	1300.00		2025-08-28 12:33:40.438964	2025-08-28 12:33:40.438966	PVC pipe
85	36	\N	2.00	30.00	50.00	\N	50.00		2025-08-28 12:33:40.438969	2025-08-28 12:33:40.438971	Ppr over bend
86	36	328	7.00	20.00	40.00	\N	40.00		2025-08-28 12:33:40.451511	2025-08-28 12:33:40.451528	F|Elbow 25*1/2
87	36	362	1.00	200.00	350.00	\N	350.00		2025-08-28 12:33:40.462749	2025-08-28 12:33:40.462772	Double Elbow 25*1/2
88	36	\N	1.00	700.00	4000.00	\N	4000.00		2025-08-28 12:33:40.462776	2025-08-28 12:33:40.462779	Stop cork cobra
89	36	\N	2.00	20.00	50.00	\N	50.00		2025-08-28 12:33:40.462782	2025-08-28 12:33:40.462786	Male socket
90	36	335	15.00	8.00	20.00	\N	20.00		2025-08-28 12:33:40.472544	2025-08-28 12:33:40.47256	PPR Elbow 25''
91	36	352	6.00	10.00	25.00	20.00	20.00		2025-08-28 12:33:40.478913	2025-08-28 12:33:40.478931	PPR Tee 25mm
92	36	242	15.00	5.00	20.00	\N	20.00		2025-08-28 12:33:40.486513	2025-08-28 12:33:40.486534	PPR Socket 25mm
93	36	\N	20.00	300.00	400.00	\N	400.00		2025-08-28 12:33:40.486538	2025-08-28 12:33:40.48654	Ppr pipe danco
94	36	\N	10.00	16.00	30.00	\N	30.00		2025-08-28 12:33:40.486542	2025-08-28 12:33:40.486545	Gi cup plug
95	36	\N	10.00	16.00	30.00	\N	30.00		2025-08-28 12:33:40.486548	2025-08-28 12:33:40.48655	Gi socket
96	36	585	4.00	55.00	100.00	\N	100.00		2025-08-28 12:33:40.497615	2025-08-28 12:33:40.497635	Big Thread Tape
97	36	\N	11.00	1800.00	2400.00	\N	2400.00		2025-08-28 12:33:40.49764	2025-08-28 12:33:40.497643	PVC pipe 6”
98	36	\N	1.00	90.00	180.00	190.00	190.00		2025-08-28 12:33:40.497645	2025-08-28 12:33:40.497648	Gulley Trap 4”
99	36	378	1.00	160.00	250.00	\N	250.00		2025-08-28 12:33:40.506597	2025-08-28 12:33:40.506613	PVC INSPECTION BEND 4 INCH
100	36	\N	4.00	350.00	450.00	\N	450.00		2025-08-28 12:33:40.506615	2025-08-28 12:33:40.506616	PVC pipe 2”
101	36	367	6.00	30.00	60.00	\N	60.00		2025-08-28 12:33:40.514681	2025-08-28 12:33:40.514705	PVC BEND 2*45
102	36	374	2.00	40.00	70.00	80.00	80.00		2025-08-28 12:33:40.521912	2025-08-28 12:33:40.521923	PVC TEE 2 INCH
103	36	389	3.00	30.00	60.00	50.00	50.00		2025-08-28 12:33:40.526909	2025-08-28 12:33:40.526924	PVC PLUG 2 INCH
104	36	\N	1.00	280.00	400.00	\N	400.00		2025-08-28 12:33:40.526927	2025-08-28 12:33:40.526929	PVC pipe 1 1/2
105	36	\N	1.00	700.00	800.00	\N	800.00		2025-08-28 12:33:40.526932	2025-08-28 12:33:40.526934	Tangit
106	36	\N	1.00	350.00	450.00	460.00	460.00		2025-08-28 12:33:40.526936	2025-08-28 12:33:40.526938	Garden tap
107	36	\N	1.00	330.00	500.00	\N	500.00		2025-08-28 12:33:40.526941	2025-08-28 12:33:40.526943	Gate valve 1/2
108	37	474	1.00	1200.00	2800.00	2500.00	2500.00		2025-08-28 12:39:43.093541	2025-08-28 12:39:43.093559	JUMBO SERVIETTE LIRLEE
109	37	397	1.00	600.00	1800.00	\N	1800.00		2025-08-28 12:39:43.099876	2025-08-28 12:39:43.099891	MIRROR
110	38	143	1.00	180.00	300.00	\N	300.00		2025-08-28 13:06:41.555359	2025-08-28 13:06:41.555375	Magic 4'' Kenplastic 
111	38	\N	1.00	8000.00	8500.00	\N	8500.00		2025-08-28 13:06:41.555377	2025-08-28 13:06:41.555378	Closed couple half set orient
112	38	209	1.00	165.00	450.00	\N	450.00		2025-08-28 13:06:41.563133	2025-08-28 13:06:41.563144	Tissue Holder
113	38	\N	1.00	180.00	350.00	\N	350.00		2025-08-28 13:06:41.563146	2025-08-28 13:06:41.563147	Tile cleaner 1l
114	39	157	1.00	2290.00	3500.00	3000.00	3000.00		2025-08-28 13:56:14.345569	2025-08-28 13:56:14.345581	Bathroom Accessory Set
115	40	177	1.00	1200.00	2500.00	1800.00	1800.00		2025-08-28 14:55:17.410055	2025-08-28 14:55:17.410101	FAME BIG 
116	41	\N	2.00	150.00	150.00	200.00	200.00		2025-08-29 13:17:32.61395	2025-08-29 13:17:32.613964	Flex Tube 2ft Yellow
122	46	\N	1.00	3600.00	4200.00	\N	4200.00		2025-08-30 10:48:43.189567	2025-08-30 10:48:43.189579	Cover coat
123	47	\N	1.00	4000.00	5500.00	\N	5500.00		2025-08-30 11:02:46.356222	2025-08-30 11:02:46.356234	Ks1250XI
124	48	\N	1.00	180.00	300.00	\N	300.00		2025-08-30 11:09:43.734751	2025-08-30 11:09:43.734763	Magic flex
125	48	\N	1.00	15800.00	17800.00	\N	17800.00		2025-08-30 11:09:43.734764	2025-08-30 11:09:43.734766	501
126	48	587	2.00	90.00	150.00	\N	150.00		2025-08-30 11:09:43.746712	2025-08-30 11:09:43.746726	Flex Tube 1 1/2ft Lirlee
127	48	588	1.00	120.00	200.00	\N	200.00		2025-08-30 11:09:43.752699	2025-08-30 11:09:43.752712	Flex Tube 2ft Lirlee
128	48	545	1.00	180.00	450.00	400.00	400.00		2025-08-30 11:09:43.758979	2025-08-30 11:09:43.758993	Single Valve
129	48	\N	2.00	1485.00	2200.00	\N	2200.00		2025-08-30 11:09:43.758996	2025-08-30 11:09:43.758999	Pillar Tap
130	48	\N	1.00	11700.00	15500.00	\N	15500.00		2025-08-30 11:09:43.759001	2025-08-30 11:09:43.759004	Cabinet
131	48	\N	1.00	11170.00	15500.00	\N	15500.00		2025-08-30 11:09:43.759006	2025-08-30 11:09:43.759008	Cabinet gray
132	48	149	2.00	190.00	450.00	400.00	400.00		2025-08-30 11:09:43.76588	2025-08-30 11:09:43.765893	Magic 11/4'' grey
133	49	\N	1.00	900.00	1000.00	\N	1000.00		2025-08-30 11:44:30.838065	2025-08-30 11:44:30.838073	Moment lock
134	49	\N	1.00	60.00	110.00	\N	110.00		2025-08-30 11:44:30.838075	2025-08-30 11:44:30.838076	Window handle
135	50	\N	2.00	1045.00	1500.00	\N	1500.00		2025-08-30 11:46:41.447434	2025-08-30 11:46:41.447442	Tile
136	51	\N	1.00	60.00	110.00	\N	110.00		2025-08-30 11:47:51.375546	2025-08-30 11:47:51.375555	Window handle
140	53	432	1.00	615.00	1200.00	900.00	900.00		2025-09-01 13:29:45.449477	2025-09-01 13:29:45.449488	HOOKS
141	54	\N	1.00	9700.00	13500.00	\N	13500.00		2025-09-01 13:38:35.952705	2025-09-01 13:38:35.952718	Cabinet K9112
144	52	\N	400.00	100.00	140.00	\N	140.00		2025-09-01 14:30:29.428657	2025-09-01 14:30:29.428681	PPR M/ADAPTER 25MMX 3/4 (WHITE)
146	56	\N	2.00	1300.00	1900.00	\N	1900.00		2025-09-02 13:23:00.307813	2025-09-02 13:23:00.307834	PQA503c
147	56	\N	1.00	17955.00	20000.00	\N	20000.00		2025-09-02 13:23:00.307836	2025-09-02 13:23:00.307838	6224toilet+828half pedestal
148	56	531	1.00	1265.00	2500.00	2000.00	2000.00		2025-09-02 13:23:00.316666	2025-09-02 13:23:00.316677	RECTANGULAR/GLASS SHELVES
149	56	202	1.00	500.00	900.00	1000.00	1000.00		2025-09-02 13:23:00.320784	2025-09-02 13:23:00.320794	Phone Tissue Silver
150	56	149	1.00	190.00	450.00	400.00	400.00		2025-09-02 13:23:00.324476	2025-09-02 13:23:00.324484	Magic 11/4'' grey
151	56	\N	1.00	650.00	1000.00	\N	1000.00		2025-09-02 13:23:00.324486	2025-09-02 13:23:00.324487	Magic 4”Europlus
152	56	\N	1.00	4500.00	5500.00	\N	5500.00		2025-09-02 13:23:00.324488	2025-09-02 13:23:00.324489	Huma LED mirror
153	56	595	2.00	90.00	200.00	\N	200.00		2025-09-02 13:23:00.328775	2025-09-02 13:23:00.328784	Flex Tube 1 1/2ft Italy
154	56	551	2.00	140.00	300.00	\N	300.00		2025-09-02 13:23:00.33256	2025-09-02 13:23:00.332569	Ezuri Single Valve
155	56	\N	1.00	600.00	1000.00	\N	1000.00		2025-09-02 13:23:00.332573	2025-09-02 13:23:00.332575	2201
156	56	\N	1.00	5800.00	6800.00	\N	6800.00		2025-09-02 13:23:00.332577	2025-09-02 13:23:00.332579	216 kitchen sink
157	56	\N	1.00	2300.00	3300.00	\N	3300.00		2025-09-02 13:23:00.332582	2025-09-02 13:23:00.332584	Kitchen mixer 6016H
158	56	430	1.00	350.00	350.00	700.00	700.00		2025-09-02 13:23:00.342696	2025-09-02 13:23:00.342708	TOWEL RING
159	56	447	1.00	340.00	650.00	550.00	550.00		2025-09-02 13:23:00.345868	2025-09-02 13:23:00.345874	HOOKS
160	56	461	1.00	575.00	1200.00	1000.00	1000.00		2025-09-02 13:23:00.348754	2025-09-02 13:23:00.348759	TOILET BRUSH
161	56	557	1.00	385.00	1500.00	1000.00	1000.00		2025-09-02 13:23:00.35152	2025-09-02 13:23:00.351527	GRAB BAR
503	75	154	5.00	140.00	250.00	\N	250.00		2025-09-05 14:39:08.74795	2025-09-05 14:39:08.747967	Viega 11/2''
504	75	\N	2.00	95.00	200.00	\N	200.00		2025-09-05 14:39:08.74797	2025-09-05 14:39:08.747972	White Boss
505	75	566	10.00	310.00	450.00	500.00	500.00		2025-09-05 14:39:08.757319	2025-09-05 14:39:08.757333	Silicone Hytech Clear
165	58	44	1.00	9600.00	11600.00	15000.00	15000.00		2025-09-02 13:25:47.897136	2025-09-02 13:25:47.897145	CABINET
166	58	146	1.00	180.00	450.00	350.00	350.00		2025-09-02 13:25:47.899998	2025-09-02 13:25:47.900004	Magic 11/2'' grey
167	58	55	1.00	1300.00	3500.00	3000.00	3000.00		2025-09-02 13:25:47.902344	2025-09-02 13:25:47.90235	Basin Mixer
168	59	\N	1.00	7000.00	7500.00	\N	7500.00		2025-09-02 13:29:49.889284	2025-09-02 13:29:49.889296	7843S kitchen sink
169	59	601	1.00	380.00	700.00	600.00	600.00		2025-09-02 13:29:49.895017	2025-09-02 13:29:49.895028	Wall Knob Short Neck Lirlee
170	59	\N	1.00	1460.00	2000.00	\N	2000.00		2025-09-02 13:29:49.895031	2025-09-02 13:29:49.895033	KS9044
171	57	\N	1.00	20050.00	21500.00	\N	21500.00		2025-09-02 13:30:32.962727	2025-09-02 13:30:32.962741	Toilet 0805+778basin
172	57	\N	1.00	16850.00	18400.00	\N	18400.00		2025-09-02 13:30:32.962744	2025-09-02 13:30:32.962747	Toilet 8078+778 basin
173	57	\N	1.00	2500.00	4500.00	\N	4500.00		2025-09-02 13:30:32.96275	2025-09-02 13:30:32.962752	314 Dinning sink
174	60	593	2.00	50.00	100.00	\N	100.00		2025-09-02 13:59:03.766546	2025-09-02 13:59:03.766564	Flex Tube 1 1/2ft Brazil
175	61	\N	1.00	140.00	300.00	\N	300.00		2025-09-02 14:00:45.50738	2025-09-02 14:00:45.507399	Angle valve Ezuri
176	62	457	2.00	800.00	1500.00	1300.00	1300.00		2025-09-03 13:06:13.812705	2025-09-03 13:06:13.812742	Horizon Instant
177	62	\N	2.00	2900.00	3500.00	4375.00	4375.00		2025-09-03 13:06:13.812749	2025-09-03 13:06:13.812751	Mfd board
178	62	\N	12.00	60.00	70.00	\N	70.00		2025-09-03 13:06:13.812753	2025-09-03 13:06:13.812756	Drawer knobs
179	62	\N	18.00	100.00	150.00	\N	150.00		2025-09-03 13:06:13.812758	2025-09-03 13:06:13.81276	Hydraulic malpha
180	62	\N	2.00	700.00	1000.00	\N	1000.00		2025-09-03 13:06:13.812762	2025-09-03 13:06:13.812764	Moment locks
181	62	\N	7.00	80.00	120.00	\N	120.00		2025-09-03 13:06:13.812767	2025-09-03 13:06:13.812768	Window fastener
182	62	\N	1.00	100.00	200.00	\N	200.00		2025-09-03 13:06:13.812771	2025-09-03 13:06:13.812773	1 Gang switch
183	62	\N	1.00	140.00	250.00	\N	250.00		2025-09-03 13:06:13.812775	2025-09-03 13:06:13.812776	2 Gang switch
184	62	\N	1.00	50.00	250.00	\N	250.00		2025-09-03 13:06:13.812777	2025-09-03 13:06:13.812778	Bulb holder
185	63	600	2.00	380.00	700.00	500.00	500.00		2025-09-03 13:25:33.881616	2025-09-03 13:25:33.881633	Wall Knob Long Neck Jawa
186	63	\N	1.00	380.00	500.00	\N	500.00		2025-09-03 13:25:33.881636	2025-09-03 13:25:33.881637	Longneck star lirlee
187	64	\N	1.00	1800.00	2200.00	\N	2200.00		2025-09-03 13:45:12.135948	2025-09-03 13:45:12.135965	Silk soft white 4litre
188	64	\N	10.00	100.00	120.00	\N	120.00		2025-09-03 13:45:12.135969	2025-09-03 13:45:12.135972	Wall filler
189	64	\N	1.00	200.00	250.00	\N	250.00		2025-09-03 13:45:12.135976	2025-09-03 13:45:12.135979	Paint brush 6”
190	64	\N	1.00	150.00	250.00	\N	250.00		2025-09-03 13:45:12.135982	2025-09-03 13:45:12.135985	Paint roller
506	75	585	11.00	55.00	100.00	\N	100.00		2025-09-05 14:39:08.764136	2025-09-05 14:39:08.764155	Big Thread Tape
507	75	\N	15.00	16.00	30.00	\N	30.00		2025-09-05 14:39:08.764159	2025-09-05 14:39:08.764162	Gi nipple 1/2
193	67	\N	1.00	1100.00	2000.00	\N	2000.00		2025-09-04 13:17:45.000999	2025-09-04 13:17:45.001017	Gjs lock
194	69	152	1.00	140.00	250.00	\N	250.00		2025-09-04 13:21:02.294445	2025-09-04 13:21:02.294458	Viega 11/4
195	69	89	1.00	380.00	700.00	500.00	500.00		2025-09-04 13:21:02.297996	2025-09-04 13:21:02.298002	PILLAR TAP KNOB Jawa
196	69	\N	1.00	1000.00	1350.00	\N	1350.00		2025-09-04 13:21:02.298004	2025-09-04 13:21:02.298005	Wash basin 018H blossom
197	70	\N	2.00	750.00	1250.00	\N	1250.00		2025-09-04 13:21:22.350349	2025-09-04 13:21:22.350356	Grey metal Primer
198	71	\N	2.00	290.00	550.00	\N	550.00		2025-09-04 13:45:05.362094	2025-09-04 13:45:05.36212	Soap Dish K29
199	72	656	2.00	120.00	120.00	220.00	220.00		2025-09-04 13:46:08.85387	2025-09-04 13:46:08.853881	2 GANG 2-WAY GREY M1
200	72	667	14.00	220.00	220.00	280.00	280.00		2025-09-04 13:46:08.857151	2025-09-04 13:46:08.857157	T-S NORMAL D/GY
201	72	663	11.00	120.00	120.00	220.00	220.00		2025-09-04 13:46:08.859535	2025-09-04 13:46:08.85954	T-S SINGLE GREY M1
202	73	625	2.00	3000.00	4500.00	3500.00	3500.00		2025-09-05 09:02:31.77797	2025-09-05 09:02:31.778004	CN013-200W FLOOD LIGHT SOLAR
203	74	\N	21.00	450.00	800.00	\N	800.00		2025-09-05 12:13:55.187183	2025-09-05 12:13:55.187201	Arabic shower
204	74	617	15.00	180.00	350.00	320.00	320.00		2025-09-05 12:13:55.191402	2025-09-05 12:13:55.191408	Soap Dish Small Silver
205	74	529	15.00	765.00	1500.00	1200.00	1200.00		2025-09-05 12:13:55.194653	2025-09-05 12:13:55.19466	RECTANGULAR/GLASS SHELVES
206	74	218	15.00	480.00	750.00	650.00	650.00		2025-09-05 12:13:55.197661	2025-09-05 12:13:55.197665	Single Towel Bar Silver
207	74	430	21.00	350.00	350.00	620.00	620.00		2025-09-05 12:13:55.201506	2025-09-05 12:13:55.201512	TOWEL RING
208	74	452	21.00	725.00	1500.00	1200.00	1200.00		2025-09-05 12:13:55.204492	2025-09-05 12:13:55.204498	TOILET BRUSH
209	74	466	15.00	450.00	650.00	600.00	600.00		2025-09-05 12:13:55.208419	2025-09-05 12:13:55.208429	SINGLE TOOTH BRUSH HOLDER 
210	74	196	21.00	180.00	350.00	320.00	320.00		2025-09-05 12:13:55.211499	2025-09-05 12:13:55.211507	Europenize  Tissue Holder Silver 
508	75	\N	5.00	20.00	50.00	\N	50.00		2025-09-05 14:39:08.764165	2025-09-05 14:39:08.764167	PVC reducer 2x1 1/2
509	75	\N	15.00	16.00	30.00	\N	30.00		2025-09-05 14:39:08.76417	2025-09-05 14:39:08.764172	Gi socket 1/2
510	75	581	10.00	60.00	150.00	\N	150.00		2025-09-05 14:39:08.772255	2025-09-05 14:39:08.772272	Basin Screw
511	75	\N	2.00	80.00	130.00	\N	130.00		2025-09-05 14:39:08.772273	2025-09-05 14:39:08.772274	Hacksaw blade
512	75	380	5.00	160.00	230.00	\N	230.00		2025-09-05 14:39:08.780762	2025-09-05 14:39:08.780777	FLOOR TRAP 1WAY PVC 
513	75	\N	1.00	20.00	59.00	50.00	50.00		2025-09-05 14:39:08.780779	2025-09-05 14:39:08.780781	F|Socket 25*1/2
514	75	335	18.00	8.00	20.00	\N	20.00		2025-09-05 14:39:08.790631	2025-09-05 14:39:08.790652	PPR Elbow 25''
515	75	148	5.00	90.00	200.00	150.00	150.00		2025-09-05 14:39:08.803155	2025-09-05 14:39:08.803174	Magic 11/2'' Kenplastic 
516	75	\N	8.00	800.00	1100.00	\N	1100.00		2025-09-05 14:39:08.803178	2025-09-05 14:39:08.80318	Locks
517	75	\N	12.00	130.00	170.00	\N	170.00		2025-09-05 14:39:08.803186	2025-09-05 14:39:08.803188	Hinges
518	75	\N	20.00	2900.00	3000.00	\N	3000.00		2025-09-05 14:39:08.80319	2025-09-05 14:39:08.803192	MDF Boards
519	75	\N	40.00	100.00	150.00	\N	150.00		2025-09-05 14:39:08.803194	2025-09-05 14:39:08.803196	Hydraulic malpha hinges
520	75	\N	35.00	70.00	100.00	\N	100.00		2025-09-05 14:39:08.803198	2025-09-05 14:39:08.8032	Handler silver
521	75	\N	8.00	220.00	300.00	\N	300.00		2025-09-05 14:39:08.803202	2025-09-05 14:39:08.803204	MDF 2” screws
522	75	\N	1.00	1350.00	1550.00	\N	1550.00		2025-09-05 14:39:08.803206	2025-09-05 14:39:08.803208	Sand paper p80
523	75	\N	3.00	160.00	200.00	250.00	250.00		2025-09-05 14:39:08.80321	2025-09-05 14:39:08.803212	Nails 3”
524	75	\N	3.00	160.00	200.00	\N	200.00		2025-09-05 14:39:08.803214	2025-09-05 14:39:08.803216	Nails 4”
525	75	\N	3.00	150.00	250.00	\N	250.00		2025-09-05 14:39:08.803219	2025-09-05 14:39:08.80322	Steel nails
526	75	\N	1.00	7200.00	8200.00	\N	8200.00		2025-09-05 14:39:08.803222	2025-09-05 14:39:08.803224	Pedrollo pump
527	75	\N	1.00	1750.00	2500.00	\N	2500.00		2025-09-05 14:39:08.803226	2025-09-05 14:39:08.803228	Matt Pressure controller
528	75	\N	6.00	40.00	60.00	\N	60.00		2025-09-05 14:39:08.80323	2025-09-05 14:39:08.803232	M|socket 1”
529	75	\N	1.00	465.00	650.00	\N	650.00		2025-09-05 14:39:08.803234	2025-09-05 14:39:08.803235	Ppr pipe danco 1”
530	75	\N	3.00	300.00	450.00	\N	450.00		2025-09-05 14:39:08.803237	2025-09-05 14:39:08.803239	Ppr pipe danco 3/4”
531	75	336	6.00	12.00	30.00	50.00	50.00		2025-09-05 14:39:08.815815	2025-09-05 14:39:08.815833	PPR Elbow 32''
532	75	359	2.00	25.00	80.00	60.00	60.00		2025-09-05 14:39:08.824791	2025-09-05 14:39:08.824811	PPR Union 32mm
533	75	607	1.00	430.00	700.00	705.00	705.00		2025-09-05 14:39:08.840362	2025-09-05 14:39:08.840394	Gate Valve 3/4 lirlee
534	75	\N	1.00	20.00	40.00	\N	40.00		2025-09-05 14:39:08.840398	2025-09-05 14:39:08.8404	Ppr reducer 3/4”
535	75	\N	4.00	9.00	20.00	\N	20.00		2025-09-05 14:39:08.840404	2025-09-05 14:39:08.840406	Ppr elbow 3/4
536	75	\N	1.00	25.00	60.00	\N	60.00		2025-09-05 14:39:08.840408	2025-09-05 14:39:08.84041	F|Elbow
537	75	\N	2.00	30.00	60.00	\N	60.00		2025-09-05 14:39:08.840412	2025-09-05 14:39:08.840415	M|Socket 3/4*3/4
538	75	\N	3.00	6.00	20.00	\N	20.00		2025-09-05 14:39:08.840418	2025-09-05 14:39:08.84042	Ppr socket 3/4
539	75	\N	5.00	8500.00	9500.00	\N	9500.00		2025-09-05 14:39:08.840422	2025-09-05 14:39:08.840424	Closed couple complet set
540	75	\N	15.00	120.00	170.00	\N	170.00		2025-09-05 14:39:08.840426	2025-09-05 14:39:08.840428	Aluminum corner strip
541	75	\N	1.00	900.00	1300.00	\N	1300.00		2025-09-05 14:39:08.84043	2025-09-05 14:39:08.840432	Gate valve 1”
542	75	\N	8.00	2800.00	3000.00	\N	3000.00	\N	2025-09-05 14:39:08.840435	2025-09-05 14:39:08.840436	Flush Door
595	87	\N	1.00	3500.00	3900.00	\N	3900.00		2025-09-06 16:28:46.073359	2025-09-06 16:28:46.073361	Snake light
596	89	\N	75.00	4000.00	5200.00	\N	5200.00		2025-09-08 12:14:17.383144	2025-09-08 12:14:17.383159	KS6045S SINGLE BOWL (GRILL WITH FITTINGS)
699	101	\N	6.00	20.00	40.00	\N	40.00		2025-09-10 09:24:32.319728	2025-09-10 09:24:32.319744	M/adpter 20*1/2
700	101	\N	4.00	6.00	20.00	\N	20.00		2025-09-10 09:24:32.319746	2025-09-10 09:24:32.319747	Per elbow 20mm
701	101	585	4.00	55.00	100.00	\N	100.00		2025-09-10 09:24:32.329491	2025-09-10 09:24:32.329503	Big Thread Tape
609	91	581	1.00	60.00	150.00	\N	150.00		2025-09-08 13:36:53.298317	2025-09-08 13:36:53.298327	Basin Screw
610	90	\N	1.00	4500.00	5500.00	\N	5500.00		2025-09-08 13:39:33.582586	2025-09-08 13:39:33.582602	Led mirror
611	90	\N	1.00	4800.00	6000.00	\N	6000.00		2025-09-08 13:39:33.582604	2025-09-08 13:39:33.582605	Dining sink synova
612	90	\N	1.00	11500.00	16000.00	\N	16000.00		2025-09-08 13:39:33.582607	2025-09-08 13:39:33.582608	Lirlee water Heater
613	90	592	3.00	60.00	150.00	\N	150.00		2025-09-08 13:39:33.596544	2025-09-08 13:39:33.596562	Flex Tube 2ft Brazil
614	90	143	2.00	180.00	300.00	\N	300.00		2025-09-08 13:39:33.6026	2025-09-08 13:39:33.602612	Magic 4'' Kenplastic 
615	90	\N	1.00	8645.00	10000.00	\N	10000.00		2025-09-08 13:39:33.602615	2025-09-08 13:39:33.602619	WC 009+326
616	90	149	2.00	190.00	450.00	400.00	400.00		2025-09-08 13:39:33.608445	2025-09-08 13:39:33.608456	Magic 11/4'' grey
617	90	553	1.00	95.00	200.00	\N	200.00		2025-09-08 13:39:33.613454	2025-09-08 13:39:33.61346	Jawa 
618	90	96	2.00	880.00	1800.00	1500.00	1500.00		2025-09-08 13:39:33.617513	2025-09-08 13:39:33.617519	PILLAR LEVER BIG 
619	90	\N	1.00	3300.00	7500.00	7300.00	7300.00		2025-09-08 13:39:33.617521	2025-09-08 13:39:33.617524	Kitchen mixer Ht 002
620	90	156	1.00	2035.00	3000.00	\N	3000.00		2025-09-08 13:39:33.623546	2025-09-08 13:39:33.623557	Bathroom Accessory Set
621	90	581	1.00	60.00	150.00	\N	150.00		2025-09-08 13:39:33.632464	2025-09-08 13:39:33.632471	Basin Screw
622	92	\N	1.00	130.00	200.00	\N	200.00		2025-09-08 17:04:49.414394	2025-09-08 17:04:49.414408	LED panel
623	92	636	30.00	50.00	75.00	60.00	60.00		2025-09-08 17:04:49.419836	2025-09-08 17:04:49.419847	1 GANG 2-WAY BAKELITE
624	92	641	1.00	160.00	250.00	230.00	230.00		2025-09-08 17:04:49.423366	2025-09-08 17:04:49.423373	T-S D-UNIVERSAL BAKELITE
625	94	\N	1.00	1300.00	1900.00	\N	1900.00		2025-09-09 13:22:20.951448	2025-09-09 13:22:20.951463	Plastic cistern frencia
626	94	557	2.00	385.00	1500.00	1300.00	1300.00		2025-09-09 13:22:20.97232	2025-09-09 13:22:20.97233	GRAB BAR
627	94	\N	1.00	725.00	1200.00	\N	1200.00		2025-09-09 13:22:20.972332	2025-09-09 13:22:20.972333	Toilet brush N146
628	94	\N	1.00	1750.00	2000.00	\N	2000.00		2025-09-09 13:22:20.972335	2025-09-09 13:22:20.972336	Step Asian blue
629	95	\N	1.00	100.00	150.00	\N	150.00		2025-09-09 13:24:24.535473	2025-09-09 13:24:24.535482	Hydraulic malpha hinges
630	96	151	1.00	90.00	200.00	150.00	150.00		2025-09-09 14:41:40.456048	2025-09-09 14:41:40.456058	Magic 11/4'' KenPlastic
631	96	89	1.00	380.00	700.00	600.00	600.00		2025-09-09 14:41:40.460522	2025-09-09 14:41:40.46053	PILLAR TAP KNOB Jawa
632	96	\N	1.00	320.00	600.00	\N	600.00		2025-09-09 14:41:40.460532	2025-09-09 14:41:40.460533	Seatcover
633	96	\N	2.00	90.00	130.00	\N	130.00		2025-09-09 14:41:40.460534	2025-09-09 14:41:40.460535	Left/right window
634	96	\N	1.00	50.00	100.00	\N	100.00		2025-09-09 14:41:40.460537	2025-09-09 14:41:40.460538	Draw handle
635	96	\N	1.00	80.00	130.00	\N	130.00		2025-09-09 14:41:40.460539	2025-09-09 14:41:40.46054	Long handle
636	97	\N	1.00	13800.00	15000.00	\N	15000.00		2025-09-09 14:58:17.738304	2025-09-09 14:58:17.738317	DYG+sink
637	97	156	1.00	2035.00	3000.00	\N	3000.00		2025-09-09 14:58:17.743412	2025-09-09 14:58:17.743422	Bathroom Accessory Set
638	97	47	1.00	1200.00	2500.00	1900.00	1900.00		2025-09-09 14:58:17.748086	2025-09-09 14:58:17.748094	Basin Mixer Lirlee
639	97	\N	1.00	180.00	300.00	\N	300.00		2025-09-09 14:58:17.748095	2025-09-09 14:58:17.748096	Magic 4
702	101	\N	2.00	20.00	50.00	\N	50.00		2025-09-10 09:24:32.329505	2025-09-10 09:24:32.329506	PVC bend 1/12
703	101	\N	1.00	250.00	400.00	\N	400.00		2025-09-10 09:24:32.329508	2025-09-10 09:24:32.329509	PVC pipe 1/12
704	101	\N	1.00	350.00	450.00	\N	450.00		2025-09-10 09:24:32.32951	2025-09-10 09:24:32.329511	Tangit
705	101	\N	2.00	8.00	20.00	\N	20.00		2025-09-10 09:24:32.329513	2025-09-10 09:24:32.329514	Per tee 20mm
706	101	\N	3.00	85.00	150.00	\N	150.00		2025-09-10 09:24:32.329515	2025-09-10 09:24:32.329516	PVC bend 4”
707	101	592	1.00	60.00	150.00	200.00	200.00		2025-09-10 09:24:32.338526	2025-09-10 09:24:32.33854	Flex Tube 2ft Brazil
708	101	\N	1.00	20.00	50.00	\N	50.00		2025-09-10 09:24:32.338541	2025-09-10 09:24:32.338543	PVC R/bush 2*11/2
709	101	\N	1.00	70.00	120.00	\N	120.00		2025-09-10 09:24:32.338544	2025-09-10 09:24:32.338545	Boss connector 4*11/2
710	101	\N	1.00	18.00	30.00	\N	30.00		2025-09-10 09:24:32.338547	2025-09-10 09:24:32.338548	Gi Tee 1/2
640	97	152	1.00	140.00	250.00	\N	250.00		2025-09-09 14:58:17.753604	2025-09-09 14:58:17.753615	Viega 11/4
641	97	395	1.00	900.00	2000.00	\N	2000.00		2025-09-09 14:58:17.757638	2025-09-09 14:58:17.757649	MIRROR
642	97	186	1.00	5000.00	10000.00	9000.00	9000.00		2025-09-09 14:58:17.762446	2025-09-09 14:58:17.762461	SHOWER RISER
643	97	587	1.00	90.00	150.00	\N	150.00		2025-09-09 14:58:17.767301	2025-09-09 14:58:17.767312	Flex Tube 1 1/2ft Lirlee
644	97	\N	3.00	1800.00	2200.00	\N	2200.00		2025-09-09 14:58:17.767314	2025-09-09 14:58:17.767315	Silk 4litres
645	97	\N	1.00	80.00	150.00	\N	150.00		2025-09-09 14:58:17.767316	2025-09-09 14:58:17.767318	Hydronic cocelled
678	99	636	20.00	50.00	75.00	60.00	60.00		2025-09-09 15:54:13.139763	2025-09-09 15:54:13.139775	1 GANG 2-WAY BAKELITE
679	99	\N	7.00	80.00	110.00	\N	110.00		2025-09-09 15:54:13.139776	2025-09-09 15:54:13.139778	Snake light
698	100	\N	1.00	6800.00	8500.00	\N	8500.00		2025-09-10 06:51:22.863841	2025-09-10 06:51:22.86386	Kitchen sink F02
711	101	296	1.00	2300.00	3300.00	10500.00	10500.00		2025-09-10 09:24:32.345865	2025-09-10 09:24:32.345879	Frencia Seat
712	101	\N	1.00	1100.00	1350.00	\N	1350.00		2025-09-10 09:24:32.34588	2025-09-10 09:24:32.345882	Small basin (orient)
713	101	\N	1.00	11000.00	15000.00	14590.00	14590.00		2025-09-10 09:24:32.345883	2025-09-10 09:24:32.345884	Heater
714	102	\N	2.00	55.00	100.00	\N	100.00		2025-09-10 13:19:15.587491	2025-09-10 13:19:15.587508	Drawer Handles
715	102	\N	3.00	100.00	150.00	\N	150.00		2025-09-10 13:19:15.58751	2025-09-10 13:19:15.587511	Hydraulic Malpha hinges
716	102	\N	1.00	190.00	250.00	\N	250.00		2025-09-10 13:19:15.587513	2025-09-10 13:19:15.587514	MDF screw 11/2
717	102	\N	1.00	200.00	250.00	\N	250.00		2025-09-10 13:19:15.587515	2025-09-10 13:19:15.587516	Steel nails
718	102	\N	1.00	260.00	400.00	\N	400.00		2025-09-10 13:19:15.587517	2025-09-10 13:19:15.587519	Chrome pipe 1
724	104	\N	2.00	80.00	130.00	\N	130.00		2025-09-10 15:21:54.698565	2025-09-10 15:21:54.69858	Oglex 9watts
725	104	\N	1.00	270.00	350.00	\N	350.00		2025-09-10 15:21:54.698583	2025-09-10 15:21:54.698585	15watt surface
726	104	\N	1.00	800.00	1200.00	\N	1200.00		2025-09-10 15:21:54.698587	2025-09-10 15:21:54.698589	50watts Ac led light
727	104	636	30.00	50.00	75.00	60.00	60.00		2025-09-10 15:21:54.706705	2025-09-10 15:21:54.706716	1 GANG 2-WAY BAKELITE
728	104	685	6.00	350.00	600.00	500.00	500.00		2025-09-10 15:21:54.711212	2025-09-10 15:21:54.711221	SPOTLIGHT
729	104	\N	1.00	1200.00	1500.00	\N	1500.00		2025-09-10 15:21:54.711224	2025-09-10 15:21:54.711226	Full moon
730	105	470	2.00	550.00	1000.00	900.00	900.00		2025-09-11 13:17:07.553147	2025-09-11 13:17:07.553159	Arabic New Black
731	106	\N	8.00	100.00	140.00	\N	140.00		2025-09-11 13:36:00.394494	2025-09-11 13:36:00.394507	Hydraulic Malpha hinges
732	106	\N	1.00	800.00	1100.00	\N	1100.00		2025-09-11 13:36:00.394509	2025-09-11 13:36:00.394511	GJS locks normal
733	106	\N	1.00	850.00	1100.00	\N	1100.00		2025-09-11 13:36:00.394512	2025-09-11 13:36:00.394513	GJS bathroom lock
734	106	\N	1.00	1250.00	1250.00	\N	1250.00		2025-09-11 13:36:00.394514	2025-09-11 13:36:00.394515	Lipping 50m
735	106	\N	3.00	120.00	180.00	\N	180.00		2025-09-11 13:36:00.394517	2025-09-11 13:36:00.394518	Steel hinges
543	76	625	3.00	3000.00	4500.00	3500.00	3500.00		2025-09-05 16:42:27.247164	2025-09-05 16:42:27.247176	CN013-200W FLOOD LIGHT SOLAR
544	76	677	1.00	450.00	600.00	500.00	500.00		2025-09-05 16:42:27.255375	2025-09-05 16:42:27.255386	DUST PROOF BRACKET
545	76	\N	1.00	350.00	500.00	\N	500.00		2025-09-05 16:42:27.255388	2025-09-05 16:42:27.255389	Snake light 5M
546	77	\N	5.00	2940.00	3300.00	\N	3300.00		2025-09-06 10:34:54.443622	2025-09-06 10:34:54.443634	Lorenzetti 4T
547	77	\N	8.00	280.00	400.00	\N	400.00		2025-09-06 10:34:54.443635	2025-09-06 10:34:54.443636	Plastic shower arm
548	78	\N	1.00	1750.00	2200.00	\N	2200.00		2025-09-06 10:35:47.788278	2025-09-06 10:35:47.788287	Pressure controller
549	78	\N	1.00	400.00	550.00	\N	550.00		2025-09-06 10:35:47.788288	2025-09-06 10:35:47.78829	Gi ball valve1/2
550	78	\N	2.00	15.00	35.00	\N	35.00		2025-09-06 10:35:47.788291	2025-09-06 10:35:47.788292	M/adapter 20*1/2
736	106	\N	1.00	270.00	400.00	\N	400.00		2025-09-11 13:36:00.394519	2025-09-11 13:36:00.39452	Chrome pipe
737	106	\N	1.00	50.00	150.00	\N	150.00		2025-09-11 13:36:00.394521	2025-09-11 13:36:00.394523	Chrome bracket 1”
553	80	\N	1.00	300.00	450.00	\N	450.00		2025-09-06 10:39:56.308364	2025-09-06 10:39:56.308374	Mixer flex
738	106	\N	2.00	220.00	320.00	\N	320.00		2025-09-11 13:36:00.394524	2025-09-11 13:36:00.394525	Drawer runner 18”
739	106	\N	1.00	920.00	1000.00	\N	1000.00		2025-09-11 13:36:00.394526	2025-09-11 13:36:00.394527	Conta 1litre
740	106	\N	10.00	50.00	80.00	\N	80.00		2025-09-11 13:36:00.394528	2025-09-11 13:36:00.394529	Drawer handles
741	107	636	10.00	50.00	75.00	60.00	60.00		2025-09-11 15:19:22.836904	2025-09-11 15:19:22.836962	1 GANG 2-WAY BAKELITE
742	108	\N	2.00	300.00	350.00	\N	350.00		2025-09-11 15:33:06.185693	2025-09-11 15:33:06.185706	Bulkhead
745	110	\N	1.00	1150.00	1450.00	\N	1450.00		2025-09-12 13:30:35.182	2025-09-12 13:30:35.182017	Corner basin
746	110	\N	1.00	100.00	250.00	\N	250.00		2025-09-12 13:30:35.182019	2025-09-12 13:30:35.18202	Toilet brush plastic
747	111	\N	1.00	1750.00	1950.00	\N	1950.00		2025-09-12 13:34:20.563278	2025-09-12 13:34:20.563289	Floor tiles 40*40
748	111	570	3.00	140.00	250.00	200.00	200.00		2025-09-12 13:34:20.566804	2025-09-12 13:34:20.56681	Silicone Orient clear
584	88	\N	26.00	80.00	120.00	\N	120.00		2025-09-06 16:08:44.500635	2025-09-06 16:08:44.500647	Door stopper
585	87	668	5.00	200.00	0.00	250.00	250.00		2025-09-06 16:28:46.042627	2025-09-06 16:28:46.042639	T-S DOUBLE U M1
586	87	658	5.00	140.00	0.00	180.00	180.00		2025-09-06 16:28:46.047603	2025-09-06 16:28:46.047612	3 GANG 2-WAY GOLD M1
587	87	673	5.00	25.00	0.00	30.00	30.00		2025-09-06 16:28:46.062001	2025-09-06 16:28:46.062012	SWITCH BOX 3X3S M1
588	87	674	5.00	30.00	0.00	40.00	40.00		2025-09-06 16:28:46.066159	2025-09-06 16:28:46.066168	SWITCH BOX 6X3D M1
589	87	687	2.00	110.00	200.00	150.00	150.00		2025-09-06 16:28:46.073321	2025-09-06 16:28:46.073334	RGB STRIP WIRE
590	87	\N	1.00	2200.00	3500.00	\N	3500.00		2025-09-06 16:28:46.073337	2025-09-06 16:28:46.073339	Grey cable 1.5
591	87	\N	1.00	3700.00	4500.00	\N	4500.00		2025-09-06 16:28:46.073342	2025-09-06 16:28:46.073344	Grey cable 2.5
592	87	\N	4.00	90.00	120.00	\N	120.00		2025-09-06 16:28:46.073347	2025-09-06 16:28:46.073349	Electrical tape
593	87	\N	12.00	1300.00	1600.00	\N	1600.00		2025-09-06 16:28:46.073351	2025-09-06 16:28:46.073353	Acoustic ceiling
594	87	\N	2.00	60.00	80.00	\N	80.00		2025-09-06 16:28:46.073355	2025-09-06 16:28:46.073357	Cable clip
749	112	690	1.00	2200.00	3500.00	2900.00	2900.00		2025-09-12 15:39:08.508847	2025-09-12 15:39:08.508857	SOLAR STREET LIGHT
750	113	622	6.00	120.00	180.00	\N	180.00		2025-09-13 07:17:51.977641	2025-09-13 07:17:51.977648	D-100 LED BULB
751	114	642	6.00	160.00	220.00	\N	220.00		2025-09-13 10:26:51.339985	2025-09-13 10:26:51.339996	T-S D-NORMAL BAKELITE
752	114	640	1.00	80.00	150.00	\N	150.00		2025-09-13 10:26:51.345078	2025-09-13 10:26:51.345086	T-S SINGLE BAKELITE 
753	114	649	6.00	70.00	110.00	100.00	100.00		2025-09-13 10:26:51.348607	2025-09-13 10:26:51.348613	2 GANG 2-WAY M1
754	114	638	1.00	90.00	150.00	\N	150.00		2025-09-13 10:26:51.35169	2025-09-13 10:26:51.351697	3 GANG 2-WAY BAKELITE
755	114	643	1.00	380.00	500.00	\N	500.00		2025-09-13 10:26:51.354988	2025-09-13 10:26:51.354993	COOKER UNIT 45A BAKELITE
756	114	\N	1.00	170.00	200.00	\N	200.00		2025-09-13 10:26:51.354995	2025-09-13 10:26:51.354996	4 gang
757	115	677	5.00	450.00	600.00	500.00	500.00		2025-09-13 10:33:14.049832	2025-09-13 10:33:14.049842	DUST PROOF BRACKET
758	116	\N	1.00	6000.00	6500.00	\N	6500.00		2025-09-13 11:25:02.634074	2025-09-13 11:25:02.634085	Titan urinal bowl
763	117	\N	2.00	450.00	900.00	\N	900.00		2025-09-13 11:33:36.017336	2025-09-13 11:33:36.017352	Lirlee Arabic shower
764	117	\N	2.00	8500.00	9500.00	\N	9500.00		2025-09-13 11:33:36.017355	2025-09-13 11:33:36.017358	Close couple orient
765	117	\N	2.00	3485.00	6000.00	\N	6000.00		2025-09-13 11:33:36.01736	2025-09-13 11:33:36.017362	Half pedestal
766	117	99	2.00	900.00	1500.00	1600.00	1600.00		2025-09-13 11:33:36.031326	2025-09-13 11:33:36.031337	SQUARE TAP LIRLEE SILVER
767	118	636	13.00	50.00	75.00	70.00	70.00		2025-09-13 13:07:35.179798	2025-09-13 13:07:35.179804	1 GANG 2-WAY BAKELITE
769	120	532	1.00	2280.00	3500.00	3000.00	3000.00		2025-09-15 12:44:15.830832	2025-09-15 12:44:15.830843	RECTANGULAR/GLASS SHELVES
770	120	\N	2.00	1000.00	1500.00	\N	1500.00		2025-09-15 12:44:15.830844	2025-09-15 12:44:15.830846	N342
771	120	\N	1.00	13000.00	14000.00	\N	14000.00		2025-09-15 12:44:15.830847	2025-09-15 12:44:15.830848	ZYG toilet
772	120	\N	2.00	450.00	800.00	\N	800.00		2025-09-15 12:44:15.830849	2025-09-15 12:44:15.83085	Soap dispenser black
773	121	483	1.00	700.00	1500.00	1000.00	1000.00		2025-09-15 12:47:38.968839	2025-09-15 12:47:38.968852	CORNER SHELVES
774	122	395	1.00	900.00	2000.00	\N	2000.00		2025-09-15 12:50:15.905222	2025-09-15 12:50:15.905231	MIRROR
775	123	\N	2.00	500.00	750.00	\N	750.00		2025-09-15 13:47:06.805877	2025-09-15 13:47:06.80589	Super gloss black
776	123	\N	2.00	500.00	750.00	\N	750.00		2025-09-15 13:47:06.805892	2025-09-15 13:47:06.805893	Super gloss yellow
777	123	\N	1.00	1100.00	1300.00	\N	1300.00		2025-09-15 13:47:06.805894	2025-09-15 13:47:06.805895	White spirit 5litre
778	123	\N	1.00	80.00	150.00	\N	150.00		2025-09-15 13:47:06.805897	2025-09-15 13:47:06.805898	Brush 4”
779	123	\N	1.00	50.00	80.00	\N	80.00		2025-09-15 13:47:06.805899	2025-09-15 13:47:06.8059	Paint brush 2”
780	123	\N	1.00	500.00	750.00	\N	750.00		2025-09-15 13:47:06.805903	2025-09-15 13:47:06.805907	Varnish gloss
781	124	\N	1.00	1800.00	2000.00	\N	2000.00		2025-09-15 13:49:16.897912	2025-09-15 13:49:16.897919	Grab bar HD002
782	125	\N	10.00	185.00	250.00	\N	250.00		2025-09-15 14:43:48.486538	2025-09-15 14:43:48.486548	Ppr pipe 25mm
783	125	\N	10.00	20.00	40.00	\N	40.00		2025-09-15 14:43:48.48655	2025-09-15 14:43:48.486551	M/Elbow 25*1/2
784	125	\N	6.00	20.00	40.00	\N	40.00		2025-09-15 14:43:48.486552	2025-09-15 14:43:48.486553	F/Elbow 25*1/2
785	125	\N	3.00	1500.00	2000.00	\N	2000.00		2025-09-15 14:43:48.486554	2025-09-15 14:43:48.486555	Concealed stopcock 3/4
786	125	\N	7.00	90.00	200.00	\N	200.00		2025-09-15 14:43:48.486557	2025-09-15 14:43:48.486558	Angle valve
787	125	\N	30.00	10.00	20.00	\N	20.00		2025-09-15 14:43:48.486559	2025-09-15 14:43:48.48656	Ppr elbow 25mm
788	125	\N	15.00	15.00	20.00	\N	20.00		2025-09-15 14:43:48.486561	2025-09-15 14:43:48.486562	Ppr tee 25mm
789	125	\N	10.00	285.00	350.00	\N	350.00		2025-09-15 14:43:48.486564	2025-09-15 14:43:48.486565	Ppr pipe 32mm
790	125	\N	8.00	10.00	20.00	\N	20.00		2025-09-15 14:43:48.486566	2025-09-15 14:43:48.486567	R/socket 32*25
791	125	\N	14.00	15.00	30.00	\N	30.00		2025-09-15 14:43:48.486568	2025-09-15 14:43:48.486569	Ppr elbow 32mm
792	125	\N	6.00	15.00	30.00	\N	30.00		2025-09-15 14:43:48.48657	2025-09-15 14:43:48.486571	Ppr tee 32mm
793	125	\N	16.00	16.00	30.00	\N	30.00		2025-09-15 14:43:48.486572	2025-09-15 14:43:48.486573	Gi.hex nipple 1/2
794	125	\N	5.00	20.00	40.00	\N	40.00		2025-09-15 14:43:48.486575	2025-09-15 14:43:48.486576	Male tee 25*1/2
795	125	\N	16.00	16.00	30.00	\N	30.00		2025-09-15 14:43:48.486577	2025-09-15 14:43:48.486578	Gi.socket1/2
796	125	584	30.00	11.00	30.00	\N	30.00		2025-09-15 14:43:48.513165	2025-09-15 14:43:48.513178	Small Thread Tape
797	125	\N	2.00	1000.00	1500.00	\N	1500.00		2025-09-15 14:43:48.513181	2025-09-15 14:43:48.513183	Ball valve 1inch
798	125	\N	1.00	16000.00	19500.00	\N	19500.00		2025-09-15 14:43:48.513185	2025-09-15 14:43:48.513187	Submersive pump
799	125	\N	3.00	40.00	60.00	\N	60.00		2025-09-15 14:43:48.513189	2025-09-15 14:43:48.513191	M/adapter 32*1
800	125	\N	3.00	190.00	300.00	\N	300.00		2025-09-15 14:43:48.513193	2025-09-15 14:43:48.513194	Manic flex 4inch
801	125	\N	1.00	900.00	1200.00	\N	1200.00		2025-09-15 14:43:48.513196	2025-09-15 14:43:48.513198	Gate valve 1”
802	125	177	2.00	1200.00	2500.00	2000.00	2000.00		2025-09-15 14:43:48.523844	2025-09-15 14:43:48.523852	FAME BIG 
803	125	\N	8.00	250.00	400.00	\N	400.00		2025-09-15 14:43:48.523854	2025-09-15 14:43:48.523855	PVC pipe 11/2
804	125	\N	4.00	25.00	60.00	\N	60.00		2025-09-15 14:43:48.523857	2025-09-15 14:43:48.523858	PVC tee 11/2
805	125	\N	4.00	20.00	50.00	\N	50.00		2025-09-15 14:43:48.523859	2025-09-15 14:43:48.52386	Plug 11/2
806	125	\N	20.00	20.00	50.00	\N	50.00		2025-09-15 14:43:48.523861	2025-09-15 14:43:48.523862	PVC bend 11/2
807	125	\N	18.00	900.00	1200.00	\N	1200.00		2025-09-15 14:43:48.523864	2025-09-15 14:43:48.523865	PVC pipe 4”G/B
808	125	\N	8.00	1250.00	1450.00	\N	1450.00		2025-09-15 14:43:48.523866	2025-09-15 14:43:48.523867	Manhole cover 18*24
809	125	593	6.00	50.00	100.00	\N	100.00		2025-09-15 14:43:48.530988	2025-09-15 14:43:48.530997	Flex Tube 1 1/2ft Brazil
810	125	\N	4.00	400.00	600.00	\N	600.00		2025-09-15 14:43:48.530999	2025-09-15 14:43:48.531	Manhole cover 12*12
811	125	\N	4.00	90.00	150.00	\N	150.00		2025-09-15 14:43:48.531001	2025-09-15 14:43:48.531002	Gulley trap 4” black
812	125	\N	30.00	85.00	150.00	\N	150.00		2025-09-15 14:43:48.531003	2025-09-15 14:43:48.531004	PVC bend 4”
813	125	154	4.00	140.00	250.00	\N	250.00		2025-09-15 14:43:48.537726	2025-09-15 14:43:48.537744	Viega 11/2''
814	125	\N	4.00	40.00	80.00	\N	80.00		2025-09-15 14:43:48.537748	2025-09-15 14:43:48.537752	Vent cowl
815	125	\N	2.00	850.00	1250.00	\N	1250.00		2025-09-15 14:43:48.537755	2025-09-15 14:43:48.537758	Tangit 1kg
816	125	\N	2.00	85.00	130.00	\N	130.00		2025-09-15 14:43:48.53776	2025-09-15 14:43:48.537762	Bend 4*45
817	125	\N	1.00	300.00	450.00	\N	450.00		2025-09-15 14:43:48.537765	2025-09-15 14:43:48.537768	Tank connector 1”
818	125	\N	20.00	1250.00	1350.00	\N	1350.00		2025-09-15 14:43:48.53777	2025-09-15 14:43:48.537772	Gutter PTG
819	125	\N	19.00	1100.00	1250.00	\N	1250.00		2025-09-15 14:43:48.537774	2025-09-15 14:43:48.537776	Down pipe 3”
820	125	\N	6.00	400.00	450.00	\N	450.00		2025-09-15 14:43:48.537778	2025-09-15 14:43:48.53778	Gutter outlet
821	125	\N	104.00	90.00	100.00	\N	100.00		2025-09-15 14:43:48.537782	2025-09-15 14:43:48.537784	Gutter bracket
822	125	\N	10.00	90.00	130.00	\N	130.00		2025-09-15 14:43:48.537787	2025-09-15 14:43:48.53779	PVC plug4”
823	125	\N	18.00	480.00	550.00	\N	550.00		2025-09-15 14:43:48.537792	2025-09-15 14:43:48.537795	PVC pipe 3”
824	125	\N	18.00	85.00	110.00	\N	110.00		2025-09-15 14:43:48.537797	2025-09-15 14:43:48.537798	PVC bend 3”
825	125	\N	6.00	70.00	100.00	\N	100.00		2025-09-15 14:43:48.537801	2025-09-15 14:43:48.537802	PVC R/B
826	125	\N	6.00	150.00	250.00	\N	250.00		2025-09-15 14:43:48.537804	2025-09-15 14:43:48.537806	PVC tee 4”
827	125	\N	3.00	140.00	140.00	\N	140.00		2025-09-15 14:43:48.537809	2025-09-15 14:43:48.537811	PVC tee +plug 2”
828	125	\N	5.00	50.00	120.00	\N	120.00		2025-09-15 14:43:48.537813	2025-09-15 14:43:48.537815	PVC tee +plug 11/2
829	125	\N	10.00	180.00	250.00	\N	250.00		2025-09-15 14:43:48.537818	2025-09-15 14:43:48.53782	Silicon orient
830	125	581	6.00	60.00	150.00	\N	150.00		2025-09-15 14:43:48.547248	2025-09-15 14:43:48.54726	Basin Screw
831	125	100	3.00	950.00	1800.00	1500.00	1500.00		2025-09-15 14:43:48.551077	2025-09-15 14:43:48.551086	PILLAR TAP JUMBO
832	125	225	1.00	1300.00	3500.00	4500.00	4500.00		2025-09-15 14:43:48.557081	2025-09-15 14:43:48.557093	BASIN MIXER HUMA
833	125	\N	3.00	380.00	450.00	\N	450.00		2025-09-15 14:43:48.557096	2025-09-15 14:43:48.557098	Bip tap 1/2
834	125	\N	3.00	160.00	250.00	\N	250.00		2025-09-15 14:43:48.5571	2025-09-15 14:43:48.557102	Inspection bend 4”
835	125	\N	1.00	300.00	400.00	\N	400.00		2025-09-15 14:43:48.557104	2025-09-15 14:43:48.557106	Ppr ball cork1”
836	125	\N	1.00	200.00	350.00	\N	350.00		2025-09-15 14:43:48.557108	2025-09-15 14:43:48.55711	Inspection tee 4”
837	125	193	1.00	4400.00	9500.00	11000.00	11000.00		2025-09-15 14:43:48.565988	2025-09-15 14:43:48.566001	SHOWER RISER
838	125	\N	2.00	8600.00	11500.00	\N	11500.00		2025-09-15 14:43:48.566005	2025-09-15 14:43:48.566007	Wc 664
839	125	\N	1.00	3800.00	4500.00	\N	4500.00		2025-09-15 14:43:48.56601	2025-09-15 14:43:48.566012	Dining sink 314
840	125	\N	1.00	5500.00	7500.00	\N	7500.00		2025-09-15 14:43:48.566014	2025-09-15 14:43:48.566017	Kitchen sink 1050xi
841	125	\N	1.00	5500.00	6000.00	\N	6000.00		2025-09-15 14:43:48.566019	2025-09-15 14:43:48.566021	Kitchen mixer HT002
842	125	\N	1.00	1750.00	2000.00	\N	2000.00		2025-09-15 14:43:48.566023	2025-09-15 14:43:48.566026	Step toilet orient
843	125	\N	1.00	3800.00	4000.00	\N	4000.00		2025-09-15 14:43:48.566028	2025-09-15 14:43:48.56603	Basin+pedestal 326
844	125	\N	6.00	20.00	50.00	\N	50.00		2025-09-15 14:43:48.566033	2025-09-15 14:43:48.566035	Ppr union 32mm
845	125	\N	2.00	9800.00	10000.00	\N	10000.00		2025-09-15 14:43:48.566037	2025-09-15 14:43:48.566039	Granite
846	125	\N	6.00	20.00	40.00	\N	40.00		2025-09-15 14:43:48.566042	2025-09-15 14:43:48.566044	Ppr union 3/4
847	126	\N	1.00	1750.00	2000.00	\N	2000.00		2025-09-15 14:48:49.173305	2025-09-15 14:48:49.173316	1050 kitchen sink
848	127	\N	1.00	250.00	400.00	\N	400.00		2025-09-15 14:49:27.149177	2025-09-15 14:49:27.149185	Plastic soap dish
849	128	624	1.00	2500.00	3500.00	3000.00	3000.00		2025-09-15 15:37:03.935167	2025-09-15 15:37:03.935179	1095-100W FLOOD LIGHT SOLAR
850	128	666	17.00	220.00	220.00	240.00	240.00		2025-09-15 15:37:03.939912	2025-09-15 15:37:03.939918	T-S NORMAL D/GD
851	128	\N	1.00	350.00	400.00	\N	400.00		2025-09-15 15:37:03.93992	2025-09-15 15:37:03.939921	Filament
852	128	\N	2.00	1700.00	1800.00	\N	1800.00		2025-09-15 15:37:03.939923	2025-09-15 15:37:03.939924	Ac floodlight 200 W
853	128	\N	1.00	1100.00	1200.00	\N	1200.00		2025-09-15 15:37:03.939925	2025-09-15 15:37:03.939926	Ac floodlight 100W
854	128	636	10.00	50.00	75.00	60.00	60.00		2025-09-15 15:37:03.945428	2025-09-15 15:37:03.945438	1 GANG 2-WAY BAKELITE
855	128	642	5.00	160.00	220.00	200.00	200.00		2025-09-15 15:37:03.948516	2025-09-15 15:37:03.948522	T-S D-NORMAL BAKELITE
856	128	678	1.00	200.00	280.00	250.00	250.00		2025-09-15 15:37:03.951821	2025-09-15 15:37:03.951826	DUST PROOF BRACKET
857	128	\N	5.00	70.00	110.00	\N	110.00		2025-09-15 15:37:03.951828	2025-09-15 15:37:03.951829	RGB
858	128	687	1.00	110.00	200.00	\N	200.00		2025-09-15 15:37:03.955518	2025-09-15 15:37:03.955528	RGB STRIP WIRE
859	128	\N	5.00	270.00	300.00	\N	300.00		2025-09-15 15:37:03.955531	2025-09-15 15:37:03.955534	24w oval bulkhead
860	128	640	1.00	80.00	150.00	\N	150.00		2025-09-15 15:37:03.959614	2025-09-15 15:37:03.959622	T-S SINGLE BAKELITE 
861	128	\N	1.00	3000.00	3500.00	\N	3500.00		2025-09-15 15:37:03.959625	2025-09-15 15:37:03.959628	200 W street light
862	128	673	2.00	25.00	25.00	30.00	30.00		2025-09-15 15:37:03.963262	2025-09-15 15:37:03.963267	SWITCH BOX 3X3S M1
863	128	\N	5.00	35.00	60.00	\N	60.00		2025-09-15 15:37:03.963269	2025-09-15 15:37:03.96327	9W
864	128	\N	1.00	900.00	1000.00	\N	1000.00		2025-09-15 15:37:03.963271	2025-09-15 15:37:03.963273	Small full moon
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, userid, ordertypeid, branchid, created_at, updated_at, approvalstatus, approved_at, payment_status) FROM stdin;
39	6	1	1	2025-08-28 13:56:14.334145	2025-08-28 14:00:12.302073	t	2025-08-28 13:59:22.929643	paid
80	6	1	1	2025-09-06 10:39:56.299239	2025-09-06 12:42:39.684626	t	2025-09-06 11:30:06.481209	paid
26	6	1	1	2025-08-26 13:32:06.07053	2025-08-27 05:16:26.657743	t	2025-08-26 13:44:56.731612	paid
51	14	1	1	2025-08-30 11:47:51.371094	2025-08-30 14:22:20.088238	t	2025-08-30 11:57:08.198728	paid
50	14	1	1	2025-08-30 11:46:41.441688	2025-08-30 14:22:20.09842	t	2025-08-30 11:50:42.682177	paid
49	14	1	1	2025-08-30 11:44:30.832387	2025-08-30 14:22:20.111815	t	2025-08-30 11:49:29.928578	paid
78	7	1	1	2025-09-06 10:35:47.782172	2025-09-06 12:42:39.691881	t	2025-09-06 11:35:04.889745	paid
77	6	1	1	2025-09-06 10:34:54.431851	2025-09-06 12:42:39.697729	t	2025-09-06 11:37:19.18065	paid
34	6	1	1	2025-08-27 14:04:36.63502	2025-08-27 15:31:08.932442	t	2025-08-27 15:29:35.617607	paid
33	6	1	1	2025-08-27 14:02:53.321831	2025-08-27 15:31:08.942768	t	2025-08-27 15:28:39.837492	paid
31	6	1	1	2025-08-27 13:50:20.904107	2025-08-27 15:31:08.948853	t	2025-08-27 15:27:45.893786	paid
30	6	1	1	2025-08-27 13:46:45.99715	2025-08-27 15:31:08.955513	t	2025-08-27 15:24:12.443178	paid
40	7	1	1	2025-08-28 14:55:17.382942	2025-08-28 15:30:38.516941	t	2025-08-28 14:55:45.868008	paid
41	7	1	1	2025-08-29 13:17:32.58715	2025-08-29 13:22:55.170768	t	2025-08-29 13:20:11.293852	paid
52	15	1	1	2025-08-30 12:35:05.792234	2025-09-01 19:13:06.981406	t	2025-09-01 16:09:08.465118	paid
61	6	1	1	2025-09-02 14:00:45.498072	2025-09-02 15:44:28.649468	t	2025-09-02 14:04:20.575146	paid
60	6	1	1	2025-09-02 13:59:03.753141	2025-09-02 15:44:28.658779	t	2025-09-02 14:03:21.083179	paid
37	6	1	1	2025-08-28 12:39:43.075418	2025-08-28 12:52:03.313674	t	2025-08-28 12:42:53.646828	paid
36	6	1	1	2025-08-28 12:33:40.398186	2025-08-28 12:52:03.327339	t	2025-08-28 12:38:56.247085	paid
59	6	1	1	2025-09-02 13:29:49.880889	2025-09-02 15:44:28.666584	t	2025-09-02 14:01:46.841986	paid
35	7	1	1	2025-08-28 08:10:10.598608	2025-08-28 08:23:23.348052	t	2025-08-28 08:23:23.34523	paid
58	7	1	1	2025-09-02 13:25:47.890469	2025-09-02 15:44:28.674683	t	2025-09-02 13:50:26.993387	paid
57	6	1	1	2025-09-02 13:25:44.412789	2025-09-02 15:44:28.690983	t	2025-09-02 14:00:51.956431	paid
56	6	1	1	2025-09-02 13:23:00.297599	2025-09-02 15:44:28.696402	t	2025-09-02 14:06:19.884081	paid
97	7	1	1	2025-09-09 14:58:17.728431	2025-09-09 17:07:47.65746	t	2025-09-09 15:03:51.094351	paid
96	7	1	1	2025-09-09 14:41:40.447089	2025-09-09 17:07:47.662455	t	2025-09-09 15:02:23.633437	paid
38	7	1	1	2025-08-28 13:06:41.543845	2025-08-28 13:14:01.09706	t	2025-08-28 13:09:13.390304	paid
100	7	1	1	2025-09-10 06:51:22.853512	2025-09-10 11:02:08.332559	t	2025-09-10 08:44:35.683305	paid
48	6	1	1	2025-08-30 11:09:43.728055	2025-08-30 11:20:46.80221	t	2025-08-30 11:14:55.815513	paid
47	7	1	1	2025-08-30 11:02:46.351034	2025-08-30 11:20:46.810587	t	2025-08-30 11:08:07.464354	paid
46	7	1	1	2025-08-30 10:48:43.182114	2025-08-30 11:20:46.815499	t	2025-08-30 11:02:49.751605	paid
54	6	1	1	2025-09-01 13:38:35.945837	2025-09-01 14:01:32.080798	t	2025-09-01 13:47:44.48024	paid
53	6	1	1	2025-09-01 13:29:45.431557	2025-09-01 14:01:32.095479	t	2025-09-01 13:46:11.550141	paid
88	18	1	2	2025-09-06 16:08:44.492721	2025-09-06 17:41:02.052691	f	\N	not_paid
117	6	1	1	2025-09-13 11:32:27.309758	2025-09-13 13:04:38.952952	t	2025-09-13 11:39:48.320711	paid
122	6	1	1	2025-09-15 12:50:15.89801	2025-09-15 13:28:36.423736	t	2025-09-15 13:20:27.791779	paid
121	6	1	1	2025-09-15 12:47:38.951249	2025-09-15 13:28:36.429347	t	2025-09-15 13:18:36.883908	paid
116	6	1	1	2025-09-13 11:25:02.626811	2025-09-13 13:04:38.958538	t	2025-09-13 11:46:29.38608	paid
106	6	1	1	2025-09-11 13:36:00.3852	2025-09-11 14:16:43.852836	t	2025-09-11 14:01:14.196438	paid
90	6	1	1	2025-09-08 13:35:53.117913	2025-09-08 15:15:29.361681	t	2025-09-08 13:42:48.037585	paid
64	6	1	1	2025-09-03 13:45:12.126735	2025-09-03 13:50:39.063216	t	2025-09-03 13:47:40.950804	paid
63	7	1	1	2025-09-03 13:25:33.872547	2025-09-03 13:50:39.074297	t	2025-09-03 13:27:23.890402	paid
62	6	1	1	2025-09-03 13:06:13.800893	2025-09-03 13:50:39.084163	t	2025-09-03 13:37:50.316689	paid
105	7	1	1	2025-09-11 13:17:07.541816	2025-09-11 14:16:43.860888	t	2025-09-11 13:41:50.448637	paid
75	6	1	1	2025-09-05 13:52:48.377918	2025-09-05 14:46:59.807513	t	2025-09-05 14:44:01.903812	paid
74	6	1	1	2025-09-05 12:13:55.178432	2025-09-05 14:46:59.814547	t	2025-09-05 12:29:43.505012	paid
70	7	1	1	2025-09-04 13:21:22.346919	2025-09-04 13:27:30.974671	t	2025-09-04 13:23:33.936096	paid
69	6	1	1	2025-09-04 13:21:02.286755	2025-09-04 13:27:30.980809	t	2025-09-04 13:26:21.127714	paid
67	7	1	1	2025-09-04 13:17:44.991996	2025-09-04 13:27:30.986941	t	2025-09-04 13:21:52.913751	paid
73	16	1	3	2025-09-05 09:02:31.763234	2025-09-05 09:24:16.055098	t	2025-09-05 09:04:31.152242	paid
72	16	1	3	2025-09-04 13:46:08.846212	2025-09-05 09:24:16.067401	t	2025-09-05 09:03:39.167247	paid
71	6	1	1	2025-09-04 13:45:05.351994	2025-09-05 09:24:16.081883	t	2025-09-04 13:55:58.846176	paid
89	15	1	1	2025-09-08 12:14:17.374632	2025-09-08 13:24:37.819001	t	2025-09-08 12:19:59.330947	paid
76	16	1	3	2025-09-05 16:42:27.22858	2025-09-06 09:02:09.46586	t	2025-09-05 16:44:30.947913	paid
120	6	1	1	2025-09-15 12:44:15.814678	2025-09-15 13:28:36.433572	t	2025-09-15 13:17:50.493215	paid
115	16	1	3	2025-09-13 10:33:14.0409	2025-09-13 13:04:38.963048	t	2025-09-13 10:34:06.615689	paid
91	6	1	1	2025-09-08 13:36:53.290238	2025-09-08 13:39:41.753161	t	2025-09-08 13:39:41.748186	paid
95	6	1	1	2025-09-09 13:24:24.530347	2025-09-09 14:42:03.188496	t	2025-09-09 13:28:10.570343	paid
92	16	1	3	2025-09-08 17:04:49.36804	2025-09-08 17:18:26.672011	t	2025-09-08 17:06:03.918056	paid
108	16	1	3	2025-09-11 15:33:06.174798	2025-09-11 15:57:34.338377	t	2025-09-11 15:33:47.655916	paid
87	16	1	3	2025-09-06 15:35:17.315332	2025-09-12 10:11:18.683713	t	2025-09-12 10:09:38.764276	paid
94	6	1	1	2025-09-09 13:22:20.940172	2025-09-09 14:42:03.193144	t	2025-09-09 13:26:28.146463	paid
107	16	1	3	2025-09-11 15:19:22.82162	2025-09-11 15:57:34.357188	t	2025-09-11 15:20:01.58683	paid
104	16	1	3	2025-09-10 15:21:54.687786	2025-09-10 15:43:01.069182	t	2025-09-10 15:22:38.581875	paid
99	16	1	3	2025-09-09 15:54:13.128635	2025-09-09 17:07:47.640541	t	2025-09-09 15:55:58.567074	paid
101	7	1	1	2025-09-10 09:24:32.30926	2025-09-10 13:53:09.646166	t	2025-09-10 13:53:09.644651	paid
102	6	1	1	2025-09-10 13:19:15.576463	2025-09-10 14:39:58.595813	t	2025-09-10 13:48:01.763993	paid
114	16	1	3	2025-09-13 10:26:51.330495	2025-09-13 13:04:38.967365	t	2025-09-13 10:27:37.542189	paid
113	16	1	3	2025-09-13 07:17:51.969251	2025-09-13 13:04:38.971356	t	2025-09-13 07:18:29.404081	paid
112	16	1	3	2025-09-12 15:39:08.499095	2025-09-13 13:04:38.975351	t	2025-09-12 15:39:54.690381	paid
111	6	1	1	2025-09-12 13:34:20.555747	2025-09-13 13:04:38.979439	t	2025-09-12 13:45:10.499926	paid
110	7	1	1	2025-09-12 13:30:35.173654	2025-09-13 13:04:38.983073	t	2025-09-12 13:43:38.288705	paid
118	16	1	3	2025-09-13 13:07:35.171114	2025-09-13 13:10:32.194896	t	2025-09-13 13:08:25.969857	paid
127	7	1	1	2025-09-15 14:49:27.144727	2025-09-15 14:58:23.754085	t	2025-09-15 14:53:49.347475	paid
126	7	1	1	2025-09-15 14:48:49.16397	2025-09-15 14:58:24.622461	t	2025-09-15 14:57:38.60303	paid
124	6	1	1	2025-09-15 13:49:16.891205	2025-09-15 14:58:25.580279	t	2025-09-15 13:55:26.154256	paid
123	6	1	1	2025-09-15 13:47:06.787926	2025-09-15 14:58:26.037042	t	2025-09-15 13:53:58.060425	paid
125	7	1	1	2025-09-15 14:43:48.477107	2025-09-15 15:05:55.21531	t	2025-09-15 14:58:10.602664	paid
128	16	1	3	2025-09-15 15:37:03.916279	2025-09-15 17:30:52.038471	t	2025-09-15 15:53:05.373096	paid
\.


--
-- Data for Name: ordertypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordertypes (id, name) FROM stdin;
1	walk-in
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (id, user_id, token, expires_at, used, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, orderid, userid, amount, payment_method, payment_status, transaction_id, reference_number, notes, payment_date, created_at, updated_at) FROM stdin;
6	26	6	16800.00	mobile_money	completed	\N		Paid through Mpesa	2025-08-26 13:46:06.16421	2025-08-26 13:46:06.170358	2025-08-26 13:46:06.170402
8	30	6	24000.00	mobile_money	completed	\N		Paid through pay Bill	2025-08-27 14:10:19.540661	2025-08-27 14:10:19.548316	2025-08-27 14:10:19.548357
10	31	6	1300.00	cash	completed	\N			2025-08-27 15:27:41.658927	2025-08-27 15:27:41.664176	2025-08-27 15:27:41.664196
11	33	6	6800.00	mobile_money	completed	\N			2025-08-27 15:28:35.089942	2025-08-27 15:28:35.093517	2025-08-27 15:28:35.093539
12	34	6	450.00	cash	completed	\N			2025-08-27 15:29:29.632133	2025-08-27 15:29:29.640348	2025-08-27 15:29:29.640362
13	35	7	17700.00	mobile_money	completed	\N		Paid through Mpesa	2025-08-28 08:11:55.24024	2025-08-28 08:11:55.243185	2025-08-28 08:11:55.243201
15	36	6	49670.00	mobile_money	completed	\N		Paid through pay bill 	2025-08-28 12:37:46.257078	2025-08-28 12:37:46.261852	2025-08-28 12:37:46.26187
16	37	6	4300.00	mobile_money	completed	\N		Paid through pay bill	2025-08-28 12:42:24.396739	2025-08-28 12:42:24.401535	2025-08-28 12:42:24.401552
17	38	7	4000.00	cash	completed	\N		Paid cash	2025-08-28 13:08:18.581847	2025-08-28 13:08:18.585528	2025-08-28 13:08:18.585544
18	38	7	5600.00	mobile_money	completed	\N		Paid through mpesa	2025-08-28 13:08:59.371775	2025-08-28 13:08:59.375116	2025-08-28 13:08:59.37513
19	39	6	3000.00	mobile_money	completed	\N		Paid through Pay bill	2025-08-28 13:58:49.357795	2025-08-28 13:58:49.361753	2025-08-28 13:58:49.361768
20	40	7	1800.00	mobile_money	completed	\N		Paid through Mpesa	2025-08-28 14:56:13.63638	2025-08-28 14:56:13.642169	2025-08-28 14:56:13.642197
21	41	7	400.00	mobile_money	completed	\N		Paid through Mpesa	2025-08-29 13:19:32.595979	2025-08-29 13:19:32.602223	2025-08-29 13:19:32.602235
22	46	7	4200.00	mobile_money	completed	\N		Paid via Mpesa	2025-08-30 11:02:36.779089	2025-08-30 11:02:36.787303	2025-08-30 11:02:36.787319
23	47	7	5500.00	mobile_money	completed	\N		Paid via Mpesa	2025-08-30 11:06:44.382837	2025-08-30 11:06:44.39067	2025-08-30 11:06:44.390682
24	48	6	55200.00	mobile_money	completed	\N		Paid through paybill	2025-08-30 11:14:46.528525	2025-08-30 11:14:46.531242	2025-08-30 11:14:46.531259
25	49	14	1110.00	mobile_money	completed	\N		Send money	2025-08-30 11:49:16.237655	2025-08-30 11:49:16.239607	2025-08-30 11:49:16.239616
26	50	14	3000.00	mobile_money	completed	\N		Mpesa	2025-08-30 11:50:37.789254	2025-08-30 11:50:37.792098	2025-08-30 11:50:37.792112
27	51	14	110.00	mobile_money	completed	\N		Mpesa	2025-08-30 11:56:14.17753	2025-08-30 11:56:14.179952	2025-08-30 11:56:14.179961
28	51	14	110.00	mobile_money	completed	\N		Mpesa	2025-08-30 11:56:19.898769	2025-08-30 11:56:19.901821	2025-08-30 11:56:19.901834
29	53	6	900.00	mobile_money	completed	\N		Paid via mpesa	2025-09-01 13:44:07.399433	2025-09-01 13:44:07.404629	2025-09-01 13:44:07.404647
30	54	6	13500.00	mobile_money	completed	\N		Paid through send money	2025-09-01 13:47:39.607264	2025-09-01 13:47:39.609409	2025-09-01 13:47:39.609417
33	52	15	56000.00	mobile_money	completed	\N		Mpesa	2025-09-01 16:09:26.419784	2025-09-01 16:09:26.426753	2025-09-01 16:09:26.426764
34	58	7	18350.00	cash	completed	\N		Paid cash	2025-09-02 13:50:10.532676	2025-09-02 13:50:10.539971	2025-09-02 13:50:10.539981
35	57	6	44400.00	cash	completed	\N		Paid cash	2025-09-02 14:00:28.291859	2025-09-02 14:00:28.295218	2025-09-02 14:00:28.295232
36	59	6	10100.00	mobile_money	completed	\N		Paid through Mpesa	2025-09-02 14:01:32.349695	2025-09-02 14:01:32.354766	2025-09-02 14:01:32.354787
37	60	6	200.00	mobile_money	completed	\N		Paid via mpesa	2025-09-02 14:03:08.195908	2025-09-02 14:03:08.201955	2025-09-02 14:03:08.201978
38	61	6	300.00	mobile_money	completed	\N		Mobile money	2025-09-02 14:04:13.731894	2025-09-02 14:04:13.736087	2025-09-02 14:04:13.736104
39	56	6	49050.00	mobile_money	completed	\N		Paid through Mpesa	2025-09-02 14:06:05.404337	2025-09-02 14:06:05.408553	2025-09-02 14:06:05.408575
41	63	7	1500.00	mobile_money	completed	\N		Paid through mpesa	2025-09-03 13:27:17.720214	2025-09-03 13:27:17.722997	2025-09-03 13:27:17.723006
42	62	6	10930.00	mobile_money	completed	\N		Paid through Mpesa	2025-09-03 13:36:40.896641	2025-09-03 13:36:40.900236	2025-09-03 13:36:40.900248
43	62	6	7500.00	cash	completed	\N		Paid cash	2025-09-03 13:37:26.031884	2025-09-03 13:37:26.03571	2025-09-03 13:37:26.03572
44	64	6	3900.00	cash	completed	\N		Paid cash 4000 (100 refunded)	2025-09-03 13:47:22.969938	2025-09-03 13:47:22.974089	2025-09-03 13:47:22.974098
45	67	7	2000.00	mobile_money	completed	\N		Paid through Send money	2025-09-04 13:21:42.002708	2025-09-04 13:21:42.006284	2025-09-04 13:21:42.006292
46	70	7	2500.00	mobile_money	completed	\N		Paid through Mpesa	2025-09-04 13:23:21.549929	2025-09-04 13:23:21.553314	2025-09-04 13:23:21.553324
47	69	6	2100.00	mobile_money	completed	\N		Paid cash	2025-09-04 13:25:00.860091	2025-09-04 13:25:00.862879	2025-09-04 13:25:00.862886
48	71	6	1100.00	mobile_money	completed	\N		Paid through mpesa	2025-09-04 13:55:46.870926	2025-09-04 13:55:46.872353	2025-09-04 13:55:46.87236
49	72	16	6780.00	cash	completed	\N			2025-09-05 09:03:29.645177	2025-09-05 09:03:29.649427	2025-09-05 09:03:29.649442
50	73	16	7000.00	mobile_money	completed	\N			2025-09-05 09:04:23.121677	2025-09-05 09:04:23.127389	2025-09-05 09:04:23.127405
51	74	6	103290.00	mobile_money	completed	\N		Paid through send money	2025-09-05 12:29:21.741525	2025-09-05 12:29:21.747699	2025-09-05 12:29:21.747709
52	75	6	209755.00	mobile_money	completed	\N			2025-09-05 14:43:57.362009	2025-09-05 14:43:57.371998	2025-09-05 14:43:57.372011
53	76	16	11500.00	mobile_money	completed	\N			2025-09-05 16:44:19.509925	2025-09-05 16:44:19.513662	2025-09-05 16:44:19.513671
54	80	6	450.00	cash	completed	\N		Paid cash 500 (50 refunded)	2025-09-06 11:29:52.348834	2025-09-06 11:29:52.352106	2025-09-06 11:29:52.352116
55	78	7	2820.00	cash	completed	\N		Paid cash 3000 (180 refunded)	2025-09-06 11:34:34.44935	2025-09-06 11:34:34.451572	2025-09-06 11:34:34.45158
56	77	6	19700.00	mobile_money	completed	\N		Paid through send money	2025-09-06 11:36:25.132009	2025-09-06 11:36:25.134639	2025-09-06 11:36:25.134649
57	89	15	390000.00	mobile_money	completed	\N	Mpesa Payment	Paid 250,000 at first and the 140,000 later	2025-09-08 12:21:00.391989	2025-09-08 12:21:00.396658	2025-09-08 12:21:00.396677
58	91	6	150.00	cash	completed	\N		Paid cash	2025-09-08 13:39:21.703614	2025-09-08 13:39:21.708824	2025-09-08 13:39:21.70884
59	90	6	53000.00	mobile_money	completed	\N		Paid through mobile money	2025-09-08 13:42:22.33329	2025-09-08 13:42:22.33673	2025-09-08 13:42:22.336746
60	92	16	2230.00	mobile_money	completed	\N			2025-09-08 17:05:56.966266	2025-09-08 17:05:56.970485	2025-09-08 17:05:56.9705
61	94	6	7700.00	mobile_money	completed	\N		Paid through send mobile 	2025-09-09 13:26:12.201571	2025-09-09 13:26:12.205224	2025-09-09 13:26:12.205232
62	95	6	150.00	cash	completed	\N		Paid cash 	2025-09-09 13:27:55.866808	2025-09-09 13:27:55.869799	2025-09-09 13:27:55.869807
63	96	7	1840.00	cash	completed	\N			2025-09-09 15:03:23.470064	2025-09-09 15:03:23.472802	2025-09-09 15:03:23.472812
64	97	7	38350.00	mobile_money	completed	\N		paid through Mpesa	2025-09-09 15:04:16.698748	2025-09-09 15:04:16.70077	2025-09-09 15:04:16.700778
65	99	16	1970.00	cash	completed	\N			2025-09-09 15:55:34.181292	2025-09-09 15:55:34.183894	2025-09-09 15:55:34.183901
66	100	7	8500.00	mobile_money	completed	\N		Paid through Send money 	2025-09-10 08:44:28.195494	2025-09-10 08:44:28.198978	2025-09-10 08:44:28.198987
67	101	7	29000.00	mobile_money	completed	\N		Paid through send money 	2025-09-10 09:27:48.242608	2025-09-10 09:27:48.245891	2025-09-10 09:27:48.245903
68	102	6	1550.00	mobile_money	completed	\N		Paid through send money 	2025-09-10 13:44:49.425752	2025-09-10 13:44:49.427539	2025-09-10 13:44:49.427548
69	104	16	8110.00	mobile_money	completed	\N			2025-09-10 15:22:32.436134	2025-09-10 15:22:32.439254	2025-09-10 15:22:32.439263
70	106	6	7000.00	cash	completed	\N		Paid cash	2025-09-11 13:37:52.296824	2025-09-11 13:37:52.299312	2025-09-11 13:37:52.29932
72	105	7	1800.00	cash	completed	\N		Paid cash	2025-09-11 13:41:42.929713	2025-09-11 13:41:42.932809	2025-09-11 13:41:42.932819
73	107	16	600.00	cash	completed	\N			2025-09-11 15:19:56.14881	2025-09-11 15:19:56.153044	2025-09-11 15:19:56.153057
74	108	16	700.00	mobile_money	completed	\N			2025-09-11 15:33:42.529349	2025-09-11 15:33:42.53169	2025-09-11 15:33:42.531699
75	87	16	34540.00	mobile_money	completed	\N			2025-09-12 10:09:49.661688	2025-09-12 10:09:49.666529	2025-09-12 10:09:49.666541
71	106	6	1100.00	mobile_money	completed	\N		Paid through send money 	2025-09-11 13:39:11.047545	2025-09-11 13:39:11.051303	2025-09-11 13:39:11.051312
76	110	7	1700.00	mobile_money	completed	\N		Paid through send money 	2025-09-12 13:43:16.832305	2025-09-12 13:43:16.834965	2025-09-12 13:43:16.834974
77	111	6	2550.00	mobile_money	completed	\N		Paid through send money 	2025-09-12 13:44:31.865124	2025-09-12 13:44:31.866655	2025-09-12 13:44:31.866663
78	112	16	2900.00	mobile_money	completed	\N			2025-09-12 15:39:45.877252	2025-09-12 15:39:45.880391	2025-09-12 15:39:45.880398
79	113	16	1080.00	mobile_money	completed	\N			2025-09-13 07:18:24.696781	2025-09-13 07:18:24.70002	2025-09-13 07:18:24.700029
80	114	16	2920.00	cash	completed	\N			2025-09-13 10:27:31.734577	2025-09-13 10:27:31.73643	2025-09-13 10:27:31.736438
82	117	6	36000.00	mobile_money	completed	\N		Paid through send money 	2025-09-13 11:39:00.74768	2025-09-13 11:39:00.750134	2025-09-13 11:39:00.750142
83	116	6	6500.00	mobile_money	completed	\N		Paid through send money 	2025-09-13 11:45:24.651329	2025-09-13 11:45:24.654078	2025-09-13 11:45:24.654085
87	122	6	2000.00	mobile_money	completed	\N		Paid via send money 	2025-09-15 13:20:16.376405	2025-09-15 13:20:16.37938	2025-09-15 13:20:16.379391
90	127	7	400.00	mobile_money	completed	\N		Paid through Mpesa 	2025-09-15 14:57:17.118628	2025-09-15 14:57:17.122596	2025-09-15 14:57:17.122605
91	126	7	2000.00	cash	completed	\N		Paid by cash	2025-09-15 14:57:56.764794	2025-09-15 14:57:56.766717	2025-09-15 14:57:56.766728
92	125	7	270950.00	mobile_money	completed	\N		Paid through Mpesa	2025-09-15 14:59:24.994715	2025-09-15 14:59:24.997925	2025-09-15 14:59:24.997933
93	128	16	21390.00	mobile_money	completed	\N			2025-09-15 15:52:52.383221	2025-09-15 15:52:52.385764	2025-09-15 15:52:52.385775
81	115	16	2500.00	mobile_money	completed	\N			2025-09-13 10:33:44.676364	2025-09-13 10:33:44.680158	2025-09-13 10:33:44.680167
84	118	16	910.00	cash	completed	\N			2025-09-13 13:08:20.883353	2025-09-13 13:08:20.885905	2025-09-13 13:08:20.885911
85	120	6	21600.00	mobile_money	completed	\N		Paid through send money 	2025-09-15 13:17:34.228685	2025-09-15 13:17:34.23151	2025-09-15 13:17:34.231517
86	121	6	1000.00	mobile_money	completed	\N		Paid through send money 	2025-09-15 13:18:26.579903	2025-09-15 13:18:26.58187	2025-09-15 13:18:26.581878
88	123	6	5280.00	mobile_money	completed	\N		Paid through send. Money 	2025-09-15 13:53:06.230844	2025-09-15 13:53:06.233152	2025-09-15 13:53:06.23316
89	124	6	2000.00	cash	completed	\N		Paid cash	2025-09-15 13:55:12.765537	2025-09-15 13:55:12.768562	2025-09-15 13:55:12.768569
\.


--
-- Data for Name: product_descriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_descriptions (id, product_id, title, content, content_type, language, is_active, sort_order, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, branchid, name, image_url, buyingprice, sellingprice, stock, productcode, display, created_at, updated_at, subcategory_id) FROM stdin;
85	1	BASIN PILLAR TAP	\N	1500	3000	\N	GT007	t	2025-08-20 12:56:30.775916	2025-08-23 16:45:21.828738	18
18	1	COUNTER BASIN	\N	0	\N	7.00	WB037C	t	2025-08-20 11:04:02.004924	2025-08-20 11:04:02.004941	8
19	1	Two Piece Sawa	\N	\N	\N	1.00	WC019	t	2025-08-20 11:04:23.378448	2025-08-20 11:04:23.378461	2
20	1	COUNTER BASIN	\N	\N	\N	4.00	WB036C	t	2025-08-20 11:05:17.797875	2025-08-20 11:05:17.79789	8
21	1	Two Piece Sawa	\N	\N	\N	1.00	WCO13	t	2025-08-20 11:06:17.361102	2025-08-20 11:06:17.361114	2
22	1	COUNTER BASIN	\N	\N	\N	4.00	WB022C	t	2025-08-20 11:06:22.16175	2025-08-20 11:06:22.161759	8
23	1	COUNTER BASIN	\N	\N	\N	4.00	WB024C	t	2025-08-20 11:07:09.612755	2025-08-20 11:07:09.612773	8
25	1	COUNTER BASIN	\N	\N	\N	8.00	WB9156	t	2025-08-20 11:07:49.389944	2025-08-20 11:07:49.389961	8
27	1	COUNTER BASIN	\N	\N	\N	9.00	WB026C	t	2025-08-20 11:08:36.234552	2025-08-20 11:08:36.234564	8
28	1	COUNTER BASIN	\N	\N	\N	3.00	WB9041	t	2025-08-20 11:09:14.146107	2025-08-20 11:09:14.146119	8
30	1	ORDINARY BASIN BLOSSOM	\N	\N	\N	9.00	WB018H	t	2025-08-20 11:12:20.047225	2025-08-20 11:12:20.047242	9
32	1	ORDINARY BASIN FRENCIA	\N	\N	\N	0.00	WB018H	t	2025-08-20 11:14:24.604784	2025-08-20 11:14:24.604801	9
35	1	MEDIUM BASIN WHITE	\N	\N	\N	\N		t	2025-08-20 11:18:43.196493	2025-08-20 11:18:43.196501	9
34	1	MEDIUM BASIN COLOURED	\N	\N	\N	\N		t	2025-08-20 11:17:53.688006	2025-08-20 11:20:41.321184	9
48	1	STEP ASIAN COLOURED	\N	\N	\N	\N		t	2025-08-20 12:08:32.694039	2025-08-20 12:08:32.694054	5
50	1	STEP ASIAN WHITE 	\N	\N	\N	\N		t	2025-08-20 12:09:11.703452	2025-08-20 12:09:11.703483	5
51	1	STAINLESS STEP ASIAN	\N	\N	\N	1.00		t	2025-08-20 12:09:55.33939	2025-08-20 12:09:55.339412	5
47	1	Basin Mixer Lirlee	\N	1200	2500	9.00		t	2025-08-20 12:08:04.402784	2025-09-09 15:03:51.1062	15
57	1	KITCHEN WALL TAP SPROUT	\N	1155	2000	\N	EG6014	t	2025-08-20 12:21:01.244771	2025-08-20 12:21:01.244797	20
59	1	Kitchen mixer pillar type	\N	1300	4000	5.00	6001	t	2025-08-20 12:22:53.240147	2025-08-20 12:22:53.240169	16
60	1	Kitchen mixer pillar type	\N	1800	4500	5.00	6023	t	2025-08-20 12:24:47.354456	2025-08-20 12:24:47.354474	16
61	1	Kitchen mixer pillar type	\N	1900	4500	5.00	6023K	t	2025-08-20 12:25:50.554567	2025-08-20 12:25:50.554584	16
63	1	KITCHEN  WALL TAP SPROUT	\N	1330	2000	\N	KS9042	t	2025-08-20 12:29:40.928237	2025-08-20 12:29:40.928259	20
65	1	Kitchen mixer pillar type	\N	3800	6500	3.00	6020C	t	2025-08-20 12:31:06.249822	2025-08-20 12:31:06.24984	16
66	1	Kitchen mixer pillar type	\N	3800	6500	3.00	6020K	t	2025-08-20 12:32:24.891191	2025-08-20 12:32:24.891217	16
67	1	Kitchen mixer pillar type	\N	2300	4500	3.00	6016K	t	2025-08-20 12:33:43.323008	2025-08-20 12:33:43.323032	16
68	1	Kitchen mixer pillar type	\N	3300	6000	0.00	HT002	t	2025-08-20 12:35:19.406576	2025-08-20 12:35:19.406594	16
69	1	Kitchen mixer pillar type	\N	3905	5500	\N	PU2331	t	2025-08-20 12:38:23.006602	2025-08-20 12:38:23.006622	16
72	1	Kitchen mixer pillar type	\N	6600	10000	0.00	KS6038	t	2025-08-20 12:41:16.101249	2025-08-20 12:41:16.101267	16
73	1	EZURI WALL SPROUT	\N	850	1500	\N	WD2007	t	2025-08-20 12:41:58.589199	2025-08-20 12:41:58.589223	20
74	1	Kitchen mixer pillar type	\N	3570	5500	\N	KS6026	t	2025-08-20 12:42:24.386835	2025-08-20 12:42:24.386857	16
75	1	Kitchen mixer pillar type	\N	3025	5500	\N	KS1066	t	2025-08-20 12:43:47.066464	2025-08-20 12:43:47.066489	16
76	1	PLASTIC WALL TAP SPROUT 	\N	305	650	\N		f	2025-08-20 12:44:54.275869	2025-08-20 12:44:54.275891	20
77	1	Kitchen mixer pillar type	\N	2640	4500	\N	KS6029	t	2025-08-20 12:45:35.465016	2025-08-20 12:45:35.465034	17
81	1	Kitchen mixer wall type	\N	3355	5500	\N	KM3051	t	2025-08-20 12:48:41.077969	2025-08-20 12:48:41.077991	17
82	1	BASIN PILLAR TAP	\N	1300	2000	\N	GT045	t	2025-08-20 12:54:16.860052	2025-08-20 12:54:16.860073	18
84	1	BASIN PILLAR TAP	\N	1500	2500	\N	GT028	t	2025-08-20 12:55:22.871015	2025-08-20 12:55:22.871036	18
80	1	Kitchen mixer Wall type	\N	2420	4500	\N	KS6031	t	2025-08-20 12:46:40.374837	2025-08-20 12:55:51.087504	17
42	1	CABINET	\N	10800	12800	3.00	BCP9557	t	2025-08-20 12:01:51.502361	2025-08-23 17:52:00.724184	65
56	1	Kitchen mixer pillar type	\N	2800	5000	\N	GT016	t	2025-08-20 12:20:34.524478	2025-08-21 16:11:14.811501	16
52	1	Basin Mixer	\N	1200	3500	5.00	3002K	t	2025-08-20 12:10:46.042225	2025-08-21 16:04:12.561695	15
58	1	Kitchen mixer pillar type	\N	3000	4500	\N	GT017	t	2025-08-20 12:21:49.735904	2025-08-21 16:12:42.756996	16
64	1	Kitchen mixer pillar type	\N	3800	6500	2.00	LL3009K	t	2025-08-20 12:29:55.376082	2025-08-21 16:17:18.153431	16
62	1	Kitchen mixer pillar type	\N	3800	6500	2.00	LL3009C	t	2025-08-20 12:28:32.569828	2025-08-21 16:18:23.900965	16
41	1	CORNER BASIN	\N	1600	1800	\N		t	2025-08-20 12:00:29.095282	2025-08-26 05:12:35.023864	9
7	1	One piece	\N	14900	17000	4.00	WC306	t	2025-08-20 10:46:05.335769	2025-08-23 15:22:32.744414	1
8	1	One piece	\N	13500	15500	4.00	WC313	t	2025-08-20 10:47:59.929992	2025-08-23 15:25:28.632323	1
9	1	One piece	\N	13500	15500	4.00	WC8078	t	2025-08-20 10:48:36.050823	2025-08-23 15:26:05.623824	1
10	1	One piece	\N	14500	16500	4.00	WC6224	t	2025-08-20 10:49:36.457982	2025-08-23 15:26:46.916423	1
11	1	One piece	\N	16000	18000	1.00	WC501	t	2025-08-20 10:51:50.319245	2025-08-23 15:28:57.215092	1
13	1	Leno Synova	\N	13500	16500	1.00	leno	t	2025-08-20 10:54:41.485372	2025-08-23 15:33:51.643075	1
12	1	One piece	\N	16700	19000	2.00	WC0805	t	2025-08-20 10:52:44.076302	2025-08-23 15:32:55.46192	1
14	1	DYG Sawa	\N	11000	12500	1.00	DYG	t	2025-08-20 10:56:35.084558	2025-08-23 15:34:41.770416	1
43	1	CABINET	\N	10500	12500	3.00	BCP6947	t	2025-08-20 12:02:37.784816	2025-08-23 18:03:33.550086	65
79	1	BIP TAP PEGLER 1/2	\N	260	500	\N		t	2025-08-20 12:46:36.630596	2025-08-23 18:47:32.953608	21
78	1	BIP TAP LIRLEE 1/2	\N	240	450	1.00		t	2025-08-20 12:46:03.551072	2025-08-23 18:47:09.585865	21
37	1	SMALL BASIN COLOURED	\N	950	1300	\N		t	2025-08-20 11:19:22.616207	2025-08-26 04:55:08.042641	9
53	1	KITCHEN WALL TAP SPROUT	\N	1900	3000	\N	GT040	t	2025-08-20 12:14:06.233779	2025-08-26 04:57:23.710489	20
54	1	KITCHEN WALL TAP SPROUT	\N	1900	2000	\N	GT009	t	2025-08-20 12:15:17.982112	2025-08-26 04:57:57.643277	20
16	1	One Piece Square Orient	\N	13500	15500	1.00	1202	t	2025-08-20 10:58:02.100207	2025-08-26 05:02:37.931385	1
45	1	P TRAP FRENCIA	\N	1995	2500	19.00	WC004	t	2025-08-20 12:04:19.249691	2025-08-26 05:13:27.85222	3
46	1	S TRAP	\N	2500	2800	\N		t	2025-08-20 12:04:42.137942	2025-08-26 05:14:23.767217	4
44	1	CABINET	\N	9600	11600	2.00	BCP109	t	2025-08-20 12:03:18.525811	2025-09-02 13:50:27.009918	65
55	1	Basin Mixer	\N	1300	3500	4.00	3014K	t	2025-08-20 12:17:47.413267	2025-09-02 13:50:27.031743	15
86	1	BASIN PILLAR TAP	\N	1320	2500	\N	KS9041	t	2025-08-20 12:58:25.059372	2025-08-20 12:58:25.059398	18
87	1	BASIN PILLAR TAP	\N	1485	3000	\N	EG9618	t	2025-08-20 13:01:57.902875	2025-08-20 13:01:57.902897	18
88	1	BASIN PILLAR TAP	\N	1320	2500	\N	EG6015	t	2025-08-20 13:03:28.530317	2025-08-20 13:03:28.53035	18
98	1	PILLAR LEVER SMALL	\N	850	1500	10.00		t	2025-08-20 13:18:36.872109	2025-08-20 13:18:36.872128	18
101	1	PUSH TAP LIRLEE	\N	1200	2000	10.00		t	2025-08-20 13:23:53.99366	2025-08-20 13:23:53.993679	18
103	1	PILLAR TAP PLASTIC 	\N	120	250	\N		t	2025-08-20 13:25:19.187899	2025-08-20 13:25:19.187912	18
105	1	LAB TAP SILVER	\N	1000	1800	10.00		t	2025-08-20 13:26:48.344469	2025-08-20 13:26:48.344545	19
107	1	LAB TAP BLACK	\N	1200	2000	10.00		t	2025-08-20 13:28:18.194289	2025-08-20 13:28:18.194304	19
109	1	ROSE PILLAR	\N	850	1500	10.00		t	2025-08-20 13:30:08.885048	2025-08-20 13:30:08.885072	20
110	1	KITCHEN PILLAR SPROUT 	\N	580	1000	5.00	W2001K	t	2025-08-20 14:37:51.23139	2025-08-20 14:37:51.231412	19
113	1	PILLAR SPROUT	\N	1080	2000	\N	EG6020	t	2025-08-20 14:44:31.605925	2025-08-20 14:44:31.605952	19
115	1	PILLAR SPROUT 	\N	1500	2500	\N	GT032	t	2025-08-20 14:45:42.477668	2025-08-20 14:45:42.477706	19
116	1	PILLAR SPROUT 	\N	1300	2000	\N	GT026	t	2025-08-20 14:46:18.042838	2025-08-20 14:46:18.042867	19
118	1	PILLAR SPROUT 	\N	1460	2500	\N	KS9044	t	2025-08-20 14:47:02.632626	2025-08-20 14:47:02.632643	19
130	1	LORENZETTI ADVANCED	\N	4605	7000	7.00		t	2025-08-20 15:21:29.41245	2025-08-20 15:21:29.412482	22
131	1	LORENZETTI 4T	\N	2940	4000	5.00		t	2025-08-20 15:22:28.528061	2025-08-20 15:22:28.528088	22
132	1	LORENZETTI 3T	\N	\N	3000	\N		t	2025-08-20 15:23:34.565997	2025-08-20 15:23:34.566013	22
143	1	Magic 4'' Kenplastic 	\N	180	300	-7.00		t	2025-08-20 15:44:37.56492	2025-09-08 13:42:48.061995	40
145	1	Magic 4'' europlus	\N	650	1000	1.00		t	2025-08-20 15:47:19.088522	2025-08-23 13:18:33.67772	40
144	1	Magic 4'' Lirlee	\N	400	750	1.00		t	2025-08-20 15:46:23.682862	2025-08-20 15:46:23.682881	40
155	1	Kenplastic 11/2''	\N	150	200	\N		t	2025-08-20 16:02:26.274131	2025-08-20 16:02:26.274149	43
158	1	Bathroom Accessory Set	\N	3050	4000	3.00	N053AC	t	2025-08-20 16:09:21.263741	2025-08-20 16:09:21.263759	48
159	1	Bathroom Accessory Set	\N	3300	4500	3.00	N053AB	t	2025-08-20 16:10:09.394866	2025-08-20 16:10:09.394888	48
134	1	Basin Mixer Centamily	\N	3000	5000	\N	GT003	t	2025-08-20 15:24:38.143756	2025-08-21 14:52:18.046561	15
114	1	Close Couple	\N	4000	5000	\N		t	2025-08-20 14:45:33.233619	2025-08-21 15:18:53.097551	11
117	1	Ceramic Cistern Top Flush	\N	4500	5000	\N		t	2025-08-20 14:46:56.542483	2025-08-21 15:20:42.337447	11
123	1	Plastic Top Flush Cistern Frencia	\N	1300	2000	1.00		t	2025-08-20 14:55:38.660663	2025-08-21 15:23:37.217137	12
121	1	Plastic Top Flush Cistern Kenplastic	\N	900	1100	\N		t	2025-08-20 14:54:03.973048	2025-08-21 15:26:46.46358	12
119	1	Plastic Top Flush Cistern Orient	\N	1250	1600	\N		t	2025-08-20 14:52:21.847524	2025-08-21 15:27:48.894791	12
122	1	Plastic Top Flush Cistern Sino	\N	950	1300	\N		t	2025-08-20 14:54:57.80191	2025-08-21 15:28:54.975024	12
124	1	Plastic cistern Low Level	\N	850	1150	\N		t	2025-08-20 14:58:38.799842	2025-08-21 15:29:51.338026	12
125	1	Plastic cistern High Level	\N	850	1150	\N		t	2025-08-20 14:59:50.259034	2025-08-21 15:30:28.567457	12
127	1	Automatic cistern urinal ceramic	\N	7500	9500	\N		t	2025-08-20 15:01:53.695189	2025-08-21 15:31:35.948207	13
126	1	Automatic cistern urinal plastic	\N	2700	3500	\N		t	2025-08-20 15:01:17.652231	2025-08-21 15:32:03.962108	13
129	1	Medium Urinal	\N	2800	4500	\N		t	2025-08-20 15:04:02.877132	2025-08-21 15:32:51.601453	14
128	1	Small urinal	\N	1600	1800	\N		t	2025-08-20 15:03:19.267851	2025-08-21 15:33:54.840686	14
137	1	Basin Mixer Centamily	\N	2800	5000	\N	GT001	t	2025-08-20 15:28:28.576864	2025-08-21 15:37:49.809281	15
138	1	Basin Mixer Centamily	\N	3200	5000	\N	GT093	t	2025-08-20 15:29:16.058746	2025-08-21 15:41:39.532313	15
139	1	Basin Mixer Nemsi	\N	2420	4500	\N	EG9615	t	2025-08-20 15:30:44.451158	2025-08-21 15:46:32.154557	15
140	1	Basin Mixer Nemsi	\N	2900	5000	\N	BM2050G	t	2025-08-20 15:31:31.156681	2025-08-21 15:47:08.24954	15
141	1	Basin Mixer Nemsi	\N	2145	4500	\N	BM2050	t	2025-08-20 15:32:33.019273	2025-08-21 15:47:52.693037	15
142	1	Basin Mixer Nemsi	\N	2085	4500	\N	KS1009	t	2025-08-20 15:34:02.999646	2025-08-21 15:48:33.570103	15
93	1	Kitchen mixer wall type	\N	2800	4500	\N	GT002	t	2025-08-20 13:12:28.953647	2025-08-21 16:24:50.74574	17
94	1	Kitchen mixer wall type	\N	3500	5000	\N	GT071	t	2025-08-20 13:13:49.846843	2025-08-21 16:25:30.842166	17
162	1	Soap Dish Big Silver	\N	400	800	30.00	N123M	t	2025-08-20 16:23:48.14157	2025-09-01 12:49:28.377756	49
149	1	Magic 11/4'' grey	\N	190	450	25.00		t	2025-08-20 15:56:06.345845	2025-09-08 13:42:48.069861	42
99	1	SQUARE TAP LIRLEE SILVER	\N	900	1500	8.00		t	2025-08-20 13:20:10.037708	2025-09-13 11:39:48.325714	18
146	1	Magic 11/2'' grey	\N	180	450	29.00		t	2025-08-20 15:50:27.085476	2025-09-02 13:50:27.024269	41
90	1	Kitchen mixer wall type	\N	2970	5000	1.00	KM3051B	t	2025-08-20 13:07:30.49544	2025-08-26 05:01:43.714529	17
104	1	Plastic Pillar Sprout Knob	\N	305	650	\N		t	2025-08-20 13:26:11.732844	2025-08-26 05:04:53.203668	19
106	1	Pillar Sprout Plastic Lever	\N	305	650	\N		t	2025-08-20 13:27:32.728833	2025-08-26 05:06:40.430328	19
111	1	PILLAR SPROUT 	\N	1230	2500	\N	KS103i	t	2025-08-20 14:42:33.761575	2025-08-26 05:08:00.14137	19
112	1	Ceramic Cistern Low Level	\N	3000	3500	10.00		t	2025-08-20 14:44:26.966153	2025-08-26 05:15:52.171039	11
97	1	Kitchen mixer knob lirlee	\N	1200	2500	5.00		t	2025-08-20 13:17:06.413626	2025-08-26 05:20:32.698517	15
150	1	Magic 1 1/4'' chrome	\N	190	350	24.00		t	2025-08-20 15:56:48.200036	2025-08-27 15:28:39.853577	42
157	1	Bathroom Accessory Set	\N	2290	3500	-4.00	N053B	t	2025-08-20 16:08:00.430732	2025-08-28 13:59:22.940862	48
153	1	Bottle Trap Kenplastic 11/4	\N	150	200	10.00		t	2025-08-20 16:00:38.129238	2025-08-30 13:02:33.079464	44
151	1	Magic 11/4'' KenPlastic	\N	90	200	11.00		t	2025-08-20 15:57:34.569177	2025-09-09 15:02:23.643457	42
156	1	Bathroom Accessory Set	\N	2035	3000	3.00	N053M	t	2025-08-20 16:06:02.265704	2025-09-09 15:03:51.100677	48
96	1	PILLAR LEVER BIG 	\N	880	1800	8.00		t	2025-08-20 13:16:07.563503	2025-09-08 13:42:48.086285	18
147	1	Magic 11/2' chrome 	\N	200	350	49.00		t	2025-08-20 15:52:54.468765	2025-08-30 13:32:11.013533	41
92	1	PILLAR TAP STAR Lirlee	\N	380	600	30.00		t	2025-08-20 13:10:20.389371	2025-08-30 13:59:41.967677	18
102	1	PILLAR ELBOW ACTION 	\N	1050	1500	5.00		t	2025-08-20 13:24:42.138681	2025-08-30 16:07:54.595486	18
163	1	Soap Dish Big Black	\N	450	900	26.00	N123B	t	2025-08-20 16:25:08.010898	2025-09-01 12:50:33.627911	49
89	1	PILLAR TAP KNOB Jawa	\N	380	700	48.00		t	2025-08-20 13:04:57.861792	2025-09-09 15:02:23.650482	18
152	1	Viega 11/4	\N	140	250	8.00		t	2025-08-20 15:59:34.848906	2025-09-09 15:03:51.1104	44
148	1	Magic 11/2'' Kenplastic 	\N	90	200	26.00		t	2025-08-20 15:54:15.379018	2025-09-05 14:44:01.987981	41
167	1	Soap Dish	\N	370	650	10.00	N122B	t	2025-08-20 16:29:55.649281	2025-08-20 16:29:55.649303	49
172	1	Soap Dish	\N	265	650	8.00	N340	t	2025-08-20 16:35:11.106321	2025-08-20 16:35:11.106335	49
173	1	Soap Dish	\N	275	650	6.00	N340B	t	2025-08-20 16:36:04.226238	2025-08-20 16:36:04.226256	49
174	1	Soap Dish	\N	305	450	10.00	N092AC	t	2025-08-20 16:37:22.673454	2025-08-20 16:37:22.673468	49
176	1	Soap Dish	\N	285	450	10.00	N092AB	t	2025-08-20 16:38:54.888236	2025-08-20 16:38:54.888255	49
181	1	Soap Dish	\N	205	450	6.00	N147MATT	t	2025-08-20 16:42:22.259005	2025-08-20 16:42:22.25902	49
183	1	Soap Dish	\N	165	450	10.00	N080	t	2025-08-20 16:44:28.064861	2025-08-20 16:44:28.06488	49
185	1	Soap Dish	\N	430	650	1.00	N027	t	2025-08-20 16:46:00.126364	2025-08-20 16:46:00.126424	49
187	1	Soap Dish	\N	275	450	10.00	N036	t	2025-08-20 16:47:12.859718	2025-08-20 16:47:12.859742	49
189	1	Tissue Holder 	\N	870	1200	6.00	N016	t	2025-08-20 16:49:37.8916	2025-08-20 16:50:11.453974	50
190	1	Tissue Holder	\N	375	1000	6.00	N017	t	2025-08-20 16:52:10.999504	2025-08-20 16:52:10.99953	50
191	1	SHOWER RISER 	\N	5100	12000	3.00	8011K	t	2025-08-20 16:52:47.873298	2025-08-20 16:52:47.873314	23
192	1	Tissue Holder	\N	975	2000	5.00	N269	t	2025-08-20 16:53:28.959149	2025-08-20 16:53:28.959162	50
194	1	Tissue Holder	\N	530	1000	5.00	N059	t	2025-08-20 16:55:48.073495	2025-08-20 16:55:48.073523	50
195	1	SHOWER RISER	\N	5900	14500	3.00	8017C	t	2025-08-20 16:58:31.139969	2025-08-20 16:58:31.140013	23
197	1	Europenize  Tissue Holder Black	\N	190	450	10.00		t	2025-08-20 17:03:53.676405	2025-08-20 17:03:53.676432	50
198	1	Tissue Holder	\N	470	1000	5.00	N268	t	2025-08-20 17:04:50.528704	2025-08-20 17:04:50.528718	50
199	1	Tissue Holder	\N	470	1000	5.00	N268AB	t	2025-08-20 17:06:10.613625	2025-08-20 17:06:10.613673	50
200	1	Plastic Tissue Holder	\N	250	450	20.00		t	2025-08-20 17:07:46.771308	2025-08-20 17:07:46.771328	50
201	1	SHOWER MIXER NORMAL	\N	3500	6500	1.00		t	2025-08-20 17:12:55.863732	2025-08-20 17:12:55.86375	24
203	1	Phone Tissue Black 	\N	600	1000	20.00	N131B	t	2025-08-20 17:16:09.954419	2025-08-20 17:16:09.954463	50
207	1	Alpha Tissue Pink	\N	600	1000	1.00		t	2025-08-20 17:20:49.710827	2025-08-20 17:20:49.710857	50
210	1	Towel Bar	\N	1840	3000	5.00	N050B	t	2025-08-20 17:25:53.680151	2025-08-20 17:25:53.680173	51
213	1	Towel Bar	\N	530	1200	5.00	N061	t	2025-08-20 17:28:18.170261	2025-08-20 17:28:18.170292	51
212	1	Towel Bar	\N	1915	3500	5.00	N051	t	2025-08-20 17:27:07.506442	2025-08-20 17:28:57.078151	51
214	1	PLASTIC SHOWER ROSE	\N	50	100	\N		t	2025-08-20 17:29:38.341294	2025-08-20 17:29:38.341308	25
215	1	Towel Bar	\N	1705	3500	\N	N220	t	2025-08-20 17:31:10.678797	2025-08-20 17:31:10.678813	51
216	1	Towel Bar	\N	1815	3500	5.00	N221	t	2025-08-20 17:32:03.003327	2025-08-20 17:32:03.003342	51
217	1	Towel Bar	\N	1690	3500	5.00	N193	t	2025-08-20 17:32:57.589227	2025-08-20 17:32:57.589244	51
219	1	Double Towel Bar Silver	\N	800	1500	10.00		t	2025-08-20 17:35:00.379887	2025-08-20 17:35:00.379904	51
220	1	Single Towel Bar Black	\N	500	800	1.00		t	2025-08-20 17:35:42.077871	2025-08-20 17:35:42.077889	51
221	1	Double Towel Bar Black	\N	850	1500	1.00		t	2025-08-20 17:36:17.055524	2025-08-20 17:36:17.055538	51
71	1	ROSE WALL 	\N	850	1500	9.00		t	2025-08-20 12:40:55.456279	2025-08-21 10:42:11.123832	20
120	1	Plastic Top Flush Cistern Shoshona	\N	1250	1600	\N		t	2025-08-20 14:53:13.955883	2025-08-21 15:28:16.180876	12
222	1	LARGE URINAL BOWLS	\N	5500	7500	\N		t	2025-08-21 15:35:50.808483	2025-08-21 15:35:50.80851	14
223	1	URINAL TWYFORD	\N	6500	7500	\N		t	2025-08-21 15:37:10.466769	2025-08-21 15:37:10.466785	14
135	1	Basin Mixer Centamily	\N	3200	5000	\N	GT014	t	2025-08-20 15:24:56.903394	2025-08-21 15:40:04.178168	15
228	1	M|adpter 25*3/4	\N	25	50	\N		t	2025-08-21 16:23:06.438717	2025-08-21 16:23:06.43874	46
226	1	M|adpter 20*1/2	\N	19	40	0.00		t	2025-08-21 16:10:31.623554	2025-08-21 16:13:58.221479	46
227	1	M|adpter 25*1/2	\N	21	40	\N		t	2025-08-21 16:13:40.034135	2025-08-21 16:20:59.593103	46
229	1	M|adpter 32*1	\N	43	80	0.00		t	2025-08-21 16:24:38.473731	2025-08-21 16:24:38.473752	46
230	1	M|adpter 40*1	\N	63	120	\N		t	2025-08-21 16:25:48.080108	2025-08-21 16:25:48.080128	46
95	1	Kitchen mixer star lirlee	\N	1300	2500	5.00		t	2025-08-20 13:15:49.439704	2025-08-21 16:27:37.547699	17
231	1	M|adpter 40*11/4	\N	96	150	0.00		t	2025-08-21 16:28:25.581667	2025-08-21 16:28:25.58169	46
232	1	M|adpter 50*11/2	\N	120	200	0.00		t	2025-08-21 16:30:42.734933	2025-08-21 16:30:42.734958	46
233	1	M|adpter 63*2	\N	185	250	\N		t	2025-08-21 16:36:44.425267	2025-08-21 16:36:44.425301	46
234	1	f|adapter 20*1/2	\N	18	40	\N		t	2025-08-21 17:25:37.409199	2025-08-21 17:25:37.409223	46
235	1	f|adapter 25*1/2	\N	19	40	\N		t	2025-08-21 17:27:00.481463	2025-08-21 17:27:00.481487	46
236	1	f|adapter 25*3/4	\N	22	50	\N		t	2025-08-21 17:28:29.708789	2025-08-21 17:28:29.708814	46
237	1	f|adapter 32*1	\N	38	80	0.00		t	2025-08-21 17:29:55.868195	2025-08-21 17:29:55.86822	46
168	1	Soap Dish	\N	285	450	6.00	N147AB	t	2025-08-20 16:31:13.61867	2025-08-23 13:05:10.867592	49
165	1	Soap Dish Nemsi	https://res.cloudinary.com/dxyewzvnr/image/upload/v1756034978/abz_products/zxrz4cwxhvqxdvs7spqs.jpg	230	400	10.00	N092M	t	2025-08-20 16:28:28.751982	2025-09-01 12:44:49.515977	49
202	1	Phone Tissue Silver	\N	500	900	39.00	N131M	t	2025-08-20 17:14:59.924971	2025-09-02 14:06:19.911687	50
175	1	ENERSHOWER 4T	\N	2300	3500	1.00		t	2025-08-20 16:38:07.890202	2025-08-24 12:26:58.660223	22
188	1	SHOWER RISER	\N	7600	15000	3.00	8031H	t	2025-08-20 16:48:49.05818	2025-08-24 13:33:09.359264	23
204	1	CONCELED SHOWER 4 WAY BRIMIX	\N	5500	7500	1.00		t	2025-08-20 17:17:41.541063	2025-08-24 13:42:32.657742	38
211	1	CONCEALED SHOWER 4 WAY EZURI	\N	6000	9500	\N		t	2025-08-20 17:26:09.756269	2025-08-24 13:45:52.540433	38
169	1	ENERDUCHA 3T	\N	2200	3000	1.00		t	2025-08-20 16:31:14.914099	2025-08-26 05:43:12.152607	22
180	1	Shower Head SQUARE BLACK 	\N	900	1800	\N		t	2025-08-20 16:42:18.469845	2025-08-26 05:44:51.552752	26
182	1	Shower Head ROUND SILVER	\N	700	1200	\N		t	2025-08-20 16:43:53.198962	2025-08-26 05:45:57.971489	26
184	1	Shower Head APPLE PINK/GREEN 	\N	700	1200	\N		t	2025-08-20 16:45:25.749818	2025-08-26 05:47:28.181991	26
178	1	Soap Dish	\N	275	450	5.00	N212	t	2025-08-20 16:40:44.991011	2025-09-01 12:24:34.575822	49
206	1	FUFU Tissue Blue	\N	400	750	10.00		t	2025-08-20 17:19:28.057422	2025-08-26 05:49:20.970818	50
209	1	Tissue Holder	\N	165	450	9.00	N081	t	2025-08-20 17:22:55.036449	2025-08-28 13:09:13.414219	50
205	1	FUFU Tissue Gold	\N	400	750	10.00		t	2025-08-20 17:18:31.349191	2025-08-30 16:02:46.186411	50
171	1	Soap Dish	\N	285	450	8.00	N147AC	t	2025-08-20 16:34:02.513925	2025-09-01 12:27:00.900766	49
218	1	Single Towel Bar Silver	\N	480	750	-5.00		t	2025-08-20 17:33:54.172468	2025-09-05 12:29:43.527401	51
196	1	Europenize  Tissue Holder Silver 	\N	180	350	-1.00		t	2025-08-20 16:59:55.937466	2025-09-05 12:29:43.544475	50
164	1	Soap Dish	\N	120	250	0.00	N028	t	2025-08-20 16:27:02.133625	2025-09-05 14:44:01.923077	49
186	1	SHOWER RISER	\N	5000	10000	2.00	8011	t	2025-08-20 16:46:46.655689	2025-09-09 15:03:51.117971	23
238	1	f|adapter 40*11/4	\N	85	150	\N		t	2025-08-21 17:30:53.331485	2025-08-21 17:30:53.33152	46
239	1	f|adapter 50*11/2	\N	110	200	\N		t	2025-08-21 17:32:59.770848	2025-08-21 17:32:59.770878	46
240	1	f|adapter 63*2	\N	170	250	\N		t	2025-08-21 17:38:26.257713	2025-08-21 17:38:26.257738	46
241	1	PPR Socket 20mm	\N	3	15	\N		t	2025-08-21 17:41:28.137558	2025-08-21 17:41:28.137583	46
243	1	PPR Socket 32mm	\N	8	30	\N		t	2025-08-21 17:43:01.934236	2025-08-21 17:43:01.934264	46
244	1	PPR Socket 40mm	\N	15	40	\N		t	2025-08-21 17:44:48.303325	2025-08-21 17:44:48.303354	46
245	1	PPR Socket 50mm	\N	25	50	\N		t	2025-08-21 17:46:22.677958	2025-08-21 17:46:22.677982	46
246	1	PPR Socket 63mm	\N	45	100	\N		t	2025-08-21 17:47:39.843408	2025-08-21 17:47:39.843427	46
285	1	M|Elbow 25*3/4	\N	30	50	0.00		t	2025-08-23 14:03:41.95442	2025-08-23 14:03:41.954445	46
286	1	M|Elbow 32*3/4	\N	36	80	0.00		t	2025-08-23 14:04:56.555789	2025-08-23 14:04:56.555818	46
287	1	M|Elbow 32*1	\N	50	80	\N		t	2025-08-23 14:05:55.762614	2025-08-23 14:05:55.762646	46
15	1	ZYG Sawa	https://res.cloudinary.com/dxyewzvnr/image/upload/v1755948052/abz_products/dljobgc27rtmevbexlxt.jpg	9500	11000	1.00	ZYG	t	2025-08-20 10:57:13.638315	2025-08-23 15:35:22.885641	1
256	1	CHANDELIAR	\N	3000	7000	4.00	40002	t	2025-08-22 08:25:35.770275	2025-08-22 08:25:35.770308	54
257	1	CHANDELIAR	\N	7500	10000	3.00	F617L	t	2025-08-22 08:29:21.556455	2025-08-22 08:29:21.556488	54
170	1	Soap Dish	https://res.cloudinary.com/dxyewzvnr/image/upload/v1755948013/abz_products/bw24nshbnfddqfhyjuql.jpg	330	650	10.00	N195	t	2025-08-20 16:32:45.728997	2025-08-23 11:20:14.037291	49
247	1	WALL BRACKET	\N	900	1500	4.00	5963	t	2025-08-21 18:06:00.033223	2025-08-23 11:54:52.999787	55
248	1	WALL BRACKET	\N	1100	2500	4.00	BD2055	t	2025-08-21 18:12:24.026551	2025-08-23 11:56:54.095368	55
249	1	WALL BRACKET	\N	800	1500	4.00	BD2171/1W	t	2025-08-22 07:35:47.919773	2025-08-23 11:58:07.425491	55
250	1	WALL BRACKET	\N	800	1500	5.00	6051F	t	2025-08-22 07:39:57.172834	2025-08-23 11:59:57.894712	55
251	1	WALL BRACKET	\N	900	1500	4.00	BD2007B/1W	t	2025-08-22 07:41:27.979236	2025-08-23 12:02:09.820844	55
258	1	WALL BRACKET	\N	900	1500	4.00	BD2057/1W	t	2025-08-23 12:04:16.688156	2025-08-23 12:04:16.68819	55
252	1	WALL BRACKET	\N	700	1500	4.00	3538-1A	t	2025-08-22 08:04:40.451127	2025-08-23 12:05:58.63175	55
253	1	WALL BRACKET	\N	800	1500	5.00	BD2060/1W	t	2025-08-22 08:07:34.085845	2025-08-23 12:06:27.934811	55
254	1	CHANDELIAR	\N	4500	8000	4.00	LH80402+2	t	2025-08-22 08:16:57.437842	2025-08-23 12:07:17.202546	54
255	1	CHANDELIAR	\N	3800	7000	4.00	LH80399+2/500	t	2025-08-22 08:22:34.934058	2025-08-23 12:16:01.906623	54
259	1	CHANDELIAR	\N	4100	8000	4.00	DS-2685X4	t	2025-08-23 12:18:13.61455	2025-08-23 12:18:13.614569	54
260	1	CHANDELIAR	\N	3000	6500	\N	CH40003	t	2025-08-23 12:20:53.889578	2025-08-23 12:20:53.889599	54
261	1	CHANDELIAR	\N	9500	13000	2.00	D8016/600	t	2025-08-23 12:22:14.057419	2025-08-23 12:22:14.057439	54
262	1	CHANDELIAR	\N	7500	11000	3.00	CH2001/800/300	t	2025-08-23 12:23:09.441146	2025-08-23 12:23:09.441161	54
263	1	CHANDELIAR	\N	4200	8000	4.00	CH2002/400	t	2025-08-23 12:24:12.344044	2025-08-23 12:24:12.344079	54
264	1	CHANDELIAR	\N	9500	13000	2.00	CH3009	t	2025-08-23 12:27:13.070669	2025-08-23 12:27:13.070698	54
265	1	WALL BRACKET 	\N	700	1500	5.00	BD2011/1W	t	2025-08-23 12:28:19.715007	2025-08-23 12:28:19.71502	55
267	1	WALL BRACKET 	\N	700	1500	5.00	BD2007/1W	t	2025-08-23 12:29:57.515549	2025-08-23 12:29:57.515564	55
268	1	WALL BRACKET 	\N	800	1500	5.00	BD2061/1W	t	2025-08-23 12:31:05.197403	2025-08-23 12:31:21.662117	55
269	1	WALL BRACKET 	\N	1000	2500	5.00	SF2507	t	2025-08-23 12:32:36.353028	2025-08-23 12:32:36.353057	55
270	1	WALL BRACKET 	\N	1000	2500	5.00	Y-11-1	t	2025-08-23 12:33:15.239721	2025-08-23 12:33:15.239739	55
266	1	WALL BRACKET 	\N	700	1500	5.00	BD2012/1W	t	2025-08-23 12:29:04.876886	2025-08-23 12:35:09.200857	55
271	1	GYOSUM	\N	770	850	\N		t	2025-08-23 12:42:57.309819	2025-08-23 12:42:57.309843	56
273	1	PARTICLE BOARD	\N	2730	3300	\N		t	2025-08-23 12:45:40.299062	2025-08-23 12:45:40.299085	58
274	1	MARINE BOARD 	\N	1900	2500	\N		t	2025-08-23 12:50:01.888184	2025-08-23 12:50:01.888205	59
275	1	PLYWOOD 3MM	\N	330	450	\N		t	2025-08-23 12:51:57.364293	2025-08-23 12:51:57.364318	60
276	1	PLYWOOD 6MM	\N	820	950	\N		t	2025-08-23 12:52:36.467677	2025-08-23 12:52:36.467696	60
277	1	PLYWOOD 9MM	\N	1300	1450	\N		t	2025-08-23 12:53:22.884253	2025-08-23 12:53:22.884276	60
278	1	PLYWOOD 12MM	\N	1840	2000	\N		t	2025-08-23 12:53:59.122236	2025-08-23 12:53:59.122268	60
279	1	GRANITE	\N	6500	9000	\N		t	2025-08-23 12:56:33.214271	2025-08-23 12:56:33.214291	61
280	1	GRANITE	\N	15500	18000	\N	WHITE GALAXY	t	2025-08-23 12:58:21.258607	2025-08-23 12:59:14.090695	62
281	1	GRANITE	\N	16000	18000	\N	BLACK GALAXY	t	2025-08-23 13:00:38.486984	2025-08-23 13:00:38.487015	62
70	1	WALL SPROUT KNOB LIRLEE	\N	580	900	10.00		f	2025-08-20 12:38:44.700068	2025-08-23 13:09:44.178296	20
136	1	Basin Mixer Centamily	https://res.cloudinary.com/dxyewzvnr/image/upload/v1755954666/abz_products/kekt7vrqcdf0ezyw8p9y.jpg	3500	5000	\N	GT015	t	2025-08-20 15:27:32.348184	2025-08-23 13:11:07.136898	15
208	1	Alpha Tissue Blue	https://res.cloudinary.com/dxyewzvnr/image/upload/v1755956799/abz_products/gnd5ya8epdjpvv6g1bcd.jpg	600	1000	1.00		t	2025-08-20 17:21:42.009922	2025-08-23 13:46:39.875063	50
283	1	M|Elbow 20*1/2	\N	20	40	0.00		t	2025-08-23 13:53:40.673196	2025-08-23 13:53:40.673221	46
284	1	M|Elbow 25*1/2	\N	23	40	0.00		t	2025-08-23 14:02:42.943583	2025-08-23 14:02:42.943603	46
288	1	Blossom Seat	\N	2145	3145	9.00	WC009	t	2025-08-23 16:49:30.06706	2025-08-23 16:51:19.12615	64
289	1	Blossom cistern 	\N	2770	3500	9.00	WC009	t	2025-08-23 16:50:21.774585	2025-08-23 16:52:18.070184	11
291	1	SQAURE TAP BLACK	\N	950	1800	10.00		t	2025-08-23 16:55:55.849474	2025-08-23 16:55:55.849503	18
290	1	Blossom Seat cover	\N	600	800	9.00	WC009	t	2025-08-23 16:53:41.392108	2025-08-23 16:56:01.744191	63
293	1	Blossom Seat	\N	4900	5900	10.00	WC029	t	2025-08-23 16:59:32.451711	2025-08-23 16:59:32.451734	64
294	1	Blossom cistern 	\N	2180	3180	10.00	WC029	t	2025-08-23 17:00:30.36192	2025-08-23 17:00:30.361941	11
298	1	Frencia Seat Cover	\N	600	800	9.00	WC008	t	2025-08-23 17:09:09.111074	2025-08-23 17:09:09.111097	63
299	1	Frencia Seat	\N	2200	3200	10.00	WC009	t	2025-08-23 17:10:40.412131	2025-08-23 17:10:40.412149	64
300	1	Frencia Cistern	\N	2825	3625	6.00	WC009	t	2025-08-23 17:12:04.561184	2025-08-23 17:12:04.561216	11
301	1	Frencia Seat Cover	\N	600	800	10.00	WC009	t	2025-08-23 17:13:17.898146	2025-08-23 17:13:17.898179	63
302	1	Frencia Seat	\N	4000	5000	0.00	WC100	t	2025-08-23 17:15:26.903978	2025-08-23 17:15:26.90401	64
303	1	Frencia Cistern	\N	2550	3600	0.00	WC100	t	2025-08-23 17:17:20.685191	2025-08-23 17:17:20.685221	11
304	1	Frencia Seat	\N	4000	5000	6.00	WC664	t	2025-08-23 17:19:44.945088	2025-08-23 17:19:44.945113	64
305	1	Frencia Cistern	\N	2700	2800	6.00	WC664	t	2025-08-23 17:22:08.805712	2025-08-23 17:22:08.80574	11
306	1	KITCHEN WALL TAP SPROUT	\N	1900	3000	\N	GT040	t	2025-08-23 17:24:28.469348	2025-08-23 17:24:28.469366	20
297	1	Frencia Cistern	\N	2770	3600	8.00	WC008	t	2025-08-23 17:08:06.428134	2025-08-24 11:10:59.440478	11
242	1	PPR Socket 25mm	\N	5	20	-15.00		t	2025-08-21 17:42:07.251782	2025-08-28 12:38:56.320271	46
296	1	Frencia Seat	\N	2300	3300	8.00	WC008	t	2025-08-23 17:06:42.703088	2025-09-10 13:53:09.662141	64
307	1	KITHEN WALL TAP SPROUT	\N	1300	2000	\N	GT009	t	2025-08-23 17:25:22.129512	2025-08-23 17:25:22.129545	20
308	1	Frencia Seat	\N	7000	9000	1.00	WC029	t	2025-08-23 17:25:34.938193	2025-08-23 17:25:34.938208	64
309	1	Frencia Cistern	\N	3120	4200	1.00	WC029	t	2025-08-23 17:27:33.124332	2025-08-23 17:27:33.124358	11
311	1	Cabinet Mirror	\N	3400	5500	3.00	BCP109	t	2025-08-23 17:57:53.515977	2025-08-23 17:57:53.515999	66
317	1	Basin Frencia	\N	1745	2750	3.00	B828	t	2025-08-23 18:41:06.83301	2025-08-23 18:41:06.833036	67
322	1	Basin Blossom 	\N	\N	\N	\N	B778	t	2025-08-24 09:22:50.061296	2025-08-24 09:22:50.061317	67
327	1	F|Elbow 20*1/2	\N	18	40	\N		t	2025-08-24 09:35:23.868764	2025-08-24 09:35:23.868784	46
329	1	F|Elbow 25*3/4	\N	26	50	\N		t	2025-08-24 09:41:31.456498	2025-08-24 09:41:31.456525	46
330	1	F|Elbow 32*1	\N	45	80	\N		t	2025-08-24 09:45:55.330011	2025-08-24 09:45:55.330044	46
310	1	Cabinet Mirror	\N	2750	4750	3.00	BCP9557	t	2025-08-23 17:53:52.703704	2025-08-23 17:53:52.703746	66
312	1	Cabinet Mirror	\N	4200	6500	3.00	BCP6947	t	2025-08-23 18:05:01.368013	2025-08-23 18:05:01.36805	66
313	1	Basin Frencia	\N	1489	2250	9.00	B326	t	2025-08-23 18:24:32.673918	2025-08-23 18:24:32.673955	67
314	1	Pedestal Frencia	\N	1470	2250	9.00	P326	t	2025-08-23 18:32:02.719921	2025-08-23 18:32:02.71994	68
315	1	Basin Frencia	\N	1800	2400	22.00	B778	t	2025-08-23 18:33:30.038058	2025-08-23 18:33:30.038081	67
316	1	Pedestal Frencia	\N	1515	2400	22.00	B207	t	2025-08-23 18:38:10.417061	2025-08-23 18:38:10.417111	68
318	1	Pedestal Frencia	\N	1865	2750	3.00	P828	t	2025-08-23 18:43:24.899058	2025-08-23 18:44:02.760552	68
319	1	KITCHEN WALL SPROUT 	\N	1505	2500	\N	KS9045	t	2025-08-23 18:44:17.866004	2025-08-23 18:44:17.866016	19
321	1	Pedestal Blossom	\N	\N	\N	\N	P326	t	2025-08-23 18:46:49.848636	2025-08-23 18:46:49.848676	68
320	1	Basin Blossom 	\N	\N	\N	\N	B326	t	2025-08-23 18:45:43.229846	2025-08-24 09:16:59.956833	67
323	1	Pedestal Blossom	\N	\N	\N	\N	P207	t	2025-08-24 09:24:31.805991	2025-08-24 09:24:31.806011	7
324	1	M|Elbow 40*1 1/4	\N	105	150	\N		t	2025-08-24 09:30:28.598237	2025-08-24 09:30:28.598266	46
325	1	M|Elbow 50*1 1/2	\N	185	250	\N		t	2025-08-24 09:32:03.009207	2025-08-24 09:32:03.009245	46
326	1	M|Elbow 63*2	\N	265	350	\N		t	2025-08-24 09:33:03.182738	2025-08-24 09:33:03.182763	46
331	1	F|Elbow 40*1 1/4	\N	94	150	\N		t	2025-08-24 09:47:19.826834	2025-08-24 09:47:19.826861	46
332	1	F|Elbow 50*1 1/2	\N	150	250	\N		t	2025-08-24 09:49:34.195597	2025-08-24 09:49:34.19562	46
333	1	F|Elbow 63*2	\N	245	350	\N		t	2025-08-24 09:50:32.258579	2025-08-24 09:50:32.25862	46
334	1	PPR Elbow 20''	\N	5	20	\N		t	2025-08-24 09:52:47.787222	2025-08-24 09:52:47.787246	46
337	1	PPR Elbow 40''	\N	27	40	\N		t	2025-08-24 09:55:27.509837	2025-08-24 09:55:27.509864	46
338	1	PPR Elbow 50''	\N	46	60	\N		t	2025-08-24 09:56:43.647146	2025-08-24 09:56:43.647173	46
339	1	PPR Elbow 63''	\N	90	150	\N		t	2025-08-24 10:00:08.648031	2025-08-24 10:00:08.648062	46
341	1	M|Tee 20*1/2	\N	24	50	\N		t	2025-08-24 10:03:19.442117	2025-08-24 10:03:19.442161	46
342	1	M|Tee 25*1/2	\N	25	50	\N		t	2025-08-24 10:04:17.421325	2025-08-24 10:04:17.421355	46
343	1	M|Tee 25*3/4	\N	32	60	\N		t	2025-08-24 10:05:07.206315	2025-08-24 10:05:07.206339	46
344	1	M|Tee 40*1 1/4	\N	110	150	\N		t	2025-08-24 10:06:41.676584	2025-08-24 10:06:41.67662	46
345	1	M|Tee 32*1''	\N	56	80	\N		t	2025-08-24 10:09:11.666843	2025-08-24 10:09:11.666862	46
346	1	F|Tee 20*1/2	\N	21	40	\N		t	2025-08-24 10:11:21.792057	2025-08-24 10:11:21.792084	46
347	1	F|Tee 25*1/2	\N	24	50	\N		t	2025-08-24 10:13:55.308047	2025-08-24 10:13:55.308073	46
348	1	F|Tee 25*3/4	\N	30	60	\N		t	2025-08-24 10:14:55.999529	2025-08-24 10:14:55.999557	46
349	1	F|Tee 32*1	\N	50	80	\N		t	2025-08-24 10:18:00.542226	2025-08-24 10:18:00.542249	46
350	1	F|Tee 40*1 1/4	\N	105	150	\N		t	2025-08-24 10:21:12.650281	2025-08-24 10:21:12.650306	46
351	1	PPR Tee 20mm	\N	7	20	\N		t	2025-08-24 10:24:13.834959	2025-08-24 10:24:13.834983	46
353	1	PPR Tee 32mm	\N	17	35	\N		t	2025-08-24 10:26:37.48189	2025-08-24 10:26:37.48191	46
354	1	PPR Tee 40mm	\N	31	50	\N		t	2025-08-24 10:28:04.297807	2025-08-24 10:28:04.297839	46
355	1	PPR Tee 50mm	\N	55	80	\N		t	2025-08-24 10:28:46.548929	2025-08-24 10:28:46.548943	46
356	1	PPR Tee 63mm	\N	105	150	\N		t	2025-08-24 10:29:39.687037	2025-08-24 10:29:39.687072	46
357	1	PPR Union 20mm	\N	12	50	\N		t	2025-08-24 10:32:39.929086	2025-08-24 10:32:39.929108	46
358	1	PPR Union 25mm	\N	17	60	\N		t	2025-08-24 10:33:33.215321	2025-08-24 10:33:33.215343	46
361	1	PVC BEND 4*45	\N	90	150	\N		t	2025-08-24 10:36:54.521446	2025-08-24 10:36:54.521483	45
363	1	PVC BEND 3*90	\N	90	150	\N		t	2025-08-24 10:37:56.57986	2025-08-24 10:37:56.57989	45
364	1	R|Socket 25*20	\N	6	20	\N		t	2025-08-24 10:38:47.705311	2025-08-24 10:38:47.705345	46
365	1	PVC  BEND 3*45	\N	90	150	\N		t	2025-08-24 10:38:50.941948	2025-08-24 10:38:50.941964	45
366	1	PVC BEND 2*90	\N	30	60	\N		t	2025-08-24 10:39:42.555897	2025-08-24 10:39:42.555921	45
369	1	PVC BEND 1 1/2*45	\N	25	50	\N		t	2025-08-24 11:00:03.074219	2025-08-24 11:00:03.074239	45
272	1	MDF BOARDS	\N	2900	3500	\N		t	2025-08-23 12:44:17.388634	2025-08-24 11:10:35.935721	57
370	1	PVC BEND 1 1/4*90	\N	20	40	\N		t	2025-08-24 11:36:01.599508	2025-08-24 11:36:01.599527	45
371	1	PVC BEND 1 1/4*45	\N	20	40	\N		t	2025-08-24 11:37:06.391413	2025-08-24 11:37:06.391429	45
372	1	PVC TEE 4 INCH	\N	150	250	\N		t	2025-08-24 11:38:12.67474	2025-08-24 11:38:12.674767	45
373	1	PVC TEE 3 INCH	\N	110	200	\N		t	2025-08-24 11:38:46.635426	2025-08-24 11:38:46.635455	45
375	1	PVC TEE 1 1/2	\N	30	50	\N		t	2025-08-24 11:39:50.147518	2025-08-24 11:39:50.147538	45
376	1	PVC 1 1/4	\N	30	50	\N		t	2025-08-24 11:40:28.638288	2025-08-24 11:40:28.638306	45
377	1	PVC INSPECTION TEE 4 INCH	\N	190	350	\N		t	2025-08-24 11:41:19.221364	2025-08-24 11:41:19.221393	45
381	1	PVC REDUCER BUSH 1 1/4*1 1/2	\N	15	40	\N		t	2025-08-24 12:03:59.3249	2025-08-24 12:03:59.324932	45
382	1	PVC REDUCER BUSH 2*1 1/4	\N	20	50	\N		t	2025-08-24 12:04:45.348799	2025-08-24 12:04:45.348815	45
383	1	PVC REDUCER BUSH 2*1 1/2	\N	25	50	\N		t	2025-08-24 12:05:21.793207	2025-08-24 12:05:21.793222	45
384	1	PVC REDUCER BUSH 3*2	\N	50	70	\N		t	2025-08-24 12:06:05.574666	2025-08-24 12:06:05.574678	45
385	1	PVC REDUCER BUSH 4*2	\N	70	120	\N		t	2025-08-24 12:06:43.008951	2025-08-24 12:06:43.008972	45
386	1	PVC REDUCER BUSH 4*3	\N	70	130	\N		t	2025-08-24 12:07:26.763891	2025-08-24 12:07:26.763903	45
387	1	PVC PLUG 4 INCH	\N	100	150	\N		t	2025-08-24 12:08:33.737302	2025-08-24 12:08:33.737319	45
388	1	PVC PLUG 3 INCH	\N	80	120	\N		t	2025-08-24 12:09:16.43072	2025-08-24 12:09:16.430735	45
390	1	PVC PLUG 1 1/2  INCH	\N	25	50	\N		t	2025-08-24 12:10:24.358357	2025-08-24 12:10:24.358453	45
391	1	PVC PLUG 1 1/4 INCH	\N	20	40	\N		t	2025-08-24 12:10:53.780117	2025-08-24 12:10:53.780152	45
393	1	VENT COWL 3 INCH	\N	30	90	\N		t	2025-08-24 12:13:12.728637	2025-08-24 12:13:12.728651	45
392	1	VENT COWL 4 INCH	\N	30	100	\N		t	2025-08-24 12:12:44.098614	2025-08-24 12:13:28.149074	45
394	1	MIRROR	\N	900	2000	10.00	BM6227	t	2025-08-24 12:17:58.190022	2025-08-24 12:17:58.19005	69
379	1	FLOOR TRAP 4 WAY PVC 	\N	170	280	-1.00		t	2025-08-24 11:42:33.256946	2025-08-28 12:38:56.259142	45
380	1	FLOOR TRAP 1WAY PVC 	\N	160	230	-5.00		t	2025-08-24 11:44:10.441444	2025-09-05 14:44:01.970155	45
336	1	PPR Elbow 32''	\N	12	30	-6.00		t	2025-08-24 09:54:21.723465	2025-09-05 14:44:01.994634	46
359	1	PPR Union 32mm	\N	25	80	-2.00		t	2025-08-24 10:35:43.401376	2025-09-05 14:44:02.000817	46
396	1	MIRROR	\N	1900	3500	10.00	BM8759	t	2025-08-24 12:19:40.983317	2025-08-24 12:19:40.983333	69
398	1	MIRROR	\N	600	1800	10.00	BM45604G	t	2025-08-24 12:22:01.179673	2025-08-24 12:22:01.179696	69
399	1	MIRROR	\N	1900	3500	10.00	BM8675	t	2025-08-24 12:22:34.528719	2025-08-24 12:22:34.528735	69
400	1	LED MIRROR	\N	5700	8500	1.00	8060	t	2025-08-24 12:26:01.089856	2025-08-24 12:26:01.089889	69
402	1	KITCHEN SINK	\N	7000	9500	\N	D01	t	2025-08-24 12:30:01.123399	2025-08-24 12:30:01.123418	70
403	1	KITCHEN SINK	\N	6800	8500	\N	F05A	t	2025-08-24 12:30:51.811812	2025-08-24 12:30:51.811836	70
404	1	KITCHEN SINK	\N	4300	5500	\N	103	t	2025-08-24 12:31:17.279299	2025-08-24 12:31:17.279316	70
405	1	Fame Small	\N	980	1500	10.00		t	2025-08-24 12:31:21.325978	2025-08-24 12:31:21.326	22
406	1	KITCHEN SINK	\N	5800	7000	\N	219	t	2025-08-24 12:31:43.444409	2025-08-24 12:31:43.444425	70
407	1	KITCHEN SINK	\N	5000	6000	\N	6045-1	t	2025-08-24 12:32:09.025232	2025-08-24 12:34:13.266191	70
408	1	KITCHEN SINK	\N	5500	6500	\N	6045	t	2025-08-24 12:35:39.035215	2025-08-24 12:35:39.035235	70
409	1	KITCHEN SINK	\N	5300	7000	\N	108	t	2025-08-24 12:36:29.743193	2025-08-24 12:36:29.743211	70
410	1	KITCHEN SINK	\N	6000	8000	\N	624	t	2025-08-24 12:36:55.140047	2025-08-24 12:36:55.14006	70
411	1	KITCHEN SINK	\N	6800	8500	\N	F02	t	2025-08-24 12:37:23.252712	2025-08-24 12:37:23.252724	70
412	1	KITCHEN SINK	\N	1750	2000	\N	KS1050XI POLISH	t	2025-08-24 12:38:36.298862	2025-08-24 12:38:36.298898	70
414	1	KITCHEN SINK	\N	3050	4000	\N	KS1250XI POLISH	t	2025-08-24 12:40:06.65878	2025-08-24 12:40:06.658798	70
417	1	KITCHEN SINK	\N	5400	7000	\N	KS6045B	t	2025-08-24 12:42:05.917249	2025-08-24 12:42:05.917262	70
418	1	KITCHEN SINK	\N	6400	9000	\N	KS7843B	t	2025-08-24 12:42:56.490247	2025-08-24 12:42:56.490259	70
419	1	KITCHEN SINK	\N	5200	6500	\N	KS6045S	t	2025-08-24 12:43:56.705663	2025-08-24 12:43:56.705699	70
420	1	KITCHEN SINK	\N	6200	8500	\N	KS7843S	t	2025-08-24 12:44:35.414455	2025-08-24 12:44:35.414469	70
421	1	SMART KITCHEN SINK	\N	13000	19000	1.00		t	2025-08-24 12:45:33.173127	2025-08-24 12:45:33.173142	70
422	1	KITCHEN SINK	\N	1100	1400	\N	SBSD LIGHT	t	2025-08-24 12:46:10.245157	2025-08-24 12:46:10.245171	70
423	1	KITCHEN SINK	\N	1450	1650	\N	SBSD MEDIUM	t	2025-08-24 12:46:45.862885	2025-08-24 12:46:45.862902	70
424	1	KITCHEN SINK	\N	1350	1550	\N	SBSD BABY MEDIUM	t	2025-08-24 12:47:45.593353	2025-08-24 12:47:45.593375	70
425	1	KITCHEN SINK	\N	1050	1350	\N	SBSD BABY LIGHT	t	2025-08-24 12:48:31.962132	2025-08-24 12:48:31.96215	70
426	1	SHOWER CUBICLE	\N	27000	35000	1.00		t	2025-08-24 12:57:25.484247	2025-08-24 12:57:25.484265	71
428	1	TOWEL RING	\N	605	\N	6.00	N025AC	t	2025-08-24 13:02:20.38594	2025-08-24 13:02:20.385952	72
429	1	TOWEL RING	\N	385	800	10.00	N025B	t	2025-08-24 13:03:12.112475	2025-08-24 13:03:12.112489	72
431	1	TOWEL RING	\N	590	1000	10.00	N144 SLIM	t	2025-08-24 13:04:45.424195	2025-08-24 13:04:45.424227	72
433	1	HOOKS	\N	615	1200	6.00	N173	t	2025-08-24 13:07:51.237253	2025-08-24 13:07:51.237273	73
434	1	HOOKS	\N	95	180	10.00	N207	t	2025-08-24 13:08:24.943763	2025-08-24 13:08:24.943781	73
435	1	HOOKS	\N	370	700	10.00	N042	t	2025-08-24 13:09:32.9148	2025-08-24 13:09:32.914819	73
436	1	HOOKS	\N	70	150	10.00	N040	t	2025-08-24 13:10:19.643856	2025-08-24 13:10:19.643869	73
437	1	HOOKS	\N	635	1200	10.00	N043	t	2025-08-24 13:10:56.528265	2025-08-24 13:10:56.528285	73
438	1	HOOKS	\N	560	1000	10.00	N227	t	2025-08-24 13:11:33.242072	2025-08-24 13:11:33.24209	73
439	1	HOOKS	\N	95	150	10.00	N041	t	2025-08-24 13:12:05.817229	2025-08-24 13:12:05.81726	73
441	1	HOOKS	\N	680	1000	10.00	N096	t	2025-08-24 13:14:41.681393	2025-08-24 13:14:41.681426	73
442	1	HOOKS	\N	155	250	10.00	N106	t	2025-08-24 13:15:59.804544	2025-08-24 13:15:59.804768	73
443	1	HOOKS	\N	145	250	10.00	N107	t	2025-08-24 13:16:40.470645	2025-08-24 13:16:40.470658	73
444	1	HOOKS	\N	145	250	10.00	N109	t	2025-08-24 13:17:21.927788	2025-08-24 13:17:21.927803	73
445	1	HOOKS	\N	520	1000	10.00	N120	t	2025-08-24 13:17:56.420534	2025-08-24 13:17:56.420547	73
446	1	HOOKS	\N	140	250	10.00	N208	t	2025-08-24 13:18:39.649056	2025-08-24 13:18:39.649069	73
448	1	TOILET BRUSH	\N	605	\N	5.00	N205	t	2025-08-24 13:21:05.5511	2025-08-24 13:21:05.551121	74
449	1	TOILET BRUSH	\N	740	\N	5.00	N205B	t	2025-08-24 13:21:34.078548	2025-08-24 13:21:34.078566	74
451	1	TOILET BRUSH	\N	755	2000	5.00	N363	t	2025-08-24 13:22:26.446305	2025-08-24 13:22:26.446317	74
450	1	TOILET BRUSH	\N	755	2000	5.00	N303	t	2025-08-24 13:22:24.619398	2025-08-24 13:23:13.732363	74
454	1	TOILET BRUSH	\N	655	1500	5.00	N146G	t	2025-08-24 13:25:38.482326	2025-08-24 13:25:38.482345	74
455	1	TOILET BRUSH	\N	890	1800	5.00	N146AB	t	2025-08-24 13:26:25.580508	2025-08-24 13:26:25.580526	74
456	1	TOILET BRUSH	\N	855	1800	\N	N146AC	t	2025-08-24 13:27:23.827735	2025-08-24 13:27:23.827757	74
458	1	TOILET BRUSH	\N	1430	3000	\N	N300	t	2025-08-24 13:27:54.847745	2025-08-24 13:27:54.847761	74
459	1	TOOTHBRUSH HOLDERS 	\N	385	750	10.00	N186	t	2025-08-24 13:32:29.113056	2025-08-24 13:32:29.113075	75
460	1	TOOTHBRUSH HOLDERS 	\N	715	2000	5.00	N026B	t	2025-08-24 13:33:37.608828	2025-08-24 13:33:37.608854	75
463	1	TOOTH BRUSH HOLDER 	\N	1155	2000	6.00	N299	t	2025-08-24 13:36:15.600164	2025-08-24 13:36:15.600182	74
464	1	TOOTH BRUSH HOLDER 	\N	1190	2000	6.00	N299B	t	2025-08-24 13:37:14.977578	2025-08-24 13:37:14.977593	75
465	1	TOOTH BRUSH HOLDER	\N	450	1200	8.00	N337	t	2025-08-24 13:37:51.46661	2025-08-24 13:37:51.466633	74
467	1	DOUBLE TOOTH BRUSH HOLDER	\N	800	1800	8.00		t	2025-08-24 13:39:33.021646	2025-08-24 13:39:33.021672	75
471	1	Arabic New White	\N	550	1000	10.00		t	2025-08-24 13:58:09.535744	2025-08-24 13:58:09.535764	27
473	1	Arabic New Metallic	\N	550	1000	10.00		t	2025-08-24 13:59:37.230268	2025-08-24 13:59:37.23028	27
415	1	KITCHEN SINK	\N	3500	4800	\N	KS1250XI HEAVY	t	2025-08-24 12:40:42.254539	2025-08-24 15:30:27.18798	70
416	1	KITCHEN SINK	\N	5000	6000	\N	KS1550XI HEAVY	t	2025-08-24 12:41:20.956886	2025-08-24 15:32:46.084676	70
427	1	TOWEL RING	\N	605	\N	6.00	N025AB	t	2025-08-24 13:01:42.70187	2025-08-26 05:25:29.458692	72
457	1	Horizon Instant	\N	800	1500	8.00		t	2025-08-24 13:27:35.585967	2025-09-03 13:37:50.323206	22
462	1	TOILET BRUSH	\N	595	1200	6.00	N313B	t	2025-08-24 13:35:21.168546	2025-08-26 05:34:38.789742	74
468	1	Arabic Shower Plastic Lirlee	\N	350	550	15.00		t	2025-08-24 13:50:46.526963	2025-08-26 05:36:54.611496	27
469	1	Arabic Shower Metallic Lirlee	\N	400	650	10.00		t	2025-08-24 13:53:05.314223	2025-08-26 05:39:00.930361	27
401	1	MIRROR	\N	4300	7000	0.00	MG001	t	2025-08-24 12:26:42.580907	2025-08-26 05:54:49.209184	69
397	1	MIRROR	\N	600	1800	9.00	BM45604C	t	2025-08-24 12:21:04.517234	2025-08-28 12:42:53.671275	69
472	1	JUMBO TISSUE Holder LIRLEE	\N	1350	2500	5.00		t	2025-08-24 13:59:22.916205	2025-08-30 14:07:20.339973	50
432	1	HOOKS	\N	615	1200	5.00	N173	t	2025-08-24 13:07:48.152007	2025-09-01 13:46:11.556541	73
470	1	Arabic New Black	\N	550	1000	8.00		t	2025-08-24 13:57:06.571944	2025-09-11 13:41:50.453622	27
447	1	HOOKS	\N	340	650	9.00	N039	t	2025-08-24 13:19:14.573132	2025-09-02 14:06:19.964778	73
430	1	TOWEL RING	\N	350	\N	-12.00	N025	t	2025-08-24 13:03:54.212127	2025-09-05 12:29:43.531083	72
452	1	TOILET BRUSH	\N	725	1500	-16.00	N146	t	2025-08-24 13:23:44.974491	2025-09-05 12:29:43.535503	74
466	1	SINGLE TOOTH BRUSH HOLDER 	\N	450	650	5.00		t	2025-08-24 13:38:41.111596	2025-09-05 12:29:43.540206	75
475	1	TISSUE HOLDER	\N	2010	3000	3.00	019M	t	2025-08-24 14:03:48.262697	2025-08-24 14:03:48.262725	50
541	1	Double Angle Valve	\N	435	650	11.00	VA121	t	2025-08-24 14:58:01.195546	2025-08-30 12:32:52.761198	37
476	1	TISSUE HOLDER	\N	2145	3500	3.00	091B	t	2025-08-24 14:05:00.35426	2025-08-24 14:05:00.354288	50
477	1	TISSUE HOLDER	\N	2105	3500	3.00	068B	t	2025-08-24 14:05:58.096131	2025-08-24 14:05:58.096144	50
478	1	TISSUE HOLDER	\N	970	3500	3.00	068M	t	2025-08-24 14:06:35.570533	2025-08-24 14:06:35.570557	50
479	1	Telephone Shower	\N	500	750	1.00		t	2025-08-24 14:06:50.897521	2025-08-24 14:06:50.897534	28
480	1	TISSUE HOLDER 	\N	1100	2000	5.00	N318	t	2025-08-24 14:07:15.922538	2025-08-24 14:07:15.922562	50
481	1	Telephone Shower Apple	\N	500	750	\N		t	2025-08-24 14:07:51.117206	2025-08-24 14:07:51.117221	28
482	1	CORNER SHELVES	\N	585	1000	\N	N009	t	2025-08-24 14:12:18.297079	2025-08-24 14:12:18.297095	76
484	1	CORNER SHELVES	\N	720	1200	5.00	N187	t	2025-08-24 14:13:37.108672	2025-08-24 14:13:37.108687	76
485	1	CORNER SHELVES	\N	1080	1500	1.00	N066	t	2025-08-24 14:14:39.507846	2025-08-24 14:14:39.50786	76
486	1	CORNER SHELVES	\N	935	1500	5.00	N121AB	t	2025-08-24 14:16:13.622103	2025-08-24 14:16:13.622126	76
487	1	CORNER SHELVES	\N	935	1500	\N	N121AC	t	2025-08-24 14:17:24.795027	2025-08-24 14:17:24.795041	76
488	1	CORNER SHELVES	\N	1155	2000	1.00	N010	t	2025-08-24 14:18:07.991307	2025-08-24 14:18:07.991325	76
489	1	CORNER SHELVES	\N	1990	3000	\N	N169	t	2025-08-24 14:19:19.095002	2025-08-24 14:19:19.095014	76
490	1	CORNER SHELVES	\N	2200	3500	\N	N124	t	2025-08-24 14:20:35.587921	2025-08-24 14:20:35.587941	76
491	1	CORNER SHELVES	\N	1950	3500	5.00	N291	t	2025-08-24 14:21:22.44162	2025-08-24 14:21:22.441635	76
492	1	CORNER SHELVES	\N	1925	3500	\N	N241	t	2025-08-24 14:22:18.413627	2025-08-24 14:22:18.413642	76
493	1	WASTE PIPE 4 INCH GOLDEN BROWN	\N	850	1350	\N		t	2025-08-24 14:25:05.081536	2025-08-24 14:25:05.081554	45
494	1	WASTE PIPE 4 INCH GOLDEN BROWN	\N	850	1350	\N		t	2025-08-24 14:25:06.143077	2025-08-24 14:25:06.14309	45
495	1	WASTE PIPE 4 INCH GREY	\N	820	1100	\N		t	2025-08-24 14:25:57.189871	2025-08-24 14:25:57.189885	45
496	1	WASTE PIPE 3 INCH GREY	\N	300	550	\N		t	2025-08-24 14:26:31.333299	2025-08-24 14:26:31.333313	45
497	1	WASTE PIPE 2 INCH GREY	\N	230	450	\N		t	2025-08-24 14:26:57.960007	2025-08-24 14:26:57.960022	45
498	1	Bathtub Mixer	\N	2300	5500	3.00	8302	t	2025-08-24 14:27:02.723379	2025-08-24 14:27:02.723393	77
499	1	WASTE PIPE 1 1/2 INCH GREY	\N	160	400	\N		t	2025-08-24 14:27:41.350126	2025-08-24 14:27:41.350143	45
500	1	WASTE PIPE 1 1/4 INCH GREY	\N	140	350	\N		t	2025-08-24 14:28:36.323023	2025-08-24 14:28:36.323043	45
501	1	Bathtub Mixer	\N	10200	18000	2.00	8401	t	2025-08-24 14:29:10.006151	2025-08-24 14:29:10.006169	77
502	1	PPR PIPE 20MM	\N	110	180	\N		t	2025-08-24 14:30:05.70406	2025-08-24 14:30:05.704073	46
503	1	PPR PIPE 25MM	\N	175	280	\N		t	2025-08-24 14:30:39.964184	2025-08-24 14:30:39.964196	46
504	1	PPR PIPE 32MM	\N	275	380	\N		t	2025-08-24 14:31:09.512821	2025-08-24 14:31:09.512849	46
505	1	PPR PIPE 40MM	\N	480	650	\N		t	2025-08-24 14:31:31.433191	2025-08-24 14:31:31.433203	46
506	1	PPR PIPE 50MM	\N	780	950	\N		t	2025-08-24 14:31:56.638326	2025-08-24 14:31:56.63834	46
507	1	PPR PIPE 63MM	\N	1150	1500	\N		t	2025-08-24 14:32:20.598606	2025-08-24 14:32:20.598619	46
508	1	PPR ROLLS 20MM	\N	2750	3500	\N		t	2025-08-24 14:32:53.251883	2025-08-24 14:32:53.251905	46
509	1	   PPR ROLLS 25MM	\N	4375	5500	\N		t	2025-08-24 14:33:18.321672	2025-08-24 14:33:18.321695	46
510	1	   PPR ROLLS 25MM	\N	4375	5500	\N		t	2025-08-24 14:33:19.411193	2025-08-24 14:33:19.411211	46
512	1	PPR ROLLS 32MM	\N	6875	8000	\N		t	2025-08-24 14:33:44.488013	2025-08-24 14:33:44.488026	46
513	1	PPR ROLLS 40MM	\N	6000	8500	\N		t	2025-08-24 14:33:57.829752	2025-08-24 14:34:28.139023	46
515	1	MANHOLE COVER 12*12	\N	400	650	\N		t	2025-08-24 14:36:45.370612	2025-08-24 14:36:45.370624	78
516	1	Plastic Kent Meter	\N	\N	\N	\N		t	2025-08-24 14:37:00.368284	2025-08-24 14:37:00.368314	34
517	1	MANHOLE COVER 15*15	\N	500	750	\N		t	2025-08-24 14:37:34.204784	2025-08-24 14:37:34.204795	78
518	1	MANHOLE COVER 18*18	\N	600	900	\N		t	2025-08-24 14:38:02.942808	2025-08-24 14:38:02.942824	78
519	1	MANHOLE COVER 18*24	\N	1200	1550	\N		t	2025-08-24 14:38:34.68164	2025-08-24 14:38:34.681662	78
511	1	Plastic Meter Lirlee 1/2''	\N	\N	\N	1.00		t	2025-08-24 14:33:29.117813	2025-08-24 14:38:57.319364	34
520	1	MANHOLE COVER 24*24	\N	3300	4000	\N		t	2025-08-24 14:39:09.565086	2025-08-24 14:39:09.565108	78
514	1	Plastic Super meter 1/2''	\N	350	550	\N		t	2025-08-24 14:36:15.919863	2025-08-24 14:39:43.948697	34
521	1	Metallic Super Meter 1/2''	\N	\N	\N	\N		t	2025-08-24 14:41:38.169513	2025-08-24 14:41:38.169527	35
522	1	Metallic Kent Meter 1/2''	\N	\N	\N	\N		t	2025-08-24 14:42:32.858753	2025-08-24 14:42:32.858767	35
523	1	Metallic Kmei Meter	\N	\N	\N	\N		t	2025-08-24 14:43:24.502927	2025-08-24 14:43:24.502958	35
524	1	Metallic B-Meter	\N	\N	\N	\N		t	2025-08-24 14:44:00.772939	2025-08-24 14:44:00.772962	35
525	1	RECTANGULAR/GLASS SHELVES	\N	495	1500	5.00	N007	t	2025-08-24 14:45:06.94134	2025-08-24 14:45:06.941358	79
526	1	RECTANGULAR/GLASS SHELVES	\N	570	1000	5.00	N011	t	2025-08-24 14:46:04.806051	2025-08-24 14:46:04.806067	79
527	1	RECTANGULAR/GLASS SHELVES	\N	550	1500	5.00	N333M	t	2025-08-24 14:46:36.626652	2025-08-24 14:46:36.626673	79
528	1	RECTANGULAR/GLASS SHELVES	\N	605	1500	5.00	N333B	t	2025-08-24 14:47:06.139165	2025-08-24 14:47:06.13918	79
530	1	RECTANGULAR/GLASS SHELVES	\N	1320	2500	3.00	N302B	t	2025-08-24 14:48:20.957183	2025-08-24 14:48:20.957199	79
534	1	SOAP DISPENSER GOLD LIRLEE	\N	450	1000	10.00		t	2025-08-24 14:53:10.68427	2025-08-24 14:53:10.684286	80
535	1	SOAP DISPENSER WHITE LIRLEE	\N	450	1000	10.00		t	2025-08-24 14:53:46.207352	2025-08-24 14:53:46.207376	80
537	1	SOAP DISPENSER 	\N	1735	3000	5.00	N033	t	2025-08-24 14:54:46.926878	2025-08-24 14:54:46.926899	80
538	1	SOAP DISPENSER 	\N	1610	3500	5.00	N211	t	2025-08-24 14:56:21.07893	2025-08-24 14:56:21.078953	80
540	1	SOAP DISPENSER	\N	1710	3500	5.00	N317	t	2025-08-24 14:57:16.541279	2025-08-24 14:57:16.541302	80
542	1	SOAP DISPENSER EZURI	\N	1200	2000	1.00		t	2025-08-24 14:59:22.397875	2025-08-24 14:59:22.397908	80
543	1	Double Angle Sanitary	\N	250	450	1.00		t	2025-08-24 14:59:50.366783	2025-08-24 14:59:50.366797	37
544	1	SOAP DISPENSER SILVER	\N	400	900	1.00		t	2025-08-24 15:00:04.551221	2025-08-24 15:00:04.551234	80
546	1	FLOOR DRAIN 	\N	320	750	10.00	N148	t	2025-08-24 15:03:18.147805	2025-08-24 15:03:18.147821	81
547	1	Single Valve	\N	295	500	1.00	VA119	t	2025-08-24 15:04:00.115727	2025-08-24 15:04:00.115747	36
548	1	FLOOR DRAIN	\N	405	800	10.00	N151B	t	2025-08-24 15:04:17.109466	2025-08-24 15:04:17.109485	81
549	1	FLOOR DRAIN	\N	405	850	10.00	N252	t	2025-08-24 15:05:03.752474	2025-08-24 15:05:03.752494	81
474	1	JUMBO SERVIETTE LIRLEE	\N	1200	2800	5.00		t	2025-08-24 14:02:26.952001	2025-08-30 14:06:42.115082	50
533	1	SOAP DISPENSER SILVER LIRLEE	\N	450	1000	0.00		t	2025-08-24 14:52:35.359485	2025-08-30 16:59:45.698077	80
545	1	Single Valve Huma	\N	180	450	30.00	9008	t	2025-08-24 15:01:53.917795	2025-08-30 12:31:27.248444	36
536	1	SOAP DISPENSER BLACK LIRLEE	\N	450	1000	0.00		t	2025-08-24 14:54:11.615619	2025-08-30 17:01:10.934707	80
531	1	RECTANGULAR/GLASS SHELVES	\N	1265	2500	2.00	N302M	t	2025-08-24 14:48:52.118248	2025-09-02 14:06:19.901075	79
529	1	RECTANGULAR/GLASS SHELVES	\N	765	1500	-10.00	N235	t	2025-08-24 14:47:53.333899	2025-09-05 12:29:43.523213	79
550	1	FLOOR DRAIN	\N	665	1500	5.00	N330B	t	2025-08-24 15:05:58.093118	2025-08-24 15:05:58.093148	81
552	1	FLOOR DRAIN	\N	665	1500	5.00	N330AB	t	2025-08-24 15:06:40.797099	2025-08-24 15:06:40.797113	81
554	1	FLOOR DRAIN	\N	1210	2000	3.00	N332M	t	2025-08-24 15:07:35.249443	2025-08-24 15:07:35.249465	81
555	1	FLOOR DRAIN	\N	1275	2000	3.00	N332B	t	2025-08-24 15:08:23.809223	2025-08-24 15:08:23.809238	81
556	1	FLOOR DRAIN	\N	635	1200	3.00	N331B	t	2025-08-24 15:08:58.665047	2025-08-24 15:08:58.665072	81
558	1	GRAB BAR	\N	400	1500	6.00	N153B	t	2025-08-24 15:13:00.878962	2025-08-24 15:13:00.87898	82
559	1	GRAB BAR	\N	3740	7500	5.00	N290	t	2025-08-24 15:13:34.825897	2025-08-24 15:13:34.825916	82
560	1	GRAB BAR	\N	3465	7500	5.00	N324	t	2025-08-24 15:14:20.349208	2025-08-24 15:14:20.349222	82
561	1	GRAB BAR	\N	870	1800	5.00	N321	t	2025-08-24 15:14:57.316722	2025-08-24 15:14:57.316741	82
562	1	GRAB BAR	\N	300	850	10.00	N062B	t	2025-08-24 15:15:28.865591	2025-08-24 15:15:28.865608	82
563	1	GRAB BAR	\N	340	1200	10.00	N063	t	2025-08-24 15:15:59.471116	2025-08-24 15:15:59.471151	82
564	1	GRAB BAR	\N	350	1200	10.00	N063B	t	2025-08-24 15:16:41.024299	2025-08-24 15:16:41.024318	82
565	1	GRAB BAR	\N	1210	2500	5.00	N370	t	2025-08-24 15:17:19.327524	2025-08-24 15:17:19.327542	82
567	1	GRAB BAR 1 1/2 FT LIRLEE	\N	1400	2500	5.00		t	2025-08-24 15:18:31.613405	2025-08-24 15:18:31.613422	82
568	1	GRAB BAR 2 FT LIRLEE	\N	1800	3000	5.00		t	2025-08-24 15:19:07.606039	2025-08-24 15:19:07.606052	82
572	1	HAND DRYER	\N	5170	7500	3.00	N320	t	2025-08-24 15:21:30.200606	2025-08-24 15:21:30.200629	84
573	1	SIGLE SLOT FITTINGS	\N	450	1000	\N	F04	t	2025-08-24 15:27:22.762824	2025-08-24 15:27:41.294878	85
574	1	Ariston	\N	17000	20000	1.00		t	2025-08-24 15:28:13.806543	2025-08-24 15:28:13.80656	86
575	1	Lorenzeti	\N	6800	9500	1.00		t	2025-08-24 15:29:07.465724	2025-08-24 15:29:07.46574	86
576	1	DOUBLE SLOT FITTINGS 	\N	520	1800	\N	F03	t	2025-08-24 15:29:10.54289	2025-08-24 15:29:10.542906	85
577	1	Fame	\N	4500	6500	\N		t	2025-08-24 15:30:08.337058	2025-08-24 15:30:08.337071	86
413	1	KITCHEN SINK	\N	2450	3500	\N	KS1050XI HEAVY	t	2025-08-24 12:39:30.669777	2025-08-24 15:31:50.352468	70
578	1	Stand Pipe 1ft	\N	50	100	50.00		t	2025-08-24 15:32:09.282198	2025-08-24 15:32:09.282217	47
579	1	Stand Pipe 1 1/2ft	\N	70	150	50.00		t	2025-08-24 15:34:07.521084	2025-08-24 15:34:07.521106	47
580	1	Normal Toilet Screw	\N	60	150	100.00		t	2025-08-24 15:48:05.205382	2025-08-24 15:48:05.205415	87
582	1	Hexagonal  screw 3''	\N	15	30	\N		t	2025-08-24 15:52:00.460248	2025-08-24 15:52:00.46027	87
583	1	Hexagonal  screw 4''	\N	20	40	\N		t	2025-08-24 15:52:55.301354	2025-08-24 15:52:55.301378	87
586	1	Flex Tube 1ft Lirlee	\N	88	150	50.00		t	2025-08-24 16:02:03.515083	2025-08-24 16:02:03.515101	52
589	1	Flex Tube 2ft Yellow	\N	60	150	50.00		t	2025-08-24 16:05:23.257865	2025-08-24 16:05:23.257884	52
590	1	Flex Tube 1 1/2ft Yellow	\N	50	100	50.00		t	2025-08-24 16:06:30.438132	2025-08-24 16:06:30.438145	52
591	1	Flex Tube 1ft Yellow	\N	40	100	50.00		t	2025-08-24 16:07:17.075027	2025-08-24 16:07:17.07504	52
594	1	Flex Tube 1ft Brazil	\N	40	100	50.00		t	2025-08-24 16:12:39.543934	2025-08-24 16:12:39.543962	52
596	1	Flex Tube 1ft Italy	\N	\N	\N	\N		t	2025-08-24 16:16:30.470221	2025-08-24 16:16:30.470238	52
597	1	Flex Tube 2ft Italy	\N	\N	\N	\N		t	2025-08-24 16:17:01.3753	2025-08-24 16:18:41.78288	52
588	1	Flex Tube 2ft Lirlee	\N	120	200	49.00		t	2025-08-24 16:04:19.332341	2025-08-30 11:14:55.85032	52
585	1	Big Thread Tape	\N	55	100	31.00		t	2025-08-24 15:57:33.530834	2025-09-10 13:53:09.651605	88
599	1	Wall Knob Short Neck Jawa	\N	380	700	49.00		t	2025-08-30 13:27:22.85957	2025-08-30 13:27:22.859585	89
598	1	Ezuri Arabic Shower	\N	700	1200	1.00		t	2025-08-26 13:27:14.366689	2025-08-26 13:44:56.91363	27
368	1	PVC BEND 1 1/2*90	\N	25	50	-4.00		t	2025-08-24 10:42:44.224587	2025-08-28 12:38:56.274807	45
360	1	PVC BEND 4*90	\N	90	150	-4.00		t	2025-08-24 10:36:04.996983	2025-08-28 12:38:56.282748	45
328	1	F|Elbow 25*1/2	\N	20	40	-7.00		t	2025-08-24 09:36:21.635039	2025-08-28 12:38:56.292075	46
362	1	Double Elbow 25*1/2	\N	200	350	-1.00		t	2025-08-24 10:37:15.294589	2025-08-28 12:38:56.299369	46
352	1	PPR Tee 25mm	\N	10	25	-6.00		t	2025-08-24 10:25:54.055583	2025-08-28 12:38:56.314221	46
570	1	Silicone Orient clear	\N	140	250	9.00		t	2025-08-24 15:19:49.624606	2025-09-12 13:45:10.507794	83
378	1	PVC INSPECTION BEND 4 INCH	\N	160	250	-1.00		t	2025-08-24 11:41:51.590172	2025-08-28 12:38:56.335677	45
367	1	PVC BEND 2*45	\N	30	60	-6.00		t	2025-08-24 10:41:47.192715	2025-08-28 12:38:56.340701	45
374	1	PVC TEE 2 INCH	\N	40	70	-2.00		t	2025-08-24 11:39:12.278869	2025-08-28 12:38:56.349879	45
389	1	PVC PLUG 2 INCH	\N	30	60	-3.00		t	2025-08-24 12:09:43.734733	2025-08-28 12:38:56.358123	45
600	1	Wall Knob Long Neck Jawa	\N	380	700	48.00		t	2025-08-30 13:28:13.188297	2025-09-03 13:27:23.895698	89
539	1	Double Angle Valve Huma	\N	240	500	36.00	9012	t	2025-08-24 14:56:26.390932	2025-08-30 12:30:18.028661	37
569	1	Silicone Pattex Clear	\N	310	500	24.00		t	2025-08-24 15:19:13.335541	2025-08-30 12:37:55.80053	83
553	1	Jawa 	\N	95	200	89.00		t	2025-08-24 15:07:10.142142	2025-09-08 13:42:48.077069	36
571	1	Silicone DLG clear	\N	290	500	48.00		t	2025-08-24 15:20:36.055401	2025-08-30 12:48:21.310308	83
602	1	Wall Knob Long Neck Lirlee	\N	380	700	30.00		t	2025-08-30 13:51:09.05117	2025-08-30 13:51:09.051185	89
603	1	Wall Star Short Neck Lirlee	\N	380	700	30.00		t	2025-08-30 13:52:46.75968	2025-08-30 13:52:46.759695	89
604	1	Wall Star Long Neck Lirlee	\N	380	700	0.00		t	2025-08-30 13:55:24.149598	2025-08-30 13:55:24.14961	89
606	1	Concelled Stop Cork Lirlee 1/2	\N	600	950	20.00		t	2025-08-30 14:20:45.752034	2025-08-30 14:20:45.752065	90
608	1	Gate Valve 1/2 lirlee	\N	330	450	20.00		t	2025-08-30 14:32:23.567618	2025-08-30 14:32:23.567647	91
609	1	Gate Valve 1'' lirlee	\N	730	950	\N		t	2025-08-30 14:34:08.973182	2025-08-30 14:34:08.973207	91
610	1	Lockable Tap 1/2 Lirlee	\N	360	450	20.00		t	2025-08-30 14:38:07.64906	2025-08-30 14:38:07.649082	33
611	1	Lockable Tap 3/4 Lirlee	\N	340	500	20.00		t	2025-08-30 14:39:23.073795	2025-08-30 14:39:23.073823	33
612	1	Wall Elbow Action	\N	1050	1500	10.00		t	2025-08-30 16:16:54.239935	2025-08-30 16:16:54.239961	30
613	1	Tile cleaner 5l	\N	850	1200	4.00		t	2025-08-30 17:14:28.094473	2025-08-30 17:14:28.094496	92
587	1	Flex Tube 1 1/2ft Lirlee	\N	90	150	99.00		t	2025-08-24 16:03:23.529034	2025-09-09 15:03:51.121525	52
595	1	Flex Tube 1 1/2ft Italy	\N	90	200	98.00		t	2025-08-24 16:15:49.844789	2025-09-02 14:06:19.934239	52
601	1	Wall Knob Short Neck Lirlee	\N	380	700	24.00		t	2025-08-30 13:50:15.911494	2025-09-05 14:44:01.930206	89
566	1	Silicone Hytech Clear	\N	310	450	38.00		t	2025-08-24 15:18:23.599656	2025-09-05 14:44:01.95507	83
592	1	Flex Tube 2ft Brazil	\N	60	150	46.00		t	2025-08-24 16:10:09.568507	2025-09-10 13:53:09.658142	52
614	1	Tile cleaner 1l	\N	180	450	2.00		t	2025-08-30 17:15:15.418132	2025-08-30 17:15:15.418144	92
627	3	FLOODLIGHT 100W AC	\N	1200	1600	10.00	H627	t	2025-09-03 11:53:31.384882	2025-09-04 15:02:56.551321	94
623	3	1094-50W FLOOD LIGHT SOLAR	\N	2000	2500	5.00	1094	t	2025-09-03 11:46:58.284293	2025-09-04 15:08:11.549873	94
628	3	9W NORMAL BULB 	\N	35	70	100.00	D-305	t	2025-09-03 11:56:03.740558	2025-09-04 15:11:09.153212	94
630	3	3W RECESS WH+WW ROUND	\N	80	120	80.00	B041	t	2025-09-03 11:58:48.973997	2025-09-04 15:14:32.342083	94
631	3	3-1 RECESS ROUND	\N	130	200	100.00	B040	t	2025-09-03 12:00:09.446533	2025-09-04 15:15:34.341413	94
632	3	7W MULTI-COLOR 	\N	180	250	0.00	B128	t	2025-09-03 12:01:20.925313	2025-09-04 15:16:59.464768	94
633	3	COB 20W	\N	270	350	0.00	B252	t	2025-09-03 12:01:59.945807	2025-09-04 15:18:20.598763	94
635	3	COB 10W	\N	160	250	0.00	B068	t	2025-09-03 12:03:55.720346	2025-09-04 15:24:00.737667	94
621	3	RGB SNAKE LIGHT	\N	75	130	100.00	J205	t	2025-09-03 11:44:29.103153	2025-09-04 16:09:26.452899	94
639	3	BELL SWITCH BAKELITE	\N	80	150	20.00	FE071	t	2025-09-03 12:53:43.176322	2025-09-04 16:13:42.414817	94
637	3	2 GANG 2-WAY BAKELITE	\N	70	110	100.00	FE063	t	2025-09-03 12:51:08.44152	2025-09-04 16:16:27.572778	94
641	3	T-S D-UNIVERSAL BAKELITE	\N	160	250	49.00	FE085	t	2025-09-03 13:00:46.916326	2025-09-08 17:06:03.932723	94
643	3	COOKER UNIT 45A BAKELITE	\N	380	500	49.00	FE088	t	2025-09-03 13:03:37.134294	2025-09-13 10:27:37.567348	94
615	1	Pop Up 1 1/4 lirlee	\N	230	450	6.00		t	2025-08-30 17:24:03.100214	2025-08-30 17:24:03.10023	93
616	1	Pop Up 1 1/2 lirlee	\N	210	450	5.00		t	2025-08-30 17:24:51.173397	2025-08-30 17:24:51.173421	93
618	1	Soap Dish Small Black	\N	180	350	38.00	N092B	t	2025-09-01 12:55:23.99978	2025-09-01 12:55:23.999798	49
551	1	Ezuri Single Valve	\N	140	300	82.00		t	2025-08-24 15:06:16.75984	2025-09-05 14:44:01.938833	36
619	1	Pillar Sprout Knob Lirlee	\N	600	900	10.00		t	2025-09-01 13:11:31.979486	2025-09-01 13:11:31.979515	19
605	1	PILLAR TAP KNOB Lirlee	\N	380	700	1.00		t	2025-08-30 14:03:53.177841	2025-09-01 13:18:52.882982	18
461	1	TOILET BRUSH	\N	575	1200	5.00	N313M	t	2025-08-24 13:34:29.298774	2025-09-02 14:06:19.973799	74
675	3	GLASS DIFFUSE 18W	\N	100	150	60.00	E030	t	2025-09-03 14:45:12.21584	2025-09-04 15:30:22.996667	94
676	3	GLASS DIFFUSE 9W	\N	80	120	60.00	E029	t	2025-09-03 14:45:57.621688	2025-09-04 15:30:56.266529	94
654	3	1 GANG 2-W WH M1	\N	90	150	100.00	FE123	t	2025-09-03 14:02:52.743823	2025-09-04 15:30:58.176766	94
682	3	BREAKER 60A	\N	130	270	48.00	FQ018	t	2025-09-03 14:50:40.551699	2025-09-04 15:40:21.864369	94
690	3	SOLAR STREET LIGHT	\N	2200	3500	9.00	I157	t	2025-09-04 16:00:56.179056	2025-09-12 15:39:54.695766	94
620	3	SNAKE LIGHT 	\N	50	130	50.00	J250	t	2025-09-03 11:42:58.413811	2025-09-04 14:50:44.032474	94
617	1	Soap Dish Small Silver	\N	180	350	24.00	N092M	t	2025-09-01 12:54:15.319393	2025-09-05 12:29:43.514717	49
651	3	1 GANG 2-W GOLD M1	\N	110	250	100.00	FE122	t	2025-09-03 13:22:29.202517	2025-09-04 15:32:04.683067	94
626	3	FLOOD LIGHT 200W AC	\N	2200	2800	8.00	H629	t	2025-09-03 11:52:48.476669	2025-09-04 15:10:11.975192	94
652	3	1 GANG 2-W GREY M1	\N	110	250	100.00	FE124	t	2025-09-03 13:41:44.842282	2025-09-04 15:33:02.095508	\N
653	3	2 GANG 2-W WH M1	\N	100	200	100.00	R366	t	2025-09-03 13:45:24.51593	2025-09-04 15:34:30.85709	94
629	3	6W RECESS ROUND WH	\N	70	150	80.00	B052	t	2025-09-03 11:57:51.32458	2025-09-04 15:11:55.496176	94
624	3	1095-100W FLOOD LIGHT SOLAR	\N	2500	3500	4.00	1095	t	2025-09-03 11:49:04.564022	2025-09-15 15:53:05.383053	94
636	3	1 GANG 2-WAY BAKELITE	\N	50	75	77.00	FE061	t	2025-09-03 12:49:43.134113	2025-09-15 15:53:05.394232	94
677	3	DUST PROOF BRACKET	\N	450	600	14.00	C206	t	2025-09-03 14:46:48.660861	2025-09-13 10:34:06.61977	94
644	3	BLANK COVER DOUBLE BAKELITE	\N	30	50	100.00	FE089	t	2025-09-03 13:05:05.716126	2025-09-04 16:19:06.347907	94
645	3	BLANK COVER SINGLE BAKELITE	\N	20	40	100.00	FE083	t	2025-09-03 13:05:53.442479	2025-09-04 16:19:36.898554	94
646	3	T-S+UNI+USB+C BAKELITE	\N	400	600	50.00	FE086	t	2025-09-03 13:08:29.617901	2025-09-04 16:20:27.177714	94
647	3	DIMA SWITCH BAKELITE	\N	180	300	10.00	FE335	t	2025-09-03 13:11:10.724609	2025-09-04 16:20:52.059895	94
665	3	T-S NORMAL D M1	\N	200	\N	50.00	R372	t	2025-09-03 14:24:18.252685	2025-09-04 16:26:50.410253	94
648	3	1 GANG 2-W WH M1	\N	50	70	0.00	FE100	t	2025-09-03 13:16:16.246022	2025-09-04 15:22:40.596253	94
634	3	COB 15W	\N	200	300	40.00	B443	t	2025-09-03 12:03:12.670407	2025-09-04 15:22:57.073861	94
650	3	3 GANG 2-WAY M1	\N	90	150	100.00	FE102	t	2025-09-03 13:18:19.001433	2025-09-04 15:29:11.860086	94
557	1	GRAB BAR	\N	385	1500	3.00	N153	t	2025-08-24 15:12:16.203191	2025-09-09 13:26:28.152054	82
683	3	CHANDERLIER BULB 	\N	50	100	100.00	D266	t	2025-09-04 15:47:32.652497	2025-09-04 15:47:32.652513	94
684	3	CHANDERLIER BULB 	\N	50	100	100.00	D266	t	2025-09-04 15:47:33.109804	2025-09-04 15:47:33.109822	94
655	3	2 GANG 2-WAY GOLD M1	\N	120	220	100.00	FE030	t	2025-09-03 14:09:51.423646	2025-09-04 15:36:20.068673	94
679	3	BREAKER 10A	\N	120	200	48.00	FQ012	t	2025-09-03 14:48:48.479701	2025-09-04 15:38:08.430753	94
680	3	BREAKER 20A	\N	120	220	48.00	FQ014	t	2025-09-03 14:49:27.587635	2025-09-04 15:38:40.23149	94
681	3	BREAKER 32A	\N	120	250	48.00	FQ016	t	2025-09-03 14:50:02.530857	2025-09-04 15:39:32.402535	94
657	3	3 GANG 2-WAY WH M1	\N	120	\N	100.00	R367	t	2025-09-03 14:12:19.510844	2025-09-04 15:40:00.182479	94
659	3	3 GANG 2-WAY GREY M1	\N	140	\N	0.00	FE004	t	2025-09-03 14:15:47.802796	2025-09-04 15:41:57.888463	94
660	3	BELL SWITCH M1	\N	100	\N	100.00	R369	t	2025-09-03 14:16:50.206628	2025-09-04 15:42:52.938835	94
661	3	T-S SINGLE WH M1	\N	100	\N	100.00	R370	t	2025-09-03 14:17:52.444751	2025-09-04 15:43:48.712866	94
662	3	T-S SINGLE GOLD M1	\N	120	\N	100.00	FE034	t	2025-09-03 14:18:34.634256	2025-09-04 15:44:40.558933	10
664	3	T-S SINGLE+UNI+C M1	\N	400	\N	20.00	R386	t	2025-09-03 14:22:45.556153	2025-09-04 15:46:07.130939	94
671	3	W/HEATER 45A M1	\N	150	\N	100.00	R379	t	2025-09-03 14:38:39.771554	2025-09-04 16:27:38.610337	94
335	1	PPR Elbow 25''	\N	8	20	-33.00		t	2025-08-24 09:53:38.935	2025-09-05 14:44:01.975226	46
622	3	D-100 LED BULB	\N	120	180	94.00	D-100	t	2025-09-03 11:45:21.803891	2025-09-13 07:18:29.407835	94
649	3	2 GANG 2-WAY M1	\N	70	110	94.00	FE101	t	2025-09-03 13:17:15.016028	2025-09-13 10:27:37.558221	94
669	3	T-S DOUBLE U+GD M1	\N	220	\N	0.00	FE038	t	2025-09-03 14:31:30.332965	2025-09-04 15:50:33.795333	\N
670	3	T-S DOUBLE U+GY M1	\N	220	\N	50.00	FE010	t	2025-09-03 14:33:35.565457	2025-09-04 15:51:43.423587	94
686	3	SPOTLIGHT	\N	350	600	30.00	A168	t	2025-09-04 15:52:15.248322	2025-09-04 15:52:15.248339	94
672	3	COOKER UNIT 45A M1	\N	400	\N	20.00	R385	t	2025-09-03 14:40:03.365236	2025-09-04 16:27:58.96001	94
638	3	3 GANG 2-WAY BAKELITE	\N	90	150	99.00	FE065	t	2025-09-03 12:51:49.491874	2025-09-13 10:27:37.563808	94
656	3	2 GANG 2-WAY GREY M1	\N	120	220	98.00	FE003	t	2025-09-03 14:10:40.179273	2025-09-05 09:03:39.181466	94
688	3	CHASER 2-PIN 	\N	60	100	25.00	S038	t	2025-09-04 15:55:42.518354	2025-09-04 15:55:42.518384	94
689	3	LAMP HANGING HOLDER	\N	800	1500	2.00	R006	t	2025-09-04 15:58:52.788464	2025-09-04 15:58:52.788481	94
691	3	FLOOD LIGHT 200W AC	\N	1500	2500	10.00	I221	t	2025-09-04 16:04:56.822016	2025-09-04 16:04:56.822033	94
692	3	TRACK LIGHT RAIL 1M	\N	120	250	50.00	S251	t	2025-09-04 16:06:17.316714	2025-09-04 16:06:17.316731	94
667	3	T-S NORMAL D/GY M1	\N	220	\N	36.00	FE009	t	2025-09-03 14:29:21.917786	2025-09-05 09:03:39.190301	94
663	3	T-S SINGLE GREY M1	\N	120	\N	89.00	FE007	t	2025-09-03 14:20:05.220158	2025-09-05 09:03:39.199639	94
607	1	Gate Valve 3/4 lirlee	\N	430	700	19.00		t	2025-08-30 14:31:14.282986	2025-09-05 14:44:02.006761	91
625	3	CN013-200W FLOOD LIGHT SOLAR	\N	3000	4500	0.00	CN013	t	2025-09-03 11:51:34.766465	2025-09-05 16:44:30.957062	94
685	3	SPOTLIGHT	\N	350	600	24.00	A168	t	2025-09-04 15:52:14.504343	2025-09-10 15:22:38.596303	94
668	3	T-S DOUBLE U M1	\N	200	\N	45.00	R373	t	2025-09-03 14:30:11.03962	2025-09-12 10:09:38.773302	94
658	3	3 GANG 2-WAY GOLD M1	\N	140	\N	95.00	FE031	t	2025-09-03 14:14:46.726633	2025-09-12 10:09:38.783684	\N
674	3	SWITCH BOX 6X3D M1	\N	30	\N	95.00	R482	t	2025-09-03 14:43:17.728231	2025-09-12 10:09:38.793933	94
532	1	RECTANGULAR/GLASS SHELVES	\N	2280	3500	2.00	N229	t	2025-08-24 14:50:52.149087	2025-09-15 13:17:50.498112	79
483	1	CORNER SHELVES	\N	700	1500	4.00	N009B	t	2025-08-24 14:12:55.267359	2025-09-15 13:18:36.888175	76
395	1	MIRROR	\N	900	2000	8.00	BM9003	t	2025-08-24 12:18:55.524605	2025-09-15 13:20:27.799492	69
584	1	Small Thread Tape	\N	11	30	469.00		t	2025-08-24 15:56:33.355483	2025-09-15 14:58:10.608177	88
177	1	FAME BIG 	\N	1200	2500	6.00		t	2025-08-20 16:40:15.105727	2025-09-15 14:58:10.612891	22
593	1	Flex Tube 1 1/2ft Brazil	\N	50	100	42.00		t	2025-08-24 16:11:31.971454	2025-09-15 14:58:10.616828	52
154	1	Viega 11/2''	\N	140	250	16.00		t	2025-08-20 16:01:41.019791	2025-09-15 14:58:10.620288	43
581	1	Basin Screw	\N	60	150	32.00		t	2025-08-24 15:51:01.458333	2025-09-15 14:58:10.623932	87
100	1	PILLAR TAP JUMBO	\N	950	1800	7.00		t	2025-08-20 13:23:10.913972	2025-09-15 14:58:10.627336	18
225	1	BASIN MIXER HUMA	\N	1300	3500	4.00	3014	t	2025-08-21 16:09:36.593779	2025-09-15 14:58:10.631479	15
193	1	SHOWER RISER	\N	4400	9500	2.00	8014K	t	2025-08-20 16:54:34.818653	2025-09-15 14:58:10.63478	23
666	3	T-S NORMAL D/GD	\N	220	\N	33.00	FE037	t	2025-09-03 14:27:37.887722	2025-09-15 15:53:05.389175	94
642	3	T-S D-NORMAL BAKELITE	\N	160	220	39.00	FE084	t	2025-09-03 13:02:31.677544	2025-09-15 15:53:05.39904	94
678	3	DUST PROOF BRACKET	\N	200	280	29.00	C234	t	2025-09-03 14:48:00.05861	2025-09-15 15:53:05.402972	94
687	3	RGB STRIP WIRE	\N	110	200	7.00	S232	t	2025-09-04 15:53:18.394206	2025-09-15 15:53:05.407503	94
640	3	T-S SINGLE BAKELITE 	\N	80	150	98.00	FE077	t	2025-09-03 12:59:53.469816	2025-09-15 15:53:05.411943	94
673	3	SWITCH BOX 3X3S M1	\N	25	\N	93.00	R481	t	2025-09-03 14:42:08.352233	2025-09-15 15:53:05.41579	94
\.


--
-- Data for Name: purchase_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_items (id, purchase_order_id, product_code, product_name, quantity, unit_price, total_price, received_quantity, notes, created_at, updated_at) FROM stdin;
15	7	*	kitchen Sink Sbsd white	12.000	\N	\N	0.000		2025-08-28 15:03:52.500308	2025-08-28 15:03:52.500328
16	7	*	Square bowl white	2.000	\N	\N	0.000		2025-08-28 15:03:52.500331	2025-08-28 15:03:52.500332
17	8	N121AB		6.000	\N	\N	0.000		2025-09-15 15:28:29.007763	2025-09-15 15:28:29.007775
18	8	N121AC		6.000	\N	\N	0.000		2025-09-15 15:28:29.007777	2025-09-15 15:28:29.007778
19	8	N169		6.000	\N	\N	0.000		2025-09-15 15:28:29.007779	2025-09-15 15:28:29.00778
20	8	N241		3.000	\N	\N	0.000		2025-09-15 15:28:29.007782	2025-09-15 15:28:29.007783
21	8	N235		8.000	\N	\N	0.000		2025-09-15 15:28:29.007784	2025-09-15 15:28:29.007785
22	8	N019B		6.000	\N	\N	0.000		2025-09-15 15:28:29.007787	2025-09-15 15:28:29.007788
23	8	N025		12.000	\N	\N	0.000		2025-09-15 15:28:29.00779	2025-09-15 15:28:29.007791
24	8	N051		6.000	\N	\N	0.000		2025-09-15 15:28:29.007792	2025-09-15 15:28:29.007793
25	8	N220		5.000	\N	\N	0.000		2025-09-15 15:28:29.007794	2025-09-15 15:28:29.007795
26	8	N146		8.000	\N	\N	0.000		2025-09-15 15:28:29.007797	2025-09-15 15:28:29.007798
27	8	N053M		8.000	\N	\N	0.000		2025-09-15 15:28:29.007799	2025-09-15 15:28:29.0078
28	8	N053B		8.000	\N	\N	0.000		2025-09-15 15:28:29.007801	2025-09-15 15:28:29.007802
29	8	KS6039		2.000	\N	\N	0.000		2025-09-15 15:28:29.007804	2025-09-15 15:28:29.007805
30	8	KS9045		6.000	\N	\N	0.000		2025-09-15 15:28:29.007806	2025-09-15 15:28:29.007807
31	8	KS9044		6.000	\N	\N	0.000		2025-09-15 15:28:29.007808	2025-09-15 15:28:29.007809
32	8	EG6020		5.000	\N	\N	0.000		2025-09-15 15:28:29.007811	2025-09-15 15:28:29.007812
33	8	HT002		2.000	\N	\N	0.000		2025-09-15 15:28:29.007813	2025-09-15 15:28:29.007814
34	8	PU2331		4.000	\N	\N	0.000		2025-09-15 15:28:29.007815	2025-09-15 15:28:29.007816
35	8	KM3051		2.000	\N	\N	0.000		2025-09-15 15:28:29.007818	2025-09-15 15:28:29.007819
36	8	KM3051B		2.000	\N	\N	0.000		2025-09-15 15:28:29.00782	2025-09-15 15:28:29.007821
37	8	EG9618H		6.000	\N	\N	0.000		2025-09-15 15:28:29.007823	2025-09-15 15:28:29.007824
38	8	KS9041		10.000	\N	\N	0.000		2025-09-15 15:28:29.007825	2025-09-15 15:28:29.007826
39	8	EG9618		6.000	\N	\N	0.000		2025-09-15 15:28:29.007827	2025-09-15 15:28:29.007828
40	8	EG9615		6.000	\N	\N	0.000		2025-09-15 15:28:29.00783	2025-09-15 15:28:29.007831
41	8	KS1009H		6.000	\N	\N	0.000		2025-09-15 15:28:29.007832	2025-09-15 15:28:29.007833
42	8	KS2013		5.000	\N	\N	0.000		2025-09-15 15:28:29.007834	2025-09-15 15:28:29.007835
43	8	KS2013B		5.000	\N	\N	0.000		2025-09-15 15:28:29.007837	2025-09-15 15:28:29.007838
44	8	VA119		50.000	\N	\N	0.000		2025-09-15 15:28:29.007839	2025-09-15 15:28:29.00784
45	8	VA121		30.000	\N	\N	0.000		2025-09-15 15:28:29.007841	2025-09-15 15:28:29.007842
46	8			1.000	\N	\N	0.000		2025-09-15 15:28:29.007844	2025-09-15 15:28:29.007845
47	9	D01		5.000	\N	\N	0.000		2025-09-15 16:04:17.765237	2025-09-15 16:04:17.765248
48	9	624		4.000	\N	\N	0.000		2025-09-15 16:04:17.76525	2025-09-15 16:04:17.765251
49	9	F05A		5.000	\N	\N	0.000		2025-09-15 16:04:17.765253	2025-09-15 16:04:17.765254
50	9	F02		5.000	\N	\N	0.000		2025-09-15 16:04:17.765255	2025-09-15 16:04:17.765256
51	9	103		6.000	\N	\N	0.000		2025-09-15 16:04:17.765258	2025-09-15 16:04:17.765259
52	9	6045		5.000	\N	\N	0.000		2025-09-15 16:04:17.76526	2025-09-15 16:04:17.765261
53	9	GT006		10.000	\N	\N	0.000		2025-09-15 16:04:17.765263	2025-09-15 16:04:17.765264
54	9	GT003		6.000	\N	\N	0.000		2025-09-15 16:04:17.765265	2025-09-15 16:04:17.765267
55	9	GT016		8.000	\N	\N	0.000		2025-09-15 16:04:17.765268	2025-09-15 16:04:17.765269
56	9	GT028		10.000	\N	\N	0.000		2025-09-15 16:04:17.765271	2025-09-15 16:04:17.765272
57	9	GT031		10.000	\N	\N	0.000		2025-09-15 16:04:17.765273	2025-09-15 16:04:17.765274
58	9	GT071		3.000	\N	\N	0.000		2025-09-15 16:04:17.765276	2025-09-15 16:04:17.765277
59	9	GT017		5.000	\N	\N	0.000		2025-09-15 16:04:17.765278	2025-09-15 16:04:17.765279
60	9	GT032		6.000	\N	\N	0.000		2025-09-15 16:04:17.765281	2025-09-15 16:04:17.765282
61	9			1.000	\N	\N	0.000		2025-09-15 16:04:17.765283	2025-09-15 16:04:17.765284
62	10	WC0805		4.000	\N	\N	0.000		2025-09-15 16:14:03.667323	2025-09-15 16:14:03.667333
63	10	WC501		10.000	\N	\N	0.000		2025-09-15 16:14:03.667335	2025-09-15 16:14:03.667336
64	10	WC306		8.000	\N	\N	0.000		2025-09-15 16:14:03.667338	2025-09-15 16:14:03.667339
65	10	WC029	BLOSSOM	15.000	\N	\N	0.000		2025-09-15 16:14:03.66734	2025-09-15 16:14:03.667341
66	10	WC664		15.000	\N	\N	0.000		2025-09-15 16:14:03.667343	2025-09-15 16:14:03.667344
67	10	PB778		15.000	\N	\N	0.000		2025-09-15 16:14:03.667345	2025-09-15 16:14:03.667346
68	10	PB326		20.000	\N	\N	0.000		2025-09-15 16:14:03.667348	2025-09-15 16:14:03.667349
69	10	PB326	BLOSSOM	15.000	\N	\N	0.000		2025-09-15 16:14:03.667351	2025-09-15 16:14:03.667352
70	10	PB035		6.000	\N	\N	0.000		2025-09-15 16:14:03.667353	2025-09-15 16:14:03.667354
71	10	WT02D		20.000	\N	\N	0.000		2025-09-15 16:14:03.667356	2025-09-15 16:14:03.667357
72	10	KS7843B		12.000	\N	\N	0.000		2025-09-15 16:14:03.667358	2025-09-15 16:14:03.66736
73	10	KS7843S		6.000	\N	\N	0.000		2025-09-15 16:14:03.667361	2025-09-15 16:14:03.667362
74	10	KS1258XI HEAVY		15.000	\N	\N	0.000		2025-09-15 16:14:03.667364	2025-09-15 16:14:03.667365
75	10	KS1050XI LIGHT		20.000	\N	\N	0.000		2025-09-15 16:14:03.667366	2025-09-15 16:14:03.667367
76	10	KS1050XI HEAVY		20.000	\N	\N	0.000		2025-09-15 16:14:03.667369	2025-09-15 16:14:03.66737
77	10	WC100		15.000	\N	\N	0.000		2025-09-15 16:14:03.667371	2025-09-15 16:14:03.667372
78	10	KS8146I		20.000	\N	\N	0.000		2025-09-15 16:14:03.667374	2025-09-15 16:14:03.667375
79	10	KS1550XI		5.000	\N	\N	0.000		2025-09-15 16:14:03.667376	2025-09-15 16:14:03.667377
80	10			1.000	\N	\N	0.000		2025-09-15 16:14:03.667378	2025-09-15 16:14:03.66738
\.


--
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, po_number, supplier_id, branch_id, user_id, order_date, expected_delivery_date, delivery_date, subtotal, tax_amount, discount_amount, total_amount, status, payment_status, payment_method, notes, approved_by, approved_at, created_at, updated_at) FROM stdin;
7	PO-20250828-180352	4	1	10	2025-08-28	2025-08-28	\N	0.00	0.00	0.00	0.00	draft	pending	\N	Orders for customers 	\N	\N	2025-08-28 15:03:52.46885	2025-08-28 15:03:52.468882
8	PO-20250915-182828	5	1	10	2025-09-15	2025-09-17	\N	0.00	0.00	0.00	0.00	draft	pending	\N		\N	\N	2025-09-15 15:28:28.982965	2025-09-15 15:28:28.98298
9	PO-20250915-190417	7	1	10	2025-09-15	2025-09-17	\N	0.00	0.00	0.00	0.00	draft	pending	\N		\N	\N	2025-09-15 16:04:17.746286	2025-09-15 16:04:17.746304
10	PO-20250915-191403	6	1	10	2025-09-15	\N	\N	0.00	0.00	0.00	0.00	draft	pending	\N		\N	\N	2025-09-15 16:14:03.655423	2025-09-15 16:14:03.655433
\.


--
-- Data for Name: quotationitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotationitems (id, quotation_id, product_id, quantity, unit_price, total_price, notes, created_at, product_name) FROM stdin;
295	19	\N	100.000	250.00	25000.00		2025-09-11 06:41:18.770745	MAGIC 4 INCH
296	19	\N	1000.000	250.00	250000.00		2025-09-11 06:41:18.770749	MAGIC 1 AND 1/4
297	19	\N	100.000	120.00	12000.00		2025-09-11 06:41:18.77075	TOILET SCREW
298	19	\N	100.000	120.00	12000.00		2025-09-11 06:41:18.77075	BASIN SCREW
299	19	\N	150.000	350.00	52500.00		2025-09-11 06:41:18.770751	WALL TAP
300	19	\N	80.000	350.00	28000.00		2025-09-11 06:41:18.770752	PILLAR TAP
301	19	\N	300.000	190.00	57000.00		2025-09-11 06:41:18.770753	ANGLE VALVE
302	19	\N	30.000	1900.00	57000.00		2025-09-11 06:41:18.770753	KITCHEN PILLAR
303	19	\N	95.000	900.00	85500.00		2025-09-11 06:41:18.770754	ARABIC SHOWER
304	19	\N	95.000	1000.00	95000.00		2025-09-11 06:41:18.770755	INTANT SHOWER
305	19	\N	95.000	130.00	12350.00		2025-09-11 06:41:18.770756	G.I PIPE 1 AND 1/2
306	19	\N	300.000	30.00	9000.00		2025-09-11 06:41:18.770756	G.I SOCKET
307	19	\N	50.000	200.00	10000.00		2025-09-11 06:41:18.770757	BOSS WHITE 400 GRMS
308	19	\N	1000.000	25.00	25000.00		2025-09-11 06:41:18.770758	THREAD TAPE
309	19	\N	50.000	400.00	20000.00		2025-09-11 06:41:18.770758	SILICONE HIGHTEC
310	19	\N	90.000	100.00	9000.00		2025-09-11 06:41:18.770759	FLEXTUBE 1 AND 1/2 FT
21	5	\N	400.000	140.00	56000.00	\N	2025-08-30 17:52:10.83182	PPR M/ADAPTER 25MM*3/4
22	5	\N	152.000	200.00	30400.00	\N	2025-08-30 17:52:10.83182	METALLIC UNION 25MMX*3/4(male)
23	5	\N	148.000	600.00	88800.00	\N	2025-08-30 17:52:10.83182	GATE VALVE 3/4
24	5	\N	76.000	450.00	34200.00	\N	2025-08-30 17:52:10.83182	SILICON PATEX 
28	6	\N	1.000	34000.00	34000.00	\N	2025-09-02 09:21:18.475716	CONCEALED WALL MOUNT TOILET CISTERN
29	6	\N	3.000	13000.00	39000.00	\N	2025-09-02 09:21:18.475728	5 WAY CONCEALED MIXER BRIMIX BLACK
30	6	\N	1.000	1250.00	1250.00	\N	2025-09-02 09:21:18.47573	STOP CORK COBRA
218	16	\N	57.000	100.00	5700.00	\N	2025-09-05 14:20:14.871665	CLEAR SITE FOR WORKING AREA OF BUSH AND SHRUB
219	16	\N	57.000	250.00	14250.00	\N	2025-09-05 14:20:14.871677	EVACUATE 150MM AVERAGE TOP VEGITABLE SOIL
49	7	\N	1.000	14700.00	14700.00	\N	2025-09-02 15:44:22.923703	FRENCIA WC 029 COMPLETE
50	7	\N	9.000	150.00	1350.00	\N	2025-09-02 15:44:22.923709	FLEXTUBE 1 1/2
51	7	\N	3.000	300.00	900.00	\N	2025-09-02 15:44:22.92371	MAGIC 4 INCH
52	7	\N	3.000	350.00	1050.00	\N	2025-09-02 15:44:22.92371	MAGIC 1 1/4 CHROME
53	7	\N	2.000	1500.00	3000.00	\N	2025-09-02 15:44:22.923711	LEVER TAP
54	7	\N	1.000	800.00	800.00	\N	2025-09-02 15:44:22.923712	TISSUE HOLDER
55	7	\N	2.000	800.00	1600.00	\N	2025-09-02 15:44:22.923713	SINGLE TOOTHBRUSH HOLDER
56	7	\N	3.000	800.00	2400.00	\N	2025-09-02 15:44:22.923714	SINGLE TOWEL HOLDER
57	7	\N	3.000	600.00	1800.00	\N	2025-09-02 15:44:22.923714	WALL TAP LONG KNECK
58	7	\N	3.000	150.00	450.00	\N	2025-09-02 15:44:22.923715	GI PIPE 1 1/2
59	7	\N	3.000	30.00	90.00	\N	2025-09-02 15:44:22.923716	GI SOCKET
60	7	\N	3.000	2750.00	8250.00	\N	2025-09-02 15:44:22.923717	INSTANT SHOWER
61	7	\N	1.000	10700.00	10700.00	\N	2025-09-02 15:44:22.923718	FRENCIA WC 664 COMPLETE
62	7	\N	1.000	10000.00	10000.00	\N	2025-09-02 15:44:22.923718	FRENCIA 008 COMPLETE
63	7	\N	9.000	250.00	2250.00	\N	2025-09-02 15:44:22.923719	ANGLE VALVE
64	7	\N	3.000	1000.00	3000.00	\N	2025-09-02 15:44:22.92372	ARABIC SHOWER
65	8	625	1.000	500.00	500.00		2025-09-03 15:29:02.543982	\N
66	9	\N	76.000	5200.00	395200.00		2025-09-04 09:31:16.610631	KS6045S SINGLE BOWL (GRILL WITH FITTINGS)
71	10	\N	2.000	1300.00	2600.00	\N	2025-09-04 11:24:49.87717	INSTANT SHOWER
72	10	\N	7.000	230.00	1610.00	\N	2025-09-04 11:24:49.877174	ANGLE VALVE
73	10	\N	2.000	800.00	1600.00	\N	2025-09-04 11:24:49.877175	STOP CORK CONCALED
74	10	\N	2.000	500.00	1000.00	\N	2025-09-04 11:24:49.877175	PILLAR TAP
75	10	\N	2.000	150.00	300.00	\N	2025-09-04 11:24:49.877177	FLEX TUBE 1.5
76	10	\N	2.000	180.00	360.00	\N	2025-09-04 11:24:49.877178	MAGIC FLEX
77	10	\N	1.000	4800.00	4800.00	\N	2025-09-04 11:24:49.877178	HANDWASH BASIN
78	10	\N	2.000	600.00	1200.00	\N	2025-09-04 11:24:49.877179	ARABIC SHOWER
79	11	\N	60.000	4200.00	252000.00		2025-09-04 11:30:24.507992	Kitchen sink Double FR
80	12	\N	2.000	3200.00	6400.00		2025-09-04 12:27:29.407921	Cistern
81	12	\N	4.000	2600.00	10400.00		2025-09-04 12:27:29.407924	Pedestal
82	13	\N	500.000	11000.00	5500000.00		2025-09-04 14:24:34.065864	Wc 100 closed couple
83	13	\N	50.000	800.00	40000.00		2025-09-04 14:24:34.065877	Gypsum
84	13	\N	5.000	250.00	1250.00		2025-09-04 14:24:34.06588	Gypsum screw
85	14	\N	60.000	4600.00	276000.00		2025-09-05 05:30:56.909035	KITCHEN SINK DOUBLE  BOWL JO
86	15	\N	21.000	900.00	18900.00		2025-09-05 06:54:03.167465	ARABIC SHOWER
87	15	\N	15.000	350.00	5250.00		2025-09-05 06:54:03.167472	SOAP DISH
88	15	\N	15.000	1300.00	19500.00		2025-09-05 06:54:03.167475	GLASS RACK
89	15	\N	9.000	700.00	6300.00		2025-09-05 06:54:03.167476	TOWEL BAR
90	15	\N	21.000	650.00	13650.00		2025-09-05 06:54:03.167478	TOWEL RING
91	15	\N	21.000	1300.00	27300.00		2025-09-05 06:54:03.167479	TOILET BRUSH
92	15	\N	9.000	650.00	5850.00		2025-09-05 06:54:03.16748	TOOTHBRUSH HOLDER
93	15	\N	21.000	350.00	7350.00		2025-09-05 06:54:03.167482	TISSUE HOLDER
94	15	\N	6.000	700.00	4200.00		2025-09-05 06:54:03.167483	SINGLE TOWEL BAR
95	15	\N	6.000	650.00	3900.00		2025-09-05 06:54:03.167485	TOOTH BRUSH HOLDER
274	18	\N	100.000	850.00	85000.00	\N	2025-09-10 05:12:14.425525	GYPSUM BOARD
275	18	\N	90.000	130.00	11700.00	\N	2025-09-10 05:12:14.425531	STUDS
276	18	\N	60.000	130.00	7800.00	\N	2025-09-10 05:12:14.425532	CHANNELS
277	18	\N	10.000	600.00	6000.00	\N	2025-09-10 05:12:14.425533	GYPSUM SCREW 1"
278	18	\N	5.000	250.00	1250.00	\N	2025-09-10 05:12:14.425534	MDF SCREW 2"
279	18	\N	2.000	230.00	460.00	\N	2025-09-10 05:12:14.425535	STEEL NAILS 2"
280	18	\N	1.000	230.00	230.00	\N	2025-09-10 05:12:14.425536	STEEL NAILS 1.5"
281	18	\N	5.000	150.00	750.00	\N	2025-09-10 05:12:14.425536	WALL PLUG 6MM
282	18	\N	1.000	1500.00	1500.00	\N	2025-09-10 05:12:14.425537	SAND PAPER P120 ROLL
283	18	\N	6.000	1900.00	11400.00	\N	2025-09-10 05:12:14.425538	GYPROC FILLER
284	18	\N	3.000	1300.00	3900.00	\N	2025-09-10 05:12:14.425539	SKIMCOAT
285	18	\N	10.000	350.00	3500.00	\N	2025-09-10 05:12:14.42554	FIBRE TAPE
286	18	\N	4.000	1100.00	4400.00	\N	2025-09-10 05:12:14.425541	CORNER TAPE
287	18	\N	2.000	3000.00	6000.00	\N	2025-09-10 05:12:14.425542	UNDERCOAT 2OL
288	18	\N	3.000	200.00	600.00	\N	2025-09-10 05:12:14.425542	ROLLER BRUSH
289	18	\N	3.000	150.00	450.00	\N	2025-09-10 05:12:14.425543	BRUSH 4"
290	18	\N	1.000	4800.00	4800.00	\N	2025-09-10 05:12:14.425544	ELECTRICAL WIRE 1.5
291	18	\N	150.000	40.00	6000.00	\N	2025-09-10 05:12:14.425545	SKIRTING
292	18	\N	1.000	22300.00	22300.00	\N	2025-09-10 05:12:14.425546	ALLUMINIUM SLIDING DOOR MATERIALS
293	18	\N	1.000	4200.00	4200.00	\N	2025-09-10 05:12:14.425546	ROPE + HOSE PIPE
294	18	\N	1.000	60000.00	60000.00	\N	2025-09-10 05:12:14.425547	LABOUR COST
181	17	\N	2.000	4500.00	9000.00	\N	2025-09-05 14:11:06.917924	Cistern 045
182	17	\N	4.000	2600.00	10400.00	\N	2025-09-05 14:11:06.917935	Pedestal
311	19	\N	100.000	190.00	19000.00		2025-09-11 06:41:18.77076	FLEXTUBE 2FT
220	16	\N	41.000	450.00	18450.00	\N	2025-09-05 14:20:14.871679	EVACUATE 600MM WIDE FOUNDATION TRENCH COMMENCING FROM STIPPED LEVEL AVERAGE DEPTH 1.5
221	16	\N	1.000	9500.00	9500.00	\N	2025-09-05 14:20:14.87168	ALLOW FOR PLUNKING AND STRUTING
222	16	\N	1.000	9500.00	9500.00	\N	2025-09-05 14:20:14.871681	KEEP OFF WATER FROM EXCAVATED SITE
223	16	\N	27.000	1200.00	32400.00	\N	2025-09-05 14:20:14.871683	50MM FOUNDATION CONCRETE BLINDING CLASS P MIX 1.03:06
224	16	\N	5.000	13000.00	65000.00	\N	2025-09-05 14:20:14.871685	CONCRETE CLASS 20/20 MIX 1:3:6 IN STRIP FOUNDATION
225	16	\N	57.000	1200.00	68400.00	\N	2025-09-05 14:20:14.871686	200mm thick substructure stone walling in cement mortar 1:4 reinforced with hoop iron at alternate courses
226	16	\N	23.000	350.00	8050.00	\N	2025-09-05 14:20:14.871688	Backfill excavated material around foundation trenches
227	16	\N	18.000	450.00	8100.00	\N	2025-09-05 14:20:14.871689	Remove surplus excavated material from site wheel and spread around the site
228	16	\N	57.000	350.00	19950.00	\N	2025-09-05 14:20:14.87169	300mm thick hardcore filling
229	16	\N	57.000	450.00	25650.00	\N	2025-09-05 14:20:14.871692	50mm murram blinding to hardcore
230	16	\N	57.000	250.00	14250.00	\N	2025-09-05 14:20:14.871693	Anti termite solution sprayed on murram blinding with 10years gurantee
231	16	\N	57.000	650.00	37050.00	\N	2025-09-05 14:20:14.871695	1000 gauge polythene underlay damp proof membrane
232	16	\N	30.000	250.00	7500.00	\N	2025-09-05 14:20:14.871696	150 x 25mm timber formwork to sides of slab (75-150mm high)
233	16	\N	57.000	350.00	19950.00	\N	2025-09-05 14:20:14.871698	B.R.C mesh ref A142
234	16	\N	57.000	1200.00	68400.00	\N	2025-09-05 14:20:14.871699	150mm thick floor concrete slab mix 1:3:6
235	16	\N	18.000	350.00	6300.00	\N	2025-09-05 14:20:14.8717	12mm thick render to walls
236	16	\N	18.000	350.00	6300.00	\N	2025-09-05 14:20:14.871703	Prepare and apply three coats oil paints to rendered
237	16	\N	94.000	170.00	15980.00	\N	2025-09-05 14:20:14.871704	Y10 bars
238	16	\N	55.000	170.00	9350.00	\N	2025-09-05 14:20:14.871705	Y8 bars
239	16	\N	112.000	1100.00	123200.00	\N	2025-09-05 14:20:14.871707	200mm thick superstructure stonewalling in cement mortar 1:4 reinforced with hoop/iron at alternate courses with REINFORCED CONCRETE SUPERSTRUCTURE 112 Sm 1,100.00 123,200.00 Vibrated reinforced concrete grade 25/20 (1:5:3) in:-
240	16	\N	4.000	1300.00	5200.00	\N	2025-09-05 14:20:14.871708	Beam
241	16	\N	1.000	450000.00	450000.00	\N	2025-09-05 14:20:14.87171	Allow a provisional sum of four hundred and fifty thousand shillings (450,000.00) only for the outdoor 3-door toilet and shower
242	16	\N	1.000	500000.00	500000.00	\N	2025-09-05 14:20:14.871711	Allow a provisional sum of five hundred thousand shillings(500,000.00) only for sanitary fittings
243	16	\N	1.000	750000.00	750000.00	\N	2025-09-05 14:20:14.871713	Allow a provisional sum of seven hundredand fifty thousand shillings(750,000.00) only for landscaping works
244	16	\N	1.000	870000.00	870000.00	\N	2025-09-05 14:20:14.871714	Allow a provisional sum of eight hundred and seventy thousand shillings (870,000.00) only for external works
245	16	\N	1.000	870000.00	870000.00	\N	2025-09-05 14:20:14.871716	Allow a provisional sum of five hundred and fifty thousand shillings (550,000.00) only for mechanical works
246	16	\N	1.000	460000.00	460000.00	\N	2025-09-05 14:20:14.871717	Allow a provisional sum of three hundred and sixty thousand shillings(460,000.00) only for electrical works
247	16	\N	1.000	350000.00	350000.00	\N	2025-09-05 14:20:14.871719	Allow a provisional sum of three hundred and fifty thousand shillings (350,000.00) only for plumbing works
248	16	\N	96.000	350.00	33600.00	\N	2025-09-05 14:20:14.87172	Hightec
249	16	\N	30.000	19550.00	586500.00	\N	2025-09-05 14:20:14.871721	Wc Toilet Master
250	16	\N	30.000	16500.00	495000.00	\N	2025-09-05 14:20:14.871723	Main Cabinet
251	16	\N	115.000	8000.00	920000.00	\N	2025-09-05 14:20:14.871725	Wc Common Toilet
252	16	\N	115.000	7500.00	862500.00	\N	2025-09-05 14:20:14.871726	Wc Mini Master
253	16	\N	29.000	8000.00	232000.00	\N	2025-09-05 14:20:14.871727	Wc Dsq Toilet
254	16	\N	400.000	300.00	120000.00	\N	2025-09-05 14:20:14.871729	Chrome Pipe
255	16	\N	580.000	500.00	290000.00	\N	2025-09-05 14:20:14.87173	Magic 4 Inch
256	16	\N	300.000	500.00	150000.00	\N	2025-09-05 14:20:14.871731	ToothBrush Holder
312	20	\N	95.000	250.00	23750.00		2025-09-15 15:22:18.132675	MAGIC 4''
313	20	\N	95.000	250.00	23750.00		2025-09-15 15:22:18.132681	MAGIC 1,1/4''
314	20	\N	95.000	120.00	11400.00		2025-09-15 15:22:18.132684	TOILET SCREW
315	20	\N	70.000	120.00	8400.00		2025-09-15 15:22:18.132687	BASIN SCREW
316	20	\N	95.000	350.00	33250.00		2025-09-15 15:22:18.132691	WALL TAP
317	20	\N	95.000	350.00	33250.00		2025-09-15 15:22:18.132692	PILLAR TAP
318	20	\N	200.000	190.00	38000.00		2025-09-15 15:22:18.132694	ANGLE VALVE
319	20	\N	30.000	1900.00	57000.00		2025-09-15 15:22:18.132695	KITCHEN PILLAR TAP
320	20	\N	95.000	900.00	85500.00		2025-09-15 15:22:18.132697	ARABIC SHOWER
321	20	\N	95.000	1000.00	95000.00		2025-09-15 15:22:18.132698	INSTANT SHOWER
322	20	\N	95.000	130.00	12350.00		2025-09-15 15:22:18.132699	G.I PIPE 1,1/2''
323	20	\N	200.000	30.00	6000.00		2025-09-15 15:22:18.132702	G.I SOCKET 1/2''
324	20	\N	100.000	100.00	10000.00		2025-09-15 15:22:18.132703	BOSS WHITE 200GM
325	20	\N	500.000	25.00	12500.00		2025-09-15 15:22:18.132704	THREAD TAPE
326	20	\N	170.000	100.00	17000.00		2025-09-15 15:22:18.132705	FLEX 1,1/2 FT
327	20	\N	95.000	190.00	18050.00		2025-09-15 15:22:18.132706	FLEX 2FT
328	20	\N	50.000	350.00	17500.00		2025-09-15 15:22:18.132708	SILICON KNICKER
\.


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotations (id, quotation_number, customer_name, customer_email, customer_phone, created_by, branch_id, subtotal, total_amount, status, valid_until, notes, created_at, updated_at) FROM stdin;
16	QT-002618	HASSAN MOHAMED			15	1	8538030.00	8538030.00	pending	2025-10-05 00:00:00		2025-09-05 11:21:43.17666	2025-09-05 14:20:14.863433
18	QT-719883	GLASSKEY			18	2	242240.00	242240.00	pending	2025-09-20 00:00:00		2025-09-09 09:43:49.701462	2025-09-10 05:12:14.42144
19	QT-983349	WAJID			18	2	778350.00	778350.00	pending	2025-09-30 00:00:00		2025-09-11 06:41:18.755319	2025-09-11 06:41:18.766149
20	QT-306965	WAJID			14	2	502700.00	502700.00	pending	2025-09-30 00:00:00		2025-09-15 15:22:18.118229	2025-09-15 15:22:18.127366
5	QT-280280	SWEETHOMES		0741233899	5	1	209400.00	209400.00	pending	2025-09-15 00:00:00		2025-08-29 13:38:16.556129	2025-08-30 17:52:10.17936
6	QT-109473	NUUR SGM			15	1	74250.00	74250.00	pending	2025-09-30 00:00:00		2025-08-30 17:18:28.680462	2025-09-02 09:21:18.467582
7	QT-451670	SUSWA			15	2	62340.00	62340.00	pending	2025-10-02 00:00:00		2025-09-02 10:22:05.922869	2025-09-02 15:44:22.920035
8	QT-984827	Ann			16	3	500.00	500.00	pending	2025-10-31 00:00:00		2025-09-03 15:29:02.531001	2025-09-03 15:29:02.541823
9	QT-051054	SWEETHOMES REAL ESTATE			5	1	395200.00	395200.00	pending	2025-10-05 00:00:00		2025-09-04 09:31:16.60147	2025-09-04 09:31:16.607943
10	QT-065491	IDRIS			5	2	13470.00	13470.00	pending	2025-10-05 00:00:00		2025-09-04 11:18:39.984336	2025-09-04 11:24:49.874312
11	QT-806754	Khaleel Homes			18	2	252000.00	252000.00	pending	2025-09-30 00:00:00		2025-09-04 11:30:24.498969	2025-09-04 11:30:24.505746
12	QT-041957	Abdiqadir 			18	2	16800.00	16800.00	pending	\N		2025-09-04 12:27:29.402416	2025-09-04 12:27:29.406388
13	QT-494868	Glasskey			18	2	5541250.00	5541250.00	pending	\N		2025-09-04 14:24:34.045335	2025-09-04 14:24:34.055263
14	QT-853305	Khaleel Homes			18	2	276000.00	276000.00	pending	\N		2025-09-05 05:30:56.901489	2025-09-05 05:30:56.907144
15	QT-256402	*			14	1	112200.00	112200.00	pending	2025-09-11 00:00:00		2025-09-05 06:54:03.157736	2025-09-05 06:54:03.164776
17	QT-252626	Sakina House			18	2	19400.00	19400.00	pending	\N		2025-09-05 13:39:31.134907	2025-09-05 14:11:06.913814
\.


--
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receipts (id, paymentid, orderid, receipt_number, payment_amount, previous_balance, remaining_balance, payment_method, reference_number, transaction_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: stock_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_transactions (id, productid, userid, transaction_type, quantity, previous_stock, new_stock, notes, created_at) FROM stdin;
1	52	8	remove	1.000	5.000	4.000	Stock reduced due to order #18 approval	2025-08-21 10:42:10.460295
2	71	8	remove	1.000	10.000	9.000	Stock reduced due to order #18 approval	2025-08-21 10:42:11.544046
3	47	8	remove	2.000	10.000	8.000	Stock reduced due to order #19 approval	2025-08-21 11:01:31.70484
4	95	8	remove	4.000	5.000	1.000	Stock reduced due to order #19 approval	2025-08-21 11:01:32.777708
5	539	13	remove	14.000	50.000	36.000	Stock reduced due to order #26 approval	2025-08-26 13:44:56.90476
6	598	13	remove	14.000	15.000	1.000	Stock reduced due to order #26 approval	2025-08-26 13:44:56.915124
7	157	9	remove	5.000	5.000	0.000	Stock reduced due to order #29 approval	2025-08-27 07:24:06.853893
8	157	8	remove	8.000	5.000	-3.000	Stock reduced due to order #30 approval (Backorder: 3 units)	2025-08-27 15:24:12.469778
9	47	9	remove	1.000	8.000	7.000	Stock reduced due to order #33 approval (Backorder: 0 units)	2025-08-27 15:28:39.848576
10	150	9	remove	1.000	25.000	24.000	Stock reduced due to order #33 approval (Backorder: 0 units)	2025-08-27 15:28:39.8549
11	379	9	remove	1.000	0.000	-1.000	Stock reduced due to order #36 approval (Backorder: 1 units)	2025-08-28 12:38:56.264923
12	368	9	remove	4.000	0.000	-4.000	Stock reduced due to order #36 approval (Backorder: 4 units)	2025-08-28 12:38:56.276626
13	360	9	remove	4.000	0.000	-4.000	Stock reduced due to order #36 approval (Backorder: 4 units)	2025-08-28 12:38:56.28504
14	328	9	remove	7.000	0.000	-7.000	Stock reduced due to order #36 approval (Backorder: 7 units)	2025-08-28 12:38:56.293541
15	362	9	remove	1.000	0.000	-1.000	Stock reduced due to order #36 approval (Backorder: 1 units)	2025-08-28 12:38:56.300736
16	335	9	remove	15.000	0.000	-15.000	Stock reduced due to order #36 approval (Backorder: 15 units)	2025-08-28 12:38:56.30837
17	352	9	remove	6.000	0.000	-6.000	Stock reduced due to order #36 approval (Backorder: 6 units)	2025-08-28 12:38:56.315757
18	242	9	remove	15.000	0.000	-15.000	Stock reduced due to order #36 approval (Backorder: 15 units)	2025-08-28 12:38:56.321845
19	585	9	remove	4.000	50.000	46.000	Stock reduced due to order #36 approval (Backorder: 0 units)	2025-08-28 12:38:56.330654
20	378	9	remove	1.000	0.000	-1.000	Stock reduced due to order #36 approval (Backorder: 1 units)	2025-08-28 12:38:56.336861
21	367	9	remove	6.000	0.000	-6.000	Stock reduced due to order #36 approval (Backorder: 6 units)	2025-08-28 12:38:56.342039
22	374	9	remove	2.000	0.000	-2.000	Stock reduced due to order #36 approval (Backorder: 2 units)	2025-08-28 12:38:56.35216
23	389	9	remove	3.000	0.000	-3.000	Stock reduced due to order #36 approval (Backorder: 3 units)	2025-08-28 12:38:56.359723
24	474	9	remove	1.000	0.000	-1.000	Stock reduced due to order #37 approval (Backorder: 1 units)	2025-08-28 12:42:53.664382
25	397	9	remove	1.000	10.000	9.000	Stock reduced due to order #37 approval (Backorder: 0 units)	2025-08-28 12:42:53.672636
26	143	9	remove	1.000	1.000	0.000	Stock reduced due to order #38 approval (Backorder: 0 units)	2025-08-28 13:09:13.40742
27	209	9	remove	1.000	10.000	9.000	Stock reduced due to order #38 approval (Backorder: 0 units)	2025-08-28 13:09:13.415655
28	157	9	remove	1.000	-3.000	-4.000	Stock reduced due to order #39 approval (Backorder: 4 units)	2025-08-28 13:59:22.943055
29	177	9	remove	1.000	10.000	9.000	Stock reduced due to order #40 approval (Backorder: 0 units)	2025-08-28 14:55:45.888014
30	587	9	remove	2.000	100.000	98.000	Stock reduced due to order #48 approval (Backorder: 0 units)	2025-08-30 11:14:55.833597
31	588	9	remove	1.000	50.000	49.000	Stock reduced due to order #48 approval (Backorder: 0 units)	2025-08-30 11:14:55.851319
32	545	9	remove	1.000	50.000	49.000	Stock reduced due to order #48 approval (Backorder: 0 units)	2025-08-30 11:14:55.856184
33	149	9	remove	2.000	30.000	28.000	Stock reduced due to order #48 approval (Backorder: 0 units)	2025-08-30 11:14:55.859988
34	432	9	remove	1.000	6.000	5.000	Stock reduced due to order #53 approval (Backorder: 0 units)	2025-09-01 13:46:11.557885
35	44	9	remove	1.000	3.000	2.000	Stock reduced due to order #58 approval (Backorder: 0 units)	2025-09-02 13:50:27.015055
36	146	9	remove	1.000	30.000	29.000	Stock reduced due to order #58 approval (Backorder: 0 units)	2025-09-02 13:50:27.026297
37	55	9	remove	1.000	5.000	4.000	Stock reduced due to order #58 approval (Backorder: 0 units)	2025-09-02 13:50:27.033457
38	601	9	remove	1.000	30.000	29.000	Stock reduced due to order #59 approval (Backorder: 0 units)	2025-09-02 14:01:46.853091
39	593	9	remove	2.000	50.000	48.000	Stock reduced due to order #60 approval (Backorder: 0 units)	2025-09-02 14:03:21.102164
40	531	9	remove	1.000	3.000	2.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.903541
41	202	9	remove	1.000	40.000	39.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.914487
42	149	9	remove	1.000	28.000	27.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.925754
43	595	9	remove	2.000	100.000	98.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.937376
44	551	9	remove	2.000	99.000	97.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.948153
45	430	9	remove	1.000	10.000	9.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.95783
46	447	9	remove	1.000	10.000	9.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.967236
47	461	9	remove	1.000	6.000	5.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.976094
48	557	9	remove	1.000	6.000	5.000	Stock reduced due to order #56 approval (Backorder: 0 units)	2025-09-02 14:06:19.988262
49	600	9	remove	2.000	50.000	48.000	Stock reduced due to order #63 approval (Backorder: 0 units)	2025-09-03 13:27:23.897095
50	457	9	remove	2.000	10.000	8.000	Stock reduced due to order #62 approval (Backorder: 0 units)	2025-09-03 13:37:50.324451
51	152	9	remove	1.000	10.000	9.000	Stock reduced due to order #69 approval (Backorder: 0 units)	2025-09-04 13:26:21.134271
52	89	9	remove	1.000	50.000	49.000	Stock reduced due to order #69 approval (Backorder: 0 units)	2025-09-04 13:26:21.138484
53	656	17	remove	2.000	100.000	98.000	Stock reduced due to order #72 approval (Backorder: 0 units)	2025-09-05 09:03:39.183539
54	667	17	remove	14.000	50.000	36.000	Stock reduced due to order #72 approval (Backorder: 0 units)	2025-09-05 09:03:39.192437
55	663	17	remove	11.000	100.000	89.000	Stock reduced due to order #72 approval (Backorder: 0 units)	2025-09-05 09:03:39.202177
56	625	17	remove	2.000	5.000	3.000	Stock reduced due to order #73 approval (Backorder: 0 units)	2025-09-05 09:04:31.162511
57	617	9	remove	15.000	39.000	24.000	Stock reduced due to order #74 approval (Backorder: 0 units)	2025-09-05 12:29:43.517861
58	529	9	remove	15.000	5.000	-10.000	Stock reduced due to order #74 approval (Backorder: 10 units)	2025-09-05 12:29:43.524317
59	218	9	remove	15.000	10.000	-5.000	Stock reduced due to order #74 approval (Backorder: 5 units)	2025-09-05 12:29:43.528182
60	430	9	remove	21.000	9.000	-12.000	Stock reduced due to order #74 approval (Backorder: 12 units)	2025-09-05 12:29:43.531987
61	452	9	remove	21.000	5.000	-16.000	Stock reduced due to order #74 approval (Backorder: 16 units)	2025-09-05 12:29:43.536506
62	466	9	remove	15.000	20.000	5.000	Stock reduced due to order #74 approval (Backorder: 0 units)	2025-09-05 12:29:43.541157
63	196	9	remove	21.000	20.000	-1.000	Stock reduced due to order #74 approval (Backorder: 1 units)	2025-09-05 12:29:43.545452
64	143	9	remove	5.000	0.000	-5.000	Stock reduced due to order #75 approval (Backorder: 5 units)	2025-09-05 14:44:01.913498
65	164	9	remove	10.000	10.000	0.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.924792
66	601	9	remove	5.000	29.000	24.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.931686
67	551	9	remove	15.000	97.000	82.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.940779
68	154	9	remove	5.000	25.000	20.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.950261
69	566	9	remove	10.000	48.000	38.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.956227
70	585	9	remove	11.000	46.000	35.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.961214
71	581	9	remove	10.000	50.000	40.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.966325
72	380	9	remove	5.000	0.000	-5.000	Stock reduced due to order #75 approval (Backorder: 5 units)	2025-09-05 14:44:01.97124
73	335	9	remove	18.000	-15.000	-33.000	Stock reduced due to order #75 approval (Backorder: 33 units)	2025-09-05 14:44:01.976395
74	148	9	remove	5.000	31.000	26.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:01.989654
75	336	9	remove	6.000	0.000	-6.000	Stock reduced due to order #75 approval (Backorder: 6 units)	2025-09-05 14:44:01.996096
76	359	9	remove	2.000	0.000	-2.000	Stock reduced due to order #75 approval (Backorder: 2 units)	2025-09-05 14:44:02.002455
77	607	9	remove	1.000	20.000	19.000	Stock reduced due to order #75 approval (Backorder: 0 units)	2025-09-05 14:44:02.007908
78	625	17	remove	3.000	3.000	0.000	Stock reduced due to order #76 approval (Backorder: 0 units)	2025-09-05 16:44:30.960759
79	677	17	remove	1.000	20.000	19.000	Stock reduced due to order #76 approval (Backorder: 0 units)	2025-09-05 16:44:30.966122
80	581	9	remove	1.000	40.000	39.000	Stock reduced due to order #91 approval (Backorder: 0 units)	2025-09-08 13:39:41.756864
81	592	9	remove	3.000	50.000	47.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.052153
82	143	9	remove	2.000	-5.000	-7.000	Stock reduced due to order #90 approval (Backorder: 7 units)	2025-09-08 13:42:48.064084
83	149	9	remove	2.000	27.000	25.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.071264
84	553	9	remove	1.000	90.000	89.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.078483
85	96	9	remove	2.000	10.000	8.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.088061
86	156	9	remove	1.000	5.000	4.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.092594
87	581	9	remove	1.000	39.000	38.000	Stock reduced due to order #90 approval (Backorder: 0 units)	2025-09-08 13:42:48.096045
88	636	17	remove	30.000	100.000	70.000	Stock reduced due to order #92 approval (Backorder: 0 units)	2025-09-08 17:06:03.927815
89	641	17	remove	1.000	50.000	49.000	Stock reduced due to order #92 approval (Backorder: 0 units)	2025-09-08 17:06:03.933528
90	557	9	remove	2.000	5.000	3.000	Stock reduced due to order #94 approval (Backorder: 0 units)	2025-09-09 13:26:28.153561
91	151	9	remove	1.000	12.000	11.000	Stock reduced due to order #96 approval (Backorder: 0 units)	2025-09-09 15:02:23.6455
92	89	9	remove	1.000	49.000	48.000	Stock reduced due to order #96 approval (Backorder: 0 units)	2025-09-09 15:02:23.651433
93	156	9	remove	1.000	4.000	3.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.101761
94	47	9	remove	1.000	10.000	9.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.107018
95	152	9	remove	1.000	9.000	8.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.111145
96	395	9	remove	1.000	10.000	9.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.115142
97	186	9	remove	1.000	3.000	2.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.118655
98	587	9	remove	1.000	100.000	99.000	Stock reduced due to order #97 approval (Backorder: 0 units)	2025-09-09 15:03:51.122229
99	636	17	remove	20.000	70.000	50.000	Stock reduced due to order #99 approval (Backorder: 0 units)	2025-09-09 15:55:58.576142
100	585	9	remove	4.000	35.000	31.000	Stock reduced due to order #101 approval (Backorder: 0 units)	2025-09-10 13:53:09.65319
101	592	9	remove	1.000	47.000	46.000	Stock reduced due to order #101 approval (Backorder: 0 units)	2025-09-10 13:53:09.659063
102	296	9	remove	1.000	9.000	8.000	Stock reduced due to order #101 approval (Backorder: 0 units)	2025-09-10 13:53:09.663128
103	636	17	remove	30.000	50.000	20.000	Stock reduced due to order #104 approval (Backorder: 0 units)	2025-09-10 15:22:38.592324
104	685	17	remove	6.000	30.000	24.000	Stock reduced due to order #104 approval (Backorder: 0 units)	2025-09-10 15:22:38.597081
105	470	9	remove	2.000	10.000	8.000	Stock reduced due to order #105 approval (Backorder: 0 units)	2025-09-11 13:41:50.454839
106	636	17	remove	10.000	20.000	10.000	Stock reduced due to order #107 approval (Backorder: 0 units)	2025-09-11 15:20:01.594829
107	668	17	remove	5.000	50.000	45.000	Stock reduced due to order #87 approval (Backorder: 0 units)	2025-09-12 10:09:38.776403
108	658	17	remove	5.000	100.000	95.000	Stock reduced due to order #87 approval (Backorder: 0 units)	2025-09-12 10:09:38.784649
109	673	17	remove	5.000	100.000	95.000	Stock reduced due to order #87 approval (Backorder: 0 units)	2025-09-12 10:09:38.790279
110	674	17	remove	5.000	100.000	95.000	Stock reduced due to order #87 approval (Backorder: 0 units)	2025-09-12 10:09:38.795072
111	687	17	remove	2.000	10.000	8.000	Stock reduced due to order #87 approval (Backorder: 0 units)	2025-09-12 10:09:38.809179
112	570	9	remove	3.000	12.000	9.000	Stock reduced due to order #111 approval (Backorder: 0 units)	2025-09-12 13:45:10.509606
113	690	17	remove	1.000	10.000	9.000	Stock reduced due to order #112 approval (Backorder: 0 units)	2025-09-12 15:39:54.697091
114	622	17	remove	6.000	100.000	94.000	Stock reduced due to order #113 approval (Backorder: 0 units)	2025-09-13 07:18:29.409085
115	642	17	remove	6.000	50.000	44.000	Stock reduced due to order #114 approval (Backorder: 0 units)	2025-09-13 10:27:37.549391
116	640	17	remove	1.000	100.000	99.000	Stock reduced due to order #114 approval (Backorder: 0 units)	2025-09-13 10:27:37.554569
117	649	17	remove	6.000	100.000	94.000	Stock reduced due to order #114 approval (Backorder: 0 units)	2025-09-13 10:27:37.559031
118	638	17	remove	1.000	100.000	99.000	Stock reduced due to order #114 approval (Backorder: 0 units)	2025-09-13 10:27:37.564515
119	643	17	remove	1.000	50.000	49.000	Stock reduced due to order #114 approval (Backorder: 0 units)	2025-09-13 10:27:37.568316
120	677	17	remove	5.000	19.000	14.000	Stock reduced due to order #115 approval (Backorder: 0 units)	2025-09-13 10:34:06.620835
121	99	9	remove	2.000	10.000	8.000	Stock reduced due to order #117 approval (Backorder: 0 units)	2025-09-13 11:39:48.326815
122	636	17	remove	13.000	100.000	87.000	Stock reduced due to order #118 approval (Backorder: 0 units)	2025-09-13 13:08:25.973997
123	532	9	remove	1.000	3.000	2.000	Stock reduced due to order #120 approval (Backorder: 0 units)	2025-09-15 13:17:50.499395
124	483	9	remove	1.000	5.000	4.000	Stock reduced due to order #121 approval (Backorder: 0 units)	2025-09-15 13:18:36.889492
125	395	9	remove	1.000	9.000	8.000	Stock reduced due to order #122 approval (Backorder: 0 units)	2025-09-15 13:20:27.801314
126	584	9	remove	30.000	499.000	469.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.60921
127	177	9	remove	2.000	8.000	6.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.613957
128	593	9	remove	6.000	48.000	42.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.617517
129	154	9	remove	4.000	20.000	16.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.621035
130	581	9	remove	6.000	38.000	32.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.624601
131	100	9	remove	3.000	10.000	7.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.628079
132	225	9	remove	1.000	5.000	4.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.632202
133	193	9	remove	1.000	3.000	2.000	Stock reduced due to order #125 approval (Backorder: 0 units)	2025-09-15 14:58:10.635437
134	624	17	remove	1.000	5.000	4.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.384484
135	666	17	remove	17.000	50.000	33.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.390091
136	636	17	remove	10.000	87.000	77.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.395074
137	642	17	remove	5.000	44.000	39.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.399857
138	678	17	remove	1.000	30.000	29.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.403869
139	687	17	remove	1.000	8.000	7.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.408382
140	640	17	remove	1.000	99.000	98.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.41285
141	673	17	remove	2.000	95.000	93.000	Stock reduced due to order #128 approval (Backorder: 0 units)	2025-09-15 15:53:05.416548
\.


--
-- Data for Name: sub_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sub_category (id, category_id, name, description, image_url, created_at, updated_at) FROM stdin;
1	1	One piece		\N	2025-08-08 12:28:57.372769	2025-08-08 12:28:57.372781
2	1	Two Piece		\N	2025-08-08 12:29:35.563342	2025-08-08 12:29:35.563355
3	1	P TRAP		\N	2025-08-08 12:30:22.317184	2025-08-08 12:30:22.317195
4	1	S Trap		\N	2025-08-08 12:30:34.776107	2025-08-08 12:30:34.776122
5	1	Step Asian		\N	2025-08-08 12:31:07.703404	2025-08-08 12:31:07.703415
6	1	Asian		\N	2025-08-08 12:31:21.226094	2025-08-08 12:31:21.226118
8	2	Counter		\N	2025-08-08 12:34:33.604554	2025-08-08 12:34:33.604569
9	2	Ordinary		\N	2025-08-08 12:39:12.542066	2025-08-08 12:39:12.542082
10	3	All Cabinets		\N	2025-08-08 12:40:45.77761	2025-08-08 12:40:45.777618
11	4	Ceramic Cisterns 		\N	2025-08-08 12:43:50.633873	2025-08-08 12:45:29.053834
12	4	Top Flush Plastic		\N	2025-08-08 12:47:07.718659	2025-08-08 12:47:07.718675
13	4	Urinal Automatic cistern		\N	2025-08-08 12:47:45.576869	2025-08-08 12:47:45.576877
14	5	All Urinal Bowls		\N	2025-08-08 12:48:39.042822	2025-08-08 12:48:39.042839
15	9	Basin Mixer		\N	2025-08-08 13:00:57.328324	2025-08-08 13:00:57.328336
16	9	Pillar Kitchen Mixer		\N	2025-08-08 13:01:35.662645	2025-08-08 13:01:35.662659
17	9	Wall Kitchen Mixer		\N	2025-08-08 13:02:08.535775	2025-08-08 13:02:08.535791
18	10	Basin Pillar Taps		\N	2025-08-08 13:04:49.39596	2025-08-08 13:04:49.395972
19	10	Kitchen pillar sprout		\N	2025-08-08 13:05:35.360802	2025-08-08 13:05:35.360814
20	10	Kitchen Wall Sprout		\N	2025-08-08 13:06:01.833912	2025-08-08 13:06:01.833924
21	10	Bib Taps		\N	2025-08-08 13:06:32.856585	2025-08-08 13:06:32.856594
22	11	Instant Showers		\N	2025-08-08 13:08:17.270099	2025-08-08 13:08:17.270106
23	11	Shower Risers		\N	2025-08-08 13:08:36.422602	2025-08-08 13:08:36.422611
24	11	Normal Shower Mixer		\N	2025-08-08 13:09:13.86248	2025-08-08 13:09:13.862489
25	11	Shower Rose		\N	2025-08-08 13:09:59.102513	2025-08-08 13:09:59.102524
26	11	Shower Heads		\N	2025-08-08 13:10:21.192009	2025-08-08 13:10:21.192024
27	11	Arabic Shower		\N	2025-08-08 13:10:48.851848	2025-08-08 13:10:48.851856
28	11	Telephone Shower		\N	2025-08-08 13:11:26.869582	2025-08-08 13:11:26.869589
29	8	Lab Taps		\N	2025-08-08 13:23:56.915504	2025-08-08 13:23:56.915514
30	8	Elbow Action		\N	2025-08-08 13:25:01.213581	2025-08-08 13:25:01.213594
31	8	Plastic Taps		\N	2025-08-08 13:25:28.656357	2025-08-08 13:25:28.65637
32	8	Garden Tap		\N	2025-08-08 13:25:47.99177	2025-08-08 13:25:47.991785
33	8	Lockable Tap		\N	2025-08-08 13:26:09.364163	2025-08-08 13:26:09.36417
34	24	Plastic Meters		\N	2025-08-08 13:27:53.310113	2025-08-08 13:27:53.310122
35	24	Metallic Meters		\N	2025-08-08 13:28:21.456961	2025-08-08 13:28:21.456971
36	25	SIngle		\N	2025-08-08 13:29:36.490425	2025-08-08 13:29:36.490432
37	25	Double		\N	2025-08-08 13:29:59.137048	2025-08-08 13:29:59.137061
38	11	Concealed 4 way		\N	2025-08-08 13:30:37.587294	2025-08-08 13:30:37.587305
39	11	Concealed 5 way		\N	2025-08-08 13:31:08.11296	2025-08-08 13:31:08.112971
40	28	Magic 4''		\N	2025-08-08 13:35:08.332707	2025-08-08 13:35:08.332715
45	30	PVC Pipes 		\N	2025-08-08 14:07:48.305732	2025-08-08 14:07:48.305744
46	30	PPR 		\N	2025-08-08 14:08:12.302564	2025-08-08 14:08:12.302575
47	30	GI		\N	2025-08-08 14:08:37.245312	2025-08-08 14:08:37.245331
7	2	Basin Pedestal		\N	2025-08-08 12:33:45.71041	2025-08-20 10:28:55.165386
48	31	All Bathroom Categories Set		\N	2025-08-20 13:06:03.225992	2025-08-20 13:06:03.226008
49	12	Soap Dish		\N	2025-08-20 16:14:01.804777	2025-08-20 16:14:01.804807
50	12	Tissue Holder 		\N	2025-08-20 16:48:33.977691	2025-08-20 16:48:33.977714
51	12	Towel Bars		\N	2025-08-20 17:24:09.130124	2025-08-21 09:31:02.796969
52	32	Flex Tubes		\N	2025-08-21 10:55:34.969543	2025-08-21 10:55:34.969561
54	33	CHANDELIERS		\N	2025-08-21 17:53:36.987997	2025-08-22 07:33:14.253772
55	33	WALL BRACKETS		\N	2025-08-23 11:53:32.210039	2025-08-23 11:53:32.210056
56	34	GYPSUM BOARDS		\N	2025-08-23 12:42:24.87455	2025-08-23 12:42:24.874568
57	34	MDF BOARDS		\N	2025-08-23 12:43:37.530105	2025-08-23 12:43:37.530118
58	34	PARTICLE BOARDS		\N	2025-08-23 12:44:50.991102	2025-08-23 12:44:50.991126
59	34	MARINE BOARD		\N	2025-08-23 12:46:08.989653	2025-08-23 12:46:08.989669
60	34	PLYWOOD 		\N	2025-08-23 12:50:45.000749	2025-08-23 12:51:15.220864
61	35	LOCAL GRANITE		\N	2025-08-23 12:55:02.087849	2025-08-23 12:55:02.087877
62	35	IMPORTED GANITE		\N	2025-08-23 12:55:28.529208	2025-08-23 12:55:28.529239
41	28	Magic 1 1/2		\N	2025-08-08 13:35:47.761712	2025-08-23 13:20:59.190902
42	28	Magic 1 1/4		\N	2025-08-08 13:36:12.85529	2025-08-23 13:21:23.091914
44	29	1 1/4		\N	2025-08-08 13:39:04.487916	2025-08-23 13:22:08.572349
43	29	1 1/2		\N	2025-08-08 13:37:20.634987	2025-08-23 13:22:49.153631
63	1	Seat Cover		\N	2025-08-23 16:31:40.076288	2025-08-23 16:31:40.076318
64	1	Single Seat		\N	2025-08-23 16:32:38.37702	2025-08-23 16:32:38.377034
65	3	Cabinet Frame		\N	2025-08-23 17:30:39.700675	2025-08-23 17:30:39.70069
66	3	Cabinet Mirror		\N	2025-08-23 17:31:33.858519	2025-08-23 17:31:33.858541
67	2	Basin Bowls		\N	2025-08-23 18:20:16.765898	2025-08-23 18:20:16.765916
68	2	Pedestal		\N	2025-08-23 18:20:52.492561	2025-08-23 18:20:52.492596
69	7	ALL MIRRORS 		\N	2025-08-24 12:16:52.817752	2025-08-24 12:16:52.817768
70	6	ALL KITCHEN SINKS		\N	2025-08-24 12:29:11.888059	2025-08-24 12:29:11.888074
71	37	ALL SHOWER CUBICLES		\N	2025-08-24 12:50:22.681847	2025-08-24 12:50:22.681875
72	12	TOWEL RING		\N	2025-08-24 12:58:48.080027	2025-08-24 12:58:48.080046
73	12	HOOKS		\N	2025-08-24 13:07:03.66991	2025-08-24 13:07:03.669934
74	12	TOILET BRUSH		\N	2025-08-24 13:20:06.925871	2025-08-24 13:20:06.925893
75	12	TOOTHBRUSH HOLDERS 		\N	2025-08-24 13:31:10.284743	2025-08-24 13:31:10.284759
77	38	Bathtub Mixer		\N	2025-08-24 14:25:44.083641	2025-08-24 14:25:44.083659
78	39	MANHOLE COVERS		\N	2025-08-24 14:36:16.171181	2025-08-24 14:36:16.171199
76	40	CORNER SHELVES		\N	2025-08-24 14:11:09.995354	2025-08-24 14:41:43.437562
79	40	RECTANGULAR GLASS SHELVE		\N	2025-08-24 14:44:24.351547	2025-08-24 14:44:24.35157
80	12	SOAP DISPENSER		\N	2025-08-24 14:51:45.227369	2025-08-24 14:51:45.22741
81	22	FLOOR DRAINS		\N	2025-08-24 15:01:43.993179	2025-08-24 15:01:43.993279
82	12	GRAB BAR		\N	2025-08-24 15:10:51.072972	2025-08-24 15:11:40.847127
83	42	Silicone		\N	2025-08-24 15:16:35.179674	2025-08-24 15:16:35.179698
84	12	HAND DRYER		\N	2025-08-24 15:20:35.613541	2025-08-24 15:20:35.613555
85	6	KITCHEN SINK FIITINGS		\N	2025-08-24 15:25:27.802581	2025-08-24 15:25:27.802602
86	43	Under Sink Heaters 		\N	2025-08-24 15:26:04.517411	2025-08-24 15:26:04.517429
87	44	Screw		\N	2025-08-24 15:46:02.699379	2025-08-24 15:46:02.699399
88	45	Thread Tape		\N	2025-08-24 15:54:11.303687	2025-08-24 15:54:11.3037
89	10	Wall Knob		\N	2025-08-30 13:25:34.458791	2025-08-30 13:25:34.458806
90	11	Stop Cork		\N	2025-08-30 14:10:33.288825	2025-08-30 14:10:33.288843
91	27	Gate Valve		\N	2025-08-30 14:28:01.377291	2025-08-30 14:28:01.377317
92	46	Tile Cleaner		\N	2025-08-30 17:09:23.618824	2025-08-30 17:09:23.618846
93	47	Pop Up		\N	2025-08-30 17:22:50.24975	2025-08-30 17:22:50.249765
94	33	All Electricals		\N	2025-09-03 11:39:47.949397	2025-09-03 11:39:47.949423
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, contact_person, email, phone, address, tax_number, payment_terms, credit_limit, is_active, notes, created_at, updated_at) FROM stdin;
4	KK	ELIZA		0745665460			cash on delivery	\N	t		2025-08-28 14:59:55.367866	2025-08-28 14:59:55.367915
5	NEMSI	ANN		0799385786		P051623344B	net 30	500000.00	t		2025-09-14 12:00:37.154489	2025-09-15 15:19:14.596284
6	FRENCIA	PHILLIP		0717191950				\N	t		2025-09-15 15:55:05.275919	2025-09-15 15:55:05.275943
7	CENTAMILLY	STEVE		0718908762			cash on delivery	\N	t		2025-09-15 15:56:27.479945	2025-09-15 15:56:27.479969
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, firstname, lastname, password, role, created_at, phone, accessible_branch_ids) FROM stdin;
1	admin@abzhardware.co.ke	Admin	User	scrypt:32768:8:1$ufaX5mF8fqrOzrUW$9d7f32e4135df6af73254a45b20fd33d91a9d5a475e80ddb54b021156aeeae650b7132a08e3cc8ecc0e1d4ed9a35df1bce34db221bac5d1fbbabff1f91dc6804	admin	2025-08-07 13:35:53.691919	\N	[]
5	sales@abzhardware.co.ke	ABZ	HARDWARE	scrypt:32768:8:1$JsolhHf9Q88iYS6W$851cf693c940c660cd98470e17ea6058c1b9ea8772c5636e19fb1ea52584ea2827d15c7c30459f23421fca6edd56d1a20167dd4bf6701ef33a7856f1c54e6582	sales	2025-08-14 15:59:28.114789	\N	[]
7	mwemwacollinslumadede@gmail.com	Collins	Memwa	scrypt:32768:8:1$1v4m3ND5fzpZy3RO$93b68157eb4416a42e85d9cf305d55fef81ee30fa44cdbed182c656fddfb11bef2bc33a5d81c149d68b48ad475eb6529a42fcdf6ac1997b0efaf80a7d858b599	sales	2025-08-15 12:05:38.983403	\N	[]
8	cashier@abzhardware.co.ke	ABZ	Hardware	scrypt:32768:8:1$ZpUK5XKmyNs0Gebr$b163fbe82b5110877d66380aea198a98e99fc5b24e4ca2b96a29de6f35adc1112fa3460ac8b8ef8afbdd6db6237df1e84ab6e6abd2675e69f7852b27b164e944	cashier	2025-08-15 15:19:09.8386	\N	[]
10	abdiwasamohammed@gmail.com	ABDIWASA	MOHAMED	scrypt:32768:8:1$gUK5M6Kr3KzOGLcF$cd83a20ef62f8d624f69d2f4d41175896edcb9ced7da24b1cd10fe57208443a47c9cdb48dce20c1c136c17107abbe21dd079be8380fa58c6de01e149a20fa3e6	admin	2025-08-20 10:53:15.941223	\N	[]
12	abzhardwareamazing@gmail.com	HAFSA	SALES	scrypt:32768:8:1$DefjlQH3EXN4AY7s$1121cb49b95d45f2a0452d5e18831df3d9ba28ba8c1f83460d7930703b4403496f4cbcdeae7d5a2674e40ce98e9dd2a271a7893417c9315c6caf7b0957a6e64e	sales	2025-08-26 06:53:40.930294	\N	[]
13	abdiwasamohamed84@gmail.com	Abdiwasa	Mohamed	scrypt:32768:8:1$pocqpXQqqp7ZtHtL$ada3234721d564a2990e0fd0737bde6d14ebbf52b0c93d1d0cef09066cd83303ba8dc2e2c6f399f05c2fceda0e349883ec926e5fbdb546578a57a8f12c1f3713	cashier	2025-08-26 13:43:56.34984	\N	[]
14	ibrahimkhaliil3790@gmail.com	IBRAHIM	ABDI ALI	scrypt:32768:8:1$FgsgBSwJca0417jP$52da661537a3dd68a8aa73d1769c91e5fb46dfab412c76c0db00f45f3fe774d8d8a92834b07625b90ebfa49517c3c5580b76b664631e3922328a1a717b7c650c	sales	2025-08-28 09:00:51.284605	\N	[]
15	abdiwasamohammed84@gmail.com	ABDIWASA 	MOHAMED SALES	scrypt:32768:8:1$ie2baeyiUZi5yggr$34a335eab4a913a79097933a43c234d63c23510ea4fcf0b59927fa9ff379b0e81c65f3cf7c6d550f9c11082fbd23a880b6e88dd796319aefcb279d6a90a2ca03	sales	2025-08-30 12:25:50.136191	\N	[]
16	abdullahiabdi358@gmail.com	ABDULLAHI	SALES	scrypt:32768:8:1$rNlNAoARPTphjR4g$2bbd1c2ec8a5ac9acbfa5fdef13faaaf65dc62ae45f0c09744b0e736b6344b56f4d7356acb80653f6421f9b529918c1e04a6a682c6af673c16385a717a99a05d	sales	2025-09-03 14:57:22.5261	\N	[]
18	khalidabdi722@gmail.com	KHALID	SALES	scrypt:32768:8:1$jFyF0IqX5KJS9BKI$917c10174dda4dd75df5780548cb6a2811ed434792ad18e022026ab0867d322d5e8b3eb4a13e6f33a292f5e3fc6e3936afc6efe4f2ee3075efa054abf2cf8166	sales	2025-09-04 11:24:02.626949	\N	[]
9	hafsaragow0725@gmail.com	HAFSA	RAGOW	scrypt:32768:8:1$o8hZilmrBN65slFW$6751bb930a40df924db853012111ce4e38cb998bbd2fc7f37cb6a53525b192a71bb9aaac0462f0f31b623fa4a4894734e31f5e591c04a037a48910ee1bdc9221	cashier	2025-08-20 10:05:45.717471	\N	[1]
6	cathnduku743@gmail.com	Catherine	Raymond	scrypt:32768:8:1$Bq7Oc4LwcGG1kaf3$a99272718427ea70d0601056d745a7339222acc1715079c1984fabeab4494fa02aac6aa742d7b3a7c6934a0acec415e0b5f7ed428c888c3b40822a72d437b218	sales	2025-08-15 12:05:01.609477	\N	[]
17	abdullahi358@gmail.com	ABDULLAHI	CASHIER	scrypt:32768:8:1$frA1MyJaZrewDSc8$6b7ecb78a1947e842ac4a3f83a2ae3464acec4ba5288fa4ef03130a85ed1c15bae4debd6e60aa676271b3b7e10cf786356cf84d4a81fd0c6cc75562c5ab3fbb1	cashier	2025-09-03 15:19:15.153189	\N	[3]
\.


--
-- Name: branch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.branch_id_seq', 3, true);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 48, true);


--
-- Name: deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliveries_id_seq', 1, false);


--
-- Name: delivery_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.delivery_payments_id_seq', 1, false);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_id_seq', 10, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_id_seq', 122, true);


--
-- Name: orderitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderitems_id_seq', 864, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 128, true);


--
-- Name: ordertypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordertypes_id_seq', 1, true);


--
-- Name: password_resets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_resets_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 93, true);


--
-- Name: product_descriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_descriptions_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 692, true);


--
-- Name: purchase_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_order_items_id_seq', 80, true);


--
-- Name: purchase_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_orders_id_seq', 10, true);


--
-- Name: quotationitems_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quotationitems_id_seq', 328, true);


--
-- Name: quotations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quotations_id_seq', 20, true);


--
-- Name: receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.receipts_id_seq', 1, false);


--
-- Name: stock_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_transactions_id_seq', 141, true);


--
-- Name: sub_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sub_category_id_seq', 94, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 18, true);


--
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: delivery_payments delivery_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_payments
    ADD CONSTRAINT delivery_payments_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_invoice_number_key UNIQUE (invoice_number);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: orderitems orderitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: ordertypes ordertypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertypes
    ADD CONSTRAINT ordertypes_pkey PRIMARY KEY (id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: password_resets password_resets_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_token_key UNIQUE (token);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_descriptions product_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_descriptions
    ADD CONSTRAINT product_descriptions_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: purchase_order_items purchase_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- Name: purchase_orders purchase_orders_po_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_number_key UNIQUE (po_number);


--
-- Name: quotationitems quotationitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotationitems
    ADD CONSTRAINT quotationitems_pkey PRIMARY KEY (id);


--
-- Name: quotations quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);


--
-- Name: quotations quotations_quotation_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_quotation_number_key UNIQUE (quotation_number);


--
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: receipts receipts_receipt_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_receipt_number_key UNIQUE (receipt_number);


--
-- Name: stock_transactions stock_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_transactions
    ADD CONSTRAINT stock_transactions_pkey PRIMARY KEY (id);


--
-- Name: sub_category sub_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_category
    ADD CONSTRAINT sub_category_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveries
    ADD CONSTRAINT deliveries_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: delivery_payments delivery_payments_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_payments
    ADD CONSTRAINT delivery_payments_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.deliveries(id);


--
-- Name: delivery_payments delivery_payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_payments
    ADD CONSTRAINT delivery_payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: expenses expenses_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(id);


--
-- Name: expenses expenses_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(id);


--
-- Name: expenses expenses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: invoices invoices_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(id);


--
-- Name: orderitems orderitems_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(id);


--
-- Name: orderitems orderitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: orders orders_branchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_branchid_fkey FOREIGN KEY (branchid) REFERENCES public.branch(id);


--
-- Name: orders orders_ordertypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ordertypeid_fkey FOREIGN KEY (ordertypeid) REFERENCES public.ordertypes(id);


--
-- Name: orders orders_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: password_resets password_resets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments payments_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(id);


--
-- Name: payments payments_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: product_descriptions product_descriptions_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_descriptions
    ADD CONSTRAINT product_descriptions_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products products_branchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_branchid_fkey FOREIGN KEY (branchid) REFERENCES public.branch(id);


--
-- Name: products products_subcategory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_subcategory_id_fkey FOREIGN KEY (subcategory_id) REFERENCES public.sub_category(id);


--
-- Name: purchase_order_items purchase_order_items_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- Name: purchase_orders purchase_orders_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(id);


--
-- Name: purchase_orders purchase_orders_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(id);


--
-- Name: purchase_orders purchase_orders_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- Name: purchase_orders purchase_orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: quotationitems quotationitems_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotationitems
    ADD CONSTRAINT quotationitems_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: quotationitems quotationitems_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotationitems
    ADD CONSTRAINT quotationitems_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id);


--
-- Name: quotations quotations_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(id);


--
-- Name: quotations quotations_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: receipts receipts_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(id);


--
-- Name: receipts receipts_paymentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_paymentid_fkey FOREIGN KEY (paymentid) REFERENCES public.payments(id);


--
-- Name: stock_transactions stock_transactions_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_transactions
    ADD CONSTRAINT stock_transactions_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(id);


--
-- Name: stock_transactions stock_transactions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_transactions
    ADD CONSTRAINT stock_transactions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- Name: sub_category sub_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_category
    ADD CONSTRAINT sub_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 4eYo9ddcBe224hlF31zfrbcLAe6dEU07pggva7g9WCByB3D4Nk5Ffp75feDEFdG

