---Tablas de auditoria
USE KOALASA;
GO
CREATE TABLE Audit_Color (
    AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    CodigoColor INT,
    NombreColor VARCHAR(10),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_COLOR_ID
	PRIMARY KEY CLUSTERED(AudID)
)ON Auditorias;
GO


Use KOALASA
GO
CREATE TABLE Audit_Tipo (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    CodigoTipo INT,
    NombreTipo VARCHAR(10),
	CodProveedor VARCHAR(10),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_TIPO_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Proveedor (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    CodigoProveedor VARCHAR(10),
    NombreProv VARCHAR(20),
	CedulaJuridica VARCHAR(15),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_PROVEEDOR_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Zapato (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    CodigoZapato VARCHAR(10),
    PrecioUnitario money,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_ZAPATO_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO


Use KOALASA
GO
CREATE TABLE Audit_Stock (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    CodigoZapato VARCHAR(10),
    Existencias INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_Stock_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Persona (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    Cedula int,
	Nombre varchar(20),
	Apellido1 varchar(20),
    Tipo Char(1) not null,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_Persona_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Metodo_Pago (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
	NombreMetodo VARCHAR(25),
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_MPAGO_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Compra (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    NumFactura INT,
    Total money,
    CedCliente INT,
	CedVendedor INT,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_COMPRA_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO

Use KOALASA
GO
CREATE TABLE Audit_Carrito_Compra (
	AudID INT IDENTITY(1,1),
	NombreTabla NVARCHAR(100),
    Operacion NVARCHAR(10),
    IdCarrito INT,
	NumFactura INT,
    IdStock INT,
	Cantidad int,
	SubTotal Money,
    RealizadoPor NVARCHAR(128),
    FechaDeEjecucion DATETIME
	CONSTRAINT PK_AUDITORIA_CARRITO_COMPRA_ID
	PRIMARY KEY clustered(AudID)
)ON Auditorias;
GO
