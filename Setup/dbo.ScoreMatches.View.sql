USE [TestDB]
GO
DROP VIEW [dbo].[ScoreMatches]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScoreMatches]
AS
(
    SELECT
        CustomerLastName,
        CustomerFirstName,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        'MobilePhone' Attribute,
        IIF(CustomerMobilePhone IS NOT NULL
            AND ImportMobilePhone IS NOT NULL
            /*
               Changed it back to 1.
            */
            AND REPLACE(CustomerMobilePhone, '-', '') =
                REPLACE(ImportMobilePhone, '-', ''), 1, 0) Score
    FROM AttemptToMatch
);
GO
