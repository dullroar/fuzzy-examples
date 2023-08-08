/*  Major Example 3-1  */

DECLARE @City     VARCHAR(50) = 'O''Fallon'  /* How we store it   */
DECLARE @USPSCity VARCHAR(50) = 'OFallon'    /* How USPS wants it */
/*
   TRANSLATE, REPLACE and compare both sides.
*/
SELECT
    @City City,
    @USPSCity [USPS City],
    CASE @City
        WHEN @USPSCity THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?],
    REPLACE
    (
        TRANSLATE(@City, '.,-''()[]`', '         '), ' ', ''
    ) [Norm. City],
    REPLACE
    (
        TRANSLATE(@USPSCity, '.,-''()[]`', '         '), ' ', ''
    ) [Norm. USPS City],
    CASE REPLACE(TRANSLATE(@City, '.,-''()[]`', '         '), ' ', '')
        WHEN REPLACE(TRANSLATE(@USPSCity, '.,-''()[]`', '         '), ' ', '')
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match Now?];
        

/*  Major Example 3-2  */

SELECT
    REPLACE(
        TRANSLATE(
            LEFT(LastName,
                /*
                   If a space is found...
                */
                IIF(CHARINDEX(' ', LastName) > 0,
                    /*
                       ...then use its location.
                    */
                    CHARINDEX(' ', LastName) - 1,
                    /*
                       Else use this calculation instead.
                    */
                    LEN(LastName)
                    )
                ),
            '.,-''()[]`', /* Translate these characters */
            '         '   /* ...into spaces             */
            ),
        /*
           Replace spaces with empty strings
        */
        ' ', '') [Normalized Last Name]
FROM crm.NormalizedCustomer
WHERE
    LastName IN ('Snedley, Jr.', 'O''Connor');                
        

/*  Major Example 3-3  */

DECLARE @FullName       VARCHAR(50) = 'Smedley & Sons, L.L.C.'
DECLARE @NormalizedName VARCHAR(50)
SET @NormalizedName = REPLACE
                      (
                          TRANSLATE(@FullName, '.,-''()[]`', '         '), ' ', ''
                      )
SELECT
    @FullName       [Full Name],
    @NormalizedName [Normalized Full Name],
    /*
       Important to use normalized name here to rid us of that
       pesky punctuation first.
    */
    CASE
        WHEN RIGHT(@NormalizedName, 3)  IN ('LLC', 'INC')   THEN 'Business'
        WHEN RIGHT(@NormalizedName, 4)  IN ('CORP')         THEN 'Business'
        WHEN RIGHT(@NormalizedName, 5)  IN ('TRUST')        THEN 'Business'
        WHEN RIGHT(@NormalizedName, 6)  IN ('ESTATE')       THEN 'Business'
        WHEN RIGHT(@NormalizedName, 7)  IN ('LIMITED')      THEN 'Business'
        WHEN RIGHT(@NormalizedName, 11) IN ('CORPORATION')  THEN 'Business'
        WHEN RIGHT(@NormalizedName, 12) IN ('INCORPORATED') THEN 'Business'
        ELSE 'Person'
    END [Contact Type];
         

