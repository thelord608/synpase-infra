/****** Object:  Table [dbo].[Container] ******/
CREATE TABLE [dbo].[Container](
	[ContainerKey] [int] IDENTITY(1,1) NOT NULL,
	[ContainerName] [varchar](255) NOT NULL,
	[SystemKey] [int] NOT NULL,
	[ContainerTypeKey] [int] NOT NULL,
	[ContainerDate] [datetime] NULL,
	[ContainerCreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PKs] PRIMARY KEY CLUSTERED 
(
	[ContainerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
