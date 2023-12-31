USE [TestDB]
GO
DROP VIEW [dbo].[ScoredCustomers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScoredCustomers]
AS
(
    SELECT TOP 100 PERCENT
        CustomerLastName,
        CustomerFirstName,
        CustomerAddress1,
        CustomerPostalCode,
        CustomerMobilePhone,
        SUM(Score) Score
    FROM ScoreMatches
    GROUP BY CustomerLastName, CustomerFirstName, CustomerAddress1,
        CustomerPostalCode, CustomerMobilePhone
    ORDER BY SUM(Score) DESC, CustomerLastName, CustomerFirstName
);
GO
