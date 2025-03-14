/****** Object:  StoredProcedure [dbo].[uspCopyActivityParameter] ******/
CREATE PROCEDURE [dbo].[uspCopyActivityParameter]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivityParameter_Staging])

DROP TABLE IF EXISTS #CopyActivityParameter_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL Script to Merge] ASC) AS ID
,[SQL Script to Merge]
INTO #CopyActivityParameter_Staging
FROM 
[dbo].[CopyActivityParameter_Staging]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF([SQL Script to Merge],LEN([SQL Script to Merge]),1,'') FROM #CopyActivityParameter_Staging WHERE ID = @Counter)
SET @SQLQuery = N'
MERGE dbo.CopyActivityParameter AS t
  USING (
  VALUES '+@SQLData+'
  ) as s
		(
			 CopyActivitySinkKey
			,CopyActivityParameterName
			,CopyActivityParameterValue
			,CreatedDate
			,ModifiedDate
		)
ON ( t.CopyActivitySinkKey = s.CopyActivitySinkKey AND t.CopyActivityParameterName = s.CopyActivityParameterName )
WHEN MATCHED THEN 
	UPDATE SET   CopyActivityParameterValue = s.CopyActivityParameterValue
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 CopyActivitySinkKey
			,CopyActivityParameterName
			,CopyActivityParameterValue
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.CopyActivitySinkKey
			,s.CopyActivityParameterName
			,s.CopyActivityParameterValue
			,s.CreatedDate
			,s.ModifiedDate
		  );'
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END

END
GO
