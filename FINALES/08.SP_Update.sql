
USE KOALASA
GO
CREATE PROCEDURE SP_BAJA_PROVEEDOR(
    @CodigoProveedor VARCHAR(15)
)
AS
BEGIN
    IF(@CodigoProveedor = '')
    BEGIN
        PRINT 'No se puede ingresar campos en blanco'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @CodigoProveedor)
    BEGIN
        PRINT 'El proveedor no existe'
        RETURN
    END
    ELSE
	---Falta ver si ya esta inactivo
    BEGIN
        UPDATE Proveedor 
        SET EstadoProveedor = 0
        WHERE CodigoProveedor = @CodigoProveedor
        PRINT 'Estado del proveedor Se ha dado de baja correctamente'
    END
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_REACTIVAR_PROVEEDOR(
    @CodigoProveedor VARCHAR(15)
)
AS
BEGIN
    IF(@CodigoProveedor = '')
    BEGIN
        PRINT 'No se puede ingresar campos en blanco'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @CodigoProveedor)
    BEGIN
        PRINT 'El proveedor no existe'
        RETURN
    END
    ELSE
	---Falta ver si ya esta activo
    BEGIN
        UPDATE Proveedor 
        SET EstadoProveedor = 1
        WHERE CodigoProveedor = @CodigoProveedor
        PRINT 'El proveedor se ha reactivado correctamente'
    END
END
GO
CREATE PROCEDURE SP_EDITAR_APELLIDOS_PERSONA @Cedula VARCHAR(15), @Apellido1 VARCHAR(20), @Apellido2 VARCHAR(20) = NULL
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    IF @Apellido1 = '' OR @Apellido2 = ''
        BEGIN
            PRINT 'No se permiten apellidos vacíos (si se desea omitir el segundo apellido, simplemente omitalo en los argumentos)'
            RETURN
        END

    ELSE
        BEGIN
            UPDATE Persona
            SET Apellido1 = @Apellido1, Apellido2 = @Apellido2
            WHERE Cedula = @Cedula;

            PRINT 'Se cambiaron los apellidos de la persona exitosamente'
        END

END
GO
-- Proveedor
USE KOALASA
GO
CREATE PROCEDURE SP_EDITARTELEFONO_PROVEEDOR(
@CodigoProveedor VARCHAR(10),
@NTelefono VARCHAR(20)
)
AS
IF(@CodigoProveedor='' OR @NTelefono='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @CodigoProveedor)
    BEGIN
    PRINT 'El Proveedor NO Existe'
    RETURN
    END
ELSE
BEGIN
    UPDATE Proveedor 
    SET Telefono = @NTelefono
	WHERE CodigoProveedor = @CodigoProveedor
    PRINT 'Telefono del proveedor actualizado Correctamente'
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_EDITARCORREO_PROVEEDOR(
@CodigoProveedor VARCHAR(10),
@NCorreo VARCHAR(30)
)
AS
IF(@CodigoProveedor='' OR @NCorreo='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @CodigoProveedor)
    BEGIN
    PRINT 'El Proveedor NO Existe'
    RETURN
    END
ELSE
BEGIN
    UPDATE Proveedor 
    SET Correo = @NCorreo
	WHERE CodigoProveedor = @CodigoProveedor
    PRINT 'Correo del proveedor actualizado Correctamente'
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_EDITARNOMBRE_PROVEEDOR(
@CodigoProveedor VARCHAR(10),
@NNombreProveedor VARCHAR(20)
)
AS
IF(@CodigoProveedor='' OR @NNombreProveedor='')
    BEGIN
    PRINT 'No Se pueden Ingresar Campos En Blanco'
    RETURN
END
IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @CodigoProveedor)
    BEGIN
    PRINT 'El Proveedor NO Existe'
    RETURN
    END
ELSE
BEGIN
    UPDATE Proveedor 
    SET NombreProv = @NNombreProveedor
	WHERE CodigoProveedor = @CodigoProveedor
    PRINT 'Nombre del proveedor actualizado Correctamente'
END
GO

-- Tipo

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_NOMBRE_TIPO @CodigoTipo INT, @NombreTipo VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Tipo WHERE CodigoTipo = @CodigoTipo)
        BEGIN
            PRINT 'El tipo no existe'
            RETURN
        END
    
    IF @NombreTipo = ''
        BEGIN
            PRINT 'No se permite un tipo vacio'
            RETURN
        END
    ELSE
        BEGIN
            UPDATE Tipo
            SET NombreTipo = @NombreTipo
            WHERE CodigoTipo = @CodigoTipo;
            PRINT 'Se cambio el nombre del tipo exitosamente'
        END
END
GO

-- 

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_PROVEEDOR_TIPO @CodigoTipo INT, @CodigoProveedor VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Tipo WHERE CodigoTipo = @CodigoTipo)
        BEGIN
            PRINT 'El tipo no existe'
            RETURN
        END
    
    IF @CodigoProveedor = ''
        BEGIN
            PRINT 'No se permite un proveedor vacio'
            RETURN
        END
     ELSE
        BEGIN
            UPDATE Tipo
            SET CodProveedor = @CodigoProveedor
            WHERE CodigoTipo = @CodigoTipo;

            PRINT 'Se cambio el tipo del proveedor exitosamente'
        END
END
GO

-- Color

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_NOMBRE_COLOR @CodigoColor INT, @NombreColor VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Color WHERE CodigoColor = @CodigoColor)
        BEGIN
            PRINT 'El color no existe'
            RETURN
        END
    
    IF @CodigoColor = ''
        BEGIN
            PRINT 'No se permite un nombre vacio'
            RETURN
        END
     ELSE
        BEGIN
            UPDATE Color
            SET NombreColor = @NombreColor
            WHERE CodigoColor = @CodigoColor;

            PRINT 'Se cambio el nombre del color exitosamente'
        END

END
GO

-- Zapato

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TIPO_ZAPATO @CodigoZapato varchar(10), @CodTipo INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Zapato WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'El zapato no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Zapato
            SET CodTipo = @CodTipo
            WHERE CodigoZapato = @CodigoZapato;

            PRINT 'Se cambio el tipo del zapato exitosamente'
    END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_COLOR_ZAPATO @CodigoZapato varchar(10), @CodColor INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Zapato WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'El zapato no existe'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Zapato
            SET CodColor = @CodColor
            WHERE CodigoZapato = @CodigoZapato;

            PRINT 'Se cambio el color del zapato exitosamente'

        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TALLA_ZAPATO @CodigoZapato varchar(10), @Talla INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Zapato WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'El zapato no existe'
            RETURN
        END
    

     ELSE
        BEGIN
            UPDATE Zapato
            SET Talla = @Talla
            WHERE CodigoZapato = @CodigoZapato;

            PRINT 'Se cambio la talla del zapato exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_PRECIO_ZAPATO @CodigoZapato varchar(10), @PrecioUnitario MONEY
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Zapato WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'El zapato no existe'
            RETURN
        END
    
     ELSE
        BEGIN
                UPDATE Zapato
                SET PrecioUnitario = @PrecioUnitario
                WHERE CodigoZapato = @CodigoZapato;
        
            PRINT 'Se cambio el precio del zapato exitosamente'
        END

END
GO

-- Stock

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_EXISTENCIAS_STOCK @CodigoZapato Varchar(15), @Existencias INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM STOCK WHERE CodigoZapato = @CodigoZapato)
        BEGIN
        PRINT 'El Zapato no existe en stock';
        RETURN;
    END
    ELSE
    BEGIN
        UPDATE Stock
        SET Existencias = @Existencias
        WHERE CodigoZapato = @CodigoZapato;

        DECLARE @NuevaExistencia INT;

        SELECT @NuevaExistencia = Existencias
        FROM Stock
        WHERE CodigoZapato = @CodigoZapato;

        PRINT 'Se cambiaron las existencias del stock exitosamente. Ahora el zapato cuenta con ' + CAST(@NuevaExistencia AS VARCHAR) + ' existencias.';
    END
END
GO

-- Persona

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_NOMBRE_PERSONA @Cedula VARCHAR(15), @Nombre VARCHAR(20)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    IF @Nombre = ''
        BEGIN
            PRINT 'No se permiten nombre vacíos'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Persona
            SET Nombre = @Nombre
            WHERE Cedula = @Cedula;

            PRINT 'Se cambio el nombre de la persona exitosamente'
        END

END
GO

-- 

USE KOALASA
GO

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_DIRECCION_PERSONA @Cedula VARCHAR(15),@NDireccion Varchar(15)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    IF @NDireccion = ''
        BEGIN
            PRINT 'No se permiten una direccion sin informacion'
            RETURN
        END

    ELSE
        BEGIN
            UPDATE Persona
            SET @NDireccion = @NDireccion
            WHERE Cedula = @Cedula;

            PRINT 'Se cambio la direccion de la persona exitosamente, nueva direccion: '+ @NDireccion+'.'
        END

END
GO

-- 

-- 

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_CORREO_PERSONA @Cedula VARCHAR(15), @Correo VARCHAR(30)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    IF @Correo = ''
        BEGIN
            PRINT 'No se permiten correos vacíos'
            RETURN
        END


     ELSE
        BEGIN
            UPDATE Persona
            SET Correo = @Correo
            WHERE Cedula = @Cedula;

            PRINT 'Se cambio el correo de la persona exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TELEFONO_PERSONA @Cedula VARCHAR(15), @Telefono VARCHAR(30)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    

     ELSE IF @Telefono = ''
        BEGIN
            PRINT 'No se permiten telefonos vacíos'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Persona
            SET Telefono = @Telefono
            WHERE Cedula = @Cedula;

            PRINT 'Se cambio el telefono del persona exitosamente'
        END

END
GO

-- 

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TIPO_PERSONA @Cedula VARCHAR(15), @Tipo CHAR(1)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    ELSE IF @Tipo != 'C' AND @Tipo != 'V'
        BEGIN
            PRINT 'Tipo invalido (se permiten los tipos C (cliente) y V (vendedor))'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Persona
            SET Tipo = @Tipo
            WHERE Cedula = @Cedula;

            PRINT 'Se cambio el rol de la persona exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_NOMBRE_METODO_PAGO @IdMetodoPago INT, @NombreMetodo VARCHAR(25)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Metodo_Pago WHERE IdMetodoPago = @IdMetodoPago)
        BEGIN
            PRINT 'El metodo de pago no existe'
            RETURN
        END
    
    ELSE IF @NombreMetodo = ''
        BEGIN
            PRINT 'No se permiten nombres vacíos'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Metodo_Pago
            SET NombreMetodo = @NombreMetodo
            WHERE IdMetodoPago = @IdMetodoPago;

            PRINT 'Se cambio el nombre del metodo de pago exitosamente'
        END

END
GO

-- Compra

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_FECHA_COMPRA @NumFactura INT, @Fecha DATE
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
        BEGIN
            PRINT 'La compra no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Compra
            SET Fecha = @Fecha
            WHERE NumFactura = @NumFactura;

            PRINT 'Se cambio la fecha de la compra exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TOTAL_COMPRA @NumFactura INT, @Total MONEY
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
        BEGIN
            PRINT 'La compra no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Compra
            SET Total = @Total
            WHERE NumFactura = @NumFactura;

            PRINT 'Se cambio el total de la compra exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_CLIENTE_COMPRA @NumFactura INT, @CedCliente VARCHAR(15)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
        BEGIN
            PRINT 'La compra no existe'
            RETURN
        END
    
    ELSE IF @CedCliente = ''
        BEGIN
            PRINT 'No se permite una cedula vacia'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Compra
            SET CedCliente = @CedCliente
            WHERE NumFactura = @NumFactura;

            PRINT 'Se cambio el cliente de la compra exitosamente'
        END
END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_VENDEDOR_COMPRA @NumFactura INT, @CedVendedor VARCHAR(15)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
        BEGIN
            PRINT 'La compra no existe'
            RETURN
        END
    
    ELSE IF @CedVendedor = ''
        BEGIN
            PRINT 'No se permite una cedula vacia'
            RETURN
        END

     ELSE
        BEGIN
            UPDATE Compra
            SET CedVendedor = @CedVendedor
            WHERE NumFactura = @NumFactura;

            PRINT 'Se cambio el vendedore de la compra exitosamente'
        END
END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_METODO_PAGO_COMPRA @NumFactura INT, @IdMetodoPago INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
        BEGIN
            PRINT 'La compra no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Compra
            SET IdMetodoPago = @IdMetodoPago
            WHERE NumFactura = @NumFactura;

            PRINT 'Se cambio el metodo de pago de la compra exitosamente'
        END

END
GO

-- Carrito_Compra

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_CANTIDAD_CARRITO @IdCarrito INT, @Cantidad INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Carrito_Compra WHERE IdCarrito = @IdCarrito)
        BEGIN
            PRINT 'El carrito no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Carrito_Compra
            SET Cantidad = @Cantidad
            WHERE IdCarrito = @IdCarrito;

            PRINT 'Se cambio la cantidad del carrito exitosamente'
        END

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_SUBTOTAL_CARRITO @IdCarrito INT, @SubTotal INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Carrito_Compra WHERE IdCarrito = @IdCarrito)
        BEGIN
            PRINT 'El carrito no existe'
            RETURN
        END
    
     ELSE
        BEGIN
            UPDATE Carrito_Compra
            SET SubTotal = @SubTotal
            WHERE IdCarrito = @IdCarrito;

            PRINT 'Se cambio el subtotal del carrito exitosamente'
        END

END
GO