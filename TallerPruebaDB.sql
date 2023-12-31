/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 16.1 		*/
/*  Created On : 15-abr.-2023 9:10:23 a. m. 				*/
/*  DBMS       : Oracle 						*/
/* ---------------------------------------------------- */

/* Drop Tables */

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "CLIENTE" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "CUENTA" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "SUCURSAL" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "TIPO_CUENTA" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "TRANSACCION" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

/* Create Tables */

CREATE TABLE  "CLIENTE"
(
	"NUMERO_DOCUMENTO" NUMBER(10) NOT NULL,
	"TIPO_DOCUMENTO" VARCHAR2(50) NOT NULL,
	"NOMBRES" VARCHAR2(50) NOT NULL,
	"APELLIDOS" VARCHAR2(50) NOT NULL,
	"CORREO" VARCHAR2(50) NOT NULL,
	"CELULAR" NUMBER(10) NOT NULL,
	"DIRECCION" VARCHAR2(50) NOT NULL,
	"CONTRASENA" VARCHAR2(16) NOT NULL,
	"ID_SUCURSAL" NUMBER(3) NOT NULL
)
;

CREATE TABLE  "CUENTA"
(
	"NUMERO_CUENTA" NUMBER(10) NOT NULL,
	"ID_TIPO_CUENTA" NUMBER(2) NOT NULL,
	"NUMERO_DOCUMENTO" NUMBER(10) NOT NULL,
	"SALDO" NUMBER(10,2) NOT NULL,
	"CLAVE" NUMBER(4) NOT NULL
)
;

CREATE TABLE  "SUCURSAL"
(
	"ID_SUCURSAL" NUMBER(3) NOT NULL,
	"NOMBRE_SUCURSAL" VARCHAR2(50) NOT NULL,
	"DIRECCION" VARCHAR2(50) NOT NULL,
	"TELEFONO" NUMBER(10) NOT NULL
)
;

CREATE TABLE  "TIPO_CUENTA"
(
	"ID_TIPO_CUENTA" NUMBER(2) NOT NULL,
	"NOMBRE_TIPO_CUENTA" VARCHAR2(50) NOT NULL,
	"INTERES" VARCHAR2(50) NOT NULL
)
;

CREATE TABLE  "TRANSACCION"
(
	"ID_TRANSACCION" NUMBER(8) NOT NULL,
	"NUMERO_CUENTA" NUMBER(10) NOT NULL,
	"TIPO_TRANSACCION" VARCHAR2(50) NOT NULL,
	"FECHA" DATE NOT NULL,
	"NUMERO_CUENTA_DESTINO" NUMBER(10) NULL,
	"NUMERO_DOC_DESTINO" NUMBER(10) NULL
)
;

/* Create Primary Keys, Indexes, Uniques, Checks, Triggers */

ALTER TABLE  "CLIENTE" 
 ADD CONSTRAINT "PK_CLIENTE"
	PRIMARY KEY ("NUMERO_DOCUMENTO") 
 USING INDEX
;

CREATE INDEX "IXFK_CLIENTE_SUCURSAL"   
 ON  "CLIENTE" ("ID_SUCURSAL") 
;

ALTER TABLE  "CUENTA" 
 ADD CONSTRAINT "PK_CUENTA"
	PRIMARY KEY ("NUMERO_CUENTA") 
 USING INDEX
;

CREATE INDEX "IXFK_CUENTA_CLIENTE"   
 ON  "CUENTA" ("NUMERO_DOCUMENTO") 
;

CREATE INDEX "IXFK_CUENTA_TIPO_CUENTA"   
 ON  "CUENTA" ("ID_TIPO_CUENTA") 
;

ALTER TABLE  "SUCURSAL" 
 ADD CONSTRAINT "PK_SUCURSAL"
	PRIMARY KEY ("ID_SUCURSAL") 
 USING INDEX
;

ALTER TABLE  "TIPO_CUENTA" 
 ADD CONSTRAINT "PK_TIPO_CUENTA"
	PRIMARY KEY ("ID_TIPO_CUENTA") 
 USING INDEX
;

ALTER TABLE  "TRANSACCION" 
 ADD CONSTRAINT "PK_TRANSACCION"
	PRIMARY KEY ("ID_TRANSACCION") 
 USING INDEX
;

CREATE INDEX "IXFK_TRANSACCION_CUENTA"   
 ON  "TRANSACCION" ("NUMERO_CUENTA") 
;

/* Create Foreign Key Constraints */

ALTER TABLE  "CLIENTE" 
 ADD CONSTRAINT "FK_CLIENTE_SUCURSAL"
	FOREIGN KEY ("ID_SUCURSAL") REFERENCES  "SUCURSAL" ("ID_SUCURSAL")
;

ALTER TABLE  "CUENTA" 
 ADD CONSTRAINT "FK_CUENTA_CLIENTE"
	FOREIGN KEY ("NUMERO_DOCUMENTO") REFERENCES  "CLIENTE" ("NUMERO_DOCUMENTO")
;

ALTER TABLE  "CUENTA" 
 ADD CONSTRAINT "FK_CUENTA_TIPO_CUENTA"
	FOREIGN KEY ("ID_TIPO_CUENTA") REFERENCES  "TIPO_CUENTA" ("ID_TIPO_CUENTA")
;

ALTER TABLE  "TRANSACCION" 
 ADD CONSTRAINT "FK_TRANSACCION_CUENTA"
	FOREIGN KEY ("NUMERO_CUENTA") REFERENCES  "CUENTA" ("NUMERO_CUENTA")
;
