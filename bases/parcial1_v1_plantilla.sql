-------------DML-------------
CREATE TABLE cliente(
    id_cliente smallint NOT NULL,
    nombre varchar(45) NOT NULL,
    apellido varchar(45) NOT NULL,
    PRIMARY KEY (id_cliente)
);
CREATE TABLE producto(
    id_producto smallint NOT NULL,
    nombre varchar(45) NOT NULL,
    unidades_disponibles smallint NOT NULL,
    precio_unitario smallint NOT NULL,
    PRIMARY KEY (id_producto)
);
CREATE TABLE factura(
    numero_factura serial NOT NULL,
    fecha date NOT NULL,
    valor_total smallint NOT NULL,
    id_cliente smallint,
    PRIMARY KEY (numero_factura),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);
CREATE TABLE factura_producto(
    id_factura_producto serial NOT NULL,
    cantidad smallint NOT NULL,
    valor_unitario smallint NOT NULL,
    valor_total smallint NOT NULL,
    id_producto smallint,
    numero_factura integer,
    PRIMARY KEY (id_factura_producto),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto),
    FOREIGN KEY (numero_factura) REFERENCES factura (numero_factura)
);

-------------DDL-------------
insert into cliente (id_cliente, nombre, apellido) 
values (10, 'Clark', 'Kent');
insert into cliente (nombre, apellido) 
values (20, 'Bruce', 'Wayne');
insert into cliente (nombre, apellido) 
values (30, 'Petter', 'Parker');

insert into producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
values (100, 'Cuaderno', 250, 3500);
insert into producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
values (200, 'Marcador', 120, 2800);
insert into producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
values (300, 'CD', 85, 750);
insert into producto (id_producto, nombre, unidades_disponibles, precio_unitario) 
values (400, 'Lapiz', 800, 500);

-------------Punto 1-------------


-------------Punto 2-------------


-------------Punto 3-------------


-------------Punto 4-------------
insert into factura (fecha, valor_total, id_cliente) 
values (current_date, 0, 20);
insert into factura_producto (cantidad, valor_unitario, valor_total, id_producto, numero_factura) 
values (2, 3500, 3500*2, 100, 2);
update producto set unidades_disponibles = unidades_disponibles - 2 where id_producto = 100; 
update factura set valor_total = 7000 where numero_factura = 2;

insert into factura (fecha, valor_total, id_cliente) 
values (current_date, 0, 20);
insert into factura_producto (cantidad, valor_unitario, valor_total,id_producto,numero_factura) 
values (2, 500, 500*2, 400, 3);
update producto set unidades_disponibles = unidades_disponibles - 2 where id_producto = 400; 
update factura set valor_total = 1000 where numero_factura = 3;



-------------Punto 5-------------
create or replace function actualizacion_unidades() returns trigger
language plpgsql
as
$$
begin

end;
$$


-------------Punto 6-------------


-------------Punto 7-------------
















