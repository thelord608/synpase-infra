/****** Object:  StoredProcedure [dbo].[uspInsertNotebookParameters] ******/
CREATE PROCEDURE [dbo].[uspInsertNotebookParameters]
 @NotebookName VARCHAR(255) 
,@NotebookExecutionGroupName VARCHAR(255)
,@DataFactoryName VARCHAR(255)
,@ContainerName VARCHAR(255)
,@ContainerExecutionGroupName VARCHAR(255)
,@NotebookOrder INT
,@NumPartitions SMALLINT = 8
,@ExternalDataPath VARCHAR(255) = ''
,@FileExtension VARCHAR(5) = ''
,@FilePath VARCHAR(255) = ''
,@Delimiter VARCHAR(2) = ''
,@HasHeader BIT = 0
,@RawZoneNotebookPath VARCHAR(255) = ''
,@RawDataPath VARCHAR(255) = NULL
,@QueryZoneSchemaName VARCHAR(100) = ''
,@QueryZoneTableName VARCHAR(100) 
,@CombineFiles VARCHAR(255) = ''
,@PrimaryKeyColumns VARCHAR(255) = ''
,@TimestampColumns VARCHAR(255) = ''
,@QueryZoneNotebookPath VARCHAR(255) = ''
,@SummaryZoneNotebookPath VARCHAR(255) = ''
,@SummaryZoneRemoveHDFSOutputCommitterFiles BIT = NULL
,@SummaryZoneRenameSummaryOutputFile BIT = NULL
,@SanctionedZoneNotebookPath VARCHAR(255) = ''
,@VacuumRetentionHours INT = NULL
AS
BEGIN

	EXEC dbo.uspInsertNotebookExecutionPlan
	 @NotebookName=@NotebookName
	,@NotebookExecutionGroupName=@NotebookExecutionGroupName
	,@ContainerExecutionGroupName=@ContainerExecutionGroupName
	,@DataFactoryName=@DataFactoryName
	,@ContainerName=@ContainerName
	,@NotebookOrder=10;

	EXEC dbo.uspInsertContainerExecutionPlan_ForNotebookContainer
	 @ContainerName=@ContainerName
	,@DataFactoryName=@DataFactoryName
	,@ContainerExecutionGroupName=@ContainerExecutionGroupName
	,@NotebookExecutionGroupName=@NotebookExecutionGroupName
	,@ContainerActivityTypeName='Notebook'
	,@ContainerOrder = 10;

	DECLARE @NotebookKey INT;
	SELECT @NotebookKey = NotebookKey FROM dbo.Notebook WHERE NotebookName = @NotebookName;

	MERGE dbo.NotebookParameter AS t
	USING
	(
		SELECT @NotebookKey AS NotebookKey, 'queryZoneSchemaName' AS NotebookParameterName, @QueryZoneSchemaName AS NotebookParameterValue 
		UNION
		SELECT @NotebookKey, 'queryZoneTableName', @QueryZoneTableName 
		UNION
		SELECT @NotebookKey, 'combineFiles', @CombineFiles
		UNION
		SELECT @NotebookKey, 'queryZoneNotebookPath', @QueryZoneNotebookPath 
		UNION
		SELECT @NotebookKey, 'numPartitions', CONVERT(VARCHAR(4),@NumPartitions) 
		UNION
		SELECT @NotebookKey, 'containername', @ContainerName
		UNION
		SELECT @NotebookKey, 'rawDataPath', @RawDataPath 
		UNION
		SELECT @NotebookKey, 'primaryKeyColumns', @PrimaryKeyColumns 
		UNION
		SELECT @NotebookKey, 'timestampColumns', @TimestampColumns 
		UNION
		SELECT @NotebookKey, 'summaryZoneNotebookPath', @SummaryZoneNotebookPath
		UNION
		SELECT @NotebookKey, 'summaryZoneRemoveHDFSOutputCommitterFiles', COALESCE(CONVERT(CHAR(1),@SummaryZoneRemoveHDFSOutputCommitterFiles),'')
		UNION
		SELECT @NotebookKey, 'summaryZoneRenameSummaryOutputFile', COALESCE(CONVERT(CHAR(1),@SummaryZoneRenameSummaryOutputFile),'')
		UNION
		SELECT @NotebookKey, 'sanctionedZoneNotebookPath', @SanctionedZoneNotebookPath
		UNION
		SELECT @NotebookKey, 'externalDataPath',  @ExternalDataPath
		UNION
		SELECT @NotebookKey, 'filePath', @FilePath
		UNION
		SELECT @NotebookKey, 'fileExtension', @FileExtension
		UNION
		SELECT @NotebookKey, 'delimiter', @Delimiter
		UNION
		SELECT @NotebookKey, 'hasHeader', COALESCE(CONVERT(CHAR(1),@HasHeader),'')
		UNION
		SELECT @NotebookKey, 'rawZoneNotebookPath', @RawZoneNotebookPath
		UNION
		SELECT @NotebookKey, 'vacuumRetentionHours', COALESCE(CONVERT(VARCHAR(4), @VacuumRetentionHours),'')
	) AS s 
	ON t.NotebookKey=s.NotebookKey
		AND t.NotebookParameterName=s.NotebookParameterName
	WHEN MATCHED THEN UPDATE
	SET 
		t.NotebookParameterValue=s.NotebookParameterValue
		,ModifiedDate = SYSDATETIME()
	WHEN NOT MATCHED THEN INSERT
	(
		 NotebookKey,NotebookParameterName,NotebookParameterValue,CreatedDate
	)
	VALUES
	(
		s.NotebookKey,s.NotebookParameterName,s.NotebookParameterValue,SYSDATETIME()
	);
END;
GO
