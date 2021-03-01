--This Is Script For Add New Columns To Tables

DECLARE @LogDate Varchar(20)='LogDate'
DECLARE @LogDate_Type Varchar(20)='ndtDateTime'
-----------------------------------------------------------
DECLARE @LogId Varchar(20)='LogId'
DECLARE @LogId_Type Varchar(20)='ndtInt'
-----------------------------------------------------------
DECLARE @Col_User_LoginId varchar(20)='User_LoginId'
DECLARE @Col_User_LoginId_Type varchar(20)='ndtInt'
-----------------------------------------------------------
--DECLARE @Col_UserId varchar(10)='UserId'
--DECLARE @Col_UserId_Type varchar(10)='ndtID'
-----------------------------------------------------------

Declare @Commands TABLE(Id bigint identity(1,1),Command varchar(max))
---------------------ADD LgDate Column----------------------------------
Insert INTO @Commands
						select 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@LogDate+' '+@LogDate_Type+' null'
						from
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@LogDate
						where 
							sys.columns.column_id is null 

---------------------ADD LogId Column--------------------------------------
Insert INTO @Commands
						select 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@LogId+' '+@LogId_Type+'  Identity(1,1)'
						from
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@LogId
						where 
							sys.columns.column_id is null 

---------------------ADD User_LoginId Column-------------------------------
Insert INTO @Commands
						select 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@Col_User_LoginId+' '+@Col_User_LoginId_Type+' null'
						from
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@Col_User_LoginId
						where 
							sys.columns.column_id is null 
--select * from @Commands

DECLARE @Id bigint=(SELECT TOP 1 Id FROM @Commands)

WHILE @Id IS NOT NULL
	BEGIN
		declare @cmd nvarchar(max)=(SELECT TOP 1 Command FROM @Commands WHERE Id=@Id)
		EXEC sp_executesql @cmd
		DELETE FROM @Commands WHERE Id=@Id
		set @Id=(SELECT TOP 1 Id FROM @Commands)
	END






	
