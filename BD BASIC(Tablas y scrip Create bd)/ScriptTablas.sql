Use KOALASA
go
CREATE TABLE Proveedor (
    CodigoProveedor VARCHAR(10) NOT NULL,
    NombreProv VARCHAR(20) NOT NULL,
    CedulaJuridica VARCHAR(15) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
	EstadoProveedor BIT NOT NULL Default 1,
    Correo VARCHAR(50) NOT NULL,
    CONSTRAINT Pk_Proveedor_Codigo
    PRIMARY KEY CLUSTERED(CodigoProveedor)
)ON Proveedores;
GO

Use KOALASA
GO
CREATE TABLE Tipo (
    CodigoTipo INT NOT NULL IDENTITY (1,1),
    NombreTipo VARCHAR(10) NOT NULL,
    CodProveedor VARCHAR(10) NOT NULL,
    CONSTRAINT FK_TipoProveedor_CodProveedor
    FOREIGN KEY (CodProveedor) REFERENCES Proveedor(CodigoProveedor)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT PK_Tipo_Codigo
    PRIMARY KEY CLUSTERED(CodigoTipo)
)ON Stock;
GO


Use KOALASA
GO
CREATE TABLE Color (
    CodigoColor INT IDENTITY(1,1) NOT NULL,
    NombreColor VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Color_Codigo
    PRIMARY KEY CLUSTERED(CodigoColor)
)ON Stock;
GO		
Use KOALASA
GO
CREATE TABLE Zapato (
    CodigoZapato VARCHAR(10) NOT NULL,
    CodTipo INT NOT NULL,
    CodColor INT NOT NULL,
	Talla INT NOT NULL,
	PrecioUnitario money not null
    CONSTRAINT FK_ZapatoTipo_CodTipo
    FOREIGN KEY (CodTipo) REFERENCES Tipo(CodigoTipo)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_ZapatoColor_CodColor
    FOREIGN KEY (CodColor) REFERENCES Color(CodigoColor)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT PK_Zapato_Codigo
    PRIMARY KEY CLUSTERED(CodigoZapato)
)ON Stock;
GO


Use KOALASA
GO
CREATE TABLE Stock (
    IdStock INT NOT NULL IDENTITY (1,1),
    CodigoZapato VARCHAR(10) NOT NULL,
    Existencias INT NOT NULL DEFAULT 0,
    FOREIGN KEY (CodigoZapato) REFERENCES Zapato(CodigoZapato)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT PK_Inventario_IDArticulo
    PRIMARY KEY CLUSTERED(IdStock)
)ON Stock;
GO

USE KOALASA
GO
CREATE TABLE Persona (
	Cedula VARCHAR(15) NOT NULL,
	Cedula Varchar(15) not null,
	Nombre varchar(20) not null,
	Apellido1 varchar(20) not null,
	Apellido2 varchar(20) null,
	Correo varchar(30) not null,
	Telefono Varchar(20) not null,
	Tipo Char(1) not null,
	CONSTRAINT PK_Persona_Cedula
    PRIMARY KEY CLUSTERED(Cedula)
)on Personas
GO

Use KOALASA
GO
CREATE TABLE Metodo_Pago (
    IdMetodoPago INT NOT NULL IDENTITY (1,1),
    NombreMetodo VARCHAR(25) NOT NULL,
    CONSTRAINT PK_MetodoPago_ID
    PRIMARY KEY CLUSTERED(IdMetodoPago)
)ON Ventas;
GO

Use KOALASA
GO
CREATE TABLE Compra (
    NumFactura INT NOT NULL identity(1,1),
    Fecha DATE NOT NULL,
    Total money NOT NULL,
    CedCliente VARCHAR(15) NOT NULL,
	CedVendedor VARCHAR(15) NOT NULL,
    IdMetodoPago INT NOT NULL,
	CONSTRAINT FK_MetodoCarrito_IDMetodoPago
    FOREIGN KEY (IdMetodoPago) REFERENCES Metodo_Pago(IdMetodoPago)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_VendedorCompra_CodVendedor
    FOREIGN KEY (CedVendedor) REFERENCES Persona(Cedula),
    CONSTRAINT Fk_ClienteCompra_CodCliente
    FOREIGN KEY (CedCliente) REFERENCES Persona(Cedula),
    CONSTRAINT PK_Compra_NumFactura
    PRIMARY KEY CLUSTERED(NumFactura)
)ON Ventas;
GO

Use KOALASA
GO
CREATE TABLE Carrito_Compra (
    IdCarrito INT NOT NULL IDENTITY(1,1),
	NumFactura INT null,
    IdStock INT not null,
	Cantidad int not null,
	SubTotal Money not null,
    CONSTRAINT FK_Factura_NumFactura
    FOREIGN KEY (NumFactura) REFERENCES Compra(NumFactura)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT FK_Stock_IdStock
    FOREIGN KEY (IdStock) REFERENCES Stock(IdStock)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT Pk_Carrito_Compra_IdCarrito
    PRIMARY KEY CLUSTERED(IdCarrito)
)ON Ventas;
GO
