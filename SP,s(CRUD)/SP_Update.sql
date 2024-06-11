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