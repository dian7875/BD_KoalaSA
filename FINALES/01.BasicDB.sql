USE master
GO
CREATE DATABASE KOALASA
ON PRIMARY(
Name='KOALA_Data',
FILENAME='C:\SQLData\KOALA_Data.mdf',
SIZE= 1300MB,
MaxSize=6gb,
FileGrowth= 390mb
) LOG ON(
Name  = 'Koala_Log',
filename='C:\SQLLog\Koala_Log.ldf',
Size = 6MB,
MaxSize= 10MB,
Filegrowth=1MB
)
GO

use master
go
alter database KOALASA
add filegroup Stock
go



use master
go
alter database KOALASA
add FILEGROUP Personas
go

use master
go
alter database KOALASA
add FILEGROUP Ventas
go

use master
go
alter database KOALASA
add FILEGROUP Auditorias
go


use master
go
alter database KOALASA
add FILEGROUP Proveedores
go


use master
go
alter database KOALASA
add file 
(
Name = 'Stock_Data',
filename='C:\SQLData\Stock_Data.ndf',
Size = 26MB,
MaxSize= 104MB,
Filegrowth= 8MB
)to filegroup Stock
go

use master
go
alter database KOALASA
add file 
(
Name = 'Personas_Data',
filename='C:\SQLData\Personas_Data.ndf',
Size = 28MB,
MaxSize= 112MB,
Filegrowth= 9MB
)to filegroup Personas
go



use master
go
alter database KOALASA
add file 
(
Name = 'Ventas_Data',
filename='C:\SQLData\Ventas_Data.ndf',
Size = 187MB,
MaxSize= 748MB,
Filegrowth= 57MB
)to filegroup Ventas
go



use master
go
alter database KOALASA
add file 
(
Name = 'RegistroAuditorias_Data',
filename='C:\SQLData\RegistroAuditorias_Data.ndf',
Size = 1062MB,
MaxSize= 4GB,
Filegrowth= 319MB
)to filegroup Auditorias
go

use master
go
alter database KOALASA
add file 
(
Name = 'Proveedores_Data',
filename='C:\SQLData\Proveedores_Data.ndf',
Size = 10MB,
MaxSize= 40MB,
Filegrowth= 3MB
)to filegroup Proveedores
go

