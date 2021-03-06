--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: parking_spots; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parking_spots (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying,
    latitude numeric(9,6),
    longitude numeric(9,6),
    description text,
    paid boolean DEFAULT true,
    spaces integer,
    deleted boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    created_by_id integer,
    updated_by_id integer,
    spots_available_date timestamp without time zone
);


--
-- Name: parking_spots_old; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE parking_spots_old (
    name character varying(255),
    latitude numeric(9,6),
    longitude numeric(9,6),
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    spaces integer,
    paid boolean,
    deleted boolean DEFAULT false,
    created_by_id integer,
    updated_by_id integer,
    id uuid DEFAULT uuid_generate_v4() NOT NULL
);


--
-- Name: phones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phones (
    id integer NOT NULL,
    device_id character varying(255),
    model character varying(255),
    build_json text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phones_id_seq OWNED BY phones.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    nickname character varying(255),
    fname character varying(255),
    lname character varying(255),
    email character varying(255),
    epassword character varying(255),
    salt character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phones ALTER COLUMN id SET DEFAULT nextval('phones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: parking_spots_new_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parking_spots
    ADD CONSTRAINT parking_spots_new_pkey PRIMARY KEY (id);


--
-- Name: parking_spots_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY parking_spots_old
    ADD CONSTRAINT parking_spots_pkey PRIMARY KEY (id);


--
-- Name: phones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140831200946');

INSERT INTO schema_migrations (version) VALUES ('20140831202630');

INSERT INTO schema_migrations (version) VALUES ('20140901053159');

INSERT INTO schema_migrations (version) VALUES ('20140903002059');

INSERT INTO schema_migrations (version) VALUES ('20140905194721');

INSERT INTO schema_migrations (version) VALUES ('20140907205555');

INSERT INTO schema_migrations (version) VALUES ('20141130031403');

INSERT INTO schema_migrations (version) VALUES ('20141207015757');

INSERT INTO schema_migrations (version) VALUES ('20141211205206');

INSERT INTO schema_migrations (version) VALUES ('20141224224423');

INSERT INTO schema_migrations (version) VALUES ('20141224230352');

INSERT INTO schema_migrations (version) VALUES ('20141226233701');

INSERT INTO schema_migrations (version) VALUES ('20150213203700');

