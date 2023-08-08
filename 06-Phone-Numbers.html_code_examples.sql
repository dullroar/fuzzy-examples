/*  Major Example 6-1  */

/*
   Lots of non-numeric junk in this one.
*/
DECLARE @PhoneNumber VARCHAR(50) = '(800) 555-1234 Ext. 67'
SELECT
    /*
       Take the LEFTmost 10
    */
    LEFT
    (
        /*
           After REPLACE-ing all spaces with empty strings
        */
        REPLACE
        (
            /*
               After TRANSLATE-ing "impossible" characters to spaces.
            */
            TRANSLATE
            (
                @PhoneNumber,
                '() -.,+#ABCDEFGHIJKLMNOPQRSTUVWXYZ',  /* From these */
                '                                  '   /* to spaces  */
            ),
            ' ', ''
        ),
        10
    ) [Normalized Phone #];
        

/*  Major Example 6-2  */

SELECT
    COUNT(*) [# Customers Matched By Phone]
FROM
(
    SELECT
        C.LastName [Last Name],
        C.FirstName [First Name],
        C.HomePhone [Matched Phone #]
    FROM crm.NormalizedCustomer C
    INNER JOIN dbo.PotentialMatches P ON
        REPLACE(TRANSLATE(C.HomePhone, '() -.,+#', '^^^^^^^^'), '^', '') =
        REPLACE(TRANSLATE(P.phone1, '() -.,+#', '^^^^^^^^'), '^', '')
    UNION      /* UNIONs drop dups without the "ALL" */
    SELECT
        C.LastName [Last Name],
        C.FirstName [First Name],
        C.HomePhone [Matched Phone #]
    FROM crm.NormalizedCustomer C
    INNER JOIN dbo.PotentialMatches P ON
        REPLACE(TRANSLATE(C.HomePhone, '() -.,+#', '^^^^^^^^'), '^', '') =
        REPLACE(TRANSLATE(P.phone2, '() -.,+#', '^^^^^^^^'), '^', '')
    UNION
    SELECT
        C.LastName [Last Name],
        C.FirstName [First Name],
        C.HomePhone [Matched Phone #]
    FROM crm.NormalizedCustomer C
    INNER JOIN dbo.PotentialMatches P ON
        REPLACE(TRANSLATE(C.MobilePhone, '() -.,+#', '^^^^^^^^'), '^', '') =
        REPLACE(TRANSLATE(P.phone1, '() -.,+#', '^^^^^^^^'), '^', '')
    UNION
    SELECT
        C.LastName [Last Name],
        C.FirstName [First Name],
        C.HomePhone [Matched Phone #]
    FROM crm.NormalizedCustomer C
    INNER JOIN dbo.PotentialMatches P ON
        REPLACE(TRANSLATE(C.MobilePhone, '() -.,+#', '^^^^^^^^'), '^', '') =
        REPLACE(TRANSLATE(P.phone2, '() -.,+#', '^^^^^^^^'), '^', '')
) A;
        

