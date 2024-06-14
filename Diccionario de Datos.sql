USE KOALASA;
GO

-- Información básica de las tablas y columnas
SELECT 
    t.TABLE_NAME AS 'Nombre de la Tabla',
    c.COLUMN_NAME AS 'Nombre de la columna',
    c.DATA_TYPE AS 'Tipo de Dato',
    c.CHARACTER_MAXIMUM_LENGTH AS 'Caracteres Maximos',
    c.IS_NULLABLE AS 'Nullable',
    CASE 
        WHEN pk.COLUMN_NAME IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END AS 'Llave Primaria',
    fk.CONSTRAINT_NAME AS 'Llave Foránea',
    fk.REFERENCED_TABLE_NAME AS 'Tabla de Referencia',
    fk.REFERENCED_COLUMN_NAME AS 'Columna de Referencia'
FROM 
    INFORMATION_SCHEMA.TABLES t
    INNER JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_NAME = c.TABLE_NAME
    LEFT JOIN (
        SELECT 
            ku.TABLE_NAME,
            ku.COLUMN_NAME
        FROM 
            INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
            INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE ku ON tc.CONSTRAINT_NAME = ku.CONSTRAINT_NAME
        WHERE 
            tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
    ) pk ON c.TABLE_NAME = pk.TABLE_NAME AND c.COLUMN_NAME = pk.COLUMN_NAME
    LEFT JOIN (
        SELECT 
            fk.CONSTRAINT_NAME,
            kcu.TABLE_NAME,
            kcu.COLUMN_NAME,
            ccu.TABLE_NAME AS REFERENCED_TABLE_NAME,
            ccu.COLUMN_NAME AS REFERENCED_COLUMN_NAME
        FROM 
            INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS fk
            INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu ON fk.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
            INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON fk.UNIQUE_CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
    ) fk ON c.TABLE_NAME = fk.TABLE_NAME AND c.COLUMN_NAME = fk.COLUMN_NAME
WHERE 
    t.TABLE_TYPE = 'BASE TABLE'
ORDER BY 
    t.TABLE_NAME,
    c.ORDINAL_POSITION;
