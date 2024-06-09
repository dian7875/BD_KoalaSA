USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_PROVEEDOR(
@NCodigoProveedor VARCHAR(10),
@NNombreProveedor VARCHAR(20),
@NCedulaJuridica VARCHAR(15),
@NTelefono VARCHAR(20),
@NCorreo VARCHAR(50)
)
AS
IF(@NCedulaJuridica='' OR @NCodigoProveedor='' OR @NNombreProveedor='' OR @NTelefono='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @NCodigoProveedor)
    BEGIN
    PRINT 'El Proveedor Ya Existe'
    RETURN
    END
ELSE
BEGIN
    insert INTO Proveedor (CodigoProveedor,NombreProv,CedulaJuridica,Telefono,Correo)
    VALUES(@NCodigoProveedor,@NNombreProveedor,@NCedulaJuridica,@NTelefono,@NCorreo)
    PRINT 'Proveedor Registrado Correctamente'
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_TIPO(
@NNombreTipo VARCHAR(10),
@NCodProveedor VARCHAR(10)
)
AS
IF(@NNombreTipo='' OR @NCodProveedor='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF EXISTS (SELECT 1 FROM Tipo WHERE NombreTipo = @NNombreTipo)
    BEGIN
    PRINT 'El Tipo Ya Existe'
    RETURN
    END
	---Incluir Verificacion del Proveedor
ELSE
BEGIN
    insert INTO Tipo (NombreTipo,CodProveedor)
    VALUES(@NNombreTipo, @NCodProveedor)
    PRINT 'Tipo Registrado Correctamente'
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_COLOR(
@NNombreColor VARCHAR(10)
)
AS
IF(@NNombreColor='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF EXISTS (SELECT 1 FROM Color WHERE NombreColor = @NNombreColor)
    BEGIN
    PRINT 'El Color Ya Existe'
    RETURN
    END
ELSE
BEGIN
    insert INTO Color (NombreColor)
    VALUES(@NNombreColor)
    PRINT 'Color Registrado Correctamente'
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_ZAPATO(
 @NCodTipo INT,
 @NCodColor INT,
 @NTalla INT,
 @NPrecioUnitario money
)
AS
IF(@NCodTipo='' OR @NTalla='' OR @NTalla='' or @NPrecioUnitario='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
--Validar Color y tipo
    DECLARE @NCodigoZapato VARCHAR(10)
    SET @NCodigoZapato = CAST(@NCodTipo AS VARCHAR) + CAST(@NCodColor AS VARCHAR) + '-' + CAST(@NTalla AS VARCHAR)
    IF EXISTS (SELECT 1 FROM Zapato WHERE CodigoZapato = @NCodigoZapato)
    BEGIN
    PRINT 'El Zapato Ya existe'
    RETURN
    END
	BEGIN
    INSERT INTO Zapato(CodigoZapato,CodTipo,CodColor,Talla,PrecioUnitario)
    VALUES (@NCodigoZapato,@NCodTipo,@NCodColor, @NTalla, @NPrecioUnitario)
    PRINT 'Tipo de Zapato Registrado Correctamente'
END
GO

use KOALASA
GO
create procedure SP_IngresarStock(
@CodigoZapato Varchar(10),
@Existencias INT
)
as
IF(@CodigoZapato='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
ELSE
BEGIN
 insert INTO Stock(CodigoZapato,Existencias)
    VALUES(@CodigoZapato,@Existencias)
    PRINT 'Stock Ingresado Correctamente se añadieron '
	+cast(@Existencias as Varchar)+'Unidades con Codigo '
	+ @CodigoZapato
END
GO

Use KOALASA
go
CREATE PROCEDURE SP_INGRESAR_PERSONA(
@NCedula int,
@NNombre varchar(20),
@NApellido1 varchar(20),
@NApellido2 varchar(20),
@NCorreo varchar(30),
@NTelefono Varchar(20)
)
AS
IF(@NCedula='' or @NApellido1='' OR @NNombre='' OR @NCorreo='' OR @NTelefono='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
RETURN 
END
ELSE
BEGIN
 insert INTO Persona(Cedula,Nombre,Apellido1,Apellido2,Correo,Telefono)
    VALUES(@NCedula,@NNombre,@NApellido1,@NApellido2,@NCorreo,@NTelefono)
    PRINT 'Registro de Persona Existoso '
END
GO

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

USE KOALASA
GO
CREATE PROCEDURE SP_AñADIR_METODO_PAGO(
@NMetodoPago varchar(25) 
)
AS
IF(@NMetodoPago='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
RETURN 
END
ELSE
BEGIN
 INSERT INTO Metodo_Pago(NombreMetodo)
 values (@NMetodoPago)
 Print 'Metodo De pago Agregado Exitosamente'
END
GO


USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_ARTICULO_A_CARRITO(
@IdStock int,
@Cantidad int
)
AS
BEGIN
    IF (@IdStock IS NULL OR @Cantidad IS NULL OR @Cantidad <= 0)
    BEGIN
        PRINT 'No se pueden ingresar campos en blanco o cantidad negativa/cero';
        RETURN;
    END
    DECLARE @CodigoZapato Varchar;
    DECLARE @PrecioUnitario MONEY;
    SELECT @CodigoZapato = s.CodigoZapato, @PrecioUnitario = z.PrecioUnitario
    FROM Stock s
    JOIN Zapato z ON s.CodigoZapato = z.CodigoZapato
    WHERE s.IdStock = @IdStock;
    IF (@PrecioUnitario IS NULL)
    BEGIN
        PRINT 'Zapato no encontrado';
        RETURN;
    END
    DECLARE @SubTotal MONEY;
    SET @SubTotal = @PrecioUnitario * @Cantidad;
    INSERT INTO Carrito_Compra (IdStock, Cantidad, SubTotal)
    VALUES (@IdStock, @Cantidad, @SubTotal);

    PRINT 'Artículo agregado al carrito exitosamente';
END;
GO

select * from Carrito_Compra
drop procedure SP_INGRESAR_ARTICULO_A_CARRITO
USE KOALASA
GO
CREATE PROCEDURE SP_GENERAR_COMPRA(
@Fecha DATE,
@Total money,
@CodigoCliente varchar(15),
@CodigoVendedor varchar(15),
@IdMetodoPago INT
)
AS
IF(@IdMetodoPago='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
RETURN 
END
ELSE
BEGIN
 INSERT INTO Compra(Fecha,Total,CodigoCliente,CodigoVendedor,IdMetodoPago)
 values (@Fecha,@Total,@CodigoCliente,@CodigoVendedor,@IdMetodoPago)
 Print 'Compra Generada Exitosamente'
END
GO



