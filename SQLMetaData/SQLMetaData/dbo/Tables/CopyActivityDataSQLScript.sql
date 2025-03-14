/****** Object:  Table [dbo].[CopyActivityDataSQLScript] ******/
CREATE TABLE [dbo].[CopyActivityDataSQLScript](
	[CopyActivityDataSQLScriptKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivityDataSQLScriptName] [varchar](100) NULL,
	[CopyActivityDataSqlScript] [varchar](max) NULL,
	[CopyActivityDataIncrementalSqlScript] [varchar](max) NULL,
	[IsIncrementalLoad] [bit] NULL,
	[IsActive] [bit] NULL,
	[LastRunDate] [datetime2](7) NULL,
	[CreateDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedUser] [varchar](100) NULL,
 CONSTRAINT [PKCopyActivityDataSQLScriptKey] PRIMARY KEY CLUSTERED 
(
	[CopyActivityDataSQLScriptKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
