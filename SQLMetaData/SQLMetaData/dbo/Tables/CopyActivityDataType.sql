/****** Object:  Table [dbo].[CopyActivityDataType] ******/
CREATE TABLE [dbo].[CopyActivityDataType](
	[CopyActivityDataTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivityDataTypeName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreateDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedUser] [varchar](100) NULL,
 CONSTRAINT [PKCopyActivityDataTypeKey] PRIMARY KEY CLUSTERED 
(
	[CopyActivityDataTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
