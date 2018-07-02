--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.9
-- Dumped by pg_dump version 9.6.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: budgetbro_dev
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO budgetbro_dev;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: budgetbro_dev
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    p_amount money DEFAULT '$0.00'::money NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO budgetbro_dev;

--
-- Name: COLUMN categories.name; Type: COMMENT; Schema: public; Owner: budgetbro_dev
--

COMMENT ON COLUMN public.categories.name IS 'category name';


--
-- Name: COLUMN categories.p_amount; Type: COMMENT; Schema: public; Owner: budgetbro_dev
--

COMMENT ON COLUMN public.categories.p_amount IS 'planned amount for specific category';


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: budgetbro_dev
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO budgetbro_dev;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: budgetbro_dev
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: expense_categories; Type: TABLE; Schema: public; Owner: budgetbro_dev
--

CREATE TABLE public.expense_categories (
    id integer NOT NULL,
    categories_id integer NOT NULL,
    expenses_id integer NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.expense_categories OWNER TO budgetbro_dev;

--
-- Name: expense_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: budgetbro_dev
--

CREATE SEQUENCE public.expense_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expense_categories_id_seq OWNER TO budgetbro_dev;

--
-- Name: expense_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: budgetbro_dev
--

ALTER SEQUENCE public.expense_categories_id_seq OWNED BY public.expense_categories.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: budgetbro_dev
--

CREATE TABLE public.expenses (
    id integer NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    amount money DEFAULT '$0.00'::money NOT NULL,
    date timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.expenses OWNER TO budgetbro_dev;

--
-- Name: COLUMN expenses.description; Type: COMMENT; Schema: public; Owner: budgetbro_dev
--

COMMENT ON COLUMN public.expenses.description IS 'description of expenses';


--
-- Name: COLUMN expenses.amount; Type: COMMENT; Schema: public; Owner: budgetbro_dev
--

COMMENT ON COLUMN public.expenses.amount IS 'amount of the expense';


--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: budgetbro_dev
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expenses_id_seq OWNER TO budgetbro_dev;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: budgetbro_dev
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: budgetbro_dev
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text,
    email public.citext,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO budgetbro_dev;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: budgetbro_dev
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO budgetbro_dev;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: budgetbro_dev
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: expense_categories id; Type: DEFAULT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expense_categories ALTER COLUMN id SET DEFAULT nextval('public.expense_categories_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: expense_categories expense_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: categories set_timestamp; Type: TRIGGER; Schema: public; Owner: budgetbro_dev
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: expenses set_timestamp; Type: TRIGGER; Schema: public; Owner: budgetbro_dev
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.expenses FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: users set_timestamp; Type: TRIGGER; Schema: public; Owner: budgetbro_dev
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: expense_categories set_timestamp; Type: TRIGGER; Schema: public; Owner: budgetbro_dev
--

CREATE TRIGGER set_timestamp BEFORE UPDATE ON public.expense_categories FOR EACH ROW EXECUTE PROCEDURE public.trigger_set_timestamp();


--
-- Name: categories categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: expense_categories expense_categories_categories_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_categories_id_fkey FOREIGN KEY (categories_id) REFERENCES public.categories(id);


--
-- Name: expense_categories expense_categories_expenses_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expense_categories
    ADD CONSTRAINT expense_categories_expenses_id_fkey FOREIGN KEY (expenses_id) REFERENCES public.expenses(id);


--
-- Name: expenses expenses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: budgetbro_dev
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

