--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2023-10-03 15:44:07

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
-- TOC entry 3365 (class 1262 OID 16398)
-- Name: dbShopEmployee; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "dbShopEmployee" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "dbShopEmployee" OWNER TO postgres;

\connect "dbShopEmployee"

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
-- TOC entry 3366 (class 0 OID 0)
-- Name: dbShopEmployee; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE "dbShopEmployee" CONNECTION LIMIT = 1;


\connect "dbShopEmployee"

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
-- TOC entry 215 (class 1259 OID 16406)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    "categoryName" character varying(20) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16405)
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16430)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    "employeeName" character varying(50) NOT NULL,
    "employeeSurname" character varying(50) NOT NULL,
    "employeePatronymic" character varying(50) NOT NULL,
    gender_id integer NOT NULL,
    "employeeAge" integer NOT NULL,
    "jobTitle_id" integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16424)
-- Name: gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gender (
    gender_id integer NOT NULL,
    "genderName" character varying(10) NOT NULL
);


ALTER TABLE public.gender OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: jobTitle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."jobTitle" (
    "jobTitle_id" integer NOT NULL,
    "jobTitleName" character varying(50) NOT NULL,
    category_id integer DEFAULT 1
);


ALTER TABLE public."jobTitle" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24823)
-- Name: employeeView; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."employeeView" AS
 SELECT row_number() OVER () AS id,
    employee."employeeSurname" AS "Фамилия",
    employee."employeeName" AS "Имя",
    employee."employeePatronymic" AS "Отчество",
    gender."genderName" AS "Пол",
    employee."employeeAge" AS "Возраст",
    "jobTitle"."jobTitleName" AS "Должность",
    category."categoryName" AS "Категория"
   FROM (((public.employee
     JOIN public.gender ON ((gender.gender_id = employee.gender_id)))
     JOIN public."jobTitle" ON (("jobTitle"."jobTitle_id" = employee."jobTitle_id")))
     JOIN public.category ON ((category.category_id = "jobTitle".category_id)));


ALTER TABLE public."employeeView" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16429)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.employee ALTER COLUMN employee_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.employee_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16423)
-- Name: gender_gender_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.gender ALTER COLUMN gender_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.gender_gender_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16458)
-- Name: jobTitleView; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."jobTitleView" AS
 SELECT "jobTitle"."jobTitleName" AS "Должность",
    category."categoryName" AS "Категория"
   FROM (public."jobTitle"
     JOIN public.category ON (("jobTitle".category_id = category.category_id)));


ALTER TABLE public."jobTitleView" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16411)
-- Name: jobTitle_jobTitle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."jobTitle" ALTER COLUMN "jobTitle_id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."jobTitle_jobTitle_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3353 (class 0 OID 16406)
-- Dependencies: 215
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.category (category_id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (1, 'Рабочий');
INSERT INTO public.category (category_id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (2, 'Служащий');
INSERT INTO public.category (category_id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (3, 'Специалист');


--
-- TOC entry 3359 (class 0 OID 16430)
-- Dependencies: 221
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (1, 'Иван', 'Тихомиров', 'Алексеевич', 1, 45, 3);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (2, 'Василий', 'Ширковв', 'Данилович', 1, 24, 2);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (3, 'Алиса', 'Кириллова', 'Михайловна', 2, 37, 1);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (5, 'Елизавета', 'Киреева', 'Матвеевна', 2, 27, 2);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (7, 'Виктор', 'Шишкин', 'Андреевич', 1, 42, 3);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (12, 'Анна', 'Черкасова', 'Евгеньевна', 2, 26, 2);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (13, 'Максим', 'Серов', 'Александрович', 1, 37, 2);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (14, 'Владимир', 'Максимов', 'Егорович', 1, 24, 1);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (4, 'Сергей', 'Новиков', 'Романович', 1, 42, 2);
INSERT INTO public.employee (employee_id, "employeeName", "employeeSurname", "employeePatronymic", gender_id, "employeeAge", "jobTitle_id") OVERRIDING SYSTEM VALUE VALUES (15, 'Даниил', 'Овчинников', 'Артёмович', 1, 22, 4);


--
-- TOC entry 3357 (class 0 OID 16424)
-- Dependencies: 219
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gender (gender_id, "genderName") OVERRIDING SYSTEM VALUE VALUES (1, 'Мужской');
INSERT INTO public.gender (gender_id, "genderName") OVERRIDING SYSTEM VALUE VALUES (2, 'Женский');


--
-- TOC entry 3355 (class 0 OID 16412)
-- Dependencies: 217
-- Data for Name: jobTitle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."jobTitle" ("jobTitle_id", "jobTitleName", category_id) OVERRIDING SYSTEM VALUE VALUES (1, 'Анилитик', 3);
INSERT INTO public."jobTitle" ("jobTitle_id", "jobTitleName", category_id) OVERRIDING SYSTEM VALUE VALUES (2, 'Продавец', 1);
INSERT INTO public."jobTitle" ("jobTitle_id", "jobTitleName", category_id) OVERRIDING SYSTEM VALUE VALUES (3, 'Водитель', 2);
INSERT INTO public."jobTitle" ("jobTitle_id", "jobTitleName", category_id) OVERRIDING SYSTEM VALUE VALUES (4, 'Администратор', 3);
INSERT INTO public."jobTitle" ("jobTitle_id", "jobTitleName", category_id) OVERRIDING SYSTEM VALUE VALUES (16, 'test', 2);


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 214
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 3, true);


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 220
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_employee_id_seq', 15, true);


--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 218
-- Name: gender_gender_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gender_gender_id_seq', 2, true);


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 216
-- Name: jobTitle_jobTitle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."jobTitle_jobTitle_id_seq"', 21, true);


--
-- TOC entry 3198 (class 2606 OID 16410)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- TOC entry 3204 (class 2606 OID 16434)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3202 (class 2606 OID 16428)
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (gender_id);


--
-- TOC entry 3200 (class 2606 OID 16417)
-- Name: jobTitle jobTitle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."jobTitle"
    ADD CONSTRAINT "jobTitle_pkey" PRIMARY KEY ("jobTitle_id");


--
-- TOC entry 3206 (class 2606 OID 16435)
-- Name: employee fk_employee_gender; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT fk_employee_gender FOREIGN KEY (gender_id) REFERENCES public.gender(gender_id);


--
-- TOC entry 3207 (class 2606 OID 16440)
-- Name: employee fk_employee_jobTitle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "fk_employee_jobTitle" FOREIGN KEY ("jobTitle_id") REFERENCES public."jobTitle"("jobTitle_id");


--
-- TOC entry 3205 (class 2606 OID 16418)
-- Name: jobTitle fk_jobTitle_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."jobTitle"
    ADD CONSTRAINT "fk_jobTitle_category" FOREIGN KEY (category_id) REFERENCES public.category(category_id);


-- Completed on 2023-10-03 15:44:07

--
-- PostgreSQL database dump complete
--

