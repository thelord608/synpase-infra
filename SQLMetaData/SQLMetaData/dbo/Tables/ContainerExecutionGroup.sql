/****** Object:  Table [dbo].[ContainerExecutionGroup] ******/
CREATE TABLE [dbo].[ContainerExecutionGroup](
	[ContainerExecutionGroupKey] [int] IDENTITY(1,1) NOT NULL,
	[ContainerExecutionGroupName] [varchar](100) NOT NULL,
	[ContainerKey] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PKceg] PRIMARY KEY CLUSTERED 
(
	[ContainerExecutionGroupKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
