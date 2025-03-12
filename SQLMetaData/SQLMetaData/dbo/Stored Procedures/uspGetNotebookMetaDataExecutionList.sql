/****** Object:  StoredProcedure [dbo].[uspGetNotebookMetaDataExecutionList] ******/
CREATE PROCEDURE [dbo].[uspGetNotebookMetaDataExecutionList] 
AS
BEGIN

	SET NOCOUNT ON

	SELECT	[ExcelName],[ExcelSpreadsheetName]
	FROM	[dbo].[NotebooksExcelSpreadSheets]
	
	WHERE  IsActive = 1
	
	ORDER BY 
			[ID]
END
GO
