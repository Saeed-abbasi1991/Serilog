--THIS SCRIPT IS FOR CONVERT COMPUTED COLUMNS TO REGULAR COLUMN
--<AUTHOR:ABBASI[1399-12-11]>
USE sadganBase
DECLARE @Cmd1 nvarchar(maX)
DECLARE @Cmd2 nvarchar(maX)
DECLARE @Cmd3 nvarchar(maX)
DECLARE @Cmd4 nvarchar(maX)
DECLARE @Cmd5 nvarchar(maX)
DECLARE @Cmd6 nvarchar(maX)
 
 DECLARE cmdcursor2 CURSOR FOR   
					SELECT 
					     N'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' ADD tmpcolumn'+sys.columns.name+' '+sys.types.name+' NULL' cmd1
						,N'UPDATE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' SET tmpcolumn'+sys.columns.name+'='+sys.columns.name cmd2
						,N'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' DROP COLUMN '+sys.columns.name cmd3
						,N'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' ADD '+sys.columns.name+' '+sys.types.name+' NULL ' cmd4
						,N'UPDATE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' SET '+sys.columns.name+'=tmpcolumn'+sys.columns.name cmd5
						,N'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.columns.object_id)+'.'+OBJECT_NAME(sys.columns.object_id)+' DROP COLUMN tmpcolumn'+sys.columns.name cmd6
				    FROM 
					  sys.columns
				    INNER JOIN
					  sys.objects ON sys.columns.object_id=sys.objects.object_id
				    INNER JOIN
					  sys.types   ON sys.columns.system_type_id=sys.types.system_type_id AND sys.columns.user_type_id=sys.types.user_type_id
				    WHERE 
					  sys.objects.type=N'U' 
					  AND sys.columns.is_computed=1
  
	OPEN cmdcursor2  
		FETCH NEXT FROM cmdcursor2 INTO @Cmd1,@Cmd2,@Cmd3,@Cmd4,@Cmd5,@Cmd6  
		WHILE @@FETCH_STATUS = 0  
			BEGIN  
				  PRINT @Cmd1  
				  EXEC sp_executesql @Cmd1
				  PRINT @Cmd2 
				  EXEC sp_executesql @Cmd2
				  PRINT @Cmd3
				  EXEC sp_executesql @Cmd3 
				  PRINT @Cmd4
				  EXEC sp_executesql @Cmd4 
				  PRINT @Cmd5 
				  EXEC sp_executesql @Cmd5
				  PRINT @Cmd6
				  EXEC sp_executesql @Cmd6
				FETCH NEXT FROM cmdcursor2 INTO  @Cmd1,@Cmd2,@Cmd3,@Cmd4,@Cmd5,@Cmd6    
			 END  
    CLOSE cmdcursor2  
 DEALLOCATE cmdcursor2 