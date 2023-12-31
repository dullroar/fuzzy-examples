USE [TestDB]
GO
DROP VIEW [crm].[CustomerCountByState]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [crm].[CustomerCountByState]
AS
(
    SELECT
        State,
        Total
    FROM
    (
        SELECT
            State,
            COUNT(*) Total
        FROM crm.NormalizedCustomer
        GROUP BY State
    ) A
    UNION
    SELECT
        A.Abbreviation State,
        0 Total
    FROM ref.PostalAbbreviations A
    LEFT OUTER JOIN crm.NormalizedCustomer C ON
        A.Abbreviation = C.State
    WHERE
        C.State IS NULL
);
GO
