/*  Major Example 2-1  */

SELECT
    ISNUMERIC('1E3')     [Sci Notation Is Numeric],
    ISNUMERIC('1.0')     [As Is Decimal],
    ISNUMERIC('-1.0E-3') [Neg #s and Exponents Are Numeric],
    /*
       Maybe this one is surprising to you? It originally was to me!
    */
    ISNUMERIC('$100.00') [Currency Is, Too];
         

/*  Major Example 2-2  */

SELECT '-' [Test], ISNUMERIC('-') [Result], 'A hyphen is "numeric"' [Comment]
UNION
SELECT '.',        ISNUMERIC('.'), 'A period is "numeric"'
UNION
SELECT '+',        ISNUMERIC('+'), 'A plus sign is "numeric"'
UNION
SELECT '$',        ISNUMERIC('$'), 'A currency symbol is "numeric"'
UNION
SELECT '£',        ISNUMERIC('£'), 'A currency symbol outside my locale is "numeric"'
UNION
SELECT ',',        ISNUMERIC(','), 'A comma is "numeric," because Europe'
UNION
SELECT '/',        ISNUMERIC('/'), 'Binary operators are not "numeric."'
UNION
SELECT '0xABCDEF', ISNUMERIC('0xABCDEF'), 'Hex is not considered "numeric"'
UNION
SELECT '1/1/1990', ISNUMERIC('1/1/1990'), 'A date is not consider "numeric"'
--ORDER BY ;
         

