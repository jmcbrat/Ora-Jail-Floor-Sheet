if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Charge]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Charge]
GO

CREATE TABLE [dbo].[Charge] (
	[Person_ID] [varchar] (64) NOT NULL ,
	[Booking_Number] [varchar] (64) NOT NULL ,
	[Charge_ID_Number] [varchar] (64) NULL ,
	[Statute_Number] [varchar] (64) NOT NULL ,
	[Statute_Class] [varchar] (64) NULL ,
	[Offense_Date] [char] (8) NULL ,
	[Offense_Time] [char] (6) NULL ,
	[Arrest_Number] [varchar] (64) NULL ,
	[Modifier] [varchar] (64) NULL ,
	[Case_Number] [varchar] (64) NOT NULL ,
	[Bail_Condition_Number] [varchar] (64) NOT NULL ,
	[State] [char] (1) NULL ,
	[Disposition_Reason] [varchar] (4) NULL ,
	[Sentence_Start_Date] [char] (8) NULL ,
	[Life_Sentence] [char] (1) NULL ,
	[Life_Sentence_No_Parole] [char] (1) NULL ,
	[Min_Years] [varchar] (5) NULL ,
	[Min_Months] [varchar] (5) NULL ,
	[Min_Weeks] [varchar] (5) NULL ,
	[Min_Days] [varchar] (5) NULL ,
	[Min_Hours] [varchar] (5) NULL ,
	[Max_Years] [varchar] (5) NULL ,
	[Max_Months] [varchar] (5) NULL ,
	[Max_Weeks] [varchar] (5) NULL ,
	[Max_Days] [varchar] (5) NULL ,
	[Max_Hours] [varchar] (5) NULL ,
	[ManMin_Years] [varchar] (5) NULL ,
	[ManMin_Months] [varchar] (5) NULL ,
	[ManMin_Weeks] [varchar] (5) NULL ,
	[ManMin_Days] [varchar] (5) NULL ,
	[ManMin_Hours] [varchar] (5) NULL ,
	[Credit] [varchar] (5) NULL ,
	[Assoc_Charge] [varchar] (64) NULL ,
	[Sentence_Type] [char] (1) NULL ,
	[Weekender] [char] (1) NULL ,
	[Indeterminate] [char] (1) NULL 
) ON [PRIMARY]
GO

