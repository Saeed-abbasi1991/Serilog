--This IS SCRIPT FOR Add NEW COLUMNS To ALLTables OF LOGDATABASE(SADGANBASE)
use sadganBase
DECLARE @LogDate Varchar(20)='LogDate'
DECLARE @LogDate_Type Varchar(20)='ndtDateTime'
-----------------------------------------------------------
DECLARE @LogId Varchar(20)='LogId'
DECLARE @LogId_Type Varchar(20)='ndtInt'
-----------------------------------------------------------
DECLARE @Col_User_LoginId varchar(20)='User_LoginId'
DECLARE @Col_User_LoginId_Type varchar(20)='ndtInt'
-----------------------------------------------------------
DECLARE @Action_Log varchar(20)='Log_Action'
DECLARE @Action_Log_Type varchar(20)='ndtSmallInt'

DECLARE @Commands TABLE(Id bigint identity(1,1),Command varchar(max))
---------------------ADD LgDate Column----------------------------------
Insert INTO @Commands
						SELECT 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@LogDate+' '+@LogDate_Type+' null'
						FROM
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@LogDate
						WHERE 
							sys.columns.column_id IS NULL  

---------------------ADD LogId Column--------------------------------------
Insert INTO @Commands
						SELECT 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@LogId+' '+@LogId_Type+'  Identity(1,1)'
						FROM
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@LogId
						WHERE 
							sys.columns.column_id IS NULL  

---------------------ADD User_LoginId Column-------------------------------
Insert INTO @Commands
						SELECT 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@Col_User_LoginId+' '+@Col_User_LoginId_Type+' null'
						FROM
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@Col_User_LoginId
						WHERE 
							sys.columns.column_id IS NULL 
--select * from @Commands


Insert INTO @Commands
						SELECT 
								--'Exec Sp_executesql N'' '
								--+
								N' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.tables.object_id)+'.'+sys.tables.name+'  ADD '+@Action_Log+' '+@Action_Log_Type+' null'
						FROM
							sys.tables
						Left join
							sys.columns on	sys.tables.object_id=sys.columns.object_id and sys.columns.name=@Action_Log
						WHERE 
							sys.columns.column_id IS NULL 




DECLARE @Id bigint=(SELECT TOP 1 Id FROM @Commands)

WHILE @Id IS NOT NULL
	BEGIN
		declare @cmd nvarchar(max)=(SELECT TOP 1 Command FROM @Commands WHERE Id=@Id)
		print @cmd
		EXEC sp_executesql @cmd
		DELETE FROM @Commands WHERE Id=@Id
		set @Id=(SELECT TOP 1 Id FROM @Commands)
	END






	
