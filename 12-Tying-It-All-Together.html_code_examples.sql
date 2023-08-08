/*  Major Example 12-1  */

WITH AttemptToMatch
AS
(
    SELECT
        C.LastName CustomerLastName,
        C.FirstName CustomerFirstName,
        C.Company CustomerCompany,
        C.Address1 CustomerAddress1,
        C.PostalCode CustomerPostalCode,
        C.MobilePhone CustomerMobilePhone,
        C.HomePhone CustomerHomePhone,
        C.Email CustomerEmail,
        I.LastName ImportLastName,
        I.FirstName ImportFirstName,
        I.Company ImportCompany,
        I.Address1 ImportAddress1,
        I.PostalCode ImportPostalCode,
        I.MobilePhone ImportMobilePhone,
        I.HomePhone ImportHomePhone,
        I.Email ImportEmail
    FROM  staging.NormalizedCustomer C
    LEFT OUTER JOIN staging.NormalizedImport I ON
    (
        (
            COALESCE(C.LastName, '') = COALESCE(I.LastName, '')
            AND COALESCE(C.FirstName, '') = COALESCE(I.FirstName, '')
        )
        OR COALESCE(C.Company, '') = COALESCE(I.Company, '')
    )
    AND
    (
        (
            COALESCE(C.Address1, '') = COALESCE(I.Address1, '')
            AND COALESCE(C.PostalCode, '') = COALESCE(I.PostalCode, '')
        )
        OR COALESCE(C.MobilePhone, '') IN
            (COALESCE(I.MobilePhone, ''), COALESCE(I.HomePhone, ''))
        OR COALESCE(C.HomePhone, '') IN
            (COALESCE(I.MobilePhone, ''), COALESCE(I.HomePhone, ''))
        OR COALESCE(C.Email, '') = COALESCE(I.Email, '')
    )
),
ScoreMatches
AS
(
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'LastName' Attribute,
        IIF(ImportLastName IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'FirstName' Attribute,
        IIF(ImportFirstName IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'Company' Attribute,
        IIF(ImportCompany IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'Address1' Attribute,
        IIF(ImportAddress1 IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'PostalCode' Attribute,
        IIF(ImportPostalCode IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'MobilePhone' Attribute,
        IIF(ImportMobilePhone IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'HomePhone' Attribute,
        IIF(ImportHomePhone IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
    UNION ALL
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        'Email' Attribute,
        IIF(ImportEmail IS NOT NULL, 1, 0) Score
    FROM  AttemptToMatch
),
ScoredCustomers
AS
(
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerCompany,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        CustomerHomePhone,
        CustomerEmail,
        SUM(Score) Score
    FROM ScoreMatches
    GROUP BY CustomerLastName, CustomerFirstName, CustomerCompany,
             CustomerAddress1, CustomerPostalCode, CustomerMobilePhone,
             CustomerHomePhone, CustomerEmail
)
SELECT
    C.CustomerLastName,
    C.CustomerFirstName,
    C.CustomerCompany,
    C.Score
FROM ScoredCustomers C
LEFT OUTER JOIN ScoreMatches S ON
    C.CustomerLastName = S.CustomerLastName
    AND C.CustomerFirstName = S.CustomerFirstName
    AND C.CustomerAddress1 = S.CustomerAddress1
    AND C.CustomerPostalCode = S.CustomerPostalCode
    AND C.CustomerMobilePhone = S.CustomerMobilePhone
WHERE
    C.Score > 0
GROUP BY C.CustomerLastName, C.CustomerFirstName, C.CustomerCompany,
         C.CustomerAddress1, C.CustomerPostalCode, C.CustomerMobilePhone,
         C.CustomerHomePhone, C.CustomerEmail, C.Score
ORDER BY C.Score DESC, C.CustomerLastName, C.CustomerFirstName, C.CustomerCompany;
         

