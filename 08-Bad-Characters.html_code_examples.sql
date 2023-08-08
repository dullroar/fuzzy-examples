/*  Major Example 8-1  */

DECLARE @FirstName NVARCHAR(50) = NCHAR(8195) + 'Mortimer'
SELECT
    '''' + @FirstName + '''' [Before TRIM],
    '''' + TRIM(TRANSLATE(@FirstName,
                /*
                   31 "space-like" characters
                */
                NCHAR(9)   +  /* HT    */
                NCHAR(10)  +  /* LF    */
                NCHAR(11)  +  /* VT    */
                NCHAR(12)  +  /* FF    */
                NCHAR(13)  +  /* CR    */
                NCHAR(32)  +  /* Space */
                NCHAR(133) +  /* NEL   */
                /*
                   See Unicode ref for rest
                */
                NCHAR(160)   +
                NCHAR(5760)  +
                NCHAR(6158)  +
                NCHAR(8192)  +
                NCHAR(8193)  +
                NCHAR(8194)  +
                NCHAR(8195)  +
                NCHAR(8196)  +
                NCHAR(8197)  +
                NCHAR(8198)  +
                NCHAR(8199)  +
                NCHAR(8200)  +
                NCHAR(8201)  +
                NCHAR(8202)  +
                NCHAR(8203)  +
                NCHAR(8204)  +
                NCHAR(8205)  +
                NCHAR(8232)  +
                NCHAR(8233)  +
                NCHAR(8239)  +
                NCHAR(8287)  +
                NCHAR(8288)  +
                NCHAR(12288) +
                NCHAR(65279),
                /*
                   31 UNICODE spaces to translate to (note "N").
                */
                N'                               ')) +
                '''' [After TRIM (Unicode!)];
        

/*  Major Example 8-2  */

SELECT
    COUNT(*) [Number of Matches]
FROM staging.CustomerTable C
INNER JOIN staging.ImportTable I ON
        /*
           Specifying the import table's collation on the customer table
           columns.
        */
        C.LastName  COLLATE SQL_Latin1_General_CP1_CI_AS = I.LastName
    AND C.FirstName COLLATE SQL_Latin1_General_CP1_CI_AS = I.FirstName;
         

/*  Major Example 8-3  */

SELECT
    COUNT(*) [Number of Matches]
FROM staging.CustomerTable C
INNER JOIN staging.ImportTable I ON
        /*
           Specifying the customer table's collation on the import table
           columns.
        */
        C.LastName = I.LastName   COLLATE Latin1_General_100_CS_AI_SC_UTF8
    AND C.FirstName = I.FirstName COLLATE Latin1_General_100_CS_AI_SC_UTF8;
         

