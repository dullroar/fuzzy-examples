/*  Major Example 11-1  */

/*
   This is pulling info from a set of SQL "catalog" tables,
   that is, metadata, that is kept in semi-standardized
   tables in the "sys" schema.
*/
SELECT
    C.name [Column Name]
FROM sys.columns C
INNER JOIN sys.tables T ON
    C.object_id = T.object_id
INNER JOIN sys.schemas S ON
    S.schema_id = T.schema_id
WHERE
    S.name = 'staging'
    AND T.name = 'Customers'
ORDER BY C.column_id
         

