--THIS SCRIPT CONVERT NOT NULL COLUMNS TO NULL COLUMNS
--NOTE:BEFORE RUN THIS SCRIPT YOU MUST RUN NOTCOMPUTING SCRIPT
--UNCOMPUTING SCRIPT:CONVERT ALL COMPUTE COLUMNS TO REGULAR COLUMNS
--<AUTHOR:ABBASI[1399-12-11]>
DECLARE @Cmd6 nvarchar(maX)
DECLARE @Cmd5 nvarchar(maX)
DECLARE @Cmd4 nvarchar(maX)
DECLARE @Cmd3 nvarchar(maX)
DECLARE @Cmd2 nvarchar(maX)
DECLARE @Cmd1 nvarchar(maX)

 DECLARE cmdcursor2 CURSOR FOR   
					SELECT 
					    'ALTER TABLE '
				        +OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+OBJECT_NAME(sys.objects.object_id)
				        +' ALTER COLUMN ['+sys.columns.name+'] '+sys.types.name+' NULL' 
				    FROM 
					  sys.columns
				    inner join
					  sys.objects ON sys.columns.object_id=sys.objects.object_id
				    inner join
					  sys.types   ON sys.columns.system_type_id=sys.types.system_type_id AND sys.columns.user_type_id=sys.types.user_type_id
				    WHERE 
					  sys.objects.type=N'U' 
					  AND sys.columns.is_nullable=0
					  AND sys.columns.name!='LogId'
  
	OPEN cmdcursor2  
		FETCH NEXT FROM cmdcursor2 INTO @Cmd1  
		WHILE @@FETCH_STATUS = 0  
			BEGIN  
				  PRINT @Cmd1 
				  exec sp_executesql @Cmd1  
				FETCH NEXT FROM cmdcursor2 INTO  @Cmd1   
			 END  
    CLOSE cmdcursor2  
  DEALLOCATE cmdcursor2 