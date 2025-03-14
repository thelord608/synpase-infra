/****** Object:  StoredProcedure [dbo].[uspLogEventNotebookError] ******/
CREATE PROCEDURE [dbo].[uspLogEventNotebookError]
(    
	  @NotebookExecutionLogKey			bigint						--User::NotebookLogKey
    , @SourceName						varchar(255)				--User::SourceName
    , @ErrorCode						int							--System::ErrorCode
    , @ErrorDescription					varchar(2000)				--System::ErrorDescription
)
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO NotebookErrorLog 
		(
			 NotebookExecutionLogKey
			,SourceName
			,ErrorCode
			,ErrorDescription
			,CreatedDate
		)
    VALUES 
		(
			 @NotebookExecutionLogKey
			,@SourceName
			,@ErrorCode
			,@ErrorDescription
			,GetDate()
		)

    UPDATE NotebookExecutionLog
       SET NotebookStatus = 'Failed',
           NotebookEndDate = GetDate()
    WHERE  NotebookExecutionLogKey = @NotebookExecutionLogKey

END
GO
