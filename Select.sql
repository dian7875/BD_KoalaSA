USE KOALASA
GO
CREATE PROCEDURE SP_BuscarProveedor_Estado(
@Estado bit
)
AS
BEGIN
    SELECT 
        [Codigo de Proveedor],
        [Nombre del Proveedor],
        [Cedula Juridica],
        Telefono,
        Correo,
        CASE 
            WHEN [Estado del Proveedor] = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS Estado
    FROM 
        Vw_Proveedor
    WHERE 
        [Estado del Proveedor] = @Estado;
END;
GO

CREATE PROCEDURE SP_BuscarProveedor_Nombre
    @Nombre NVARCHAR(100)
AS
BEGIN
    SELECT 
        [Codigo de Proveedor],
        [Nombre del Proveedor],
        [Cedula Juridica],
        Telefono,
        Correo,
        CASE 
            WHEN [Estado del Proveedor] = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS Estado
    FROM 
        Vw_Proveedor
    WHERE 
        [Nombre del Proveedor] LIKE '%' + @Nombre + '%';
END;
GO

CREATE PROCEDURE SP_BuscarProveedor_Codigo
    @codigoProveedor VARCHAR(10)
AS
BEGIN
    SELECT 
        [Codigo de Proveedor],
        [Nombre del Proveedor],
        [Cedula Juridica],
        Telefono,
        Correo,
        CASE 
            WHEN [Estado del Proveedor] = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS Estado
    FROM 
        Vw_Proveedor
    WHERE 
        [Codigo de Proveedor] = @codigoProveedor;
END;
GO

CREATE PROCEDURE SP_BuscarProveedor_CedulaJ
    @cedulaJuridica VARCHAR(15)
AS
BEGIN
    SELECT 
        [Codigo de Proveedor],
        [Nombre del Proveedor],
        [Cedula Juridica],
        Telefono,
        Correo,
        CASE 
            WHEN [Estado del Proveedor] = 1 THEN 'Activo'
            ELSE 'Inactivo'
        END AS Estado
    FROM 
        Vw_Proveedor
    WHERE 
        [Cedula Juridica] = @cedulaJuridica;
END;
GO

CREATE PROCEDURE Sp_BuscarTiposPorProveedor
    @codigo_proveedor VARCHAR(15)
AS
BEGIN
    SELECT 
		[Codigo de Proveedor], [Nombre Del Tipo],
	CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato]
    FROM  Vw_Proveedor P
	Join Vw_Tipo T on P.[Codigo de Proveedor] = T.[Codigo del Proveedor]
    WHERE 
	P.[Codigo de Proveedor] = @codigo_proveedor
END;
GO


--Zapatos por nombre del color, Zapato por nombre del tipo, Zapato por nombre del proveedor

USE KOALASA
GO
create procedure SP_BuscarZapato_POR_Color
@Nombre_Color varchar(10)
AS
BEGIN 
SELECT 
	[Codigo de tipo],Z.[Codigo de Zapato],Z.[Codigo de Color],
	CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C on Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
Where C.[Nombre Del Color] = @Nombre_Color order by [Nombre Del Color]
END;
GO



---Zapato por codigo DE ZAPATO,

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_ZAPATO_POR_CODIGO
@CodigoZapato VARCHAR (10)
AS
BEGIN
SELECT
Z.[Codigo de Zapato], [Nombre Del Color],[Nombre Del Tipo],
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
	Talla,
	[Precio Unitario],
	Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Z.[Codigo de Zapato]=@CodigoZapato
END;
GO

-- Por precio Rango DE PRECIO, 
USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_RANGO_PRECIO
@MINIMO MONEY,
@MAXIMO MONEY
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color],
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
	Talla,
	[Precio Unitario],
	Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Z.[Precio Unitario] BETWEEN @MINIMO AND @MAXIMO ORDER BY [Precio Unitario] ASC
END;
GO

--Talla

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_TALLA
@TALLA INT
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Z.Talla = @TALLA ORDER BY Talla ASC
END;
GO



--TALLAS


USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_RANGO_TALLAS
@TALLAMIN INT,
@TALLAMAX INT
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
S.Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Z.Talla BETWEEN @TALLAMIN and @TALLAMAX ORDER BY Talla ASC
END;
GO

--Zapato por cantidad en stock menos stock
USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_STOCK_MENOR_A
@CANTIDADSTOCK INT
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Existencias > @CANTIDADSTOCK ORDER BY Existencias ASC
END;
GO

---STOCK MAYOR A

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_STOCK_MAYOR_A
@CANTIDADSTOCK INT
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
WHERE Existencias < @CANTIDADSTOCK ORDER BY Existencias ASC
END;
GO


---Zapato por proveedor


USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_ZAPATO_POR_PROVEEDOR
@CODIGOPROVEEEDOR INT
AS
BEGIN 
SELECT
Z.[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato],
Talla,
[Precio Unitario],
Existencias
FROM Vw_Zapato Z
JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
JOIN Vw_Proveedor P ON T.[Codigo del Proveedor] = P.[Codigo de Proveedor]
WHERE @CODIGOPROVEEEDOR = [Codigo de Proveedor]
END;
GO

--Personas Por roles, Nombre, Cedula,


--Compra por numero de factura, por fecha, montos Por cliente y vendedor


--Ventas por zapatos

--Por metodos de pago


---Catalogo de zapato(Talla,Colores,Tipo,Genero)