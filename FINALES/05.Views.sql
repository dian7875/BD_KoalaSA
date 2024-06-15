---VIEW DE TABLAS
--Parte 5 Views
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
Create View Vw_Zapato_Con_Stock
as
Select
Zapato.CodigoZapato as 'Codigo de Zapato',
Zapato.CodTipo As 'Codigo de tipo',
Zapato.CodColor AS 'Codigo de Color' ,
Zapato.Talla,
Zapato.PrecioUnitario As 'Precio Unitario',
Stock.Existencias as 'Cantidad en Stock'
from Zapato JOIN Stock ON Zapato.CodigoZapato = Stock.CodigoZapato
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
Direccion,
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

USE KOALASA
GO
create view Vw_Z_CTSP
AS
SELECT 
Z.[Codigo de Zapato],Z.[Codigo de Color],Z.[Codigo de tipo],Z.[Precio Unitario],Z.Talla,
T.[Nombre Del Tipo],T.[Codigo del Proveedor],T.[Genero Del Zapato],
C.[Nombre Del Color],
p.[Nombre del Proveedor],
S.[Codigo en Inventario],S.Existencias
FROM Vw_zapato Z
JOIN Vw_Color C on Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
JOIN Vw_Proveedor P ON T.[Codigo del Proveedor] = P.[Codigo de Proveedor]
GO

USE KOALASA
GO
Create view Vw_C_I_VCMZ
AS
SELECT
CC.[Numero de Factura],CC.Cantidad,CC.[Sub Total],CC.[Codigo de carrito],CC.[Çodigo en Inventario],
C.Fecha, C.[Cedula Cliente],C.[Cedula Vendedor],C.[Metodo de pago],C.Total,
Z.[Codigo de Zapato],Z.[Nombre Del Tipo],Z.[Nombre Del Color],Z.[Precio Unitario],
MP.[Nombre de metodo de pago]
FROM Vw_Compra C
JOIN Vw_Carrito_Compra CC ON C.[Numero de Factura] = CC.[Numero de Factura]
JOIN Vw_Z_CTSP Z ON Z.[Codigo en Inventario] = CC.[Çodigo en Inventario]
JOIN Vw_MPago MP ON MP.[Codigo de metodo de pago] = C.[Metodo de pago]
GO
--Vw Auditorias

USE KOALASA
GO
Create view Vw_Audit_proveedor
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
	CodigoProveedor as 'Codigo de Proveedor',
	NombreProv as 'Nombre del Proveedor',
	CedulaJuridica as 'Cedula Juridica',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Proveedor
GO

USE KOALASA
GO
Create view Vw_Audit_Color
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    CodigoColor As 'Codigo de Color',
	NombreColor As 'Nombre Del Color',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Color
GO

USE KOALASA
GO
Create view Vw_Audit_Tipo
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    CodigoTipo AS 'Codigo del Tipo',
	NombreTipo As 'Nombre Del Tipo',
	CodProveedor As 'Codigo del Proveedor',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Tipo
GO

USE KOALASA
GO
Create view Vw_Audit_Zapato
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    CodigoZapato as 'Codigo de Zapato',
	PrecioUnitario As 'Precio Unitario',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Zapato
GO

USE KOALASA
GO
Create view Vw_Audit_Stock
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    CodigoZapato as 'Codigo De Zapato',
    Existencias,
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Stock
GO

USE KOALASA
GO
Create view Vw_Audit_Persona
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    Cedula ,
	Nombre ,
	Apellido1 as 'Primer Apellido',
	Tipo,
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Persona
GO


USE KOALASA
GO
Create view Vw_Audit_Compra
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    NumFactura as 'Numero de Factura',
    FechaDeEjecucion,
    Total,
    CedCliente 'Cedula Cliente',
	CedVendedor 'Cedula Vendedor',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Compra 
GO

USE KOALASA
GO
Create view Vw_Audit_Carrito
AS
Select
	AudID AS 'Identificador De Auditoria',
	NombreTabla AS 'Nombre de la tabla',
    Operacion,
    IdCarrito  'Codigo de carrito',
	NumFactura  'Numero de Factura',
    IdStock  as 'Çodigo en Inventario',
	Cantidad  ,
	SubTotal  As 'Sub Total',
    RealizadoPor 'Responsable',
    FechaDeEjecucion 'Fecha de Ejecucion'
From Audit_Carrito_Compra
GO
