/*  Major Example 5-1  */

SELECT
    COUNT(*) [Exact Email Matches]
FROM crm.NormalizedCustomer C
INNER JOIN dbo.PotentialMatches P ON
    REPLACE
    (
        TRANSLATE(C.Email, '@."<>,', '      '), ' ', ''
    ) = REPLACE(TRANSLATE(P.email, '@."<>,', '      '), ' ', '')
WHERE
    0 NOT IN (CHARINDEX('@', P.email), CHARINDEX('.', P.email));
        

/*  Major Example 5-2  */

DECLARE @HomeEmail     VARCHAR(50) = 'mortimer.snedley@example.com'
DECLARE @WorkEmail     VARCHAR(50) = 'mortimer.snedley.jr@snedley.test'
DECLARE @IncomingEmail VARCHAR(50) = 'mortimer.snedley.jr@snedley.test'
SELECT
    CASE
        /*
           Test incoming against both home and work email columns.
        */
        WHEN @IncomingEmail IN (@HomeEmail, @WorkEmail) THEN 'Match!'
        ELSE 'No Match!'
    END [Did The Incoming Email Match?];
        

