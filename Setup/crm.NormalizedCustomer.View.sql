USE [TestDB]
GO
DROP VIEW [crm].[NormalizedCustomer]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [crm].[NormalizedCustomer]
AS
(
    SELECT
        last_name LastName,
        first_name FirstName,
        company_name Company,
        address Address1,
        city City,
        county County,
        state State,
        zip PostalCode,
        country,
        /*
           We will discuss REPLACE and TRANSLATE in the chapter
           on SQL functions.
        */
        REPLACE(TRANSLATE(phone1, '-()', '   '), ' ', '') MobilePhone,
        REPLACE(TRANSLATE(phone2, '-()', '   '), ' ', '') HomePhone,
        email Email,
        web_address Web
    FROM crm.Customer
);
GO
