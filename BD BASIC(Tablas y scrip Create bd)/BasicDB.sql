USE master
GO
CREATE DATABASE KOALASA
ON PRIMARY(
Name='KOALA_Data',
FILENAME='C:\SQLData\KOALA_Data.mdf',
SIZE= 50MB,
MaxSize=100mb,
FileGrowth= 30mb
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
add file 
(
Name = 'Stock_Data',
filename='C:\SQLData\Stock_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Stock
go

use master
go
alter database KOALASA
add FILEGROUP Clientes
go

use master
go
alter database KOALASA
add file 
(
Name = 'Clientes_Data',
filename='C:\SQLData\Clientes_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Clientes
go

use master
go
alter database KOALASA
add FILEGROUP Vendedores
go

use master
go
alter database KOALASA
add file 
(
Name = 'Vendedores_Data',
filename='C:\SQLData\Vendedores_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Vendedores
go

use master
go
alter database KOALASA
add FILEGROUP Personas
go

use master
go
alter database KOALASA
add file 
(
Name = 'Personas_Data',
filename='C:\SQLData\Personas_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Personas
go


use master
go
alter database KOALASA
add FILEGROUP Ventas
go

use master
go
alter database KOALASA
add file 
(
Name = 'Ventas_Data',
filename='C:\SQLData\Ventas_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Ventas
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
Name = 'Proveedores_Data',
filename='C:\SQLData\Proveedores_Data.ndf',
Size = 4MB,
MaxSize= 11MB,
Filegrowth= 3MB
)to filegroup Proveedores
go

