--VIEW

Use KOALASA
GO
CREATE VIEW SelectProveedor AS
SELECT CodigoProveedor, NombreProv, Telefono, Estado, Correo
FROM Proveedor
WHERE CodigoProveedor = @CodigoProveedor
GO

Use KOALASA
GO
CREATE VIEW SelectTipo AS
SELECT CodigoTipo, NombreTipo, CodProveedor
FROM Tipo
WHERE CodigoTipo = @CodigoTipo
GO

Use KOALASA
GO
CREATE VIEW SelectColor AS
SELECT CodigoColor, NombreColor
FROM Color
WHERE CodigoColor = @CodigoColor
GO

Use KOALASA
GO
CREATE VIEW SelectZapato AS
SELECT CodigoZapato, CodTipo, CodColor, Talla, PrecioUnitario
FROM Zapato
WHERE CodigoZapato = @CodigoZapato
GO

Use KOALASA
GO
CREATE VIEW SelectCompra AS
SELECT NumFactura, Fecha, Total, CodigoCliente, CodigoVendedor, IdMetodoPago
FROM Compra
WHERE NumFactura = @NumFactura
GO

Use KOALASA
GO
CREATE VIEW SelectCarrito_Compra AS
SELECT IdCarrito, NumFactura, IdStock, Cantidad, SubTotal
FROM Carrito_Compra
WHERE IdCarrito = @IdCarrito
GO


Use KOALASA
GO
CREATE VIEW SelectCliente AS
SELECT CodigoCliente, CedulaCliente, C.Nombre, C.Apellido1, C.Apellido2, C.Correo, C.Estado, C.Telefono
FROM Cliente
WHERE CodigoCliente = @CodigoCliente
GO


Use KOALASA
GO
CREATE VIEW SelectVendedor AS
SELECT CodigoVendedor, CedulaVendedor, V.Nombre, V.Apellido1, V.Apellido2, V.Correo, V.Estado, V.Telefono
FROM Vendedor
WHERE CodigoVendedor = @CodigoVendedor
GO
