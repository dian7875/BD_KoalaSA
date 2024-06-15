--Vendedor del mes
USE KOALASA
GO
CREATE PROCEDURE SP_EMPLEADO_DEL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.';
    END
    ELSE
    BEGIN
        SELECT TOP 1
            P.Cedula,
            P.Nombre,
            P.[Primer Apellido],
            P.[Segundo Apellido],
            COUNT(C.[Numero de Factura]) AS 'Numero De Ventas',
			SUM(C.Total) AS 'Total Vendido'
        FROM 
            Vw_Compra C
            JOIN Vw_Persona P ON C.[Cedula Vendedor] = P.Cedula
        WHERE 
            C.Fecha BETWEEN @INICIO AND @FIN
			 GROUP BY 
            P.Cedula, P.Nombre, P.[Primer Apellido], P.[Segundo Apellido]
		Order By
			SUM(C.Total) DESC;
    END
END;
GO

--Comprador del Mes
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRADOR_DEL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.';
    END
    ELSE
    BEGIN
        SELECT TOP 1
            P.Cedula,
            P.Nombre,
            P.[Primer Apellido],
            P.[Segundo Apellido],
            COUNT(C.[Numero de Factura]) AS 'Numero De Compras',
			SUM(C.Total) AS 'Total comprado'
        FROM 
            Vw_Compra C
            JOIN Vw_Persona P ON C.[Cedula Cliente] = P.Cedula
        WHERE 
            C.Fecha BETWEEN @INICIO AND @FIN
			 GROUP BY 
            P.Cedula, P.Nombre, P.[Primer Apellido], P.[Segundo Apellido]
		ORDER BY 
			SUM(C.Total) DESC;
    END
END;
GO
---Catalogo de zapato(Talla,Colores,Tipo,Genero)

USE KOALASA
GO
CREATE PROCEDURE SP_CATALO_DE_ZAPATOS
AS
BEGIN 
    SELECT 
          Z.[Codigo de Zapato],
		  T.[Nombre Del Tipo],
		  C.[Nombre Del Color],
		  CASE 
			WHEN [Genero Del Zapato] = 'H'
			THEN 'HOMBRE'
			WHEN [Genero Del Zapato]='M'
			THEN 'MUJER'
			ELSE 'UNISEX'
			END AS [Genero Del Zapato],
		S.Existencias,
		Z.[Precio Unitario]
		
        FROM 
          Vw_Zapato Z
		  JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
		  JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
		  JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
        WHERE 
			S.Existencias > 0
			ORDER BY
			[Precio Unitario] ASC
    END;
GO

EXECUTE SP_CATALO_DE_ZAPATOS_POR_GENERO 'H'

USE KOALASA
GO
CREATE PROCEDURE SP_CATALO_DE_ZAPATOS_POR_GENERO
@GENERO CHAR(1)
AS
BEGIN 
   IF @GENERO NOT IN ('H', 'M', 'U')
    BEGIN
        PRINT 'El parámetro @GENERO debe ser especificado como ''H'' (Hombre), ''M'' (Mujer), o ''U'' (Unisex).';
        RETURN;
    END
    SELECT 
          Z.[Codigo de Zapato],
		  T.[Nombre Del Tipo],
		  C.[Nombre Del Color],
		  CASE 
			WHEN [Genero Del Zapato] = 'H'
			THEN 'HOMBRE'
			WHEN [Genero Del Zapato]='M'
			THEN 'MUJER'
			ELSE 'UNISEX'
			END AS [Genero Del Zapato],
		S.Existencias,
		Z.[Precio Unitario]
		
        FROM 
          Vw_Zapato Z
		  JOIN Vw_Color C ON Z.[Codigo de Color] = C.[Codigo de Color]
		  JOIN Vw_Tipo T ON Z.[Codigo de tipo] = T.[Codigo del Tipo]
		  JOIN Vw_Stock S ON Z.[Codigo de Zapato] = S.[Codigo de Zapato]
        WHERE 
			S.Existencias > 0 AND T.[Genero Del Zapato] = @GENERO
			ORDER BY
			[Precio Unitario] ASC;

	  IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No hay zapatos disponibles en stock para el género especificado ' + 
              CASE 
                  WHEN @GENERO = 'H' THEN 'Hombre'
                  WHEN @GENERO = 'M' THEN 'Mujer'
                  WHEN @GENERO = 'U' THEN 'Unisex'
              END + '.';
    END
 END;
GO





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
        [Estado del Proveedor] = @Estado
END
GO

USE KOALASA
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
        [Nombre del Proveedor] LIKE '%' + @Nombre + '%'
END
GO

USE KOALASA
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
        [Codigo de Proveedor] = @codigoProveedor
END
GO

USE KOALASA
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
        [Cedula Juridica] = @cedulaJuridica
END
GO

USE KOALASA
GO
CREATE PROCEDURE Sp_BuscarTiposPorProveedor
    @codigo_proveedor VARCHAR(15)
AS
BEGIN
    SELECT 
	[Codigo del Proveedor], [Nombre Del Tipo],
	CASE 
	WHEN [Genero Del Zapato] = 'H'
	THEN 'HOMBRE'
	WHEN [Genero Del Zapato]='M'
	THEN 'MUJER'
	ELSE 'UNISEX'
	END AS [Genero Del Zapato]
    FROM  Vw_Z_CTSP
    WHERE 
	[Codigo del Proveedor] = @codigo_proveedor
END
GO


USE KOALASA
GO
create procedure SP_BuscarZapato_POR_Color
@Nombre_Color varchar(10)
AS
BEGIN 
SELECT 
	[Codigo de tipo],[Codigo de Zapato],[Codigo de Color],
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
FROM Vw_Z_CTSP
Where [Nombre Del Color] = @Nombre_Color order by [Nombre Del Color]
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_ZAPATO_POR_CODIGO
@CodigoZapato VARCHAR (10)
AS
BEGIN
SELECT
[Codigo de Zapato], [Nombre Del Color],[Nombre Del Tipo],
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
FROM Vw_Z_CTSP
WHERE [Codigo de Zapato]=@CodigoZapato
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_RANGO_PRECIO
@MINIMO MONEY,
@MAXIMO MONEY
AS
BEGIN 
SELECT
	[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color],
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
FROM Vw_Z_CTSP
WHERE [Precio Unitario] BETWEEN @MINIMO AND @MAXIMO ORDER BY [Precio Unitario] ASC
END
GO


USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_TALLA
@TALLA INT
AS
BEGIN 
SELECT
[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
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
FROM Vw_Z_CTSP
WHERE Talla = @TALLA ORDER BY Talla ASC
END
GO


USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_RANGO_TALLAS
@TALLAMIN INT,
@TALLAMAX INT
AS
BEGIN 
SELECT
[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
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
FROM Vw_Z_CTSP
WHERE Talla BETWEEN @TALLAMIN and @TALLAMAX ORDER BY Talla ASC
END
GO

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
FROM Vw_Z_CTSP
WHERE Existencias > @CANTIDADSTOCK ORDER BY Existencias ASC
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_STOCK_MAYOR_A
@CANTIDADSTOCK INT
AS
BEGIN 
SELECT
[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
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
FROM Vw_Z_CTSP
WHERE Existencias < @CANTIDADSTOCK ORDER BY Existencias ASC
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_ZAPATO_POR_PROVEEDOR
@CODIGOPROVEEEDOR Varchar(15)
AS
BEGIN 
SELECT
[Codigo de Zapato], [Nombre Del Tipo], [Nombre Del Color], 
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
FROM Vw_Z_CTSP
WHERE @CODIGOPROVEEEDOR = [Codigo de Proveedor]
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_PERSONA_CEDULA
@CEDULA VARCHAR(15)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1
                   FROM Vw_Persona
                   WHERE Cedula = @CEDULA)
    BEGIN
        PRINT 'No existe ninguna persona con la cédula ' + @CEDULA + '.'
    END
ElSE
BEGIN
	SELECT
		Cedula,
		Nombre,
		[Primer Apellido],
		[Segundo Apellido],
		Telefono,
		Correo,
		CASE 
			WHEN Tipo = 'C'
			THEN 'CLIENTE'
			WHEN Tipo='V'
			THEN 'Vendedor'
			ELSE 'DESCONOCIDO'
			END AS Tipo,
		Direccion
		FROM Vw_Persona
		WHERE  @CEDULA = Cedula
	END
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_PERSONA_TIPO
@TIPO char(1)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Vw_Persona WHERE Tipo = @TIPO)
    BEGIN
         PRINT 'No existe ninguna persona ' + 
              CASE 
                  WHEN @TIPO = 'C' THEN 'cliente'
                  WHEN @TIPO = 'V' THEN 'vendedor'
                  ELSE 'con el tipo ' + @TIPO
              END + '.';
    END
ElSE
BEGIN
	SELECT
		Cedula,
		Nombre,
		[Primer Apellido],
		[Segundo Apellido],
		Telefono,
		Correo,
		CASE 
		WHEN Tipo = 'C' THEN 'CLIENTE'
		WHEN Tipo = 'V' THEN 'Vendedor'
		ELSE 'DESCONOCIDO'
		END AS Tipo,
		Direccion
	FROM Vw_Persona
	WHERE Tipo = @TIPO;
	END
END
GO

--Personas Nombre(busqueda grande)

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_PERSONA_NOMBRE
@Nombre Varchar(20)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Persona WHERE Nombre = @Nombre)
    BEGIN
        PRINT 'No existe ninguna persona Nombre: ' + @Nombre
    END
    ELSE
    BEGIN
        SELECT
            Cedula,
            Nombre,
            [Primer Apellido],
            [Segundo Apellido],
            Telefono,
            Correo,
            CASE 
                WHEN Tipo = 'C' THEN 'CLIENTE'
                WHEN Tipo = 'V' THEN 'VENDEDOR'
                ELSE 'DESCONOCIDO'
            END AS Tipo,
			Direccion
        FROM 
            Vw_Persona
        WHERE 
            Nombre = @Nombre;
    END
END
GO


--Personas por Apellidos

USE KOALASA
GO
CREATE PROCEDURE SP_BUSCAR_PERSONA_APELLIDO
@Apellido Varchar(10)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Persona WHERE [Primer Apellido] =@Apellido OR [Segundo Apellido] = @Apellido)
    BEGIN
        PRINT 'No existe ninguna persona Apellido: ' + @Apellido;
    END
    ELSE
    BEGIN
        SELECT
            Cedula,
            Nombre,
            [Primer Apellido],
            [Segundo Apellido],
            Telefono,
            Correo,
            CASE 
                WHEN Tipo = 'C' THEN 'CLIENTE'
                WHEN Tipo = 'V' THEN 'VENDEDOR'
                ELSE 'DESCONOCIDO'
            END AS Tipo,
			Direccion
        FROM 
            Vw_Persona
        WHERE 
           [Primer Apellido] = @Apellido or [Segundo Apellido]=@Apellido
    END
END
GO

--Compras por cliente Cedula
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRA_POR_CEDULA_CLIENTE
@CEDULA Varchar(10)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE @CEDULA = [Cedula Cliente] )
    BEGIN
        PRINT 'No existe ninguna compra asociada a la cedula cliente : ' + @CEDULA
    END
    ELSE
    BEGIN
        SELECT
         [Numero de Factura], Fecha,[Cedula Cliente],[Cedula Vendedor],Total,[Nombre de metodo de pago]
        FROM Vw_C_I_VCMZ
        WHERE 
          [Cedula Cliente] = @CEDULA
    END
END
GO

--Vendedor del mes
USE KOALASA
GO
CREATE PROCEDURE SP_EMPLEADO_DEL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
    BEGIN
        SELECT TOP 1
            P.Cedula,
            P.Nombre,
            P.[Primer Apellido],
            P.[Segundo Apellido],
            COUNT(C.[Numero de Factura]) AS 'Numero De Ventas',
			SUM(C.Total) AS 'Total Vendido'
        FROM 
            Vw_Compra C
            JOIN Vw_Persona P ON C.[Cedula Vendedor] = P.Cedula
        WHERE 
            C.Fecha BETWEEN @INICIO AND @FIN
			 GROUP BY 
            P.Cedula, P.Nombre, P.[Primer Apellido], P.[Segundo Apellido]
		Order By
			SUM(C.Total) DESC;
    END
END
GO

--Comprador del Mes
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRADOR_DEL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
    BEGIN
        SELECT TOP 1
            P.Cedula,
            P.Nombre,
            P.[Primer Apellido],
            P.[Segundo Apellido],
            COUNT(C.[Numero de Factura]) AS 'Numero De Compras',
			SUM(C.Total) AS 'Total comprado'
        FROM 
            Vw_Compra C
            JOIN Vw_Persona P ON C.[Cedula Cliente] = P.Cedula
        WHERE 
            C.Fecha BETWEEN @INICIO AND @FIN
			 GROUP BY 
            P.Cedula, P.Nombre, P.[Primer Apellido], P.[Segundo Apellido]
		ORDER BY 
			SUM(C.Total) DESC;
    END
END
GO

--Ventas del mes
USE KOALASA
GO
CREATE PROCEDURE SP_VENTAS_EN_EL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
    BEGIN
        SELECT   SUM(Total) AS 'Total Vendido',
            COUNT([Numero de Factura]) AS 'Numero de Ventas'
        FROM 
            Vw_Compra
        WHERE 
            Fecha BETWEEN @INICIO AND @FIN;
    END
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_INFO_VENTAS_DEL_MES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
   BEGIN
        SELECT 
            C.[Numero de Factura],
            C.Fecha,
            C.[Cedula Cliente],
            PCliente.Nombre AS NombreCliente,
            C.[Cedula Vendedor],
            PVendedor.Nombre AS NombreVendedor,
            C.Total,
            MP.[Nombre de metodo de pago]
        FROM 
            Vw_Compra C
            JOIN Vw_Persona PCliente ON C.[Cedula Cliente] = PCliente.Cedula
            JOIN Vw_Persona PVendedor ON C.[Cedula Vendedor] = PVendedor.Cedula
            JOIN Vw_MPago MP ON C.[Metodo de pago] = MP.[Codigo de metodo de pago]
        WHERE 
            C.Fecha BETWEEN @INICIO AND @FIN
        ORDER BY 
            C.Total DESC;
		END
END
GO

--Articulos por cedula de comprador
USE KOALASA
GO
CREATE PROCEDURE SP_ARTICULOS_COMPRA_POR_CEDULA_CLIENTE
@CEDULA Varchar(10)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE @CEDULA = [Cedula Cliente] )
    BEGIN
        PRINT 'No existe ninguna Articulo comprado por el cliente cedula  : ' + @CEDULA
    END
    ELSE
    BEGIN
        SELECT
         [Numero de Factura], Fecha,[Cedula Cliente],[Cedula Vendedor],
		 [Codigo de Zapato],[Nombre Del Tipo],[Nombre Del Color],
		 Cantidad,[Precio Unitario],[Sub Total]
        FROM 
            Vw_C_I_VCMZ
        WHERE 
          [Cedula Cliente] = @CEDULA
    END
END
GO
--Compras por vendedor Cedula
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRA_POR_CEDULA_VENDEDOR
@CEDULA Varchar(10)
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE @CEDULA = [Cedula Vendedor] )
    BEGIN
        PRINT 'No existe ninguna Venta asociada al Vendedor : ' + @CEDULA
    END
    ELSE
    BEGIN
        SELECT
         C.[Numero de Factura], C.Fecha,C.[Cedula Cliente],C.[Cedula Vendedor],Total,[Nombre de metodo de pago]
        FROM 
            Vw_Compra C
			JOIN Vw_Persona P ON C.[Cedula Cliente] = P.Cedula
			JOIN Vw_MPago MP ON C.[Metodo de pago] = MP.[Codigo de metodo de pago]
        WHERE 
          C.[Cedula Vendedor] = @CEDULA
    END
END
GO
--Basica numero de factura
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRA_POR_NUMFACTURA
@NumFactura INT
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE [Numero de Factura] = @NumFactura )
    BEGIN
        PRINT 'No existe ninguna Compra asociada a la Factura: ' + CAST(@NumFactura AS Varchar)
    END
    ELSE
    BEGIN
        SELECT
          C.[Numero de Factura], C.Fecha,C.[Cedula Cliente],C.[Cedula Vendedor],Total,[Nombre de metodo de pago]
        FROM 
            Vw_Compra C
			JOIN Vw_Persona P ON C.[Cedula Cliente] = P.Cedula
			JOIN Vw_MPago MP ON C.[Metodo de pago] = MP.[Codigo de metodo de pago]
        WHERE 
          [Numero de Factura] = @NumFactura
    END
END
GO
--Articulos por numero de factura

USE KOALASA
GO
CREATE PROCEDURE SP_ARTICULOS_COMPRA_POR_NUMFACTURA
@NUMFACTURA INT
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE @NUMFACTURA = [Numero de Factura] )
    BEGIN
        PRINT 'No existe la factura : ' + CAST(@NUMFACTURA AS VARCHAR)
    END
    ELSE
    BEGIN
        SELECT
         [Numero de Factura], Fecha,[Cedula Cliente],[Cedula Vendedor],
		 [Codigo de Zapato],[Nombre Del Tipo],[Nombre Del Color],
		 Cantidad,[Precio Unitario],[Sub Total]
        FROM 
            Vw_C_I_VCMZ
        WHERE 
          [Numero de Factura] = @NUMFACTURA
    END
END
GO

--Rango de fechas

USE KOALASA
GO
CREATE PROCEDURE SP_COMPRA_POR_RANGO_FECHAS
@INICIO DATE,
@FIN DATE
AS
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM Vw_Compra WHERE Fecha BETWEEN @INICIO AND @FIN )
    BEGIN
        PRINT 'No existe ninguna Compra en esas Fechas: '
    END
    ELSE
    BEGIN
        SELECT
          C.[Numero de Factura], C.Fecha,C.[Cedula Cliente],C.[Cedula Vendedor],Total,[Nombre de metodo de pago]
        FROM 
            Vw_Compra C
			JOIN Vw_Persona P ON C.[Cedula Cliente] = P.Cedula
			JOIN Vw_MPago MP ON C.[Metodo de pago] = MP.[Codigo de metodo de pago]
        WHERE 
             C.Fecha BETWEEN @INICIO AND @FIN;
    END
END
GO

--Por metodo de pago

USE KOALASA
GO
CREATE PROCEDURE SP_COMPRAS_POR_METODO_PAGO
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN)
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
    BEGIN
        SELECT 
            [Nombre de metodo de pago],
            COUNT([Numero de Factura]) AS 'Ventas Realizadas',
            SUM(Total) AS 'Total Vendido'
        FROM 
            Vw_C_I_VCMZ
        WHERE 
            Fecha BETWEEN @INICIO AND @FIN
        GROUP BY 
            [Nombre de metodo de pago]
        ORDER BY 
             SUM(Total) DESC;
    END
END
GO

--Ventas por metodo de pago
USE KOALASA
GO
CREATE PROCEDURE SP_COMPRAS_POR_METODO_PAGO_TOTALES
AS
BEGIN 
  DECLARE @INICIO DATE, @FIN DATE;
    SET @FIN = GETDATE();
    SET @INICIO = DATEADD(DAY, -30, @FIN);
    IF NOT EXISTS (SELECT 1 
                   FROM Vw_Compra
                   WHERE Fecha BETWEEN @INICIO AND @FIN)
    BEGIN
        PRINT 'No existe ninguna transacción en el rango de fechas especificado.'
    END
    ELSE
    BEGIN
        SELECT 
            [Nombre de metodo de pago],
            COUNT([Numero de Factura]) AS 'Ventas Realizadas',
            SUM(Total) AS 'Total Vendido'
        FROM 
            Vw_C_I_VCMZ
        WHERE 
            Fecha BETWEEN @INICIO AND @FIN
        GROUP BY 
            [Nombre de metodo de pago]
        ORDER BY 
              SUM(Total) DESC;
    END
END
GO

--Ventas por zapatos

USE KOALASA
GO
CREATE PROCEDURE SP_VENTAS_POR_ZAPATO
AS
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM Vw_Compra)
    BEGIN
        PRINT 'No existe ninguna venta registrada.'
    END
    ELSE
    BEGIN
        SELECT 
            [Codigo de Zapato],
            [Precio Unitario],
            SUM(Cantidad * [Precio Unitario]) AS 'Total Venta'
        FROM 
            Vw_C_I_VCMZ
        GROUP BY 
            [Codigo de Zapato], [Precio Unitario]
        ORDER BY 
            SUM(Cantidad * [Precio Unitario]) DESC
    END
END
GO

USE KOALASA
GO
CREATE PROCEDURE SP_VENTAS_POR_CODIGO_ZAPATO
    @CodigoZapato Varchar(15)
AS
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM Vw_Zapato WHERE [Codigo de Zapato] = @CodigoZapato)
    BEGIN
        PRINT 'No existen ventas registradas para el zapato con Código ' +@CodigoZapato
    END
    ELSE
    BEGIN
        SELECT 
            [Codigo de Zapato],
            [Precio Unitario],
			SUM(Cantidad) AS 'Cantidad Vendida',
            SUM(Cantidad * [Precio Unitario]) AS 'Total Vendido'
        FROM 
            Vw_C_I_VCMZ
        WHERE 
            [Codigo de Zapato] = @CodigoZapato
        GROUP BY 
            [Codigo de Zapato], [Precio Unitario]
        ORDER BY 
             SUM(Cantidad * [Precio Unitario]) DESC
    END
END
GO


---Catalogo de zapato(Talla,Colores,Tipo,Genero)

USE KOALASA
GO
CREATE PROCEDURE SP_CATALO_DE_ZAPATOS
AS
BEGIN 
    SELECT 
          [Codigo de Zapato],
		  [Nombre Del Tipo],
		  [Nombre Del Color],
		  CASE 
			WHEN [Genero Del Zapato] = 'H'
			THEN 'HOMBRE'
			WHEN [Genero Del Zapato]='M'
			THEN 'MUJER'
			ELSE 'UNISEX'
			END AS [Genero Del Zapato],
		Existencias,
		[Precio Unitario]
		
        FROM 
          Vw_Z_CTSP
        WHERE 
			Existencias > 0
			ORDER BY
			[Precio Unitario] ASC
    END
GO

EXECUTE SP_CATALO_DE_ZAPATOS_POR_GENERO 'H'

USE KOALASA
GO
CREATE PROCEDURE SP_CATALO_DE_ZAPATOS_POR_GENERO
@GENERO CHAR(1)
AS
BEGIN 
   IF @GENERO NOT IN ('H', 'M', 'U')
    BEGIN
        PRINT 'El parámetro @GENERO debe ser especificado como ''H'' (Hombre), ''M'' (Mujer), o ''U'' (Unisex).'
        RETURN
    END
    SELECT 
          [Codigo de Zapato],
		  [Nombre Del Tipo],
		  [Nombre Del Color],
		  CASE 
			WHEN [Genero Del Zapato] = 'H'
			THEN 'HOMBRE'
			WHEN [Genero Del Zapato]='M'
			THEN 'MUJER'
			ELSE 'UNISEX'
			END AS [Genero Del Zapato],
		Existencias,
		[Precio Unitario]
		
        FROM 
          Vw_Z_CTSP
        WHERE 
			Existencias > 0 AND [Genero Del Zapato] = @GENERO
			ORDER BY
			[Precio Unitario] ASC;

	  IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No hay zapatos disponibles en stock para el género especificado ' + 
              CASE 
                  WHEN @GENERO = 'H' THEN 'Hombre'
                  WHEN @GENERO = 'M' THEN 'Mujer'
                  WHEN @GENERO = 'U' THEN 'Unisex'
              END + '.'
    END
 END
GO

