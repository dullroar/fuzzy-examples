/*  Major Example 13-1  */

SELECT
    ImportLine.value('(/Customer/LastName/node())[1]', 'NVARCHAR(MAX)') LastName,
    ImportLine.value('(/Customer/FirstName/node())[1]', 'NVARCHAR(MAX)') FirstName
INTO staging.XMLDemoImported
FROM staging.XMLDemo;
        

/*  Major Example 13-2  */

SELECT
    JSON_VALUE(ImportLine, '$.customer.lastName') LastName,
    JSON_VALUE(ImportLine, '$.customer.firstName') FirstName
INTO staging.JSONDemoImported
FROM staging.JSONDemo;
        

/*  Major Example 13-3  */

SELECT TOP 10
    'INSERT INTO staging.CodeGeneratingDemo ' +
    '(LastName, FirstName, Company) VALUES(''' +
    COALESCE(last_name, '') + ''', ''' +
    COALESCE(first_name, '') + ''', ''' +
    COALESCE(company_name, '') + ''')' [SQL]
FROM staging.PossibleData
ORDER BY last_name, first_name, company_name;
         

/*  Major Example 13-4  */

WITH StripLeadingSlash
AS
(
    SELECT DISTINCT
        RIGHT(FilePath, LEN(FilePath) - 1) Remainder
    FROM impact.CodeArtifacts
),
RemoveProjectType
AS
(
    SELECT
        RIGHT(Remainder, LEN(Remainder) -
                               CHARINDEX('/', Remainder)) Remainder
    FROM StripLeadingSlash
),
GrabProjectName
AS
(
    SELECT
        LEFT(Remainder, CHARINDEX('/', Remainder) - 1) Project
    FROM RemoveProjectType
)
SELECT DISTINCT
    Project
FROM GrabProjectName
ORDER BY Project;
         

/*  Major Example 13-5  */

WITH GrabFileType
AS
(
    SELECT
        RIGHT(FilePath, CHARINDEX('.', REVERSE(FilePath))) FileExtension
    FROM impact.CodeArtifacts
)
SELECT
    FileExtension,
    COUNT(*) Total
FROM GrabFileType
GROUP BY FileExtension
ORDER BY 2 DESC, 1;
         

/*  Major Example 13-6  */

SELECT
    s.name [Schema],
    o.name ObjectName,
    o.type_desc ObjectType
FROM sys.objects o
INNER JOIN sys.schemas s ON
    o.schema_id = s.schema_id
WHERE
    s.name <> 'staging'
    AND o.type_desc IN
    (
        'USER_TABLE',
        'VIEW',
        'SQL_TABLE_VALUED_FUNCTION',
        'SQL_STORED_PROCEDURE',
        'SQL_INLINE_TABLE_VALUED_FUNCTION',
        'SQL_SCALAR_FUNCTION'
    )
ORDER BY 1, 2;
         

/*  Major Example 13-7  */

WITH SqlObjectInfo
AS
(
    SELECT
        s.name [Schema],
        o.name ObjectName,
        o.type_desc ObjectType
    FROM sys.objects o
    INNER JOIN sys.schemas s ON
        o.schema_id = s.schema_id
    WHERE
        s.name <> 'staging'
        AND o.type_desc IN
        (
            'USER_TABLE',
            'VIEW',
            'SQL_TABLE_VALUED_FUNCTION',
            'SQL_STORED_PROCEDURE',
            'SQL_INLINE_TABLE_VALUED_FUNCTION',
            'SQL_SCALAR_FUNCTION'
        )
)
SELECT
    'INSERT INTO impact.CodeArtifactHits ' +
    'SELECT ''' + ObjectName + ''' SearchTerm, ' +
    'FileName, FilePath FROM impact.CodeArtifacts ' +
    'WHERE ' +
    'FileContents LIKE ''%' +
    REPLACE(ObjectName, '_', '\_') +
    '%'' ESCAPE ''\''' 
FROM SqlObjectInfo;
         

/*  Major Example 13-8  */

WITH StripLeadingSlash
AS
(
    SELECT DISTINCT
        FilePath,
        RIGHT(FilePath, LEN(FilePath) - 1) Remainder
    FROM impact.CodeArtifacts
),
RemoveProjectType
AS
(
    SELECT
        FilePath,
        RIGHT(Remainder, LEN(Remainder) -
                               CHARINDEX('/', Remainder)) Remainder
    FROM StripLeadingSlash
),
GrabProjectName
AS
(
    SELECT
        FilePath,
        LEFT(Remainder, CHARINDEX('/', Remainder) - 1) Project
    FROM RemoveProjectType
)
SELECT
    G.Project,
    COUNT(*) Total
FROM impact.CodeArtifactHits C
INNER JOIN GrabProjectName G ON
    C.FilePath = G.FilePath
GROUP BY Project
ORDER BY 2 DESC, 1;
         

