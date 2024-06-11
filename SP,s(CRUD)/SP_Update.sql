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
Execute SP_EDITARTELEFONO_PROVEEDOR 'P-0687','NTELEFONO'

select * from Proveedor

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


Execute SP_EDITARCORREO_PROVEEDOR 'P-0687','NCORREO'

select * from Proveedor


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
Execute SP_EDITARNOMBRE_PROVEEDOR'P-0687','NNombre'

select * from Proveedor


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

execute SP_BAJA_PROVEEDOR 'P-0687'
select * from Proveedor


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

Execute SP_REACTIVAR_PROVEEDOR 'P-0687'
select * from Proveedor

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

    UPDATE Tipo
    SET NombreTipo = @NombreTipo
    WHERE CodigoTipo = @CodigoTipo;

    PRINT 'Se cambio el nombre del tipo exitosamente'
END
GO

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

    UPDATE Tipo
    SET NombreTipo = @NombreTipo
    WHERE CodigoTipo = @CodigoTipo;

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

    UPDATE Tipo
    SET CodProveedor = @CodigoProveedor
    WHERE CodigoTipo = @CodigoTipo;

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

    UPDATE Color
    SET NombreColor = @NombreColor
    WHERE CodigoColor = @CodigoColor;

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
    
    UPDATE Zapato
    SET CodTipo = @CodTipo
    WHERE CodigoZapato = @CodigoZapato;

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
    
    UPDATE Zapato
    SET CodColor = @CodColor
    WHERE CodigoZapato = @CodigoZapato;

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
    
    UPDATE Zapato
    SET Talla = @Talla
    WHERE CodigoZapato = @CodigoZapato;

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
    
    UPDATE Zapato
    SET PrecioUnitario = @PrecioUnitario
    WHERE CodigoZapato = @CodigoZapato;

END
GO

-- Stock


-- Puede que sea innecesario tener este...
USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_ZAPATO_STOCK @IdStock INT, @CodigoZapato VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM STOCK WHERE IdStock = @IdStock)
        BEGIN
            PRINT 'El stock no existe'
            RETURN
        END
    
    UPDATE Stock
    SET CodigoZapato = @CodigoZapato
    WHERE IdStock = @IdStock;

END
GO

--

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_EXISTENCIAS_STOCK @IdStock INT, @Existencias INT
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM STOCK WHERE IdStock = @IdStock)
        BEGIN
            PRINT 'El stock no existe'
            RETURN
        END
    
    UPDATE Stock
    SET Existencias = @Existencias
    WHERE IdStock = @IdStock;

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

    UPDATE Persona
    SET Nombre = @Nombre
    WHERE Cedula = @Cedula;

END
GO

-- 

USE KOALASA
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

    UPDATE Persona
    SET Apellido1 = @Apellido1, Apellido2 = @Apellido2
    WHERE Cedula = @Cedula;

END
GO

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

    UPDATE Persona
    SET Correo = @Correo
    WHERE Cedula = @Cedula;

END
GO

-- 

USE KOALASA
GO

CREATE PROCEDURE SP_EDITAR_TELEFONO_PERSONA @Cedula VARCHAR(15), @Tipo CHAR(1)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Persona WHERE Cedula = @Cedula)
        BEGIN
            PRINT 'La persona no existe'
            RETURN
        END
    
    IF @Tipo != 'C' AND @Tipo != 'V'
        BEGIN
            PRINT 'Tipo invalido (se permiten los tipos C (cliente) y V (vendedor))'
            RETURN
        END

    UPDATE Persona
    SET Telefono = @Telefono
    WHERE Cedula = @Cedula;

END
GO