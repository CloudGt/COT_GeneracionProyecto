/****** Object:  Table [dbo].[cloudid_AppEndpoint]    Script Date: 6/8/2018 5:54:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_AppEndpoint](
	[AppEndpointID] [uniqueidentifier] NOT NULL,
	[ClientID] [uniqueidentifier] NOT NULL,
	[RedirectURL] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_cloudid_AppEndpoint] PRIMARY KEY CLUSTERED 
(
	[AppEndpointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_Apps]    Script Date: 6/8/2018 5:54:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_Apps](
	[ClientID] [uniqueidentifier] NOT NULL,
	[AppName] [nvarchar](50) NULL,
	[ClientSecret] [nvarchar](50) NULL,
 CONSTRAINT [PK_cloudid_Apps] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_AppScopes]    Script Date: 6/8/2018 5:54:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_AppScopes](
	[ClientID] [uniqueidentifier] NOT NULL,
	[ScopeID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_cloudid_AppScopes] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC,
	[ScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_Claims]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_Claims](
	[ClaimID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Definition] [nvarchar](max) NULL,
 CONSTRAINT [PK_cloudid_Claims] PRIMARY KEY CLUSTERED 
(
	[ClaimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_ClaimScopes]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_ClaimScopes](
	[ClaimID] [uniqueidentifier] NOT NULL,
	[ScopeID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_cloudid_ClaimScopes] PRIMARY KEY CLUSTERED 
(
	[ClaimID] ASC,
	[ScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_Grants]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_Grants](
	[GrantID] [uniqueidentifier] NOT NULL,
	[ClientID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[AuthCode] [nvarchar](50) NULL,
	[AccessToken] [nvarchar](50) NULL,
	[AccessTokenExpires] [datetime] NULL,
	[RefreshToken] [nvarchar](50) NULL,
	[RefreshTokenExpires] [datetime] NULL,
	[IP] [nvarchar](50) NULL,
	[Device] [nvarchar](50) NULL,
	[Location] [nvarchar](max) NULL,
 CONSTRAINT [PK_cloudid_Grants] PRIMARY KEY CLUSTERED 
(
	[GrantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_GrantScopes]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_GrantScopes](
	[GrantScopeID] [uniqueidentifier] NOT NULL,
	[GrantID] [uniqueidentifier] NOT NULL,
	[ScopeID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_cloudid_GrantScopes] PRIMARY KEY CLUSTERED 
(
	[GrantScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_Scopes]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_Scopes](
	[ScopeID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_cloudid_Scopes] PRIMARY KEY CLUSTERED 
(
	[ScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_UserClaims]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_UserClaims](
	[UserClaimID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ClaimID] [uniqueidentifier] NOT NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_cloudid_UserClaims] PRIMARY KEY CLUSTERED 
(
	[UserClaimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cloudid_Users]    Script Date: 6/8/2018 5:54:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cloudid_Users](
	[UserID] [uniqueidentifier] NOT NULL,
	[ProviderUserKey] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_cloudid_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cloudid_AppEndpoint] ADD  CONSTRAINT [DF_cloudid_AppEndpoint_AppEndpointID]  DEFAULT (newid()) FOR [AppEndpointID]
GO
ALTER TABLE [dbo].[cloudid_Apps] ADD  CONSTRAINT [DF_cloudid_Apps_ClientID]  DEFAULT (newid()) FOR [ClientID]
GO
ALTER TABLE [dbo].[cloudid_Claims] ADD  CONSTRAINT [DF_cloudid_Claims_ClaimTypeID]  DEFAULT (newid()) FOR [ClaimID]
GO
ALTER TABLE [dbo].[cloudid_Grants] ADD  CONSTRAINT [DF_cloudid_Grants_GrantID]  DEFAULT (newid()) FOR [GrantID]
GO
ALTER TABLE [dbo].[cloudid_GrantScopes] ADD  CONSTRAINT [DF_cloudid_GrantScopes_GrantScopeID]  DEFAULT (newid()) FOR [GrantScopeID]
GO
ALTER TABLE [dbo].[cloudid_Scopes] ADD  CONSTRAINT [DF_cloudid_Scopes_ScopeID]  DEFAULT (newid()) FOR [ScopeID]
GO
ALTER TABLE [dbo].[cloudid_UserClaims] ADD  CONSTRAINT [DF_cloudid_UserClaims_ClaimID]  DEFAULT (newid()) FOR [UserClaimID]
GO
ALTER TABLE [dbo].[cloudid_Users] ADD  CONSTRAINT [DF_cloudid_Users_UserID]  DEFAULT (newid()) FOR [UserID]
GO
ALTER TABLE [dbo].[cloudid_AppEndpoint]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_AppEndpoint_cloudid_Apps] FOREIGN KEY([ClientID])
REFERENCES [dbo].[cloudid_Apps] ([ClientID])
GO
ALTER TABLE [dbo].[cloudid_AppEndpoint] CHECK CONSTRAINT [FK_cloudid_AppEndpoint_cloudid_Apps]
GO
ALTER TABLE [dbo].[cloudid_AppScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_AppScopes_cloudid_Apps] FOREIGN KEY([ClientID])
REFERENCES [dbo].[cloudid_Apps] ([ClientID])
GO
ALTER TABLE [dbo].[cloudid_AppScopes] CHECK CONSTRAINT [FK_cloudid_AppScopes_cloudid_Apps]
GO
ALTER TABLE [dbo].[cloudid_AppScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_AppScopes_cloudid_Scopes] FOREIGN KEY([ScopeID])
REFERENCES [dbo].[cloudid_Scopes] ([ScopeID])
GO
ALTER TABLE [dbo].[cloudid_AppScopes] CHECK CONSTRAINT [FK_cloudid_AppScopes_cloudid_Scopes]
GO
ALTER TABLE [dbo].[cloudid_ClaimScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_ClaimScopes_cloudid_Claims1] FOREIGN KEY([ClaimID])
REFERENCES [dbo].[cloudid_Claims] ([ClaimID])
GO
ALTER TABLE [dbo].[cloudid_ClaimScopes] CHECK CONSTRAINT [FK_cloudid_ClaimScopes_cloudid_Claims1]
GO
ALTER TABLE [dbo].[cloudid_ClaimScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_ClaimScopes_cloudid_Scopes] FOREIGN KEY([ScopeID])
REFERENCES [dbo].[cloudid_Scopes] ([ScopeID])
GO
ALTER TABLE [dbo].[cloudid_ClaimScopes] CHECK CONSTRAINT [FK_cloudid_ClaimScopes_cloudid_Scopes]
GO
ALTER TABLE [dbo].[cloudid_Grants]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_Grants_cloudid_Apps] FOREIGN KEY([ClientID])
REFERENCES [dbo].[cloudid_Apps] ([ClientID])
GO
ALTER TABLE [dbo].[cloudid_Grants] CHECK CONSTRAINT [FK_cloudid_Grants_cloudid_Apps]
GO
ALTER TABLE [dbo].[cloudid_Grants]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_Grants_cloudid_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[cloudid_Users] ([UserID])
GO
ALTER TABLE [dbo].[cloudid_Grants] CHECK CONSTRAINT [FK_cloudid_Grants_cloudid_Users]
GO
ALTER TABLE [dbo].[cloudid_GrantScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_GrantScopes_cloudid_Grants] FOREIGN KEY([GrantID])
REFERENCES [dbo].[cloudid_Grants] ([GrantID])
GO
ALTER TABLE [dbo].[cloudid_GrantScopes] CHECK CONSTRAINT [FK_cloudid_GrantScopes_cloudid_Grants]
GO
ALTER TABLE [dbo].[cloudid_GrantScopes]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_GrantScopes_cloudid_Scopes] FOREIGN KEY([ScopeID])
REFERENCES [dbo].[cloudid_Scopes] ([ScopeID])
GO
ALTER TABLE [dbo].[cloudid_GrantScopes] CHECK CONSTRAINT [FK_cloudid_GrantScopes_cloudid_Scopes]
GO
ALTER TABLE [dbo].[cloudid_UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_UserClaims_cloudid_Claims] FOREIGN KEY([ClaimID])
REFERENCES [dbo].[cloudid_Claims] ([ClaimID])
GO
ALTER TABLE [dbo].[cloudid_UserClaims] CHECK CONSTRAINT [FK_cloudid_UserClaims_cloudid_Claims]
GO
ALTER TABLE [dbo].[cloudid_UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_cloudid_UserClaims_cloudid_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[cloudid_Users] ([UserID])
GO
ALTER TABLE [dbo].[cloudid_UserClaims] CHECK CONSTRAINT [FK_cloudid_UserClaims_cloudid_Users]
GO
