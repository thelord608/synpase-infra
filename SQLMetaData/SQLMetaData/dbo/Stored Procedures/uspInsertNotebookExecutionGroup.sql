/****** Object:  StoredProcedure [dbo].[uspInsertNotebookExecutionGroup] ******/
CREATE PROCEDURE [dbo].[uspInsertNotebookExecutionGroup]
 @NotebookExecutionGroupName VARCHAR(100)
,@ContainerExecutionGroupName VARCHAR(100)
,@NotebookExecutionGroupKey INT OUTPUT
AS
BEGIN
	DECLARE @tblNotebookExecutionGroup AS TABLE (NotebookExecutionGroupKey INT);
	DECLARE @ContainerExecutionGroupKey INT;
	
	SELECT @ContainerExecutionGroupkey = ContainerExecutionGroupKey 
	FROM dbo.ContainerExecutionGroup
	WHERE ContainerExecutionGroupName = @ContainerExecutionGroupName

	SELECT @NotebookExecutionGroupKey = NotebookExecutionGroupKey
	FROM dbo.NotebookExecutionGroup
	WHERE NotebookExecutionGroupName = @NotebookExecutionGroupName;

	IF @NotebookExecutionGroupKey IS NULL
	BEGIN
		INSERT dbo.NotebookExecutionGroup(NotebookExecutionGroupName,ContainerExecutionGroupKey,CreatedDate,IsActive,IsEmailEnabled)
		OUTPUT INSERTED.NotebookExecutionGroupKey INTO @tblNotebookExecutionGroup
		VALUES(@NotebookExecutionGroupName,@ContainerExecutionGroupKey,SYSDATETIME(),1,0);

		SELECT TOP 1 @NotebookExecutionGroupKey = NotebookExecutionGroupKey FROM @tblNotebookExecutionGroup;
	END
END
GO
