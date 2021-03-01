--This Scripts Delete All ForiegnKeys
USE sadganBase
DECLARE @T TABLE (id int identity(1,1), cmd nvarchar(max));
INSERT INTO @T
				SELECT 
					N'ALTER TABLE '
					+ OBJECT_SCHEMA_NAME(sys.objects.parent_object_id) + '.' 
					+ OBJECT_NAME(sys.objects.parent_object_id) 
					+ ' DROP CONSTRAINT ' + OBJECT_NAME(sys.objects.object_id) 
				FROM 
					sys.foreign_keys
				INNER JOIN 
					sys.objects ON sys.foreign_keys.object_id=sys.objects.object_id
				ORDER BY 
					sys.foreign_keys.object_id desc

DECLARE @Id int
SET @Id = (SELECT TOP 1 id FROM @T)
WHILE @Id is not null
BEGIN
	DECLARE @cmd nvarchar(max)
	SELECT @cmd=cmd FROM @T WHERE id=@Id
	print @cmd
	EXEC sp_executesql @cmd

	DELETE FROM @T WHERE id=@Id
	SET @Id = (SELECT TOP 1 id FROM @T)
END