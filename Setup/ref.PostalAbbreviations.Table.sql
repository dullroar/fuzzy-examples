USE [TestDB]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ref].[PostalAbbreviations]') AND type in (N'U'))
DROP TABLE [ref].[PostalAbbreviations]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ref].[PostalAbbreviations](
	[StateOrProvince] [nvarchar](50) NOT NULL,
	[FIPS] [int] NOT NULL,
	[Abbreviation] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Alabama', 1, N'AL')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Alaska', 2, N'AK')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Arizona', 4, N'AZ')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Arkansas', 5, N'AR')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'California', 6, N'CA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Colorado', 8, N'CO')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Connecticut', 9, N'CT')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Delaware', 10, N'DE')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'District of Columbia', 11, N'DC')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Florida', 12, N'FL')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Georgia', 13, N'GA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Hawaii', 15, N'HI')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Idaho', 16, N'ID')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Illinois', 17, N'IL')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Indiana', 18, N'IN')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Iowa', 19, N'IA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Kansas', 20, N'KS')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Kentucky', 21, N'KY')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Louisiana', 22, N'LA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Maine', 23, N'ME')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Maryland', 24, N'MD')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Massachusetts', 25, N'MA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Michigan', 26, N'MI')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Minnesota', 27, N'MN')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Mississippi', 28, N'MS')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Missouri', 29, N'MO')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Montana', 30, N'MT')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Nebraska', 31, N'NE')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Nevada', 32, N'NV')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'New Hampshire', 33, N'NH')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'New Jersey', 34, N'NJ')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'New Mexico', 35, N'NM')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'New York', 36, N'NY')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'North Carolina', 37, N'NC')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'North Dakota', 38, N'ND')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Ohio', 39, N'OH')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Oklahoma', 40, N'OK')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Oregon', 41, N'OR')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Pennsylvania', 42, N'PA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Rhode Island', 44, N'RI')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'South Carolina', 45, N'SC')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'South Dakota', 46, N'SD')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Tennessee', 47, N'TN')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Texas', 48, N'TX')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Utah', 49, N'UT')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Vermont', 50, N'VT')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Virginia', 51, N'VA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Washington', 53, N'WA')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'West Virginia', 54, N'WV')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Wisconsin', 55, N'WI')
INSERT [ref].[PostalAbbreviations] ([StateOrProvince], [FIPS], [Abbreviation]) VALUES (N'Wyoming', 56, N'WY')
GO
