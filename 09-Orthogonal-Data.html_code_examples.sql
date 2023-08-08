/*  Major Example 9-1  */

SELECT
    CustomField3,
    CASE
        /*
           If NULL no worries.
        */
        WHEN CustomField3 IS NULL THEN 'No Email Found'
        /*
           If no @ in string, no email address found.
        */
        WHEN CHARINDEX('@', CustomField3) = 0 THEN 'No Email Found'
        /*
           If @ and no comma, then only email address in string.
        */
        WHEN CHARINDEX('@', CustomField3) > 0
            AND CHARINDEX(',', CustomField3) = 0
            THEN CustomField3
        /*
           If the email is first on the left, grab it.
        */
        WHEN CHARINDEX('@', CustomField3) > 0
            AND CHARINDEX(',', CustomField3) > CHARINDEX('@', CustomField3)
            THEN LEFT(CustomField3, CHARINDEX(',', CustomField3) - 1)
        /*
          If email is in the middle, then hold on!
        */
        WHEN CHARINDEX(',', CustomField3) > 0
         AND CHARINDEX('@', RIGHT(CustomField3, LEN(CustomField3) - 
                                  CHARINDEX(',', CustomField3))) >
                CHARINDEX(',', CustomField3)
            AND CHARINDEX('@', RIGHT(CustomField3, LEN(CustomField3) -
                                     CHARINDEX(',', CustomField3))) <
                CHARINDEX(',', RIGHT(CustomField3, LEN(CustomField3) -
                                     CHARINDEX(',', CustomField3)))
            THEN SUBSTRING(CustomField3,
                           CHARINDEX(',', CustomField3) + 1,
                           CHARINDEX(',',  RIGHT(CustomField3,
                                                 LEN(CustomField3) - 
                                                 CHARINDEX(',', CustomField3))) - 1)
        /*
           If the email is last on the right, grab it.
        */
        WHEN CHARINDEX(',', CustomField3) > 0
            AND CHARINDEX('@', CustomField3) > CHARINDEX(',', CustomField3)
            THEN RIGHT(CustomField3, LEN (CustomField3) - CHARINDEX(',', CustomField3))
        ELSE 'No Email Found'
    END [Email?]
FROM staging.CustomFields;
        

/*  Major Example 9-2  */

DECLARE @FullAddress VARCHAR(50) = '4 Kohler Memorial Dr, Brooklyn, NY 11230'
SELECT
    /*
       Street is easy.
    */
    LEFT
    (
        @FullAddress,
        PATINDEX('%, %', @FullAddress) - 1
    )                                                       [Street Address],
    /*
       City is hardest - grab the string between the
       the first comma we found above and the next.
       This is the hardest thing to understand in the book.
       You've seen this before, though. Don't be afraid.
    */
    LEFT
    (
        /*
           The remainder after grabbing street address.
        */
        RIGHT
        (
            @FullAddress, LEN(@FullAddress) - PATINDEX('%, %', @FullAddress) - 1
        ),
        /*
           How much of it comprises city (the land between the two commas).
           Take the function calls apart "from the inside out." You got this.
        */
        LEN
        (
            RIGHT
            (
                @FullAddress,
                LEN(@FullAddress) -
                PATINDEX('%, %', @FullAddress) - 1
            )
        ) -
        PATINDEX
        (
            '%, %',
            RIGHT
            (
                 @FullAddress,
                 LEN(@FullAddress) -
                 PATINDEX('%, %', @FullAddress)
             )
        )
    )                                                       [City],
    /*
       State is somewhat easy - it is the first
       two characters of the rightmost eight -
       ZIP code and the intervening space take
       up the other six characters at the end.
    */
    LEFT(RIGHT(@FullAddress, 8), 2)                         [State],
    /*
       ZIP is easiest.
    */
    RIGHT(@FullAddress, 5)                                  [ZIP Code];
         

