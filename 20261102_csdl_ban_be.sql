--
-- PostgreSQL database dump
--

\restrict 9J8iuap9j4WeswHbvZbS3iRRqaPZmaGhxAwXa7wz9Z9sgXvUnRI1w1ztHxYmCB0

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: ban_be; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ban_be (
    ma_ban_be bigint NOT NULL,
    ho_ten character varying(100) NOT NULL,
    email character varying(150),
    cong_ty character varying(100),
    ghi_chu text
);


ALTER TABLE public.ban_be OWNER TO postgres;

--
-- Name: ban_be_ma_ban_be_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ban_be ALTER COLUMN ma_ban_be ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ban_be_ma_ban_be_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ban_be_nhom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ban_be_nhom (
    ma_ban_be bigint NOT NULL,
    ma_nhom integer NOT NULL
);


ALTER TABLE public.ban_be_nhom OWNER TO postgres;

--
-- Name: nhom_quan_he; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nhom_quan_he (
    ma_nhom integer NOT NULL,
    ten_nhom character varying(50) NOT NULL,
    mo_ta character varying(255)
);


ALTER TABLE public.nhom_quan_he OWNER TO postgres;

--
-- Name: nhom_quan_he_ma_nhom_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.nhom_quan_he ALTER COLUMN ma_nhom ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.nhom_quan_he_ma_nhom_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: so_dien_thoai; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.so_dien_thoai (
    ma_so_dien_thoai bigint NOT NULL,
    ma_ban_be bigint NOT NULL,
    so_dien_thoai character varying(20) NOT NULL,
    loai_sdt character varying(50) DEFAULT 'Di động'::character varying
);


ALTER TABLE public.so_dien_thoai OWNER TO postgres;

--
-- Name: so_dien_thoai_ma_so_dien_thoai_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.so_dien_thoai ALTER COLUMN ma_so_dien_thoai ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.so_dien_thoai_ma_so_dien_thoai_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: ban_be; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ban_be (ma_ban_be, ho_ten, email, cong_ty, ghi_chu) FROM stdin;
2	Nguyễn Bá Công	cong.nguyen@vti.com.vn	VTI	Lập trình viên
\.


--
-- Data for Name: ban_be_nhom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ban_be_nhom (ma_ban_be, ma_nhom) FROM stdin;
2	2
\.


--
-- Data for Name: nhom_quan_he; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nhom_quan_he (ma_nhom, ten_nhom, mo_ta) FROM stdin;
1	Bạn học	Nhóm bạn học phổ thông, đại học
2	Đồng nghiệp	Nhóm đồng nghiệp làm cùng công ty
\.


--
-- Data for Name: so_dien_thoai; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.so_dien_thoai (ma_so_dien_thoai, ma_ban_be, so_dien_thoai, loai_sdt) FROM stdin;
2	2	0382905999	Di động
\.


--
-- Name: ban_be_ma_ban_be_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ban_be_ma_ban_be_seq', 2, true);


--
-- Name: nhom_quan_he_ma_nhom_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nhom_quan_he_ma_nhom_seq', 3, true);


--
-- Name: so_dien_thoai_ma_so_dien_thoai_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.so_dien_thoai_ma_so_dien_thoai_seq', 2, true);


--
-- Name: nhom_quan_he nhom_quan_he_ten_nhom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhom_quan_he
    ADD CONSTRAINT nhom_quan_he_ten_nhom_key UNIQUE (ten_nhom);


--
-- Name: ban_be pk_ban_be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_be
    ADD CONSTRAINT pk_ban_be PRIMARY KEY (ma_ban_be);


--
-- Name: ban_be_nhom pk_ban_be_nhom; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_be_nhom
    ADD CONSTRAINT pk_ban_be_nhom PRIMARY KEY (ma_ban_be, ma_nhom);


--
-- Name: nhom_quan_he pk_nhom_quan_he; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhom_quan_he
    ADD CONSTRAINT pk_nhom_quan_he PRIMARY KEY (ma_nhom);


--
-- Name: so_dien_thoai pk_so_dien_thoai; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.so_dien_thoai
    ADD CONSTRAINT pk_so_dien_thoai PRIMARY KEY (ma_so_dien_thoai);


--
-- Name: ban_be_nhom fk_bbn_banbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_be_nhom
    ADD CONSTRAINT fk_bbn_banbe FOREIGN KEY (ma_ban_be) REFERENCES public.ban_be(ma_ban_be) ON DELETE CASCADE;


--
-- Name: ban_be_nhom fk_bbn_nhom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_be_nhom
    ADD CONSTRAINT fk_bbn_nhom FOREIGN KEY (ma_nhom) REFERENCES public.nhom_quan_he(ma_nhom) ON DELETE CASCADE;


--
-- Name: so_dien_thoai fk_sdt_banbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.so_dien_thoai
    ADD CONSTRAINT fk_sdt_banbe FOREIGN KEY (ma_ban_be) REFERENCES public.ban_be(ma_ban_be) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 9J8iuap9j4WeswHbvZbS3iRRqaPZmaGhxAwXa7wz9Z9sgXvUnRI1w1ztHxYmCB0

