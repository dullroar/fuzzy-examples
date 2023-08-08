/*  Major Example 1-1  */

/*
   Think of a CTE as a temporary "view,"
   although it isn't as performant. In
   this case the CTE name is CustomerCountByState.
*/
WITH CustomerCountByState
AS
(
    SELECT
        State,
        COUNT(*) Total
    FROM crm.NormalizedCustomer
    GROUP BY State
)
/*
   Now we can use our CTE.
*/
SELECT
    State [States w/More Than 10 Customers],
    Total [# in State]
FROM CustomerCountByState
WHERE Total > 9             /* Or >= 10, your choice */
ORDER BY Total DESC, State;
        

/*  Major Example 1-2  */

SELECT
    State [States w/More Than 10 Customers],
    Total [# in State]
FROM
(
    SELECT
        State,
        COUNT(*) Total
    FROM crm.NormalizedCustomer
    GROUP BY State
) CustomerCountByState   /* Gotta give the subquery an alias.
                            It can be anything. I often use "A"
                            for simple queries like this, but am
                            naming it the same as the CTE to be
                            explicit. */
WHERE Total > 9
ORDER BY Total DESC, State;
        

/*  Major Example 1-3  */

WITH CustomerCountByState
AS
(
    SELECT
        State,
        COUNT(*) Total
    FROM crm.NormalizedCustomer
    GROUP BY State
),
CitiesInTopStates
AS
(
    SELECT
        City,
        State,
        COUNT(*) Total
    FROM crm.NormalizedCustomer
    WHERE
        /*
           States with more than 4 (or >= 5) customers.
        */
        State IN (SELECT State FROM CustomerCountByState WHERE Total > 4)
    GROUP BY City, State
)
SELECT
    City,
    State,
    Total
FROM CitiesInTopStates
/*
   Cities with 5 or more (or > 4) customers.
*/
WHERE Total >= 5
ORDER BY Total DESC, City, State;
        

/*  Major Example 1-4  */

/*
   We will cover this example in depth in the chapter on names.
*/
WITH NormalizeCities
AS
(
    SELECT
        City,
        USPSCity,
        REPLACE(TRANSLATE(City,     '.,-''()[]`', '         '), ' ', '') NormCity,
        REPLACE(TRANSLATE(USPSCity, '.,-''()[]`', '         '), ' ', '') NormUSPSCity
    FROM Foo
)
SELECT
    City,
    USPSCity [USPS City],
    /*
       Single-line CASE statement.
    */
    CASE City WHEN USPSCity THEN 'Match!' ELSE 'No Match!' END [Match?],
    NormCity [Norm. City],
    NormUSPSCity [Norm. USPS City],
    /*
       Multi-line CASE with expression test after the CASE.
    */
    CASE NormCity
        WHEN NormUSPSCity THEN 'Match!'
        ELSE 'No Match!'
    END [Do Normalized Match?],
    /*
       Multi-LINE CASE with expression test in the WHEN. Note "=".
    */ 
    CASE
        WHEN NormCity = NormUSPSCity THEN 'Match!'
        ELSE 'No Match!'
    END [Still?]
FROM NormalizeCities;
        

/*  Major Example 1-5  */

DECLARE @City VARCHAR(50) = 'Ste Genevieve'       /* How we store it           */
DECLARE @ImportCity VARCHAR(50) = 'St Genevieve'  /* How Marketing receives it */
SELECT
    @City City,
    @ImportCity [Imported City],
    CASE
        /*
           WHENs can actually check all variety of tests.
        */
        WHEN REPLACE(@City, 'St ',   'Saint ') =  @ImportCity THEN 'Match!'
        WHEN REPLACE(@City, 'St. ',  'Saint ') =  @ImportCity THEN 'Match!'
        WHEN REPLACE(@City, 'Ste ',  'Sainte ') = @ImportCity THEN 'Match!'
        WHEN REPLACE(@City, 'Ste. ', 'Sainte ') = @ImportCity THEN 'Match!'
        WHEN LEFT(@ImportCity, LEN('St ')) = 'St '
            AND RIGHT(@ImportCity, LEN('Genevieve')) = 'Genevieve'
            THEN 'Chauvinist!'
        WHEN LEFT(@ImportCity, LEN('St. ')) = 'St. '
            AND RIGHT(@ImportCity, LEN('Genevieve')) = 'Genevieve'
            THEN 'Chauvinist!'
        ELSE 'No Match!'
    END [Result?];
         

/*  Major Example 1-6  */

SELECT TOP 10
    A.StateOrProvince State,
    P.last_name [Last Name],
    P.first_name [First Name],
    P.company_name Company,
    P.City
FROM ref.PostalAbbreviations A
/*
   Attempt to join against our import data.
*/
LEFT OUTER JOIN dbo.PotentialMatches P ON
    A.Abbreviation = P.State
ORDER BY A.StateOrProvince;
         

