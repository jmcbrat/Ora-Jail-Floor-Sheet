if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TempEmployee]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TempEmployee]
GO

CREATE TABLE [dbo].[TempEmployee] (
	[PersonID] [varchar] (64) NULL ,
	[FirstName] [varchar] (50) NULL ,
	[LastName] [varchar] (50) NULL ,
	[Gender] [varchar] (1) NULL ,
	[PersonType] [varchar] (50) NULL 
) ON [PRIMARY]
GO

