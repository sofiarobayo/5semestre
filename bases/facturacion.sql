/*
	Manejo de Bases de Datos 2020-II
	Primer Parcial
	Script de creación de modelo de datos de facturación y template de respuestas
*/

-- SENTENCIAS DDL
CREATE TABLE cliente
(
    id_cliente SMALLINT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_cliente)
);
CREATE TABLE producto
(
    id_producto SMALLINT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    unidades_disponibles SMALLINT NOT NULL,
    precio_unitario SMALLINT NOT NULL,
    PRIMARY KEY (id_producto)
);
CREATE TABLE factura 
( 
	numero_factura SERIAL NOT NULL , 
	fecha       DATE NOT NULL , 
	valor_total SMALLINT NOT NULL , 
	id_cliente  SMALLINT , 
	PRIMARY KEY (numero_factura), 
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
);
CREATE TABLE factura_producto 
( 
	id_factura_producto SERIAL NOT NULL , 
	cantidad       SMALLINT NOT NULL , 
	valor_unitario SMALLINT NOT NULL , 
	valor_total    SMALLINT NOT NULL , 
	id_producto    SMALLINT , 
	numero_factura INTEGER , 
	PRIMARY KEY (id_factura_producto), 
	FOREIGN KEY (id_producto) REFERENCES producto (id_producto), 
	FOREIGN KEY (numero_factura) REFERENCES factura (numero_factura) 
);

-- Sentencias DML

INSERT INTO cliente (id_cliente, nombre, apellido) 
VALUES (10, 'Clark', 'Kent');
INSERT INTO cliente (id_cliente, nombre, apellido) 
VALUES (20, 'Bruce', 'Wayne');
INSERT INTO cliente (id_cliente, nombre, apellido) 
VALUES (30, 'Petter', 'Parker');

INSERT INTO producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
VALUES (100, 'Cuaderno', 250, 3500);
INSERT INTO producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
VALUES (200, 'Marcador', 120, 2800);
INSERT INTO producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
VALUES (300, 'CD', 85, 750);
INSERT INTO producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
VALUES (400, 'Lapiz', 800, 500);

----------------------------------- PUNTO 1 -----------------------------------

----------------------------------- PUNTO 2 -----------------------------------

----------------------------------- PUNTO 3 -----------------------------------

----------------------------------- PUNTO 4 -----------------------------------
INSERT INTO factura (fecha, valor_total, id_cliente) 
VALUES (now()::DATE,0,20);
INSERT INTO factura_producto (cantidad, valor_unitario, valor_total,id_producto,numero_factura) 
VALUES (2,3500,3500*2,100,2);
UPDATE producto SET unidades_disponibles = unidades_disponibles - 2 WHERE id_producto = 100; 
UPDATE factura SET valor_total = 7000 WHERE numero_factura = 2;

INSERT INTO factura (fecha, valor_total, id_cliente) 
VALUES (now()::DATE,0,20);
INSERT INTO factura_producto (cantidad, valor_unitario, valor_total,id_producto,numero_factura) 
VALUES (2,500,500*2,400,3);
UPDATE producto SET unidades_disponibles = unidades_disponibles - 2 WHERE id_producto = 400; 
UPDATE factura SET valor_total = 1000 WHERE numero_factura = 3;
----------------------------------- PUNTO 5 -----------------------------------

----------------------------------- PUNTO 6 -----------------------------------

----------------------------------- PUNTO 7 -----------------------------------
CREATE FUNCTION productos_cliente (<escriba los parámetros>) RETURNS <escriba el retorno> AS $$
BEGIN
	-- Escriba su código
END;
$$ LANGUAGE plpgsql;

SELECT productos_cliente(10);
SELECT productos_cliente(20);
----------------------------------- PUNTO 8 -----------------------------------

