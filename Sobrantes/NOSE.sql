

USE KOALASA;

SELECT 
    t.NAME AS "Tabla",
    s.Name AS "Esquema",
    p.rows AS "Filas",
    SUM(a.total_pages) * 8  AS "Tamaño (KB)", 
    SUM(a.used_pages) * 8  AS "Tamaño Usado (KB)", 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS "Espacio Libre (KB)"
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME = 'proveedor'
GROUP BY 
    t.Name, s.Name, p.Rows;


SELECT 
    t.NAME AS "Tabla",
    s.Name AS "Esquema",
    p.rows AS "Filas",
    SUM(a.total_pages) * 8 AS "Tamaño Total (KB)", 
    SUM(a.used_pages) * 8 AS "Tamaño Usado (KB)",
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS "Espacio Libre (KB)"
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    "Tamaño Total (KB)" DESC;



USE KOALASA
GO

SELECT 
    name AS NombreProcedimiento,
    type_desc AS Tipo,
    create_date AS FechaCreacion
FROM sys.procedures
ORDER BY name;
GO