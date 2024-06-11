--Delete Proveedor
USE KOALASA
GO

CREATE PROCEDURE SP_DELETE_Proveedor (
    @CodProveedor VARCHAR(10)
)
AS
BEGIN
    IF(@CodProveedor IS NULL OR @CodProveedor = 0)
    BEGIN
        PRINT 'El código del proveedor no puede ser un campo vacío o ser cero'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE @CodProveedor = @CodProveedor)
    BEGIN
        PRINT 'El registro ingresado no existe'
        RETURN
    END

    BEGIN TRANSACTION

    BEGIN TRY

        DELETE FROM Proveedor
        WHERE CodigoProveedor = @CodProveedor

        COMMIT TRANSACTION

        PRINT 'Registro eliminado exitosamente!!'
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()

        PRINT 'Error al eliminar el registro' + @ErrorMessage

        RAISERROR (@ErrorMessage, @ErrorSeverity, 1)
    END CATCH
END
GO

EXEC SP_DELETE_Proveedor @CodProveedor = 1


--Delete Compra
USE KOALASA
GO

CREATE PROCEDURE SP_DELETE_Compra (
    @NumFactura INT
)
AS
BEGIN
    IF (@NumFactura IS NULL OR @NumFactura = 0)
    BEGIN
        PRINT 'El Numero de Factura no puede ser un campo vacío o ser cero'
        RETURN
    END
    
    IF NOT EXISTS (SELECT 1 FROM Compra WHERE NumFactura = @NumFactura)
    BEGIN
        PRINT 'El registro ingresado no existe'
        RETURN
    END

    BEGIN TRANSACTION

    BEGIN TRY
        DELETE FROM Compra
        WHERE NumFactura = @NumFactura

        COMMIT TRANSACTION

        PRINT 'Registro eliminado exitosamente!!'
    END TRY
    BEGIN CATCH

        ROLLBACK TRANSACTION
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el registro: ' + @ErrorMessage

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

EXEC SP_DELETE_Compra @NumFactura = 1

--DELETE ZAPATO
USE KOALASA
GO
CREATE PROCEDURE SP_DELETE_ZAPATO(
@CodigoZapato varchar(10)
)
AS
BEGIN 
        IF (@CodigoZapato IS NULL OR @CodigoZapato = 0)
        BEGIN
        PRINT 'El código del zapato no puede ser vacio ni 0'
        RETURN
END

BEGIN TRANSACTION

BEGIN TRY
        DELETE FROM Zapato
        WHERE CodigoZapato = @CodigoZapato
        COMMIT TRANSACTION

        PRINT'Registro eliminado exitosamente!!'

END TRY
BEGIN CATCH 
 ROLLBACK TRANSACTION
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el registro: ' + @ErrorMessage

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

EXEC SP_DELETE_Zapato @CodigoZapato = 1

--DELETE TIPO
USE KOALASA
GO
CREATE PROCEDURE SP_DELETE_Tipo(
@CodigoTipo INT
)
AS
BEGIN 
         IF (@CodigoTipo IS NULL OR @CodigoTipo = 0)
         BEGIN
         PRINT 'El código del tipo de zapato no puede ser vacio ni 0'
         RETURN
END

BEGIN TRANSACTION

BEGIN TRY
          DELETE FROM Tipo
          WHERE CodigoTipo = @CodigoTipo
          COMMIT TRANSACTION

          PRINT'Tipo de zapato eliminado exitosamente!!'

END TRY
BEGIN CATCH 
 ROLLBACK TRANSACTION
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el registro: ' + @ErrorMessage

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

EXEC SP_DELETE_Tipo @CodigoTipo = 1



--DELETE COLOR
USE KOALASA
GO
CREATE PROCEDURE SP_DELETE_Color(
@CodigoColor INT
)
AS
BEGIN 
        IF (@CodigoColor IS NULL OR @CodigoColor = 0)
        BEGIN
        PRINT 'El código del color del zapato no puede ser vacio ni 0'
        RETURN
END

BEGIN TRANSACTION

BEGIN TRY
        DELETE FROM Color
        WHERE CodigoColor = @CodigoColor
COMMIT TRANSACTION

        PRINT'Color de zapato eliminado exitosamente!!'

END TRY
BEGIN CATCH 
 ROLLBACK TRANSACTION
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT 'Error al eliminar el registro: ' + @ErrorMessage

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

EXEC SP_DELETE_Color @CodigoColor = 1