USE KOALASA
GO
use KOALASA
go
CREATE PROCEDURE SP_INGRESAR_PROVEEDOR(
    @NCodigoProveedor VARCHAR(10),
    @NNombreProveedor VARCHAR(20),
    @NCedulaJuridica VARCHAR(15),
    @NTelefono VARCHAR(20),
    @NCorreo VARCHAR(50)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF(@NCedulaJuridica = '' OR @NCodigoProveedor = '' OR @NNombreProveedor = '' OR @NTelefono = '' OR @NCorreo = '')
        BEGIN
            PRINT 'No Se pueden Ingresar Campos En Blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		 IF (@NCorreo NOT LIKE '%_@__%.__%')
        BEGIN
            PRINT 'El Correo Electrónico No Es Válido';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		 IF (@NTelefono NOT LIKE '%[0-9]%')
        BEGIN
            PRINT 'El Número de Teléfono No Es Válido';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @NCodigoProveedor)
        BEGIN
            PRINT 'El Proveedor Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		IF EXISTS (SELECT 1 FROM Proveedor WHERE NombreProv = @NNombreProveedor)
        BEGIN
            PRINT 'El Nombre del Proveedor Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        IF EXISTS (SELECT 1 FROM Proveedor WHERE CedulaJuridica = @NCedulaJuridica)
        BEGIN
            PRINT 'La Cédula Jurídica Ya Está Asociada a Otro Proveedor';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        IF EXISTS (SELECT 1 FROM Proveedor WHERE Correo = @NCorreo)
        BEGIN
            PRINT 'El Correo Ya Está Asociado a Otro Proveedor';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        INSERT INTO Proveedor (CodigoProveedor, NombreProv, CedulaJuridica, Telefono, Correo)
        VALUES (@NCodigoProveedor, @NNombreProveedor, @NCedulaJuridica, @NTelefono, @NCorreo);
        COMMIT TRANSACTION;
         PRINT 'Proveedor registrado correctamente: Código ' + @NCodigoProveedor + ', Nombre ' + @NNombreProveedor;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_TIPO(
    @NNombreTipo VARCHAR(10),
    @NCodProveedor VARCHAR(10)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF(@NNombreTipo = '' OR @NCodProveedor = '')
        BEGIN
            PRINT 'No Se pueden Ingresar Campos En Blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Tipo WHERE NombreTipo = @NNombreTipo)
        BEGIN
            PRINT 'El Tipo Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Proveedor WHERE CodigoProveedor = @NCodProveedor)
        BEGIN
            PRINT 'El Proveedor No Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        INSERT INTO Tipo (NombreTipo, CodProveedor)
        VALUES (@NNombreTipo, @NCodProveedor);
        COMMIT TRANSACTION;
        PRINT 'Tipo '+@NNombreTipo+' Registrado Correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_COLOR(
    @NNombreColor VARCHAR(10)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF(@NNombreColor = '')
        BEGIN
            PRINT 'No Se pueden Ingresar Campos En Blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Color WHERE NombreColor = @NNombreColor)
        BEGIN
            PRINT 'El Color Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        INSERT INTO Color (NombreColor)
        VALUES (@NNombreColor);
        COMMIT TRANSACTION;
        PRINT 'Color '+@NNombreColor+' Registrado Correctamente';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO


USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_ZAPATO(
    @NCodTipo INT,
    @NCodColor INT,
    @NTalla INT,
    @NPrecioUnitario MONEY
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@NCodTipo = '' OR @NCodColor = ''OR @NTalla = '' OR @NPrecioUnitario = '')
        BEGIN
            PRINT 'No Se pueden Ingresar Campos En Blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		IF(@NTalla<1)
		BEGIN
			PRINT 'Las tallas no pueden ser ni 0 ni numeros negativos, en caso de talla a la medida digite 99'
			ROLLBACK TRANSACTION
			RETURN;
		END
        IF NOT EXISTS (SELECT 1 FROM Color WHERE CodigoColor= @NCodColor)
        BEGIN
            PRINT 'El Color no Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Tipo WHERE CodigoTipo = @NCodTipo)
        BEGIN
            PRINT 'El Tipo no Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        DECLARE @NCodigoZapato VARCHAR(20)
        SET @NCodigoZapato = CAST(@NCodTipo AS VARCHAR) + '-' + CAST(@NCodColor AS VARCHAR) + '-' + CAST(@NTalla AS VARCHAR)
        IF EXISTS (SELECT 1 FROM Zapato WHERE CodigoZapato = @NCodigoZapato)
        BEGIN
            PRINT 'El Zapato Ya Existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		DECLARE @NombreTipo VARCHAR(20), @NombreColor VARCHAR(20);
        SELECT @NombreTipo = NombreTipo FROM Tipo WHERE CodigoTipo = @NCodTipo;
        SELECT @NombreColor = NombreColor FROM Color WHERE CodigoColor = @NCodColor;
        INSERT INTO Zapato (CodigoZapato, CodTipo, CodColor, Talla, PrecioUnitario)
        VALUES (@NCodigoZapato, @NCodTipo, @NCodColor, @NTalla, @NPrecioUnitario);
        COMMIT TRANSACTION;
        PRINT 'Zapato Registrado Correctamente codigo de zapato '
		+ CAST(@NCodigoZapato AS Varchar)
		+', Tipo: ' +CAST(@NombreTipo  AS Varchar)
		+ ', Color: ' + @NombreColor 
		+', Talla: '+CAST(@NTalla AS Varchar);
		IF (@NTalla=99)
		PRINT 'Talla a la medida'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_STOCK(
    @CodigoZapato VARCHAR(10),
    @Existencias INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@CodigoZapato = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM Zapato WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'No existe ningun zapato con el codigo' + @CodigoZapato;
            ROLLBACK TRANSACTION;
            RETURN;
        END
		 IF EXISTS (SELECT 1 FROM Stock WHERE CodigoZapato = @CodigoZapato)
        BEGIN
            PRINT 'El Zapato ya tiene un stock asociado';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF @Existencias < 0
        BEGIN
            PRINT 'No se pueden ingresar cantidades negativas';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        INSERT INTO Stock (CodigoZapato, Existencias)
        VALUES (@CodigoZapato, @Existencias);
        COMMIT TRANSACTION;
        PRINT 'Stock Ingresado Correctamente. Se añadieron ' + CAST(@Existencias AS VARCHAR) + ' Unidades con Codigo ' + @CodigoZapato;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO



USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_PERSONA(
    @NCedula VARCHAR(15),
    @NNombre VARCHAR(20),
    @NApellido1 VARCHAR(20),
    @NApellido2 VARCHAR(20),
    @NCorreo VARCHAR(30),
    @NTelefono VARCHAR(20),
    @NTipo CHAR(1)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@NCedula IS NULL OR @NNombre = '' OR @NApellido1 = '' OR @NCorreo = '' OR @NTelefono = '' OR @NTipo = '')
        BEGIN
            PRINT 'No Se pueden Ingresar Campos En Blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		  IF @NTipo NOT IN ('C', 'V')
        BEGIN
            PRINT 'El tipo debe ser "C" (Cliente) o "V" (Vendedor)';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		IF @NTipo = 'V' AND USER_NAME() = 'Vendedor'
        BEGIN
            PRINT 'No tienes permiso para ingresar personas tipo Vendedor';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Persona WHERE Cedula = @NCedula)
        BEGIN
            PRINT 'La Cedula Ya esta asociada a Alguien';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        INSERT INTO Persona(Cedula, Nombre, Apellido1, Apellido2, Correo, Telefono, Tipo)
        VALUES (@NCedula, @NNombre, @NApellido1, @NApellido2, @NCorreo, @NTelefono, @NTipo);
        COMMIT TRANSACTION;
        PRINT 'Registro de '+@NNombre+' Exitoso';
		IF(@NTipo='C')
		PRINT @NNombre+' Se Registro Como Cliente'
		Else
		PRINT @NNombre+' Se Registro Como Vendedor'
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_AñADIR_METODO_PAGO(
    @NMetodoPago VARCHAR(25)
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@NMetodoPago = '')
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM Metodo_Pago WHERE NombreMetodo = @NMetodoPago)
        BEGIN
            PRINT 'El Metodo de Pago ya existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        INSERT INTO Metodo_Pago (NombreMetodo)
        VALUES (@NMetodoPago);
        COMMIT TRANSACTION;
        PRINT 'Metodo de Pago agregado exitosamente ya se pueden cancelar las compras con el metodo '+@NMetodoPago;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END
GO


USE KOALASA
GO
CREATE PROCEDURE SP_INGRESAR_ARTICULO_A_CARRITO(
    @IdStock INT,
    @Cantidad INT
)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        IF (@IdStock ='' OR @Cantidad ='' OR @Cantidad <= 0)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco o cantidad negativa/cero';
            ROLLBACK TRANSACTION;
            RETURN;
        END
		 IF NOT EXISTS (SELECT 1 FROM Stock WHERE IdStock = @IdStock)
        BEGIN
            PRINT 'El IdStock no existe';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        
        DECLARE @CodigoZapato VARCHAR(10);
        DECLARE @PrecioUnitario MONEY;
        DECLARE @UnidadesDisponibles INT;
        SELECT @CodigoZapato = s.CodigoZapato, @UnidadesDisponibles = s.Existencias
        FROM Stock s
        WHERE s.IdStock = @IdStock;
        IF @Cantidad > @UnidadesDisponibles
        BEGIN
            PRINT 'No hay suficientes unidades en stock';
            ROLLBACK TRANSACTION;
            RETURN;
        END
        SELECT @PrecioUnitario = PrecioUnitario
        FROM Zapato
        WHERE CodigoZapato = @CodigoZapato;
        DECLARE @SubTotal MONEY;
        SET @SubTotal = @PrecioUnitario * @Cantidad;
        INSERT INTO Carrito_Compra (IdStock, Cantidad, SubTotal)
        VALUES (@IdStock, @Cantidad, @SubTotal);
        UPDATE Stock
        SET Existencias = Existencias - @Cantidad
        WHERE IdStock = @IdStock;
        COMMIT TRANSACTION;
        PRINT 'Artículo agregado al carrito exitosamente';
		PRINT 'Resumen de compra SubTotal: '+CAST(@SubTotal as Varchar)+', Articulos: '+CAST(@Cantidad AS VARCHAR)+' Pares de Zapatos Codigo'+@CodigoZapato
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END;
GO

USE KOALASA
GO
CREATE PROCEDURE SP_GENERAR_COMPRA(
    @CodigoCliente INT,
    @CodigoVendedor INT,
    @IdMetodoPago INT
)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        IF (@IdMetodoPago IS NULL)
        BEGIN
            PRINT 'No se pueden ingresar campos en blanco';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        IF NOT EXISTS (SELECT 1 FROM Persona WHERE Cedula = @CodigoVendedor AND Tipo = 'V')
        BEGIN
            PRINT 'El vendedor no es válido';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        IF NOT EXISTS (SELECT 1 FROM Persona WHERE Cedula = @CodigoCliente AND Tipo = 'C')
        BEGIN
            PRINT 'El cliente no es válido';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        IF NOT EXISTS (SELECT 1 FROM Carrito_Compra WHERE NumFactura IS NULL)
        BEGIN
            PRINT 'No hay artículos en el carrito';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        DECLARE @Total MONEY;
        SELECT @Total = SUM(SubTotal)
        FROM Carrito_Compra
        WHERE NumFactura IS NULL;
        INSERT INTO Compra (Fecha, Total, CedCliente, CedVendedor, IdMetodoPago)
        VALUES (GETDATE(), @Total, @CodigoCliente, @CodigoVendedor, @IdMetodoPago);
        DECLARE @NumFactura INT;
        SET @NumFactura = SCOPE_IDENTITY();
        UPDATE Carrito_Compra
        SET NumFactura = @NumFactura
        WHERE NumFactura IS NULL;
        COMMIT TRANSACTION;

        PRINT 'Factura '+Cast(@NumFactura as VARCHAR)+' generada exitosamente, Total: '+CAST(@Total AS VARCHAR);
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        PRINT 'Ha ocurrido un error: ' + @ErrorMessage;
    END CATCH
END;
GO
