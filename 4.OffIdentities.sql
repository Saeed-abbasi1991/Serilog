--This Scripts Set Identity Property Columns To No For All Tables
--Note:For Disable Identity From Yes To No This Command Not Effect On Table:AlTER TABLE MYTABLE SET IDENTITY OFF
--You Most Delete Column AND Create Again
use sadganBase
DECLARE @Commands TABLE(Id BIGINT IDENTITY(1,1),Command Varchar(max))

INSERT INTO @Commands
					select 
							'EXEC sp_executesql N''ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+
							' ADD tmpcolumn'+cols.name+' '+sys.types.name +' NULL'+ '''' +char(13)
											
							+ 'EXEC sp_executesql N''UPDATE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+' SET '+'tmpcolumn'
							+cols.name+'='+cols.name+ '''' +CHAR(13)+
											
							+ 'EXEC sp_executesql N''ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' DROP COLUMN '+cols.name + '''' +char(13)
											
							+ 'EXEC sp_executesql N''ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' ADD '+cols.name+' '+sys.types.name++' NULL '+''''+char(13)
											
							+ 'EXEC sp_executesql N''UPDATE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name+' SET '+cols.name+'='
							+'tmpcolumn'+cols.name+''''+char(13)
											
							+ 'EXEC sp_executesql N''ALTER TABLE '+OBJECT_SCHEMA_NAME(sys.objects.object_id)+'.'+tbls.name
							+' DROP COLUMN '+'tmpcolumn'+cols.name+'''' 
					From 
						sys.tables tbls
					join
						sys.identity_columns identities on tbls.object_id=identities.object_id
					join 
						sys.columns cols on identities.column_id=cols.column_id and identities.object_id=cols.object_id
					join 
						sys.objects on tbls.object_id=sys.objects.object_id 
					join
						sys.types on cols.system_type_id=sys.types.system_type_id and cols.user_type_id=sys.types.user_type_id
					where 
						cols.name!='LogId'
select * from @Commands
				