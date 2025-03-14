/****** Object:  Table [dbo].[ContainerParameter] ******/
CREATE TABLE [dbo].[ContainerParameter](
	[ContainerParameterKey] [int] IDENTITY(1,1) NOT NULL,
	[ContainerKey] [int] NOT NULL,
	[ContainerParameterName] [varchar](50) NOT NULL,
	[ContainerParameterValue] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PK_ContainerParameter] PRIMARY KEY CLUSTERED 
(
	[ContainerParameterKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
