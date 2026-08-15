--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: colaboradores; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.colaboradores (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    celular character varying(20),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.colaboradores OWNER TO braulio20260715;

--
-- Name: TABLE colaboradores; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.colaboradores IS 'Almacena los colaboradores de la comunidad';


--
-- Name: colaboradores_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.colaboradores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.colaboradores_id_seq OWNER TO braulio20260715;

--
-- Name: colaboradores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.colaboradores_id_seq OWNED BY public.colaboradores.id;


--
-- Name: conceptos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.conceptos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(20) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT conceptos_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['ingreso'::character varying, 'egreso'::character varying])::text[])))
);


ALTER TABLE public.conceptos OWNER TO braulio20260715;

--
-- Name: conceptos_egresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.conceptos_egresos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conceptos_egresos OWNER TO braulio20260715;

--
-- Name: conceptos_egresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.conceptos_egresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conceptos_egresos_id_seq OWNER TO braulio20260715;

--
-- Name: conceptos_egresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.conceptos_egresos_id_seq OWNED BY public.conceptos_egresos.id;


--
-- Name: conceptos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.conceptos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conceptos_id_seq OWNER TO braulio20260715;

--
-- Name: conceptos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.conceptos_id_seq OWNED BY public.conceptos.id;


--
-- Name: conceptos_ingresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.conceptos_ingresos (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conceptos_ingresos OWNER TO braulio20260715;

--
-- Name: conceptos_ingresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.conceptos_ingresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conceptos_ingresos_id_seq OWNER TO braulio20260715;

--
-- Name: conceptos_ingresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.conceptos_ingresos_id_seq OWNED BY public.conceptos_ingresos.id;


--
-- Name: configuracion; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.configuracion (
    id integer NOT NULL,
    clave character varying(50) NOT NULL,
    valor text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.configuracion OWNER TO braulio20260715;

--
-- Name: TABLE configuracion; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.configuracion IS 'Configuración general del sistema';


--
-- Name: configuracion_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.configuracion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.configuracion_id_seq OWNER TO braulio20260715;

--
-- Name: configuracion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.configuracion_id_seq OWNED BY public.configuracion.id;


--
-- Name: detalle_egresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.detalle_egresos (
    id integer NOT NULL,
    egreso_id integer,
    concepto character varying(100) NOT NULL,
    valor numeric(10,2) NOT NULL,
    descripcion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_egresos OWNER TO braulio20260715;

--
-- Name: TABLE detalle_egresos; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.detalle_egresos IS 'Detalle de egresos (desglose de gastos)';


--
-- Name: detalle_egresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.detalle_egresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_egresos_id_seq OWNER TO braulio20260715;

--
-- Name: detalle_egresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.detalle_egresos_id_seq OWNED BY public.detalle_egresos.id;


--
-- Name: detalle_ingresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.detalle_ingresos (
    id integer NOT NULL,
    ingreso_id integer,
    nombre character varying(100) NOT NULL,
    valor numeric(10,2) NOT NULL,
    descripcion text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_ingresos OWNER TO braulio20260715;

--
-- Name: TABLE detalle_ingresos; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.detalle_ingresos IS 'Detalle de ingresos (personas que colaboraron)';


--
-- Name: detalle_ingresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.detalle_ingresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_ingresos_id_seq OWNER TO braulio20260715;

--
-- Name: detalle_ingresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.detalle_ingresos_id_seq OWNED BY public.detalle_ingresos.id;


--
-- Name: egresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.egresos (
    id integer NOT NULL,
    evento_id integer,
    colaborador_id integer,
    valor numeric(10,2) NOT NULL,
    concepto character varying(100) NOT NULL,
    detalle text,
    fecha_pago timestamp without time zone,
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    comprobante_pdf text,
    comprobante_imagen text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT egresos_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'pagado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.egresos OWNER TO braulio20260715;

--
-- Name: TABLE egresos; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.egresos IS 'Almacena los egresos (gastos) de los eventos';


--
-- Name: egresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.egresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.egresos_id_seq OWNER TO braulio20260715;

--
-- Name: egresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.egresos_id_seq OWNED BY public.egresos.id;


--
-- Name: eventos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.eventos (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion text,
    fecha_evento date NOT NULL,
    fecha_fin_evento date,
    fecha_limite_colaboracion date,
    activo boolean DEFAULT true,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.eventos OWNER TO braulio20260715;

--
-- Name: TABLE eventos; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.eventos IS 'Almacena los eventos de la comunidad';


--
-- Name: eventos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.eventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eventos_id_seq OWNER TO braulio20260715;

--
-- Name: eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.eventos_id_seq OWNED BY public.eventos.id;


--
-- Name: ingresos; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.ingresos (
    id integer NOT NULL,
    evento_id integer,
    colaborador_id integer,
    valor numeric(10,2) NOT NULL,
    concepto character varying(100) DEFAULT 'Colaboración'::character varying,
    fecha_limite date,
    fecha_pago timestamp without time zone,
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    comprobante_pdf text,
    comprobante_imagen text,
    observacion text,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ingresos_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'pagado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.ingresos OWNER TO braulio20260715;

--
-- Name: TABLE ingresos; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.ingresos IS 'Almacena los ingresos (colaboraciones) de los eventos';


--
-- Name: ingresos_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.ingresos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingresos_id_seq OWNER TO braulio20260715;

--
-- Name: ingresos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.ingresos_id_seq OWNED BY public.ingresos.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    usuario_id integer,
    accion character varying(100) NOT NULL,
    tabla character varying(50),
    registro_id integer,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    ip character varying(50),
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO braulio20260715;

--
-- Name: TABLE logs; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.logs IS 'Registro de auditoría de todas las acciones del sistema';


--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO braulio20260715;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: notificaciones; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.notificaciones (
    id integer NOT NULL,
    evento_id integer,
    tipo character varying(20) NOT NULL,
    fecha_envio timestamp without time zone,
    enviado boolean DEFAULT false,
    mensaje text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notificaciones_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['recordatorio'::character varying, 'resumen'::character varying])::text[])))
);


ALTER TABLE public.notificaciones OWNER TO braulio20260715;

--
-- Name: TABLE notificaciones; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.notificaciones IS 'Almacena las notificaciones programadas para enviar por Telegram';


--
-- Name: notificaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.notificaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notificaciones_id_seq OWNER TO braulio20260715;

--
-- Name: notificaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.notificaciones_id_seq OWNED BY public.notificaciones.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: braulio20260715
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    celular character varying(20),
    direccion text,
    telegram character varying(50),
    correo character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'visitante'::character varying NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['administrador'::character varying, 'pastoral'::character varying, 'visitante'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO braulio20260715;

--
-- Name: TABLE usuarios; Type: COMMENT; Schema: public; Owner: braulio20260715
--

COMMENT ON TABLE public.usuarios IS 'Almacena los usuarios del sistema con sus roles y credenciales';


--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: braulio20260715
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO braulio20260715;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: braulio20260715
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: v_resumen_eventos; Type: VIEW; Schema: public; Owner: braulio20260715
--

CREATE VIEW public.v_resumen_eventos AS
 SELECT id,
    nombre,
    descripcion,
    fecha_evento,
    fecha_fin_evento,
    fecha_limite_colaboracion,
    activo,
    COALESCE(( SELECT sum(i.valor) AS sum
           FROM public.ingresos i
          WHERE ((i.evento_id = e.id) AND ((i.estado)::text = 'pagado'::text))), (0)::numeric) AS total_ingresos,
    COALESCE(( SELECT sum(eg.valor) AS sum
           FROM public.egresos eg
          WHERE ((eg.evento_id = e.id) AND ((eg.estado)::text = 'pagado'::text))), (0)::numeric) AS total_egresos,
    COALESCE(( SELECT count(*) AS count
           FROM public.ingresos i
          WHERE ((i.evento_id = e.id) AND ((i.estado)::text = 'pendiente'::text))), (0)::bigint) AS ingresos_pendientes,
    COALESCE(( SELECT count(*) AS count
           FROM public.egresos eg
          WHERE ((eg.evento_id = e.id) AND ((eg.estado)::text = 'pendiente'::text))), (0)::bigint) AS egresos_pendientes,
    ( SELECT (((u.nombre)::text || ' '::text) || (u.apellido)::text)
           FROM public.usuarios u
          WHERE (u.id = e.created_by)) AS creado_por,
    created_at
   FROM public.eventos e
  WHERE (activo = true);


ALTER VIEW public.v_resumen_eventos OWNER TO braulio20260715;

--
-- Name: colaboradores id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.colaboradores ALTER COLUMN id SET DEFAULT nextval('public.colaboradores_id_seq'::regclass);


--
-- Name: conceptos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos ALTER COLUMN id SET DEFAULT nextval('public.conceptos_id_seq'::regclass);


--
-- Name: conceptos_egresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_egresos ALTER COLUMN id SET DEFAULT nextval('public.conceptos_egresos_id_seq'::regclass);


--
-- Name: conceptos_ingresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_ingresos ALTER COLUMN id SET DEFAULT nextval('public.conceptos_ingresos_id_seq'::regclass);


--
-- Name: configuracion id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.configuracion ALTER COLUMN id SET DEFAULT nextval('public.configuracion_id_seq'::regclass);


--
-- Name: detalle_egresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_egresos ALTER COLUMN id SET DEFAULT nextval('public.detalle_egresos_id_seq'::regclass);


--
-- Name: detalle_ingresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_ingresos ALTER COLUMN id SET DEFAULT nextval('public.detalle_ingresos_id_seq'::regclass);


--
-- Name: egresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.egresos ALTER COLUMN id SET DEFAULT nextval('public.egresos_id_seq'::regclass);


--
-- Name: eventos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.eventos ALTER COLUMN id SET DEFAULT nextval('public.eventos_id_seq'::regclass);


--
-- Name: ingresos id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.ingresos ALTER COLUMN id SET DEFAULT nextval('public.ingresos_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: notificaciones id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.notificaciones ALTER COLUMN id SET DEFAULT nextval('public.notificaciones_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: colaboradores; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.colaboradores (id, nombre, apellido, celular, activo, created_at, updated_at) FROM stdin;
6	Jorge	Chasi	0991188074	t	2026-07-21 22:04:26.074845	2026-07-21 22:04:26.074845
2	María	González	0992345678	f	2026-07-20 19:53:07.023203	2026-07-21 22:04:33.197843
4	Ana	Martínez	0994567890	f	2026-07-20 19:53:07.023203	2026-07-21 22:04:36.88287
1	Juan	Pérez	0991234567	f	2026-07-20 19:53:07.023203	2026-07-21 22:04:40.161152
3	Carlos	Rodríguez	0993456789	f	2026-07-20 19:53:07.023203	2026-07-21 22:04:44.15481
5	Luis	Sánchez	0995678901	f	2026-07-20 19:53:07.023203	2026-07-21 22:04:47.63681
7	Rubén	Arpi	\N	t	2026-07-21 22:15:56.529848	2026-07-21 22:15:56.529848
8	Braulio	Arpi	0959193489	f	2026-07-22 22:15:28.982768	2026-07-22 22:15:33.553043
9	Boris	Criollo	\N	t	2026-07-26 20:17:54.029516	2026-07-26 20:17:54.029516
10	Liliana	Chasi	\N	t	2026-08-02 18:08:31.787098	2026-08-02 18:08:31.787098
11	Rigoberto	Merchan	\N	t	2026-08-02 18:18:58.09135	2026-08-02 18:18:58.09135
\.


--
-- Data for Name: conceptos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.conceptos (id, nombre, tipo, descripcion, activo, created_at, updated_at) FROM stdin;
1	Colaboración	ingreso	\N	t	2026-07-22 22:05:47.044828	2026-07-22 22:05:47.044828
2	Limosna	ingreso	\N	t	2026-07-22 22:05:47.046224	2026-07-22 22:05:47.046224
3	Donación	ingreso	\N	t	2026-07-22 22:05:47.046892	2026-07-22 22:05:47.046892
4	Aporte Voluntario	ingreso	\N	t	2026-07-22 22:05:47.047529	2026-07-22 22:05:47.047529
5	Diezmo	ingreso	\N	t	2026-07-22 22:05:47.048106	2026-07-22 22:05:47.048106
6	Rifa	ingreso	\N	t	2026-07-22 22:05:47.048671	2026-07-22 22:05:47.048671
7	Bingo	ingreso	\N	t	2026-07-22 22:05:47.049722	2026-07-22 22:05:47.049722
8	Comida	ingreso	\N	t	2026-07-22 22:05:47.051221	2026-07-22 22:05:47.051221
9	Otro	ingreso	\N	t	2026-07-22 22:05:47.052368	2026-07-22 22:05:47.052368
10	Comida	egreso	\N	t	2026-07-22 22:05:47.05309	2026-07-22 22:05:47.05309
11	Refrigerio	egreso	\N	t	2026-07-22 22:05:47.053919	2026-07-22 22:05:47.053919
12	Materiales	egreso	\N	t	2026-07-22 22:05:47.054402	2026-07-22 22:05:47.054402
13	Decoración	egreso	\N	t	2026-07-22 22:05:47.054888	2026-07-22 22:05:47.054888
14	Sonido	egreso	\N	t	2026-07-22 22:05:47.055358	2026-07-22 22:05:47.055358
15	Transporte	egreso	\N	t	2026-07-22 22:05:47.055839	2026-07-22 22:05:47.055839
16	Publicidad	egreso	\N	t	2026-07-22 22:05:47.05642	2026-07-22 22:05:47.05642
17	Servicios	egreso	\N	t	2026-07-22 22:05:47.056887	2026-07-22 22:05:47.056887
18	Insumos	egreso	\N	t	2026-07-22 22:05:47.057356	2026-07-22 22:05:47.057356
19	Otro	egreso	\N	t	2026-07-22 22:05:47.057917	2026-07-22 22:05:47.057917
\.


--
-- Data for Name: conceptos_egresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.conceptos_egresos (id, nombre, descripcion, activo, created_by, created_at, updated_at) FROM stdin;
1	Otro	Otro tipo de egreso	t	1	2026-07-20 19:53:07.027724	2026-07-20 19:53:07.027724
2	Tienda	\N	t	3	2026-08-02 18:07:22.510171	2026-08-02 18:07:22.510171
\.


--
-- Data for Name: conceptos_ingresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.conceptos_ingresos (id, nombre, descripcion, activo, created_by, created_at, updated_at) FROM stdin;
1	Otro	Otro tipo de ingreso	t	1	2026-07-20 19:53:07.026603	2026-07-20 19:53:07.026603
2	Ventas de Tablas	Venta de tablas y remates	t	1	2026-07-21 22:01:10.377855	2026-07-21 22:01:10.377855
3	Remate y Dolaraso	\N	t	1	2026-07-21 22:13:52.630486	2026-07-21 22:13:52.630486
4	Limosnas	\N	t	1	2026-07-21 22:28:01.167866	2026-07-21 22:28:01.167866
\.


--
-- Data for Name: configuracion; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.configuracion (id, clave, valor, created_at, updated_at) FROM stdin;
1	telegram_token		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
2	telegram_chat_id		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
3	telegram_group_id		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
4	email_backup		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
5	email_user		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
6	email_pass		2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
7	backup_cron	0 0 1 * *	2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
8	sistema_nombre	Sindicatura Totoracocha Alta	2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
9	sistema_ubicacion	Cuenca - Ecuador	2026-07-20 19:53:07.019861	2026-07-20 19:53:07.019861
10	last_backup	22/07/2026 23:19:22	2026-07-22 20:31:50.568429	2026-07-22 23:19:22.24871
\.


--
-- Data for Name: detalle_egresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.detalle_egresos (id, egreso_id, concepto, valor, descripcion, created_at) FROM stdin;
1	1	Tienda	19.50	Arroz, azúcar, aceite, horchata	2026-08-02 18:11:55.817054
2	1	Descartables	6.80	Fuentes, desechables, plásticos	2026-08-02 18:11:55.821244
3	2	Pollos	28.00	\N	2026-08-02 18:16:16.123819
4	2	Papas	8.00	\N	2026-08-02 18:16:16.127175
5	2	Lechugas	1.50	\N	2026-08-02 18:16:16.12911
6	2	Pimiento	0.50	\N	2026-08-02 18:16:16.130736
7	2	Cebolla colorada	1.00	\N	2026-08-02 18:16:16.132455
8	2	Tomate de riñón	3.00	\N	2026-08-02 18:16:16.13419
9	2	Tomate de árbol	1.00	\N	2026-08-02 18:16:16.135927
10	2	Limón	1.00	\N	2026-08-02 18:16:16.137595
11	3	Carrera	8.00	\N	2026-08-02 18:17:06.900093
\.


--
-- Data for Name: detalle_ingresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.detalle_ingresos (id, ingreso_id, nombre, valor, descripcion, created_at) FROM stdin;
2	2	Tablas	125.00	\N	2026-07-21 22:12:52.851514
3	3	Remate	42.00	\N	2026-07-21 22:14:49.473021
4	4	Tablas	80.00	\N	2026-07-21 22:17:34.983416
5	5	Limosna	10.00	\N	2026-07-21 22:30:04.640666
6	6	Limosna	31.00	\N	2026-07-26 20:16:21.986008
7	7	Venta de tablas	140.50	\N	2026-07-26 20:19:39.452812
8	8	Sincuentaso	17.00	\N	2026-07-26 20:22:23.467661
9	9	Tablas	162.50	\N	2026-08-02 18:21:26.908848
10	9	Dolaraso	18.00	\N	2026-08-02 18:21:26.91171
11	9	Remate	13.00	\N	2026-08-02 18:21:26.913538
\.


--
-- Data for Name: egresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.egresos (id, evento_id, colaborador_id, valor, concepto, detalle, fecha_pago, estado, comprobante_pdf, comprobante_imagen, created_by, created_at, updated_at) FROM stdin;
1	4	10	26.30	Tienda	\N	2026-08-02 18:17:33	pagado	\N	\N	3	2026-08-02 18:11:55.805503	2026-08-02 18:17:33.718491
2	4	10	44.00	Otro	\N	2026-08-02 18:17:50	pagado	\N	\N	3	2026-08-02 18:16:16.115951	2026-08-02 18:17:50.609273
3	4	10	8.00	Otro	\N	2026-08-02 18:18:06	pagado	\N	\N	3	2026-08-02 18:17:06.892273	2026-08-02 18:18:06.688622
\.


--
-- Data for Name: eventos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.eventos (id, nombre, descripcion, fecha_evento, fecha_fin_evento, fecha_limite_colaboracion, activo, created_by, created_at, updated_at) FROM stdin;
2	Fiestas Patronales	Fiestas patronales de la comunidad	2026-02-20	2026-02-23	2026-02-19	f	1	2026-07-20 19:53:07.024206	2026-07-20 19:54:08.549044
1	Belaciones de la Virgen	Celebración de las belaciones de la Virgen	2026-01-15	2026-01-16	2026-01-14	f	1	2026-07-20 19:53:07.024206	2026-07-20 19:54:12.177058
3	MES JULIO 2026	Belación de la Virgen del Cisne	2026-07-01	2026-07-31	2026-07-31	t	1	2026-07-21 22:02:22.874928	2026-07-21 22:02:22.874928
4	MES AGOSTO 2026	\N	2026-08-01	2026-08-31	2026-08-31	t	3	2026-08-02 18:05:23.422851	2026-08-02 18:05:23.422851
\.


--
-- Data for Name: ingresos; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.ingresos (id, evento_id, colaborador_id, valor, concepto, fecha_limite, fecha_pago, estado, comprobante_pdf, comprobante_imagen, observacion, created_by, created_at, updated_at) FROM stdin;
3	3	6	42.00	Remate y Dolaraso	\N	2026-07-21 00:00:00	pagado	\N	/uploads/comprobante-1784690089428-810800220.jpg	\N	1	2026-07-21 22:14:49.470001	2026-07-21 22:15:04.00602
2	3	6	125.00	Ventas de Tablas	\N	2026-07-21 00:00:00	pagado	\N	/uploads/comprobante-1784689972833-300911745.jpg	\N	1	2026-07-21 22:12:52.846113	2026-07-21 22:53:18.721005
4	3	7	80.00	Ventas de Tablas	\N	2026-07-22 23:02:00	pagado	\N	\N	\N	1	2026-07-21 22:17:34.979839	2026-07-22 23:02:00.515165
5	3	6	10.00	Limosnas	\N	2026-07-25 18:58:52	pagado	\N	/uploads/comprobante-1784691004577-488531708.jpg	\N	1	2026-07-21 22:30:04.628735	2026-07-25 18:58:52.117595
6	3	7	31.00	Limosnas	\N	2026-07-26 20:16:37	pagado	\N	\N	Limosna del día de la salida 	3	2026-07-26 20:16:21.983008	2026-07-26 20:16:37.436238
7	3	9	140.50	Ventas de Tablas	\N	2026-07-26 20:19:53	pagado	\N	\N	\N	3	2026-07-26 20:19:39.450246	2026-07-26 20:19:53.746477
8	3	9	17.00	Remate y Dolaraso	\N	2026-07-26 20:22:37	pagado	\N	\N	\N	3	2026-07-26 20:22:23.463819	2026-07-26 20:22:37.136887
9	4	11	193.50	Ventas de Tablas	\N	2026-08-02 18:22:05	pagado	\N	\N	\N	3	2026-08-02 18:21:26.901498	2026-08-02 18:22:05.390002
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.logs (id, usuario_id, accion, tabla, registro_id, datos_anteriores, datos_nuevos, ip, user_agent, created_at) FROM stdin;
1	1	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-20 19:53:39.485616
2	1	eliminar	eventos	2	{"id": 2, "activo": true, "nombre": "Fiestas Patronales", "created_at": "2026-07-21T00:53:07.024Z", "created_by": 1, "updated_at": "2026-07-21T00:53:07.024Z", "descripcion": "Fiestas patronales de la comunidad", "fecha_evento": "2026-02-20T05:00:00.000Z", "fecha_fin_evento": "2026-02-23T05:00:00.000Z", "fecha_limite_colaboracion": "2026-02-19T05:00:00.000Z"}	{"id": 2, "activo": false, "nombre": "Fiestas Patronales", "created_at": "2026-07-21T00:53:07.024Z", "created_by": 1, "updated_at": "2026-07-21T00:54:08.549Z", "descripcion": "Fiestas patronales de la comunidad", "fecha_evento": "2026-02-20T05:00:00.000Z", "fecha_fin_evento": "2026-02-23T05:00:00.000Z", "fecha_limite_colaboracion": "2026-02-19T05:00:00.000Z"}	\N	\N	2026-07-20 19:54:08.552363
3	1	eliminar	eventos	1	{"id": 1, "activo": true, "nombre": "Belaciones de la Virgen", "created_at": "2026-07-21T00:53:07.024Z", "created_by": 1, "updated_at": "2026-07-21T00:53:07.024Z", "descripcion": "Celebración de las belaciones de la Virgen", "fecha_evento": "2026-01-15T05:00:00.000Z", "fecha_fin_evento": "2026-01-16T05:00:00.000Z", "fecha_limite_colaboracion": "2026-01-14T05:00:00.000Z"}	{"id": 1, "activo": false, "nombre": "Belaciones de la Virgen", "created_at": "2026-07-21T00:53:07.024Z", "created_by": 1, "updated_at": "2026-07-21T00:54:12.177Z", "descripcion": "Celebración de las belaciones de la Virgen", "fecha_evento": "2026-01-15T05:00:00.000Z", "fecha_fin_evento": "2026-01-16T05:00:00.000Z", "fecha_limite_colaboracion": "2026-01-14T05:00:00.000Z"}	\N	\N	2026-07-20 19:54:12.179776
4	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-21 14:28:15.863895
5	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-21 14:31:25.795808
6	1	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-21 21:58:46.544505
7	1	login	usuarios	\N	\N	\N	192.168.100.71	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 21:59:18.572125
8	1	login	usuarios	\N	\N	\N	192.168.100.71	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 21:59:19.910162
9	1	crear_concepto_ingreso	conceptos_ingresos	2	\N	{"id": 2, "activo": true, "nombre": "Ventas de Tablas", "created_at": "2026-07-22T03:01:10.377Z", "created_by": 1, "updated_at": "2026-07-22T03:01:10.377Z", "descripcion": "Venta de tablas y remates"}	\N	\N	2026-07-21 22:01:10.381532
10	1	crear	eventos	3	\N	{"id": 3, "activo": true, "nombre": "MES JULIO 2026", "created_at": "2026-07-22T03:02:22.874Z", "created_by": 1, "updated_at": "2026-07-22T03:02:22.874Z", "descripcion": "Belación de la Virgen del Cisne", "fecha_evento": "2026-07-01T05:00:00.000Z", "fecha_fin_evento": "2026-07-31T05:00:00.000Z", "fecha_limite_colaboracion": "2026-07-31T05:00:00.000Z"}	\N	\N	2026-07-21 22:02:22.879799
11	1	crear	colaboradores	6	\N	{"id": 6, "activo": true, "nombre": "Jorge", "celular": "0991188074", "apellido": "Chasi", "created_at": "2026-07-22T03:04:26.074Z", "updated_at": "2026-07-22T03:04:26.074Z"}	\N	\N	2026-07-21 22:04:26.078553
12	1	eliminar	colaboradores	2	{"id": 2, "activo": true, "nombre": "María", "celular": "0992345678", "apellido": "González", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-21T00:53:07.023Z"}	{"id": 2, "activo": false, "nombre": "María", "celular": "0992345678", "apellido": "González", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-22T03:04:33.197Z"}	\N	\N	2026-07-21 22:04:33.200805
13	1	eliminar	colaboradores	4	{"id": 4, "activo": true, "nombre": "Ana", "celular": "0994567890", "apellido": "Martínez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-21T00:53:07.023Z"}	{"id": 4, "activo": false, "nombre": "Ana", "celular": "0994567890", "apellido": "Martínez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-22T03:04:36.882Z"}	\N	\N	2026-07-21 22:04:36.884282
14	1	eliminar	colaboradores	1	{"id": 1, "activo": true, "nombre": "Juan", "celular": "0991234567", "apellido": "Pérez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-21T00:53:07.023Z"}	{"id": 1, "activo": false, "nombre": "Juan", "celular": "0991234567", "apellido": "Pérez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-22T03:04:40.161Z"}	\N	\N	2026-07-21 22:04:40.164763
15	1	eliminar	colaboradores	3	{"id": 3, "activo": true, "nombre": "Carlos", "celular": "0993456789", "apellido": "Rodríguez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-21T00:53:07.023Z"}	{"id": 3, "activo": false, "nombre": "Carlos", "celular": "0993456789", "apellido": "Rodríguez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-22T03:04:44.154Z"}	\N	\N	2026-07-21 22:04:44.15791
16	1	eliminar	colaboradores	5	{"id": 5, "activo": true, "nombre": "Luis", "celular": "0995678901", "apellido": "Sánchez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-21T00:53:07.023Z"}	{"id": 5, "activo": false, "nombre": "Luis", "celular": "0995678901", "apellido": "Sánchez", "created_at": "2026-07-21T00:53:07.023Z", "updated_at": "2026-07-22T03:04:47.636Z"}	\N	\N	2026-07-21 22:04:47.640072
17	1	crear_ingreso	ingresos	1	\N	{"id": 1, "valor": "130.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:08:08.570Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:08:08.570Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689688526-705780290.jpg"}	\N	\N	2026-07-21 22:08:08.577384
18	1	pagar_ingreso	ingresos	1	{"id": 1, "valor": "130.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:08:08.570Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:08:08.570Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689688526-705780290.jpg"}	{"id": 1, "valor": "130.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:08:08.570Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:09:54.387Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689688526-705780290.jpg"}	\N	\N	2026-07-21 22:09:54.390284
87	1	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-26 21:32:01.623949
91	7	logout	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-26 21:40:58.091507
19	1	revertir_ingreso	ingresos	1	{"id": 1, "valor": "130.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:08:08.570Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:09:54.387Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689688526-705780290.jpg"}	{"id": 1, "valor": "130.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:08:08.570Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:12:22.752Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689688526-705780290.jpg"}	\N	\N	2026-07-21 22:12:22.755027
20	1	eliminar_ingreso	ingresos	1	{"id": "1"}	\N	\N	\N	2026-07-21 22:12:30.814458
21	1	crear_ingreso	ingresos	2	\N	{"id": 2, "valor": "125.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:12:52.846Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	\N	\N	2026-07-21 22:12:52.852526
22	1	pagar_ingreso	ingresos	2	{"id": 2, "valor": "125.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:12:52.846Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	{"id": 2, "valor": "125.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:13:09.926Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	\N	\N	2026-07-21 22:13:09.929697
23	1	crear_concepto_ingreso	conceptos_ingresos	3	\N	{"id": 3, "activo": true, "nombre": "Remate y Dolaraso", "created_at": "2026-07-22T03:13:52.630Z", "created_by": 1, "updated_at": "2026-07-22T03:13:52.630Z", "descripcion": null}	\N	\N	2026-07-21 22:13:52.634176
24	1	crear_ingreso	ingresos	3	\N	{"id": 3, "valor": "42.00", "estado": "pendiente", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-22T03:14:49.470Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:14:49.470Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784690089428-810800220.jpg"}	\N	\N	2026-07-21 22:14:49.473966
25	1	pagar_ingreso	ingresos	3	{"id": 3, "valor": "42.00", "estado": "pendiente", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-22T03:14:49.470Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:14:49.470Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784690089428-810800220.jpg"}	{"id": 3, "valor": "42.00", "estado": "pagado", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-22T03:14:49.470Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:15:04.006Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784690089428-810800220.jpg"}	\N	\N	2026-07-21 22:15:04.010037
26	1	crear	colaboradores	7	\N	{"id": 7, "activo": true, "nombre": "Rubén", "celular": null, "apellido": "Arpi", "created_at": "2026-07-22T03:15:56.529Z", "updated_at": "2026-07-22T03:15:56.529Z"}	\N	\N	2026-07-21 22:15:56.533895
27	1	crear_ingreso	ingresos	4	\N	{"id": 4, "valor": "80.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:17:34.979Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-21 22:17:34.984951
28	1	pagar_ingreso	ingresos	4	{"id": 4, "valor": "80.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:17:34.979Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 4, "valor": "80.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:23:30.536Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-21 22:23:30.539997
29	1	crear_concepto_ingreso	conceptos_ingresos	4	\N	{"id": 4, "activo": true, "nombre": "Limosnas", "created_at": "2026-07-22T03:28:01.167Z", "created_by": 1, "updated_at": "2026-07-22T03:28:01.167Z", "descripcion": null}	\N	\N	2026-07-21 22:28:01.170773
30	1	crear_ingreso	ingresos	5	\N	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:30:04.628Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-21 22:30:04.641827
31	1	pagar_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:30:04.628Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:30:25.831Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-21 22:30:25.835083
32	1	login	usuarios	\N	\N	\N	192.168.100.24	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-21 22:35:22.906917
88	1	crear_usuario	usuarios	7	\N	{"id": 7, "rol": "pastoral", "activo": true, "correo": "chasisergio903@gmail.com", "nombre": "Rolando", "celular": "0959151711", "apellido": "Chasi", "telegram": null, "direccion": "Totoracocha Alta"}	\N	\N	2026-07-26 21:33:53.870277
33	1	revertir_ingreso	ingresos	2	{"id": 2, "valor": "125.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:13:09.926Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	{"id": 2, "valor": "125.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:53:09.275Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	\N	\N	2026-07-21 22:53:09.280966
34	1	pagar_ingreso	ingresos	2	{"id": 2, "valor": "125.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T03:53:09.275Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	{"id": 2, "valor": "125.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:12:52.846Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:53:18.721Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784689972833-300911745.jpg"}	\N	\N	2026-07-21 22:53:18.723816
35	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 13:45:03.599459
36	1	revertir_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:30:25.831Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T18:45:16.764Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 13:45:16.767324
37	1	pagar_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-22T18:45:16.764Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-22T18:45:19.000Z", "updated_at": "2026-07-22T18:45:19.641Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 13:45:19.64565
38	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 13:55:26.394889
39	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 13:58:56.09982
40	1	login	usuarios	\N	\N	\N	10.80.3.139	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 14:02:00.827265
41	1	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 20:39:58.093584
42	1	crear_usuario	usuarios	3	\N	{"id": 3, "rol": "administrador", "activo": true, "correo": "blancachasi16@gmail.com", "nombre": "Liliana", "celular": "0939863106", "apellido": "Chasi", "telegram": null, "direccion": "Totoracocha Alta"}	\N	\N	2026-07-22 20:44:08.667627
43	1	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 21:48:27.811483
44	1	revertir_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-22T18:45:19.000Z", "updated_at": "2026-07-22T18:45:19.641Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T02:48:56.843Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 21:48:56.847793
45	1	exportar_excel_detallado	eventos	\N	\N	{"fecha": "2026-07-23T02:50:05.660Z", "filename": "eventos_detallado_20260722_215005.xlsx"}	\N	\N	2026-07-22 21:50:05.661802
46	1	crear_usuario	usuarios	4	\N	{"id": 4, "rol": "visitante", "activo": true, "correo": "chasibelisario@gmail.com", "nombre": "Belisario", "celular": "0997620576", "apellido": "Chasi", "telegram": null, "direccion": "Totoracocha Alta"}	\N	\N	2026-07-22 21:54:51.499125
47	4	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 21:55:16.395863
48	4	revertir_ingreso	ingresos	4	{"id": 4, "valor": "80.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": "2026-07-21T05:00:00.000Z", "updated_at": "2026-07-22T03:23:30.536Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 4, "valor": "80.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T02:56:19.098Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-22 21:56:19.101861
49	4	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 22:14:57.185272
50	4	crear	colaboradores	8	\N	{"id": 8, "activo": true, "nombre": "Braulio", "celular": "0959193489", "apellido": "Arpi", "created_at": "2026-07-23T03:15:28.982Z", "updated_at": "2026-07-23T03:15:28.982Z"}	\N	\N	2026-07-22 22:15:28.985388
51	4	eliminar	colaboradores	8	{"id": 8, "activo": true, "nombre": "Braulio", "celular": "0959193489", "apellido": "Arpi", "created_at": "2026-07-23T03:15:28.982Z", "updated_at": "2026-07-23T03:15:28.982Z"}	{"id": 8, "activo": false, "nombre": "Braulio", "celular": "0959193489", "apellido": "Arpi", "created_at": "2026-07-23T03:15:28.982Z", "updated_at": "2026-07-23T03:15:33.553Z"}	\N	\N	2026-07-22 22:15:33.555723
52	4	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 22:25:34.096153
53	1	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 22:29:04.342788
54	1	crear_usuario	usuarios	5	\N	{"id": 5, "rol": "pastoral", "activo": true, "correo": "braulio.arpi.pc@gmail.com", "nombre": "Vinicio", "celular": "0992031818", "apellido": "Saquipay", "telegram": null, "direccion": "Totoracocha alta"}	\N	\N	2026-07-22 22:29:43.714672
55	5	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 22:30:45.949374
56	1	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:00:59.757594
57	5	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:01:20.353621
58	5	pagar_ingreso	ingresos	4	{"id": 4, "valor": "80.00", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T02:56:19.098Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 4, "valor": "80.00", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-22T03:17:34.979Z", "created_by": 1, "fecha_pago": "2026-07-23T04:02:00.000Z", "updated_at": "2026-07-23T04:02:00.515Z", "observacion": null, "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-22 23:02:00.521383
59	5	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:04:42.622658
60	5	pagar_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T02:48:56.843Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-23T04:04:51.000Z", "updated_at": "2026-07-23T04:04:51.904Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 23:04:51.907717
61	5	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:05:51.690695
62	5	revertir_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-23T04:04:51.000Z", "updated_at": "2026-07-23T04:04:51.904Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T04:06:02.354Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 23:06:02.356963
63	5	pagar_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T04:06:02.354Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-23T04:06:04.000Z", "updated_at": "2026-07-23T04:06:04.727Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 23:06:04.741803
64	4	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:07:43.885817
65	4	logout	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:08:50.7845
66	5	revertir_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-23T04:06:04.000Z", "updated_at": "2026-07-23T04:06:04.727Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T04:09:29.389Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-22 23:09:29.397298
67	5	logout	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:10:39.166524
68	1	login	usuarios	\N	\N	\N	192.168.1.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-22 23:11:01.444951
89	7	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-26 21:37:58.711487
90	4	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-26 21:38:23.722206
92	3	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-08-02 18:03:20.096824
69	1	editar_usuario	usuarios	5	{"id": 5, "rol": "pastoral", "activo": true, "correo": "braulio.arpi.pc@gmail.com", "nombre": "Vinicio", "celular": "0992031818", "apellido": "Saquipay", "password": "$2b$10$4urQ.1Pmm3zB3./7CV5k5OuLwFz2d3m3DHXr3lxPAb27auIfCPAo.", "telegram": null, "direccion": "Totoracocha alta", "created_at": "2026-07-23T03:29:43.710Z", "updated_at": "2026-07-23T03:29:43.710Z"}	{"id": 5, "rol": "administrador", "activo": true, "correo": "braulio.arpi.pc@gmail.com", "nombre": "Vinicio", "celular": "0992031818", "apellido": "Saquipay", "telegram": null, "direccion": "Totoracocha alta"}	\N	\N	2026-07-22 23:19:00.925169
70	1	login	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-25 18:39:28.661933
71	1	editar_usuario	usuarios	2	{"id": 2, "rol": "administrador", "activo": true, "correo": "admin@sindicatura.com", "nombre": "Admin", "celular": null, "apellido": "Sistema", "password": "$2b$10$KYKcWb6Phc.Is/PkM5zXseVwkrsKNXAZic.Tu096d100WBNLS/Ffy", "telegram": null, "direccion": null, "created_at": "2026-07-21T00:53:07.022Z", "updated_at": "2026-07-25T23:38:02.554Z"}	{"id": 2, "rol": "administrador", "activo": true, "correo": "braulio.arpi.seguridad@gmail.com", "nombre": "Admin", "celular": null, "apellido": "Sistema", "telegram": null, "direccion": null}	\N	\N	2026-07-25 18:53:37.098346
72	1	login	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-25 18:57:54.103986
73	1	login	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-25 18:57:55.287923
74	1	pagar_ingreso	ingresos	5	{"id": 5, "valor": "10.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": null, "updated_at": "2026-07-23T04:09:29.389Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	{"id": 5, "valor": "10.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-22T03:30:04.628Z", "created_by": 1, "fecha_pago": "2026-07-25T23:58:52.000Z", "updated_at": "2026-07-25T23:58:52.117Z", "observacion": null, "fecha_limite": null, "colaborador_id": 6, "comprobante_pdf": null, "comprobante_imagen": "/uploads/comprobante-1784691004577-488531708.jpg"}	\N	\N	2026-07-25 18:58:52.121418
75	1	logout	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-25 19:29:07.088303
76	3	login	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-25 19:29:56.776293
77	3	logout	usuarios	\N	\N	\N	192.168.1.6	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-25 19:30:10.878504
78	3	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-26 20:14:36.544547
79	3	crear_ingreso	ingresos	6	\N	{"id": 6, "valor": "31.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-27T01:16:21.983Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:16:21.983Z", "observacion": "Limosna del día de la salida ", "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:16:21.98755
80	3	pagar_ingreso	ingresos	6	{"id": 6, "valor": "31.00", "estado": "pendiente", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-27T01:16:21.983Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:16:21.983Z", "observacion": "Limosna del día de la salida ", "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 6, "valor": "31.00", "estado": "pagado", "concepto": "Limosnas", "evento_id": 3, "created_at": "2026-07-27T01:16:21.983Z", "created_by": 3, "fecha_pago": "2026-07-27T01:16:37.000Z", "updated_at": "2026-07-27T01:16:37.436Z", "observacion": "Limosna del día de la salida ", "fecha_limite": null, "colaborador_id": 7, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:16:37.439593
81	3	crear_colaborador	colaboradores	9	\N	{"id": 9, "activo": true, "nombre": "Boris", "celular": null, "apellido": "Criollo", "created_at": "2026-07-27T01:17:54.029Z", "updated_at": "2026-07-27T01:17:54.029Z"}	\N	\N	2026-07-26 20:17:54.030755
82	3	crear_ingreso	ingresos	7	\N	{"id": 7, "valor": "140.50", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-27T01:19:39.450Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:19:39.450Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:19:39.454902
83	3	pagar_ingreso	ingresos	7	{"id": 7, "valor": "140.50", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-27T01:19:39.450Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:19:39.450Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 7, "valor": "140.50", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 3, "created_at": "2026-07-27T01:19:39.450Z", "created_by": 3, "fecha_pago": "2026-07-27T01:19:53.000Z", "updated_at": "2026-07-27T01:19:53.746Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:19:53.750917
84	3	crear_ingreso	ingresos	8	\N	{"id": 8, "valor": "17.00", "estado": "pendiente", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-27T01:22:23.463Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:22:23.463Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:22:23.46979
85	3	pagar_ingreso	ingresos	8	{"id": 8, "valor": "17.00", "estado": "pendiente", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-27T01:22:23.463Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-07-27T01:22:23.463Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 8, "valor": "17.00", "estado": "pagado", "concepto": "Remate y Dolaraso", "evento_id": 3, "created_at": "2026-07-27T01:22:23.463Z", "created_by": 3, "fecha_pago": "2026-07-27T01:22:37.000Z", "updated_at": "2026-07-27T01:22:37.136Z", "observacion": null, "fecha_limite": null, "colaborador_id": 9, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-07-26 20:22:37.140872
86	1	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-07-26 21:20:37.545451
93	3	crear	eventos	4	\N	{"id": 4, "activo": true, "nombre": "MES AGOSTO 2026", "created_at": "2026-08-02T23:05:23.422Z", "created_by": 3, "updated_at": "2026-08-02T23:05:23.422Z", "descripcion": null, "fecha_evento": "2026-08-01T05:00:00.000Z", "fecha_fin_evento": "2026-08-31T05:00:00.000Z", "fecha_limite_colaboracion": "2026-08-31T05:00:00.000Z"}	\N	\N	2026-08-02 18:05:23.426028
94	3	crear_concepto_egreso	conceptos_egresos	2	\N	{"id": 2, "activo": true, "nombre": "Tienda", "created_at": "2026-08-02T23:07:22.510Z", "created_by": 3, "updated_at": "2026-08-02T23:07:22.510Z", "descripcion": null}	\N	\N	2026-08-02 18:07:22.512461
95	3	crear_colaborador	colaboradores	10	\N	{"id": 10, "activo": true, "nombre": "Liliana", "celular": null, "apellido": "Chasi", "created_at": "2026-08-02T23:08:31.787Z", "updated_at": "2026-08-02T23:08:31.787Z"}	\N	\N	2026-08-02 18:08:31.788394
96	3	crear_egreso	egresos	1	\N	{"id": 1, "valor": "26.30", "estado": "pendiente", "detalle": null, "concepto": "Tienda", "evento_id": 4, "created_at": "2026-08-02T23:11:55.805Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:11:55.805Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:11:55.823695
97	3	crear_egreso	egresos	2	\N	{"id": 2, "valor": "44.00", "estado": "pendiente", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:16:16.115Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:16:16.115Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:16:16.139556
98	3	crear_egreso	egresos	3	\N	{"id": 3, "valor": "8.00", "estado": "pendiente", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:17:06.892Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:17:06.892Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:17:06.903854
99	3	pagar_egreso	egresos	1	{"id": 1, "valor": "26.30", "estado": "pendiente", "detalle": null, "concepto": "Tienda", "evento_id": 4, "created_at": "2026-08-02T23:11:55.805Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:11:55.805Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 1, "valor": "26.30", "estado": "pagado", "detalle": null, "concepto": "Tienda", "evento_id": 4, "created_at": "2026-08-02T23:11:55.805Z", "created_by": 3, "fecha_pago": "2026-08-02T23:17:33.000Z", "updated_at": "2026-08-02T23:17:33.718Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:17:33.722884
100	3	pagar_egreso	egresos	2	{"id": 2, "valor": "44.00", "estado": "pendiente", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:16:16.115Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:16:16.115Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 2, "valor": "44.00", "estado": "pagado", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:16:16.115Z", "created_by": 3, "fecha_pago": "2026-08-02T23:17:50.000Z", "updated_at": "2026-08-02T23:17:50.609Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:17:50.613367
101	3	pagar_egreso	egresos	3	{"id": 3, "valor": "8.00", "estado": "pendiente", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:17:06.892Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:17:06.892Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 3, "valor": "8.00", "estado": "pagado", "detalle": null, "concepto": "Otro", "evento_id": 4, "created_at": "2026-08-02T23:17:06.892Z", "created_by": 3, "fecha_pago": "2026-08-02T23:18:06.000Z", "updated_at": "2026-08-02T23:18:06.688Z", "colaborador_id": 10, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:18:06.691392
102	3	crear_colaborador	colaboradores	11	\N	{"id": 11, "activo": true, "nombre": "Rigoberto", "celular": null, "apellido": "Merchan", "created_at": "2026-08-02T23:18:58.091Z", "updated_at": "2026-08-02T23:18:58.091Z"}	\N	\N	2026-08-02 18:18:58.094752
103	3	crear_ingreso	ingresos	9	\N	{"id": 9, "valor": "193.50", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 4, "created_at": "2026-08-02T23:21:26.901Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:21:26.901Z", "observacion": null, "fecha_limite": null, "colaborador_id": 11, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:21:26.915764
104	3	pagar_ingreso	ingresos	9	{"id": 9, "valor": "193.50", "estado": "pendiente", "concepto": "Ventas de Tablas", "evento_id": 4, "created_at": "2026-08-02T23:21:26.901Z", "created_by": 3, "fecha_pago": null, "updated_at": "2026-08-02T23:21:26.901Z", "observacion": null, "fecha_limite": null, "colaborador_id": 11, "comprobante_pdf": null, "comprobante_imagen": null}	{"id": 9, "valor": "193.50", "estado": "pagado", "concepto": "Ventas de Tablas", "evento_id": 4, "created_at": "2026-08-02T23:21:26.901Z", "created_by": 3, "fecha_pago": "2026-08-02T23:22:05.000Z", "updated_at": "2026-08-02T23:22:05.390Z", "observacion": null, "fecha_limite": null, "colaborador_id": 11, "comprobante_pdf": null, "comprobante_imagen": null}	\N	\N	2026-08-02 18:22:05.394388
105	1	login	usuarios	\N	\N	\N	192.168.100.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	2026-08-02 18:24:30.209031
106	1	exportar_excel_detallado	eventos	\N	\N	{"fecha": "2026-08-02T23:26:18.278Z", "filename": "eventos_detallado_20260802_182618.xlsx"}	\N	\N	2026-08-02 18:26:18.279234
\.


--
-- Data for Name: notificaciones; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.notificaciones (id, evento_id, tipo, fecha_envio, enviado, mensaje, created_at) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: braulio20260715
--

COPY public.usuarios (id, nombre, apellido, celular, direccion, telegram, correo, password, rol, activo, created_at, updated_at) FROM stdin;
2	Admin	Sistema	\N	\N	\N	braulio.arpi.seguridad@gmail.com	$2b$10$KYKcWb6Phc.Is/PkM5zXseVwkrsKNXAZic.Tu096d100WBNLS/Ffy	administrador	t	2026-07-20 19:53:07.022624	2026-07-25 18:53:37.088888
3	Liliana	Chasi	0939863106	Totoracocha Alta	\N	blancachasi16@gmail.com	$2b$10$BE41.mUEUz6baZfyWTCxAuydp1/3B3oYzbiR9OQTxhS1h5pcXnty6	administrador	t	2026-07-22 20:44:08.664249	2026-07-22 20:44:08.664249
4	Belisario	Chasi	0997620576	Totoracocha Alta	\N	chasibelisario@gmail.com	$2b$10$dg60J5EGRRILshiB5C4pUuUyr0d4zmQcuSwRcjtg0yI0ZV5CqC0Ny	visitante	t	2026-07-22 21:54:51.496549	2026-07-22 21:54:51.496549
7	Rolando	Chasi	0959151711	Totoracocha Alta	\N	chasisergio903@gmail.com	$2b$10$H6Z0bZBDnff8BPH.55xTl.dhABYEV5eUOO0a6Tg0P86ewVaeU3t62	pastoral	t	2026-07-26 21:33:53.86716	2026-07-26 21:33:53.86716
1	Braulio	Arpi	\N	\N	\N	braulio.arpi@gmail.com	$2b$10$03rCxqyy8IzLqsijGx0MRud4II/xl1AEpznAvIu7Pi543H9nQa9Ha	administrador	t	2026-07-20 19:53:07.021141	2026-08-02 18:33:29.799526
6	Admin	Sistema	\N	\N	\N	admin@sindicatura.com	$2b$10$1p.Qrr.QTV9SM5CLtTZfwu6NbGyXve6X6XESlZw/.pz7P8tKror8C	administrador	t	2026-07-26 00:09:56.821086	2026-08-02 18:33:29.892251
5	Vinicio	Saquipay	0992031818	Totoracocha alta	\N	braulio.arpi.pc@gmail.com	$2b$10$4urQ.1Pmm3zB3./7CV5k5OuLwFz2d3m3DHXr3lxPAb27auIfCPAo.	administrador	t	2026-07-22 22:29:43.71087	2026-07-22 23:19:00.92217
\.


--
-- Name: colaboradores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.colaboradores_id_seq', 11, true);


--
-- Name: conceptos_egresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.conceptos_egresos_id_seq', 2, true);


--
-- Name: conceptos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.conceptos_id_seq', 19, true);


--
-- Name: conceptos_ingresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.conceptos_ingresos_id_seq', 4, true);


--
-- Name: configuracion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.configuracion_id_seq', 14, true);


--
-- Name: detalle_egresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.detalle_egresos_id_seq', 11, true);


--
-- Name: detalle_ingresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.detalle_ingresos_id_seq', 11, true);


--
-- Name: egresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.egresos_id_seq', 3, true);


--
-- Name: eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.eventos_id_seq', 4, true);


--
-- Name: ingresos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.ingresos_id_seq', 9, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.logs_id_seq', 106, true);


--
-- Name: notificaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.notificaciones_id_seq', 1, false);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: braulio20260715
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 7, true);


--
-- Name: colaboradores colaboradores_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.colaboradores
    ADD CONSTRAINT colaboradores_pkey PRIMARY KEY (id);


--
-- Name: conceptos_egresos conceptos_egresos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_egresos
    ADD CONSTRAINT conceptos_egresos_nombre_key UNIQUE (nombre);


--
-- Name: conceptos_egresos conceptos_egresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_egresos
    ADD CONSTRAINT conceptos_egresos_pkey PRIMARY KEY (id);


--
-- Name: conceptos_ingresos conceptos_ingresos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_ingresos
    ADD CONSTRAINT conceptos_ingresos_nombre_key UNIQUE (nombre);


--
-- Name: conceptos_ingresos conceptos_ingresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_ingresos
    ADD CONSTRAINT conceptos_ingresos_pkey PRIMARY KEY (id);


--
-- Name: conceptos conceptos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos
    ADD CONSTRAINT conceptos_pkey PRIMARY KEY (id);


--
-- Name: configuracion configuracion_clave_key; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.configuracion
    ADD CONSTRAINT configuracion_clave_key UNIQUE (clave);


--
-- Name: configuracion configuracion_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.configuracion
    ADD CONSTRAINT configuracion_pkey PRIMARY KEY (id);


--
-- Name: detalle_egresos detalle_egresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_egresos
    ADD CONSTRAINT detalle_egresos_pkey PRIMARY KEY (id);


--
-- Name: detalle_ingresos detalle_ingresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_ingresos
    ADD CONSTRAINT detalle_ingresos_pkey PRIMARY KEY (id);


--
-- Name: egresos egresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.egresos
    ADD CONSTRAINT egresos_pkey PRIMARY KEY (id);


--
-- Name: eventos eventos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id);


--
-- Name: ingresos ingresos_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: notificaciones notificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: idx_conceptos_egresos_nombre; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_conceptos_egresos_nombre ON public.conceptos_egresos USING btree (nombre);


--
-- Name: idx_conceptos_ingresos_nombre; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_conceptos_ingresos_nombre ON public.conceptos_ingresos USING btree (nombre);


--
-- Name: idx_detalle_egresos_egreso; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_detalle_egresos_egreso ON public.detalle_egresos USING btree (egreso_id);


--
-- Name: idx_detalle_ingresos_ingreso; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_detalle_ingresos_ingreso ON public.detalle_ingresos USING btree (ingreso_id);


--
-- Name: idx_egresos_colaborador; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_egresos_colaborador ON public.egresos USING btree (colaborador_id);


--
-- Name: idx_egresos_concepto; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_egresos_concepto ON public.egresos USING btree (concepto);


--
-- Name: idx_egresos_estado; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_egresos_estado ON public.egresos USING btree (estado);


--
-- Name: idx_egresos_evento; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_egresos_evento ON public.egresos USING btree (evento_id);


--
-- Name: idx_eventos_fecha; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_eventos_fecha ON public.eventos USING btree (fecha_evento);


--
-- Name: idx_ingresos_colaborador; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_ingresos_colaborador ON public.ingresos USING btree (colaborador_id);


--
-- Name: idx_ingresos_concepto; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_ingresos_concepto ON public.ingresos USING btree (concepto);


--
-- Name: idx_ingresos_estado; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_ingresos_estado ON public.ingresos USING btree (estado);


--
-- Name: idx_ingresos_evento; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_ingresos_evento ON public.ingresos USING btree (evento_id);


--
-- Name: idx_logs_accion; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_logs_accion ON public.logs USING btree (accion);


--
-- Name: idx_logs_created_at; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_logs_created_at ON public.logs USING btree (created_at);


--
-- Name: idx_logs_usuario; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_logs_usuario ON public.logs USING btree (usuario_id);


--
-- Name: idx_usuarios_correo; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_usuarios_correo ON public.usuarios USING btree (correo);


--
-- Name: idx_usuarios_rol; Type: INDEX; Schema: public; Owner: braulio20260715
--

CREATE INDEX idx_usuarios_rol ON public.usuarios USING btree (rol);


--
-- Name: conceptos_egresos conceptos_egresos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_egresos
    ADD CONSTRAINT conceptos_egresos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id);


--
-- Name: conceptos_ingresos conceptos_ingresos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.conceptos_ingresos
    ADD CONSTRAINT conceptos_ingresos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id);


--
-- Name: detalle_egresos detalle_egresos_egreso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_egresos
    ADD CONSTRAINT detalle_egresos_egreso_id_fkey FOREIGN KEY (egreso_id) REFERENCES public.egresos(id) ON DELETE CASCADE;


--
-- Name: detalle_ingresos detalle_ingresos_ingreso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.detalle_ingresos
    ADD CONSTRAINT detalle_ingresos_ingreso_id_fkey FOREIGN KEY (ingreso_id) REFERENCES public.ingresos(id) ON DELETE CASCADE;


--
-- Name: egresos egresos_colaborador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.egresos
    ADD CONSTRAINT egresos_colaborador_id_fkey FOREIGN KEY (colaborador_id) REFERENCES public.colaboradores(id);


--
-- Name: egresos egresos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.egresos
    ADD CONSTRAINT egresos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id);


--
-- Name: egresos egresos_evento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.egresos
    ADD CONSTRAINT egresos_evento_id_fkey FOREIGN KEY (evento_id) REFERENCES public.eventos(id) ON DELETE CASCADE;


--
-- Name: eventos eventos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.eventos
    ADD CONSTRAINT eventos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id);


--
-- Name: ingresos ingresos_colaborador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_colaborador_id_fkey FOREIGN KEY (colaborador_id) REFERENCES public.colaboradores(id);


--
-- Name: ingresos ingresos_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.usuarios(id);


--
-- Name: ingresos ingresos_evento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_evento_id_fkey FOREIGN KEY (evento_id) REFERENCES public.eventos(id) ON DELETE CASCADE;


--
-- Name: logs logs_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: notificaciones notificaciones_evento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: braulio20260715
--

ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_evento_id_fkey FOREIGN KEY (evento_id) REFERENCES public.eventos(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

