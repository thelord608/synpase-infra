/****** Object:  StoredProcedure [dbo].[uspInsertNotebookExecutionPlan] ******/
CREATE    PROCEDURE [dbo].[uspInsertNotebookExecutionPlan]
 @NotebookName VARCHAR(255)
,@NotebookExecutionGroupName VARCHAR(255)
,@ContainerExecutionGroupName VARCHAR(255)
,@DataFactoryName VARCHAR(255)
,@ContainerName VARCHAR(255)
,@NotebookOrder INT
AS
BEGIN
	DECLARE @NotebookKey INT;
	DECLARE @NotebookExecutionGroupKey INT;
	DECLARE @DataFactoryKey INT;
	DECLARE @ContainerKey INT;
	DECLARE @ContainerExecutionGroupKey INT;

	EXEC dbo.uspInsertNotebook @NotebookName=@NotebookName, @NotebookKey=@NotebookKey OUTPUT;
	EXEC dbo.uspInsertDataFactory @DataFactoryName=@DataFactoryName,@DataFactoryKey=@DataFactoryKey OUTPUT;
	EXEC dbo.uspInsertContainer @ContainerName=@ContainerName,@ContainerKey=@ContainerKey OUTPUT;
	EXEC dbo.uspInsertContainerExecutionGroup @ContainerExecutionGroupName=@ContainerExecutionGroupName,@ContainerName=@ContainerName,@ContainerExecutionGroupKey=@ContainerExecutionGroupKey OUTPUT;
	EXEC dbo.uspInsertNotebookExecutionGroup @NotebookExecutionGroupName=@NotebookExecutionGroupName,@ContainerExecutionGroupName=@ContainerExecutionGroupName,@NotebookExecutionGroupKey=@NotebookExecutionGroupKey OUTPUT;
	

	MERGE dbo.NotebookExecutionPlan t
	USING
	(
		SELECT 
		 @NotebookKey AS NotebookKey
		,@NotebookExecutionGroupKey AS NotebookExecutionGroupKey
		,@DataFactoryKey AS DataFactoryKey
		,@ContainerKey AS ContainerKey
		,@ContainerExecutionGroupKey AS ContainerExecutionGroupKey
		,@NotebookOrder AS NotebookOrder
	) s ON t.NotebookKey=s.NotebookKey
		AND t.NotebookExecutionGroupKey=s.NotebookExecutionGroupKey
	WHEN MATCHED THEN UPDATE
	SET 
	 t.DataFactoryKey=s.DataFactoryKey
	,t.ContainerKey=s.ContainerKey
	,t.ContainerExecutionGroupKey=s.ContainerExecutionGroupKey
	,t.NotebookOrder=s.NotebookOrder
	,t.IsActive=1
	,t.IsEmailEnabled=0
	,t.IsRestart=1
	,t.ModifiedDate = SYSDATETIME()
	WHEN NOT MATCHED THEN INSERT
	(
	 NotebookKey
	,NotebookExecutionGroupKey
	,DataFactoryKey
	,ContainerKey
	,ContainerExecutionGroupKey
	,NotebookOrder
	,IsActive
	,IsEmailEnabled
	,IsRestart
	,CreatedDate
	)
	VALUES
	(
	 s.NotebookKey
	,s.NotebookExecutionGroupKey
	,s.DataFactoryKey
	,s.Containerkey
	,s.ContainerExecutionGroupKey
	,s.NotebookOrder
	,1
	,0
	,1
	,SYSDATETIME()
	);

END
GO
