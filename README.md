# SQL-CODES


	/****** Scripts for COVID Project  ******/

	
	CREATE DATABASE COVID19
	GO

	USE COVID19
	GO

	CREATE SCHEMA EDW
	GO

	CREATE SCHEMA STAGING
	GO
----------------------------------------------
    --SCRIPTS TO CREATE DIMENSION TABLES

	CREATE TABLE EDW.Dim_Region 
	(RegionID Int Identity (1,1),
	[Region Code] Int,
	Region nvarchar (50)
	CONSTRAINT PK_DimRegion PRIMARY KEY (RegionID)
	)

	CREATE TABLE EDW.Dim_Patient
	(PatientID Int Identity (1,1),
	[Gender Code] Int,
	[Gender] varchar (6),
	[Age group Code] Int,
	[Occupation Code] Int,
	[Occupation] nvarchar (50)
	CONSTRAINT PK_DimPatient PRIMARY KEY (PatientID)
	)
	ALTER TABLE EDW.Dim_Patient ADD Gender nvarchar (50)
	ALTER TABLE EDW.Dim_Patient DROP COLUMN Gender 


	CREATE TABLE EDW.Dim_Transmission
	(TransmissionID Int Identity (1,1),
	[Transmission Code] Int,
	[Transmission] nvarchar (50),
	CONSTRAINT PK_DimTransmission PRIMARY KEY (TransmissionID)
	)


	CREATE TABLE EDW.Dim_HospitalStatus
	(HospitalStatusID Int Identity (1,1),
	[Hospital Status Code] Int,
	[Hospital Status] nvarchar (50),
	CONSTRAINT PK_DimHospitalStatus PRIMARY KEY (HospitalStatusID)
	)

	ALTER Table EDW.Dim_HospitalStatus alter column [Hospital Status] nvarchar (255)

	CREATE TABLE EDW.Dim_Junk
	(
	JunkID INT IDENTITY (1,1),
	[Junk Code] INT,
	Junk NVARCHAR (255)
	CONSTRAINT PK_DimJunk PRIMARY KEY (JunkID)
	)

	--CALENDAR YEARWEEK TABLE WILL BE LOADED FROM CSV
	-------------------------------------------------------
	--SCRIPT TO CREATE FACT TABLE

	CREATE TABLE Fact_COVID19
	(
	Fact_COVID19_ID Int Identity (1,1),
	COV_ID Int,
	RegionID Int,
	OnsetYearWeekID Int,
	EpisodeYearWeekID Int,
	ResolvedYearWeekID Int,
	PatientID Int,
	TransmissionID Int, 
	HospitalStatusID Int, 
	DeathID Int,
	ResolvedID Int,
	AsymptomaticID Int,
	LoadDate Datetime,
	CONSTRAINT PK_FactCOVID19 PRIMARY KEY (Fact_COVID19_ID),
	CONSTRAINT FK_Region FOREIGN KEY (RegionID) REFERENCES EDW.Dim_Region(RegionID),
	CONSTRAINT FK_OnsetYearWeek FOREIGN KEY (OnsetYearWeekID) REFERENCES [EDW].[YearWeek](YearWeekID),
	CONSTRAINT FK_EpisodeYearWeek FOREIGN KEY (EpisodeYearWeekID) REFERENCES [EDW].[YearWeek](YearWeekID),
	CONSTRAINT FK_ResolvedYearWeek FOREIGN KEY (ResolvedYearWeekID) REFERENCES [EDW].[YearWeek](YearWeekID),
	CONSTRAINT FK_Patient FOREIGN KEY (PatientID) REFERENCES EDW.Dim_Patient(PatientID),
	CONSTRAINT FK_Transmission FOREIGN KEY (TransmissionID) REFERENCES EDW.Dim_Transmission(TransmissionID),
	CONSTRAINT FK_HospitalStatus FOREIGN KEY (HospitalStatusID) REFERENCES EDW.Dim_HospitalStatus(HospitalStatusID),
	CONSTRAINT FK_Death FOREIGN KEY (DeathID) REFERENCES EDW.Dim_Junk(JunkID),
	CONSTRAINT FK_Resolved FOREIGN KEY (ResolvedID) REFERENCES EDW.Dim_Junk(JunkID),
	CONSTRAINT FK_Asymptomic FOREIGN KEY (AsymptomaticID) REFERENCES EDW.Dim_Junk(JunkID),
	)

ALTER TABLE [EDW].[YearWeek] ADD CONSTRAINT PK_YearWeek PRIMARY KEY ([YearWeekID])

ALTER TABLE [EDW].[YearWeek] ALTER COLUMN [YearWeekID] INT not null


CREATE TABLE EDW.Anomalies
(
AnomalityID Int Identity (1,1),
[ColumnName] nvarchar (50),
ColumnID Int,
LoadDate Datetime
)
