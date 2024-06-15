
USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'KOALAADMIN')
BEGIN
    CREATE LOGIN KOALAADMIN WITH PASSWORD = 'Alpha'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'cliente')
BEGIN
    CREATE LOGIN cliente WITH PASSWORD = 'EstoDeberiaEstarEncriptado'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Vendedor')
BEGIN
    CREATE LOGIN Vendedor WITH PASSWORD = 'constrasena'
END
GO

USE KOALASA
GO
CREATE USER KOALAADMIN FOR LOGIN KOALAADMIN
CREATE USER cliente FOR LOGIN cliente
CREATE USER Vendedor FOR LOGIN Vendedor
GO
CREATE ROLE Administrador
CREATE ROLE Clientes
CREATE ROLE Vendedores
GO

USE KOALASA
GO
EXEC sp_addrolemember 'db_owner', 'KOALAADMIN'
EXEC sp_addrolemember 'Clientes', 'cliente'
EXEC sp_addrolemember 'Vendedores','Vendedor'
GO
