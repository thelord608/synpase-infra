/****** Object:  StoredProcedure [dbo].[uspLogEventNotebookEnd] ******/
CREATE PROCEDURE [dbo].[uspLogEventNotebookEnd] 
(    
	  @NotebookExecutionLogKey	bigint						--User::NotebookExecutionLogKey
    , @NotebookStatus			varchar(50)
	, @NotebookName					varchar(255)
	, @NotebookExecutionGroupName varchar(255)				--User::NotebookKey
)
AS
BEGIN

	SET NOCOUNT ON
    
    UPDATE NotebookExecutionLog
	   SET NotebookStatus = @NotebookStatus,
		   NotebookEndDate = GetDate(),
		   ModifiedDate = GetDate()
     WHERE NotebookExecutionLogKey = @NotebookExecutionLogKey

	 IF(@NotebookStatus = 'SUCCEEDED')
		BEGIN
			UPDATE NotebookExecutionPlan
			SET IsRestart = 0 
			FROM	NotebookExecutionPlan pep
			INNER JOIN Notebook p ON
				p.NotebookKey = pep.NotebookKey
            INNER JOIN NotebookExecutionGroup peg ON
				pep.NotebookExecutionGroupKey = peg.NotebookExecutionGroupKey
			WHERE 
				peg.NotebookExecutionGroupName = @NotebookExecutionGroupName AND 
				p.NotebookName = @NotebookName AND
				peg.IsActive = 1 AND
				pep.IsRestart = 1
		END    
END
GO
