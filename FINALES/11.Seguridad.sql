
USE KOALASA;
SELECT name
FROM sys.procedures
WHERE type = 'P'
ORDER BY name;



USE KOALASA
GO
GRANT EXECUTE ON SP_INGRESAR_TIPO TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_COLOR TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_ZAPATO TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_ZAPATO_POR_NOMBRE TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_STOCK TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_PERSONA TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_ARTICULO_A_CARRITO TO Vendedor;
GRANT EXECUTE ON SP_GENERAR_COMPRA TO Vendedor;
GRANT EXECUTE ON SP_COMPRA_COMO_VENDEDOR TO Vendedor;
GRANT EXECUTE ON SP_VENDIDO_EN_EL_MES TO Vendedor;
GRANT EXECUTE ON SP_VENTAS_DEL_MES TO Vendedor;
GRANT EXECUTE ON SP_VENTAS_POR_CODIGO_ZAPATO TO Vendedor;
GRANT EXECUTE ON SP_VENTAS_POR_ZAPATO TO Vendedor;
GRANT EXECUTE ON SP_ARTICULOS_COMPRA_POR_CEDULA_CLIENTE TO Vendedor;
GRANT EXECUTE ON SP_COMPRA_POR_CEDULA_CLIENTE TO Vendedor;
GRANT EXECUTE ON SP_ARTICULOS_COMPRA_POR_NUMFACTURA TO Vendedor;
GRANT EXECUTE ON SP_COMPRA_POR_NUMFACTURA TO Vendedor;
GRANT EXECUTE ON SP_BUSCAR_ZAPATO_POR_PROVEEDOR TO Vendedor;
GRANT EXECUTE ON SP_BuscarProveedor_Codigo TO Vendedor;
GO

USE KOALASA
GO
GRANT EXECUTE ON SP_COMPRA_POR_NUMFACTURA TO Cliente;
GRANT EXECUTE ON SP_ARTICULOS_COMPRA_POR_NUMFACTURA TO Cliente;
GRANT EXECUTE ON SP_ARTICULOS_COMPRA_POR_CEDULA_CLIENTE TO Cliente;
GRANT EXECUTE ON SP_COMPRA_POR_CEDULA_CLIENTE TO Cliente;
GRANT EXECUTE ON SP_CATALO_DE_ZAPATOS TO Cliente;
GRANT EXECUTE ON SP_CATALO_DE_ZAPATOS_POR_GENERO TO Cliente;
GO





