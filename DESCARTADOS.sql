--Tablas Clientes y Vendedor
Use KOALASA
GO
CREATE TABLE Cliente (
    CodigoCliente VARCHAR(15) NOT NULL,
	CedulaCliente int not null,
	EstadoCliente bit not null Default 1
    CONSTRAINT PK_Cliente_Codigo
    PRIMARY KEY CLUSTERED(CodigoCliente)
	CONSTRAINT FK_Persona_Cliente 
	FOREIGN KEY(CedulaCliente) REFERENCES Persona(Cedula)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
)ON Clientes;
GO

Use KOALASA
GO
CREATE TABLE Vendedor (
	CodigoVendedor Varchar(15) not null,
	CedulaVendedor int not null,
	EstadoVendedor bit not null DEFAULT 1
    CONSTRAINT PK_Vendedor_Codigo
    PRIMARY KEY CLUSTERED(CodigoVendedor),
	CONSTRAINT FK_Persona_Vendedor 
	FOREIGN KEY(CedulaVendedor) REFERENCES Persona(Cedula)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
)ON Vendedores;
GO
--Procedimientos Create
use KOALASA
execute sp_help Cliente

---En caso de usar CLientes y Vendedor

USE KOALASA
GO
CREATE PROCEDURE SP_REGISTRAR_Cliente(
@CodigoCliente VARCHAR(15),
@CedulaCliente int
)
AS
IF(@CodigoCliente='' or @CedulaCliente='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
RETURN 
END
ELSE
BEGIN
 insert INTO Cliente(CodigoCliente,CedulaCliente)
	VALUES (@CodigoCliente,@CedulaCliente) 
	Print 'Cliente codigo '+ @CodigoCliente+ 'Registrado Correctamente' 
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_REGISTRAR_VENDEDOR(
@CodigoVendedor VARCHAR(15),
@CedulaVendedor int
)
AS
IF(@CodigoVendedor='' or @CedulaVendedor='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
RETURN 
END
ELSE
BEGIN
 INSERT INTO Vendedor(CodigoVendedor,CedulaVendedor)
	VALUES (@CodigoVendedor,@CedulaVendedor) 
	Print 'Cliente codigo '+ @CodigoVendedor+ 'Registrado Correctamente' 
END
GO