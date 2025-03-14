/****** Object:  Table [dbo].[ContainerExecutionPlan] ******/
CREATE TABLE [dbo].[ContainerExecutionPlan](
	[ContainerKey] [int] NOT NULL,
	[DataFactoryKey] [int] NOT NULL,
	[ContainerExecutionGroupKey] [int] NOT NULL,
	[ExecutionGroupKey] [int] NOT NULL,
	[ContainerActivityTypeKey] [int] NOT NULL,
	[ContainerOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[IsRestart] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PKsep] PRIMARY KEY CLUSTERED 
(
	[ContainerKey] ASC,
	[DataFactoryKey] ASC,
	[ContainerExecutionGroupKey] ASC,
	[ExecutionGroupKey] ASC,
	[ContainerActivityTypeKey] ASC,
	[ContainerOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
