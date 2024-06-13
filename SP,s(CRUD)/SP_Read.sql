---VIEW DE TABLAS
Use KOALASA
GO
Create View Vw_Proveedor
as
Select
CodigoProveedor as 'Codigo de Proveedor',
NombreProv as 'Nombre del Proveedor',
CedulaJuridica as 'Cedula Juridica',
Telefono,
Correo,
EstadoProveedor as 'Estado del Proveedor'
from Proveedor
GO

Use KOALASA
GO
Create View Vw_Tipo
as
Select
CodigoTipo AS 'Codigo del Tipo',
NombreTipo As 'Nombre Del Tipo',
CodProveedor As 'Codigo del Proveedor',
Genero As 'Genero Del Zapato'
from Tipo
GO

Use KOALASA
GO
Create View Vw_Color
as
Select
CodigoColor As 'Codigo de Color',
NombreColor As 'Nombre Del Color'
from Color
GO

Use KOALASA
GO
Create View Vw_Zapato
as
Select
CodigoZapato as 'Codigo de Zapato',
CodTipo As 'Codigo de tipo',
CodColor AS 'Codigo de Color' ,
Talla,
PrecioUnitario As 'Precio Unitario'
from Zapato
GO

Use KOALASA
GO
Create View Vw_Stock
as
Select
	IdStock as 'Codigo en Inventario',
    CodigoZapato as 'Codigo de Zapato',
    Existencias
from Stock
GO

Use KOALASA
GO
Create View Vw_Persona
as
Select
	Cedula ,
	Nombre ,
	Apellido1 as 'Primer Apellido',
	Apellido2 as 'Segundo Apellido',
	Correo ,
	Telefono,
	Tipo 
from Persona
GO

Use KOALASA
GO
Create View Vw_MPago
as
Select
    IdMetodoPago as 'Codigo de metodo de pago',
    NombreMetodo as 'Nombre de metodo de pago'
from Metodo_Pago
GO

Use KOALASA
GO
Create View Vw_Compra
as
Select
    NumFactura as 'Numero de Factura',
    Fecha,
    Total,
    CedCliente 'Cedula Cliente',
	CedVendedor 'Cedula Vendedor',
    IdMetodoPago 'Metodo de pago'
from Compra
GO

Use KOALASA
GO
Create View Vw_Carrito_Compra
as
Select
   IdCarrito  'Codigo de carrito',
	NumFactura  'Numero de Factura',
    IdStock  as 'Çodigo en Inventario',
	Cantidad  ,
	SubTotal  As 'Sub Total'
from Carrito_Compra
GO