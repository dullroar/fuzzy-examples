USE [TestDB]
GO
DROP VIEW [dbo].[AttemptToMatch]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AttemptToMatch]
AS
(
    SELECT
        C.LastName    [CustomerLastName],
        C.FirstName   [CustomerFirstName],
        C.Address1    [CustomerAddress1],
        C.PostalCode  [CustomerPostalCode],
        C.MobilePhone [CustomerMobilePhone],
        I.LastName    [ImportLastName],
        I.FirstName   [ImportFirstName],
        I.Address1    [ImportAddress1],
        I.PostalCode  [ImportPostalCode],
        I.MobilePhone [ImportMobilePhone]
    FROM  crm.NormalizedCustomer C
    LEFT OUTER JOIN staging.ImportCustomer I ON
        COALESCE(REPLACE(C.MobilePhone, '-', ''), '') =
        COALESCE(REPLACE(I.MobilePhone, '-', ''), '')
)
GO
