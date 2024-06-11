-- Crear login para 'admin' y 'cliente'
USE master;
GO
CREATE LOGIN KOALAADMIN WITH PASSWORD = '123';
CREATE LOGIN cliente WITH PASSWORD = '123';
CREATE LOGIN Vendedor WITH PASSWORD = '123'
GO

USE KOALASA;
GO
CREATE USER KOALAADMIN FOR LOGIN KOALAADMIN;
CREATE USER cliente FOR LOGIN cliente;
CREATE USER Vendedor FOR LOGIN Vendedor;
GO
CREATE ROLE Administrador;
CREATE ROLE Clientes;
CREATE ROLE Vendedores;
GO

EXEC sp_addrolemember 'db_owner', 'KOALAADMIN';
EXEC sp_addrolemember 'Clientes', 'cliente';
EXEC sp_addrolemember 'Vendedores','Vendedor';


