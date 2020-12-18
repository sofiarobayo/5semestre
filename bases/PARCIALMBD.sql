-------------Punto 1-------------
phi(numero_factura,nombre,cantidad (sigma producto.id_producto=factura_producto.id_producto (producto x factura_producto)))

-------------Punto 2-------------
INSERT INTO factura(fecha,valor_total,id_cliente) VALUES (now()::DATE,(3500*2)+(800*2),30);
SELECT * FROM factura;

-------------Punto 3-------------
SELECT prod.nombre,SUM(cantidad) AS unidades_vendidas
FROM producto AS prod JOIN factura_producto AS factpro ON prod.id_producto=factpro.id_producto
GROUP BY prod.nombre
ORDER BY unidades_vendidas DESC;

-------------Punto 4-------------
CREATE VIEW todas_las_facturas_de_clientes AS
SELECT cli.nombre,
  cli.apellido,
  fact.numero_factura,
  fact.fecha,
  fact.valor_total
FROM cliente AS cli JOIN factura AS fact ON cli.id_cliente=fact.id_cliente;
SELECT * from  todas_las_facturas_de_clientes;

-------------Punto 5-------------
CREATE OR REPLACE FUNCTION actualizacion_unidades() RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
SELECT nombre,unidades_disponibles
FROM producto AS prod JOIN factura_producto AS factpro ON prod.id_producto= factpro.id_producto
WHERE unidades_disponibles=unidades_disponibles-cantidad;
END;
$$
SELECT * FROM producto;

-------------Punto 6-------------
SELECT * FROM
(SELECT
  cli.id_cliente,
    cli.nombre,
  cli.apellido,
    count(*) AS cantidad_facturas,
    AVG(valor_total) AS valor_prom_compras
FROM cliente AS cli JOIN factura AS fact ON cli.id_cliente=fact.id_cliente
GROUP BY cli.id_cliente) as consulta
WHERE cantidad_facturas>1;

-------------Punto 7-------------
Inicialmente lo que se hace es que se ingresa una transaccion en la tabla de factura_producto en donde
se le ingresa la cantidad que es 12,el valor unitario que es 3500, el valor total que es 42000,
el id del producto que es 100 y el numero de factura que es 5.
Luego se inserta en la tabla de factura el numero de la factura que es 5, la fecha de hoy,el valor total
que es 54500 y el id_del cliente.
Finalmente se inserta dentro de la tabla factura_producto la cantidad que es 25,el valor unitario que
es 500 el valor total que es 12500, el id del producto que es 400 y el numero de factura que es 5.
Entonces de esta manera lo que se hace es que se agregan facturas_producto al munero de la factura 5
y esta transaccion si se puede realizar porque cada que recaliza un cur.execute va seguido de un con.commit().
