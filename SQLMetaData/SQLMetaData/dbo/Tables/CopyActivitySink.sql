/****** Object:  Table [dbo].[CopyActivitySink] ******/
CREATE TABLE [dbo].[CopyActivitySink](
	[CopyActivitySinkKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivitySinkName] [varchar](100) NOT NULL,
	[CopyActivitySinkDataKey] [int] NOT NULL,
	[CopyActivitySinkDataTypeKey] [int] NOT NULL,
	[CopyActivitySinkDataTargetKey] [int] NOT NULL,
	[CopyActivitySinkDataTargetTypeKey] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[LastRunDate] [datetime2](7) NULL,
	[CreateDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedUser] [varchar](100) NULL,
 CONSTRAINT [PKCopyActivitySinkKey] PRIMARY KEY CLUSTERED 
(
	[CopyActivitySinkKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
