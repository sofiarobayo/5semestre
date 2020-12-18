-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: university_enterprise | type: DATABASE --
-- -- DROP DATABASE IF EXISTS university_enterprise;
-- CREATE DATABASE university_enterprise;
-- -- ddl-end --
-- 

-- object: public.department | type: TABLE --
-- DROP TABLE IF EXISTS public.department CASCADE;
CREATE TABLE public.department (
	department varchar(50) NOT NULL,
	building varchar(50) NOT NULL,
	budget integer NOT NULL DEFAULT 0,
	CONSTRAINT department_pk PRIMARY KEY (department)

);
-- ddl-end --
-- ALTER TABLE public.department OWNER TO postgres;
-- ddl-end --


