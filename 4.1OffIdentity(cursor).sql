--This Scripts Set Identity Property Columns To No For All Tables
--Note:For Disable Identity From Yes To No This Command Not Effect On Table:AlTER TABLE MYTABLE SET IDENTITY OFF
--You Most Delete Column AND Create Again
USE sadganBase
DECLARE @Commands TABLE(Id BIGINT IDENTITY(1,1),Command Varchar(max))

DECLARE @Cmd1 nvarchar(max)
DECLARE @Cmd2 nvarchar(max)
DECLARE @Cmd3 nvarchar(max)
DECLARE @Cmd4 nvarchar(max)
DECLARE @Cmd5 nvarchar(max)
DECLARE @Cmd6 nvarchar(max)

 DECLARE cmdcursor2 CURSOR FOR   
					SELECT 
							' ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+
							' ADD tmpcolumn'+cols.name+' '+sys.types.name +' NULL'+ +char(13) as s1
											
							, 'UPDATE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+' SET '+'tmpcolumn'
							+cols.name+'='+cols.name +CHAR(13)as s2
											
							, 'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' DROP COLUMN '+cols.name  +char(13) as s3
											
							, 'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' ADD '+cols.name+' '+sys.types.name++' NULL '+char(13)as s4
											
							, 'UPDATE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+' SET '+cols.name+'='
							+'tmpcolumn'+cols.name+char(13)as s5
											
							,'ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' DROP COLUMN '+'tmpcolumn'+cols.name as s6
					 FROM
						sys.tables tbls
					 JOIN
						sys.identity_columns identities on tbls.object_id=identities.object_id
					 JOIN 
						sys.columns cols on identities.column_id=cols.column_id and identities.object_id=cols.object_id
					 JOIN 
						sys.objects on tbls.object_id=sys.objects.object_id 
					 JOIN 
						sys.types on cols.system_type_id=sys.types.system_type_id and cols.user_type_id=sys.types.user_type_id
  
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
				