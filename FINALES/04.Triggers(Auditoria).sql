USE KOALASA
GO
CREATE TRIGGER trg_Audit_Color
ON Color
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Color';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Color (NombreTabla, Operacion, CodigoColor, NombreColor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoColor, NombreColor, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Color (NombreTabla, Operacion, CodigoColor, NombreColor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoColor, NombreColor, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Color (NombreTabla, Operacion, CodigoColor, NombreColor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoColor, NombreColor, @User, GETDATE()
        FROM deleted;
    END;
END;
GO
Use KOALASA
GO

USE KOALASA
GO

CREATE TRIGGER trg_Audit_Tipo
ON Tipo
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Tipo';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Tipo (NombreTabla, Operacion, CodigoTipo, NombreTipo, CodProveedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoTipo, NombreTipo, CodProveedor, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Tipo (NombreTabla, Operacion, CodigoTipo, NombreTipo, CodProveedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoTipo, NombreTipo, CodProveedor, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Tipo (NombreTabla, Operacion, CodigoTipo, NombreTipo, CodProveedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoTipo, NombreTipo, CodProveedor, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Proveedor
ON Proveedor
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Proveedor'; 

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Proveedor (NombreTabla, Operacion, CodigoProveedor, NombreProv, CedulaJuridica, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoProveedor, NombreProv, CedulaJuridica, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Proveedor (NombreTabla, Operacion, CodigoProveedor, NombreProv, CedulaJuridica, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoProveedor, NombreProv, CedulaJuridica, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Proveedor (NombreTabla, Operacion, CodigoProveedor, NombreProv, CedulaJuridica, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoProveedor, NombreProv, CedulaJuridica, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Zapato
ON Zapato
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Zapato';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Zapato (NombreTabla, Operacion, CodigoZapato, PrecioUnitario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, PrecioUnitario, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Zapato (NombreTabla, Operacion, CodigoZapato, PrecioUnitario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, PrecioUnitario, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Zapato (NombreTabla, Operacion, CodigoZapato, PrecioUnitario, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, PrecioUnitario, @User, GETDATE()
        FROM deleted;
    END;
END;
GO

CREATE TRIGGER trg_Audit_Stock
ON Stock
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Stock';
 -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Stock (NombreTabla, Operacion, CodigoZapato, Existencias, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, Existencias, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Stock (NombreTabla, Operacion, CodigoZapato, Existencias, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, Existencias, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Stock (NombreTabla, Operacion, CodigoZapato, Existencias, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, CodigoZapato, Existencias, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Persona
ON Persona
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Persona';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Persona (NombreTabla, Operacion, Cedula, Nombre, Apellido1, Tipo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, Cedula, Nombre, Apellido1, Tipo, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Persona (NombreTabla, Operacion, Cedula, Nombre, Apellido1, Tipo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, Cedula, Nombre, Apellido1, Tipo, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Persona (NombreTabla, Operacion, Cedula, Nombre, Apellido1, Tipo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, Cedula, Nombre, Apellido1, Tipo, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Metodo_Pago
ON Metodo_Pago
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Metodo_Pago';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Metodo_Pago (NombreTabla, Operacion, NombreMetodo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, NombreMetodo, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Metodo_Pago (NombreTabla, Operacion, NombreMetodo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, NombreMetodo, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Metodo_Pago (NombreTabla, Operacion, NombreMetodo, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion,
        NombreMetodo, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Compra
ON Compra
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Compra';

    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Compra (NombreTabla, Operacion, NumFactura, Total, CedCliente, CedVendedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, NumFactura, Total, CedCliente, CedVendedor, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Compra (NombreTabla, Operacion, NumFactura, Total, CedCliente, CedVendedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, NumFactura, Total, CedCliente, CedVendedor, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Compra (NombreTabla, Operacion, NumFactura, Total, CedCliente, CedVendedor, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, NumFactura, Total, CedCliente, CedVendedor, @User, GETDATE()
        FROM deleted;
    END;
END;
GO


CREATE TRIGGER trg_Audit_Carrito_Compra
ON Carrito_Compra
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Operacion NVARCHAR(10);
    DECLARE @User NVARCHAR(128);
    DECLARE @TableName NVARCHAR(100) = 'Carrito_Compra';
    SET @User = SYSTEM_USER;

    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'INSERT';

        INSERT INTO Audit_Carrito_Compra (NombreTabla, Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, @User, GETDATE()
        FROM inserted;
    END;

    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @Operacion = 'UPDATE';

        INSERT INTO Audit_Carrito_Compra (NombreTabla, Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, @User, GETDATE()
        FROM inserted;
    END;

    -- DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @Operacion = 'DELETE';

        INSERT INTO Audit_Carrito_Compra (NombreTabla, Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, RealizadoPor, FechaDeEjecucion)
        SELECT @TableName, @Operacion, IdCarrito, NumFactura, IdStock, Cantidad, SubTotal, @User, GETDATE()
        FROM deleted;
    END;
END;
GO
