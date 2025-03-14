/****** Object:  Table [dbo].[NotebookExecutionGroup] ******/
CREATE TABLE [dbo].[NotebookExecutionGroup](
	[NotebookExecutionGroupKey] [int] IDENTITY(1,1) NOT NULL,
	[NotebookExecutionGroupName] [varchar](255) NOT NULL,
	[ContainerExecutionGroupKey] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKnbegk] PRIMARY KEY CLUSTERED 
(
	[NotebookExecutionGroupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
