--This Scripts Delete All ForiegnKeys
use sadganBase
DECLARE @T TABLE (id int identity(1,1), cmd nvarchar(max));
INSERT INTO @T
				select 
					N'ALTER TABLE '
					+ OBJECT_SCHEMA_NAME(sys.objects.parent_object_id) + '.' 
					+ OBJECT_NAME(sys.objects.parent_object_id) 
					+ ' DROP CONSTRAINT ' + OBJECT_NAME(sys.objects.object_id) 
				from 
					sys.foreign_keys
				inner join 
					sys.objects on sys.foreign_keys.object_id=sys.objects.object_id 
				order by 
					sys.foreign_keys.object_id desc

DECLARE @id int
SET @id = (SELECT TOP 1 id FROM @T)
WHILE @id is not null
begin
	DECLARE @cmd nvarchar(max)
	SELECT @cmd=cmd FROM @T WHERE id=@id
	
	EXEC sp_executesql @cmd

	DELETE FROM @T WHERE id=@id
	SET @id = (SELECT TOP 1 id FROM @T)
end