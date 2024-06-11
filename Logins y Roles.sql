
USE master
GO
CREATE LOGIN AdministradorKoala
WITH PASSWORD = 'KoalaAD';
GO

USE master
GO
CREATE LOGIN KoalaCLiente
WITH PASSWORD = 'KoalaCL';
GO
USE master
GO
CREATE LOGIN KoalaVendedor
WITH PASSWORD = 'KoalaVE';
GO

USE KOALASA;
GO
CREATE USER administrador FOR LOGIN AdministradorKoala;
GO

USE KOALASA;
GO
CREATE USER vendedor FOR LOGIN KoalaVendedor;
GO

USE KOALASA;
GO

CREATE USER cliente FOR LOGIN KoalaCLiente;
GO