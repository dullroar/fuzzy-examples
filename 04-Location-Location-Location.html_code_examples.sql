/*  Major Example 4-1  */

DECLARE @Street2         VARCHAR(50) = 'Suite 500'
DECLARE @IncomingStreet2 VARCHAR(50) = 'Ste 500'
SELECT
    @Street2         [Production Street2],
    @IncomingStreet2 [Incoming Data],
    /*
       The following shows the kind of normalization you can do to
       attempt to always being comparing "apples to apples" on both
       sides. You can add as many REPLACEs as you need. Ugh.
       Pay attention to the "column names" (variables) in each
       clause to keep clear what's going on.
    */
    REPLACE
    (
        REPLACE
        (
            REPLACE(@Street2, 'Suite', 'Ste'),
            'P.O. Box', 'Box'
        ),
        'Apartment', 'Apt'
    ) [Normalized Street2],
    REPLACE
    (
        REPLACE
        (
            REPLACE(@IncomingStreet2, 'Suite', 'Ste'),                         
            'P.O. Box', 'Box'
        ),
        'Apartment', 'Apt'
    ) [Normalized Incoming],
    CASE
        REPLACE
        (
            REPLACE
            (
                REPLACE(@Street2, 'Suite', 'Ste'),
                'P.O. Box', 'Box'
            ),
            'Apartment', 'Apt'
        )
        WHEN
            REPLACE
            (
                REPLACE
                (
                    REPLACE(@IncomingStreet2, 'Suite', 'Ste'),
                    'P.O. Box', 'Box'
                ),
                'Apartment', 'Apt'
            ) THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

