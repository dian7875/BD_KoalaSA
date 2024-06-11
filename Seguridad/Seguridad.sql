
USE KOALASA;
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON Proveedor TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Tipo TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Color TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Zapato TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Stock TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Persona TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Metodo_Pago TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Compra TO Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON Carrito_Compra TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_COLOR TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_TIPO TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_ZAPATO TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_STOCK TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_ARTICULO_A_CARRITO TO Administrador;
GRANT EXECUTE ON SP_GENERAR_COMPRA TO Administrador;
GRANT EXECUTE ON SP_AñADIR_METODO_PAGO TO Administrador;
GRANT EXECUTE ON SP_INGRESAR_PERSONA TO Administrador;
GO

USE KOALASA
GO
GRANT SELECT, INSERT, UPDATE ON Proveedor TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Tipo TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Color TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Zapato TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Stock TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Persona TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Metodo_Pago TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Compra TO Vendedor;
GRANT SELECT, INSERT, UPDATE ON Carrito_Compra TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_COLOR TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_TIPO TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_ZAPATO TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_STOCK TO Vendedor;
GRANT EXECUTE ON SP_INGRESAR_ARTICULO_A_CARRITO TO Vendedor;
GRANT EXECUTE ON SP_GENERAR_COMPRA TO Vendedor;
GRANT EXECUTE ON SP_AñADIR_METODO_PAGO TO Vendedor;
GO

USE KOALASA
GO
GRANT SELECT ON Tipo TO Clientes;
GRANT SELECT ON Proveedor TO Clientes;
GRANT SELECT ON Color TO Clientes;
GRANT SELECT ON Zapato TO Clientes;
GRANT SELECT ON Stock TO Clientes;
GRANT SELECT ON Persona TO Clientes;
GRANT SELECT ON Metodo_Pago TO Clientes;
GRANT SELECT ON Compra TO Clientes;
GRANT SELECT ON Carrito_Compra TO Clientes;

GO


USE KOALASA
GO
GRANT SELECT ON Color TO Clientes;
GRANT EXECUTE ON SP_INGRESAR_COLOR TO Clientes;
GO



