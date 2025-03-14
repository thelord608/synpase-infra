/****** Object:  StoredProcedure [dbo].[uspLogEventCopyActivityStart] ******/
CREATE PROCEDURE [dbo].[uspLogEventCopyActivityStart] 
(    	
      @CopyActivitySinkName					varchar(255)		--System::CopyActivityName
     , @CopyActivityTriggerID        	uniqueidentifier	--System::CopyActivityTriggerID
	 , @ServerExecutionId				bigint				--System::ServerExecutionID
     , @MachineName						varchar(255)		--System::MachineName
     , @UserName						varchar(255)		--System::UserName
     , @CopyActivityStartDate				datetime			--System::StartTime
	 , @ParentCopyActivityExecutionLogKey	bigint				--User::ParentCopyActivityExecutionLogKey
     , @CopyActivityCreationDate			datetime			--System::CreationDate
     , @CopyActivityCreatedBy				varchar(255)		--System::CreationName
)

AS
BEGIN

    SET NOCOUNT ON

    DECLARE @CopyActivitySinkKey					int
          , @CopyActivityExecutionLogKey		bigint
      
	


	SELECT @CopyActivitySinkKey = CopyActivitySinkKey
	  FROM CopyActivitySink 
     WHERE CopyActivitySinkName = @CopyActivitySinkName
	 
INSERT INTO [dbo].[CopyActivityExecutionLog]
           ([CopyActivityTriggerID]
           ,[CopyActivitySinkKey]
           ,[MachineName]
           ,[UserName]
           ,[CopyActivityStartDate]
           ,[CopyActivityStatus]
           ,[ParentCopyActivityExecutionLogKey]
           ,[CreatedDate])
    VALUES
		(
			  @CopyActivityTriggerID
			 ,@CopyActivitySinkKey
			 ,@MachineName
			 ,@UserName
			 ,@CopyActivityStartDate
			 ,'Running'
			 ,@ParentCopyActivityExecutionLogKey
			 ,GetDate()
		)

	SELECT @CopyActivityExecutionLogKey = SCOPE_IDENTITY()

	IF @ParentCopyActivityExecutionLogKey = 0
	  UPDATE CopyActivityExecutionLog 
	     SET ParentCopyActivityExecutionLogKey = @CopyActivityExecutionLogKey
	   WHERE CopyActivityExecutionLogKey = @CopyActivityExecutionLogKey

	SELECT @CopyActivityExecutionLogKey as CopyActivityExecutionLogKey 

END
GO
