/****** Object:  StoredProcedure [dbo].[uspLogEventNotebookStart] ******/
CREATE PROCEDURE [dbo].[uspLogEventNotebookStart] 
(    	
      @NotebookName					varchar(255)		--System::NotebookName
    , @PipelineTriggerID        	uniqueidentifier	--System::NotebookTriggerID
	, @PipelineRunId			    uniqueidentifier				--System::ServerExecutionID
    , @DataFactoryName				varchar(255)		--System::MachineName
    , @PipelineTriggerName			varchar(255)		--System::UserName
    , @PipelineTriggerType			varchar(255)		--System::UserName
    , @NotebookStartDate			datetime			--System::StartTime
	, @ParentPipelineExecutionLogKey	bigint				--User::ParentNotebookExecutionLogKey
 )

AS
BEGIN

    SET NOCOUNT ON

    DECLARE @NotebookKey					int
          , @NotebookExecutionLogKey		bigint
      
	
	IF NOT EXISTS (SELECT 1 
					 FROM Notebook 
					WHERE NotebookName = @NotebookName)
	BEGIN 
	
		INSERT INTO Notebook 
			(
				 NotebookName
				,NotebookCreationDate
				,NotebookCreatedBy
				,CreatedDate
			)
        VALUES 
			(
				  @NotebookName
				 ,GetDate()
				 ,CURRENT_USER
				 ,GetDate()
			)
        
	END
	ELSE
		UPDATE Notebook
		   SET NotebookCreationDate = getdate(),
			   NotebookCreatedBy = CURRENT_USER,
			   ModifiedDate = GetDate()
	     WHERE NotebookName = @NotebookName

	SELECT @NotebookKey = NotebookKey
	  FROM Notebook 
     WHERE NotebookName = @NotebookName
	 
	INSERT INTO NotebookExecutionLog 
		(
			 NotebookKey
			,PipelineTriggerID
			,PipelineRunId
			,DataFactoryName
			,PipelineTriggerName
			,PipelineTriggerType
			,NotebookStartDate
			,NotebookStatus
			,ParentPipelineExecutionLogKey
			,CurrentUser
			,CreatedDate
		)
    VALUES
		(
			  @NotebookKey
			 ,@PipelineTriggerID
			 ,@PipelineRunId
			 ,@DataFactoryName
			 ,@PipelineTriggerName
			 ,@PipelineTriggerType
			 ,@NotebookStartDate
			 ,'Running'
			 ,@ParentPipelineExecutionLogKey
			 ,CURRENT_USER
			 ,GetDate()
		)

	SELECT @NotebookExecutionLogKey = SCOPE_IDENTITY()

	
	SELECT @NotebookExecutionLogKey as NotebookExecutionLogKey 

END
GO
