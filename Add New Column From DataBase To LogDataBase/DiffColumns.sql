
DECLARE @DbLogName nvarchar(max)='sadganBase'
DECLARE @Commnads TABLE(Id bigint Identity(1,1),SchemaName nvarchar(max),TableName nvarchar(max),Command nvarchar(max))
INSERT INTO @Commnads
select 
		MainDB.schemaname,
		MainDB.tblname,
		'ALTER TABLE '+@DbLogName+'.'+MainDB.schemaname+'.'+MainDB.tblname+' ADD '+MainDB.colname+' '+MainDB.typename+' NULL'
		FROM
              (SELECT 
				     cols.name colname
					 ,cols.object_id objectid
					 ,OBJECT_NAME(cols.object_id) as tblname
					 ,dtype.name typename
					 ,OBJECT_SCHEMA_NAME(cols.object_id)schemaname 
			   FROM 
					 sadganPaloodDev.sys.columns cols
			   JOIN
					 sadganPaloodDev.sys.objects objs ON cols.object_id=objs.object_id
			   JOIN
					 sadganPaloodDev.sys.types dtype ON cols.system_type_id=dtype.system_type_id and cols.user_type_id=dtype.user_type_id
			   WHERE 
					 objs.type=N'U'
			    )MainDB
	   LEFT JOIN
				(SELECT 
				       cols.name colname
					   ,cols.object_id objectid
					   ,OBJECT_NAME(cols.object_id) as tblname
					   ,dtype.name typename
					   ,OBJECT_SCHEMA_NAME(cols.object_id)schemaname
				 FROM 
				       sadganBase.sys.columns cols
				 JOIN
				       sadganBase.sys.objects objs ON cols.object_id=objs.object_id
				 JOIN
				       sadganBase.sys.types dtype ON cols.system_type_id=dtype.system_type_id AND cols.user_type_id=dtype.user_type_id
				 WHERE 
					   objs.type=N'U'
				)LOGDB
		ON 
				MainDB.schemaname=LOGDB.schemaname AND  MainDB.tblname=LOGDB.tblname AND MainDB.colname=LOGDB.colname
		where 
					LOGDB.objectid is null 

					select * from @Commnads

DECLARE @Id bigint=(SELECT TOP 1 Id FROM @Commnads)

WHILE @Id IS NOT NULL
	BEGIN
		DECLARE @cmd nvarchar(max)=(SELECT TOP 1 Command FROM @Commnads WHERE Id=@Id)
		PRINT @cmd
		EXEC sp_executesql @cmd
		DELETE FROM @Commnads WHERE Id=@Id
		SET @Id=(SELECT TOP 1 Id FROM @Commnads)
	END
