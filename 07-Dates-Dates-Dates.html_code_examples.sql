/*  Major Example 7-1  */

DECLARE @CustomerDOB DATETIME = '1990-04-01T12:53:49.000'
DECLARE @IncomingDOB DATE =     '1990-04-01'
SELECT
    CASE
        WHEN DATEPART(yyyy, @CustomerDOB) = DATEPART(yyyy, @IncomingDOB)
         AND DATEPART(mm,   @CustomerDOB) = DATEPART(mm,   @IncomingDOB)
         AND DATEPART(dd,   @CustomerDOB) = DATEPART(dd,   @IncomingDOB)
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

/*  Major Example 7-2  */

DECLARE @CustomerDOB DATETIME = '1990-04-01T12:53:49.000'
DECLARE @IncomingDOB DATE =     '1990-04-01'
SELECT
    CASE
        WHEN YEAR(@CustomerDOB) =  YEAR(@IncomingDOB)
         AND MONTH(@CustomerDOB) = MONTH(@IncomingDOB)
         AND DAY(@CustomerDOB) =   DAY(@IncomingDOB)
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

/*  Major Example 7-3  */

DECLARE @CustomerDOB DATETIME = '1990-04-01T12:53:49.000'
DECLARE @IncomingDOB DATE =     '1990-04-01'
SELECT
    CASE
        /*
           Style #23 is ISO 8601 format YYYY-MM-DD
        */
        WHEN CONVERT(VARCHAR(50), @CustomerDOB, 23) =
             CONVERT(VARCHAR(50), @IncomingDOB, 23)
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

/*  Major Example 7-4  */

DECLARE @CustomerDOB DATETIME = '1990-04-01T12:53:49.000'
DECLARE @IncomingDOB DATE =     '1990-04-01'
SELECT
    CASE
        WHEN CAST(@CustomerDOB AS DATE) = @IncomingDOB
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

/*  Major Example 7-5  */

DECLARE @CustomerDOB DATETIME = '1990-04-01T12:53:49.000'
DECLARE @IncomingDOB VARCHAR(50) = 'Aprool 1, 1990'
SELECT
    CASE
        WHEN ISDATE(@IncomingDOB) = 1
            AND CAST(@CustomerDOB AS DATE) = CAST(@IncomingDOB AS DATE)
            THEN 'Match!'
        ELSE 'No Match!'
    END [Do They Match?];
        

/*  Major Example 7-6  */

DECLARE @FutureDOB     DATETIME = '2990-04-01' /* Oops, data entry error */
DECLARE @TooYoungDOB   DATETIME = '2020-01-20' /* Here, too              */
DECLARE @HesDeadJimDOB DATETIME = '1890-04-01' /* Probably not alive     */
/*
   Two result sets in this example: First, the various outputs of DATEDIFF.
*/
SELECT
    DATEDIFF(dd,   GETDATE(), @FutureDOB)     [DOB # Days in Future],
    DATEDIFF(yyyy, GETDATE(), @TooYoungDOB)   [DOB # Years Into Past],
    DATEDIFF(yyyy, GETDATE(), @HesDeadJimDOB) [DOB # Years Into Past];
        

/*  Major Example 7-7  */

DECLARE @FutureDOB     DATETIME = '2990-04-01'
DECLARE @TooYoungDOB   DATETIME = '2020-01-20'
DECLARE @HesDeadJimDOB DATETIME = '1890-04-01'
/*
   Then how to use those as validity checks.
*/
SELECT
    CASE
        /*
           Any positive # is in the future.
        */
        WHEN DATEDIFF(dd, GETDATE(),  @FutureDOB) > 0 THEN 'Not Born Yet!'
        ELSE 'Valid.'
    END [Is Birthday Valid?],
    CASE
        /* 
           Pick an age with whom you may not legally do business - 18?
        */
        WHEN DATEDIFF(yyyy, GETDATE(), @TooYoungDOB) > -18
        THEN 'Too Young to Sign Contract!'
        ELSE 'Valid.'
    END [Is Customer Old Enough?],
    CASE
        /*
           110 years old s.b. celebrated - but are they doing biz with you?
        */
        WHEN DATEDIFF(yyyy, GETDATE(), @HesDeadJimDOB) <= -110
        THEN 'He''s Dead, Jim'
        ELSE 'Alive'
    END [Past Best By Date?];
        

/*  Major Example 7-8  */

DECLARE @Sys1Event1Time DATETIME = '2023-04-01T00:00:01.123Z'
DECLARE @Sys2Event1Time DATETIME = '2023-04-01T00:00:02.004Z'
DECLARE @Sys1Event2Time DATETIME = '2023-04-01T00:00:03.734Z'
DECLARE @Sys2Event2Time DATETIME = '2023-04-01T00:00:05.898Z'
SELECT
    DATEDIFF(ms, @Sys1Event1Time, @Sys2Event1Time) [Event 1 Time Δ in ms],
    CASE
        WHEN  DATEDIFF(ms, @Sys1Event1Time, @Sys2Event1Time) <= 1000 THEN 'Maybe?'
        ELSE 'Not the Same Event!'
    END [Sys1 and Sys2 Events #1 Correlated?],
    DATEDIFF(ms, @Sys1Event2Time, @Sys2Event2Time) [Event 2 Time Δ in ms],
    CASE
        WHEN  DATEDIFF(ms, @Sys1Event2Time, @Sys2Event2Time) <= 1000 THEN 'Maybe?'
        ELSE 'Not the Same Event!'
    END [Sys1 and Sys2 Events #2 Correlated?];
         

