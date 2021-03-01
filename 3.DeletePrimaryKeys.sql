--This Scripts Delete All PrimaryKeys
use sadganBase
declare @Commands TABLE(Id bigint identity(1,1),Command varchar(max));

Insert Into @Commands 
					 SELECT 
							N'ALTER TABLE '
							+OBJECT_SCHEMA_NAME(sys.objects.object_id)
							+'.'
							+tbls.name
							+' DROP CONSTRAINT '
							+indexs.name
					FROM 
						sys.indexes indexs 
					INNER JOIN 
						sys.index_columns indexcolumns ON  indexs.object_id = indexcolumns.object_id and indexs.index_id = indexcolumns.index_id 
					INNER JOIN 
						sys.columns cols ON indexcolumns.object_id = cols.object_id and indexcolumns.column_id = cols.column_id 
					INNER JOIN 
						sys.tables tbls ON indexs.object_id = tbls.object_id 
					INNER JOIN 
						sys.objects on tbls.object_id=sys.objects.object_id
					WHERE 
						indexs.is_primary_key = 1 

select * from @Commands

DECLARE @Id bigint=(SELECT TOP 1 id from @Commands)

WHILE @Id is not null
BEGIN
		DECLARE @cmd nvarchar(max)=(select top 1 command from @Commands where Id=@Id)
		EXEC sp_executesql @cmd
		DELETE FROM @Commands where Id=@Id
		SELECT @Id=(SELECT TOP 1 Id FROM @Commands)
END





