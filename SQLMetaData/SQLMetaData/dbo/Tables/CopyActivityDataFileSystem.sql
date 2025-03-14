/****** Object:  Table [dbo].[CopyActivityDataFileSystem] ******/
CREATE TABLE [dbo].[CopyActivityDataFileSystem](
	[CopyActivityDataFileSystemKey] [int] IDENTITY(1,1) NOT NULL,
	[CopyActivityDataFileSystemName] [varchar](100) NULL,
	[CopyActivityDataFileSystemFolderPath] [varchar](1000) NULL,
	[CopyActivityDataFileSystemFileName] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[LastRunDate] [datetime2](7) NULL,
	[CreateDate] [date] NULL,
	[ModifiedDate] [date] NULL,
	[ModifiedUser] [varchar](100) NULL,
	[CopyActivityDataFileSystemContainerName] [varchar](100) NULL,
 CONSTRAINT [PKCopyActivityDataFileSystemKey] PRIMARY KEY CLUSTERED 
(
	[CopyActivityDataFileSystemKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
