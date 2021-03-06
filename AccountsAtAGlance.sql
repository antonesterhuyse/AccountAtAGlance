SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[MarketIndexes]'
GO
CREATE TABLE [dbo].[MarketIndexes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Last] [decimal] (18, 2) NOT NULL,
[Change] [decimal] (18, 2) NOT NULL,
[PercentChange] [decimal] (18, 2) NOT NULL,
[DayHigh] [decimal] (18, 2) NOT NULL,
[DayLow] [decimal] (18, 2) NOT NULL,
[YearHigh] [decimal] (18, 2) NOT NULL,
[YearLow] [decimal] (18, 2) NOT NULL,
[Open] [decimal] (18, 2) NOT NULL,
[Volume] [decimal] (18, 2) NOT NULL,
[Title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Symbol] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RetrievalDateTime] [datetime] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_MarketIndexes] on [dbo].[MarketIndexes]'
GO
ALTER TABLE [dbo].[MarketIndexes] ADD CONSTRAINT [PK_MarketIndexes] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Exchanges]'
GO
CREATE TABLE [dbo].[Exchanges]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Exchanges] on [dbo].[Exchanges]'
GO
ALTER TABLE [dbo].[Exchanges] ADD CONSTRAINT [PK_Exchanges] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Securities]'
GO
CREATE TABLE [dbo].[Securities]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Change] [decimal] (18, 2) NOT NULL,
[PercentChange] [decimal] (18, 2) NOT NULL,
[Last] [decimal] (18, 2) NOT NULL,
[Shares] [decimal] (18, 2) NOT NULL,
[Symbol] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RetrievalDateTime] [datetime] NOT NULL,
[Company] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Securities] on [dbo].[Securities]'
GO
ALTER TABLE [dbo].[Securities] ADD CONSTRAINT [PK_Securities] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Securities_MutualFund]'
GO
CREATE TABLE [dbo].[Securities_MutualFund]
(
[MorningStarRating] [int] NOT NULL,
[Id] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Securities_MutualFund] on [dbo].[Securities_MutualFund]'
GO
ALTER TABLE [dbo].[Securities_MutualFund] ADD CONSTRAINT [PK_Securities_MutualFund] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Securities_Stock]'
GO
CREATE TABLE [dbo].[Securities_Stock]
(
[DayHigh] [decimal] (18, 2) NOT NULL,
[DayLow] [decimal] (18, 2) NOT NULL,
[Dividend] [decimal] (18, 2) NOT NULL,
[Open] [decimal] (18, 2) NOT NULL,
[Volume] [decimal] (18, 2) NOT NULL,
[YearHigh] [decimal] (18, 2) NOT NULL,
[YearLow] [decimal] (18, 2) NOT NULL,
[AverageVolume] [decimal] (18, 2) NOT NULL,
[MarketCap] [decimal] (18, 2) NOT NULL,
[ExchangeId] [int] NOT NULL,
[Id] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Securities_Stock] on [dbo].[Securities_Stock]'
GO
ALTER TABLE [dbo].[Securities_Stock] ADD CONSTRAINT [PK_Securities_Stock] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_ExchangeStock] on [dbo].[Securities_Stock]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_ExchangeStock] ON [dbo].[Securities_Stock] ([ExchangeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Positions]'
GO
CREATE TABLE [dbo].[Positions]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[SecurityId] [int] NOT NULL,
[Shares] [decimal] (18, 0) NOT NULL,
[Total] [decimal] (18, 0) NOT NULL,
[BrokerageAccountId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Positions] on [dbo].[Positions]'
GO
ALTER TABLE [dbo].[Positions] ADD CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_SecurityAccountPosition] on [dbo].[Positions]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_SecurityAccountPosition] ON [dbo].[Positions] ([SecurityId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_AccountPositionBrokerageAccount] on [dbo].[Positions]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_AccountPositionBrokerageAccount] ON [dbo].[Positions] ([BrokerageAccountId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[WatchListSecurity]'
GO
CREATE TABLE [dbo].[WatchListSecurity]
(
[WatchListId] [int] NOT NULL,
[SecurityId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_WatchListSecurity] on [dbo].[WatchListSecurity]'
GO
ALTER TABLE [dbo].[WatchListSecurity] ADD CONSTRAINT [PK_WatchListSecurity] PRIMARY KEY NONCLUSTERED ([WatchListId], [SecurityId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_WatchListSecurity_Security] on [dbo].[WatchListSecurity]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_WatchListSecurity_Security] ON [dbo].[WatchListSecurity] ([SecurityId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Customers]'
GO
CREATE TABLE [dbo].[Customers]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Zip] [int] NOT NULL,
[CustomerCode] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Customers] on [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[WatchLists]'
GO
CREATE TABLE [dbo].[WatchLists]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_WatchLists] on [dbo].[WatchLists]'
GO
ALTER TABLE [dbo].[WatchLists] ADD CONSTRAINT [PK_WatchLists] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[BrokerageAccounts]'
GO
CREATE TABLE [dbo].[BrokerageAccounts]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[AccountNumber] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountTitle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Total] [decimal] (18, 2) NOT NULL,
[MarginBalance] [decimal] (18, 2) NOT NULL,
[IsRetirement] [bit] NOT NULL,
[CustomerId] [int] NOT NULL,
[CashTotal] [decimal] (18, 2) NOT NULL,
[PositionsTotal] [decimal] (18, 2) NOT NULL,
[WatchListId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_BrokerageAccounts] on [dbo].[BrokerageAccounts]'
GO
ALTER TABLE [dbo].[BrokerageAccounts] ADD CONSTRAINT [PK_BrokerageAccounts] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_CustomerBrokerageAccount] on [dbo].[BrokerageAccounts]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_CustomerBrokerageAccount] ON [dbo].[BrokerageAccounts] ([CustomerId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_BrokerageAccountWatchList] on [dbo].[BrokerageAccounts]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_BrokerageAccountWatchList] ON [dbo].[BrokerageAccounts] ([WatchListId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[Orders]'
GO
CREATE TABLE [dbo].[Orders]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[NumberOfShares] [decimal] (18, 2) NOT NULL,
[Price] [decimal] (18, 2) NOT NULL,
[OrderTypeId] [int] NOT NULL,
[SecurityId] [int] NOT NULL,
[BrokerageAccountId] [int] NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_Orders] on [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_OrderTypeOrder] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_OrderTypeOrder] ON [dbo].[Orders] ([OrderTypeId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_OrderSecurity] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_OrderSecurity] ON [dbo].[Orders] ([SecurityId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_FK_BrokerageAccountOrder] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_FK_BrokerageAccountOrder] ON [dbo].[Orders] ([BrokerageAccountId])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[OrderTypes]'
GO
CREATE TABLE [dbo].[OrderTypes]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_OrderTypes] on [dbo].[OrderTypes]'
GO
ALTER TABLE [dbo].[OrderTypes] ADD CONSTRAINT [PK_OrderTypes] PRIMARY KEY CLUSTERED ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteSecuritiesAndExchanges]'
GO
create PROCEDURE dbo.DeleteSecuritiesAndExchanges

AS
	BEGIN
	 
	 		BEGIN TRANSACTION
		BEGIN TRY
			DELETE FROM WatchListSecurity;
			DELETE FROM Positions;   
			DELETE FROM Securities_Stock;
			DELETE FROM Securities_MutualFund;
			DELETE FROM Securities;
			DELETE FROM Exchanges; 
			DELETE FROM MarketIndexes	
			COMMIT TRANSACTION
			SELECT 0				
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			SELECT -1		
		END CATCH
	
	END
	 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[DeleteAccounts]'
GO

create PROCEDURE dbo.DeleteAccounts

AS
	BEGIN

		BEGIN TRANSACTION
			BEGIN TRY
				DELETE FROM Orders;                                              
				DELETE FROM BrokerageAccounts; 
				DELETE FROM WatchLists;  
				DELETE FROM Customers						
				COMMIT TRANSACTION
				SELECT 0				
			END TRY
			BEGIN CATCH
				ROLLBACK TRANSACTION
				SELECT -1		
			END CATCH
	END	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD
CONSTRAINT [FK_BrokerageAccountOrder] FOREIGN KEY ([BrokerageAccountId]) REFERENCES [dbo].[BrokerageAccounts] ([Id]),
CONSTRAINT [FK_OrderSecurity] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Positions]'
GO
ALTER TABLE [dbo].[Positions] ADD
CONSTRAINT [FK_AccountPositionBrokerageAccount] FOREIGN KEY ([BrokerageAccountId]) REFERENCES [dbo].[BrokerageAccounts] ([Id]),
CONSTRAINT [FK_SecurityAccountPosition] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[BrokerageAccounts]'
GO
ALTER TABLE [dbo].[BrokerageAccounts] ADD
CONSTRAINT [FK_CustomerBrokerageAccount] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]),
CONSTRAINT [FK_BrokerageAccountWatchList] FOREIGN KEY ([WatchListId]) REFERENCES [dbo].[WatchLists] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Securities_Stock]'
GO
ALTER TABLE [dbo].[Securities_Stock] ADD
CONSTRAINT [FK_ExchangeStock] FOREIGN KEY ([ExchangeId]) REFERENCES [dbo].[Exchanges] ([Id]),
CONSTRAINT [FK_Stock_inherits_Security] FOREIGN KEY ([Id]) REFERENCES [dbo].[Securities] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] ADD
CONSTRAINT [FK_OrderTypeOrder] FOREIGN KEY ([OrderTypeId]) REFERENCES [dbo].[OrderTypes] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[Securities_MutualFund]'
GO
ALTER TABLE [dbo].[Securities_MutualFund] ADD
CONSTRAINT [FK_MutualFund_inherits_Security] FOREIGN KEY ([Id]) REFERENCES [dbo].[Securities] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[WatchListSecurity]'
GO
ALTER TABLE [dbo].[WatchListSecurity] ADD
CONSTRAINT [FK_WatchListSecurity_Security] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id]),
CONSTRAINT [FK_WatchListSecurity_WatchList] FOREIGN KEY ([WatchListId]) REFERENCES [dbo].[WatchLists] ([Id])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Drop constraints from [dbo].[Positions]
ALTER TABLE [dbo].[Positions] DROP CONSTRAINT [FK_AccountPositionBrokerageAccount]
ALTER TABLE [dbo].[Positions] DROP CONSTRAINT [FK_SecurityAccountPosition]

-- Drop constraints from [dbo].[WatchListSecurity]
ALTER TABLE [dbo].[WatchListSecurity] DROP CONSTRAINT [FK_WatchListSecurity_Security]
ALTER TABLE [dbo].[WatchListSecurity] DROP CONSTRAINT [FK_WatchListSecurity_WatchList]

-- Drop constraints from [dbo].[Securities_Stock]
ALTER TABLE [dbo].[Securities_Stock] DROP CONSTRAINT [FK_ExchangeStock]
ALTER TABLE [dbo].[Securities_Stock] DROP CONSTRAINT [FK_Stock_inherits_Security]

-- Drop constraints from [dbo].[Securities_MutualFund]
ALTER TABLE [dbo].[Securities_MutualFund] DROP CONSTRAINT [FK_MutualFund_inherits_Security]

-- Drop constraints from [dbo].[BrokerageAccounts]
ALTER TABLE [dbo].[BrokerageAccounts] DROP CONSTRAINT [FK_BrokerageAccountWatchList]
ALTER TABLE [dbo].[BrokerageAccounts] DROP CONSTRAINT [FK_CustomerBrokerageAccount]

-- Drop constraint FK_BrokerageAccountOrder from [dbo].[Orders]
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_BrokerageAccountOrder]

-- Drop constraint FK_OrderSecurity from [dbo].[Orders]
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_OrderSecurity]

-- Add 1 row to [dbo].[Customers]
SET IDENTITY_INSERT [dbo].[Customers] ON
INSERT INTO [dbo].[Customers] ([Id], [FirstName], [LastName], [Address], [City], [State], [Zip], [CustomerCode]) VALUES (40, N'Marcus', N'Hightower', N'1234 Anywhere St.', N'Phoenix', N'AZ', 85229, N'C15643')
SET IDENTITY_INSERT [dbo].[Customers] OFF

-- Add 3 rows to [dbo].[Exchanges]
SET IDENTITY_INSERT [dbo].[Exchanges] ON
INSERT INTO [dbo].[Exchanges] ([Id], [Title]) VALUES (93, N'NYSE')
INSERT INTO [dbo].[Exchanges] ([Id], [Title]) VALUES (94, N'Nasdaq')
INSERT INTO [dbo].[Exchanges] ([Id], [Title]) VALUES (95, N'UNKNOWN EXCHANGE')
SET IDENTITY_INSERT [dbo].[Exchanges] OFF

-- Add 3 rows to [dbo].[MarketIndexes]
SET IDENTITY_INSERT [dbo].[MarketIndexes] ON
INSERT INTO [dbo].[MarketIndexes] ([Id], [Last], [Change], [PercentChange], [DayHigh], [DayLow], [YearHigh], [YearLow], [Open], [Volume], [Title], [Symbol], [RetrievalDateTime]) VALUES (118, 2791.19, 2.00, 0.07, 2806.20, 2785.27, 0.00, 0.00, 2787.78, 1901232697.00, N'NASDAQ Composite', N'.IXIC', '2011-04-05 19:36:15.747')
INSERT INTO [dbo].[MarketIndexes] ([Id], [Last], [Change], [PercentChange], [DayHigh], [DayLow], [YearHigh], [YearLow], [Open], [Volume], [Title], [Symbol], [RetrievalDateTime]) VALUES (119, 12393.90, -6.13, -0.05, 12438.14, 12353.34, 0.00, 0.00, 12402.08, 142257541.00, N'Dow Jones Industrial Average', N'DJI', '2011-04-05 19:36:15.747')
INSERT INTO [dbo].[MarketIndexes] ([Id], [Last], [Change], [PercentChange], [DayHigh], [DayLow], [YearHigh], [YearLow], [Open], [Volume], [Title], [Symbol], [RetrievalDateTime]) VALUES (120, 1332.63, -0.24, -0.02, 1338.21, 1330.03, 0.00, 0.00, 1332.03, 2947662807.00, N'S&P 500 INDEX', N'INX', '2011-04-05 19:36:15.747')
SET IDENTITY_INSERT [dbo].[MarketIndexes] OFF

-- Add 54 rows to [dbo].[Securities]
SET IDENTITY_INSERT [dbo].[Securities] ON
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2137, -0.25, -2.49, 9.81, 0.00, N'AA', '2012-04-04 21:33:59.497', N'Alcoa Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2138, -5.01, -0.80, 624.31, 0.00, N'AAPL', '2012-04-04 21:33:59.497', N'Apple Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2139, -5.67, -2.84, 193.99, 0.00, N'AMZN', '2012-04-04 21:33:59.497', N'Amazon.com, Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2140, -0.25, -1.34, 18.45, 0.00, N'AOL', '2012-04-04 21:33:59.497', N'AOL, Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2141, -0.98, -1.31, 73.67, 0.00, N'BA', '2012-04-04 21:33:59.497', N'The Boeing Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2142, -0.29, -3.06, 9.20, 0.00, N'BAC', '2012-04-04 21:33:59.497', N'Bank of America Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2143, -2.37, -1.61, 144.69, 0.00, N'BIDU', '2012-04-04 21:33:59.497', N'Baidu.com, Inc. (ADR)')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2144, -1.33, -3.66, 35.04, 0.00, N'C', '2012-04-04 21:33:59.497', N'Citigroup Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2145, 0.05, 0.05, 106.26, 0.00, N'CAT', '2012-04-04 21:33:59.497', N'Caterpillar Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2146, -2.64, -1.67, 155.68, 0.00, N'CRM', '2012-04-04 21:33:59.497', N'salesforce.com, inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2147, -0.46, -2.21, 20.36, 0.00, N'CSCO', '2012-04-04 21:33:59.497', N'Cisco Systems, Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2148, -1.54, -1.44, 105.60, 0.00, N'CVX', '2012-04-04 21:33:59.497', N'Chevron Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2149, -0.36, -0.83, 42.93, 0.00, N'DIS', '2012-04-04 21:33:59.497', N'The Walt Disney Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2150, -0.90, -2.46, 35.73, 0.00, N'EBAY', '2012-04-04 21:33:59.497', N'eBay Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2151, -0.67, -2.24, 29.18, 0.00, N'EMC', '2012-04-04 21:33:59.497', N'EMC Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2152, -0.14, -1.07, 12.51, 0.00, N'F', '2012-04-04 21:33:59.497', N'Ford Motor Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2153, -0.99, -1.26, 77.42, 0.00, N'FCNTX', '2012-04-04 21:33:59.497', N'Fidelity Contrafund')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2154, -0.55, -1.43, 38.03, 0.00, N'FCX', '2012-04-04 21:33:59.497', N'Freeport-McMoRan Copper & Gold Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2155, -0.49, -1.62, 29.71, 0.00, N'FDGFX', '2012-04-04 21:33:59.497', N'Fidelity Dividend Growth')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2156, -0.85, -0.93, 90.64, 0.00, N'FDX', '2012-04-04 21:33:59.497', N'FedEx Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2157, -1.00, -1.36, 72.68, 0.00, N'FMAGX', '2012-04-04 21:33:59.497', N'Fidelity Magellan')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2158, -0.47, -0.64, 72.63, 0.00, N'GD', '2012-04-04 21:33:59.497', N'General Dynamics Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2159, -0.22, -1.10, 19.74, 0.00, N'GE', '2012-04-04 21:33:59.497', N'General Electric Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2160, -7.47, -1.16, 635.15, 0.00, N'GOOG', '2012-04-04 21:33:59.497', N'Google Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2161, -0.86, -2.02, 41.66, 0.00, N'H', '2012-04-04 21:33:59.497', N'Hyatt Hotels Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2162, -3.45, -1.65, 206.05, 0.00, N'IBM', '2012-04-04 21:33:59.497', N'International Business Machines Corp.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2163, -0.18, -0.64, 27.93, 0.00, N'INTC', '2012-04-04 21:33:59.497', N'Intel Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2164, -0.70, -1.10, 62.69, 0.00, N'ITRGX', '2012-04-04 21:33:59.497', N'ING T Rowe Price Growth Equity S2')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2165, -1.01, -2.22, 44.41, 0.00, N'JPM', '2012-04-04 21:33:59.497', N'JPMorgan Chase & Co.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2166, -0.07, -0.13, 53.31, 0.00, N'K', '2012-04-04 21:33:59.497', N'Kellogg Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2167, 0.01, 0.02, 40.33, 0.00, N'LLY', '2012-04-04 21:33:59.497', N'Eli Lilly & Co.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2168, -0.73, -0.80, 90.34, 0.00, N'LMT', '2012-04-04 21:33:59.497', N'Lockheed Martin Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2169, -0.73, -2.29, 31.21, 0.00, N'MSFT', '2012-04-04 21:33:59.497', N'Microsoft Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2170, -0.46, -1.72, 26.24, 0.00, N'MTH', '2012-04-04 21:33:59.497', N'Meritage Homes Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2171, -0.38, -0.35, 109.49, 0.00, N'NKE', '2012-04-04 21:33:59.497', N'NIKE, Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2172, -0.06, -0.10, 61.45, 0.00, N'NOC', '2012-04-04 21:33:59.497', N'Northrop Grumman Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2173, -0.24, -4.52, 5.07, 0.00, N'NOK', '2012-04-04 21:33:59.497', N'Nokia Corporation (ADR)')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2174, -0.23, -0.78, 29.16, 0.00, N'ORCL', '2012-04-04 21:33:59.497', N'Oracle Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2175, 0.17, 0.25, 67.26, 0.00, N'PG', '2012-04-04 21:33:59.497', N'The Procter & Gamble Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2176, 0.00, 0.00, 0.00, 0.00, N'Q', '2012-04-04 21:33:59.497', N'')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2177, -0.20, -2.36, 8.29, 0.00, N'RBS', '2012-04-04 21:33:59.497', N'Royal Bank of Scotland Group plc (ADR)')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2178, -0.12, -0.23, 52.44, 0.00, N'RTN', '2012-04-04 21:33:59.497', N'Raytheon Company')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2179, -0.13, -4.51, 2.75, 0.00, N'S', '2012-04-04 21:33:59.497', N'Sprint Nextel Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2180, -1.04, -1.49, 68.69, 0.00, N'SLB', '2012-04-04 21:33:59.497', N'Schlumberger Limited.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2181, 0.18, 4.22, 4.45, 0.00, N'SPF', '2012-04-04 21:33:59.497', N'Standard Pacific Corp.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2182, 0.14, 0.45, 31.57, 0.00, N'T', '2012-04-04 21:33:59.497', N'AT&T Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2183, -0.40, -1.20, 32.94, 0.00, N'UL', '2012-04-04 21:33:59.497', N'Unilever plc (ADR)')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2184, -1.38, -1.15, 118.98, 0.00, N'V', '2012-04-04 21:33:59.497', N'Visa Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2185, -0.39, -0.64, 60.26, 0.00, N'WMT', '2012-04-04 21:33:59.497', N'Wal-Mart Stores, Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2186, -0.98, -3.30, 28.70, 0.00, N'X', '2012-04-04 21:33:59.497', N'United States Steel Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2187, -0.85, -0.99, 84.98, 0.00, N'XOM', '2012-04-04 21:33:59.497', N'Exxon Mobil Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2188, -0.16, -1.99, 7.90, 0.00, N'XRX', '2012-04-04 21:33:59.497', N'Xerox Corporation')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2189, 0.09, 0.59, 15.27, 0.00, N'YHOO', '2012-04-04 21:33:59.497', N'Yahoo! Inc.')
INSERT INTO [dbo].[Securities] ([Id], [Change], [PercentChange], [Last], [Shares], [Symbol], [RetrievalDateTime], [Company]) VALUES (2190, -0.43, -2.00, 21.08, 0.00, N'ZION', '2012-04-04 21:33:59.497', N'Zions Bancorporation')
SET IDENTITY_INSERT [dbo].[Securities] OFF

-- Add 3 rows to [dbo].[WatchLists]
SET IDENTITY_INSERT [dbo].[WatchLists] ON
INSERT INTO [dbo].[WatchLists] ([Id], [Title]) VALUES (116, N'My Watch Securities')
INSERT INTO [dbo].[WatchLists] ([Id], [Title]) VALUES (117, N'My Watch Securities')
INSERT INTO [dbo].[WatchLists] ([Id], [Title]) VALUES (118, N'My Watch Securities')
SET IDENTITY_INSERT [dbo].[WatchLists] OFF

-- Add 3 rows to [dbo].[BrokerageAccounts]
SET IDENTITY_INSERT [dbo].[BrokerageAccounts] ON
INSERT INTO [dbo].[BrokerageAccounts] ([Id], [AccountNumber], [AccountTitle], [Total], [MarginBalance], [IsRetirement], [CustomerId], [CashTotal], [PositionsTotal], [WatchListId]) VALUES (113, N'Z485739880', N'IRA', 1561099.00, 0.00, 1, 40, 5000.00, 1556099.00, 116)
INSERT INTO [dbo].[BrokerageAccounts] ([Id], [AccountNumber], [AccountTitle], [Total], [MarginBalance], [IsRetirement], [CustomerId], [CashTotal], [PositionsTotal], [WatchListId]) VALUES (114, N'Z485739881', N'Joint Brokerage', 1389806.00, 414888.67, 0, 40, 10000.00, 1379806.00, 117)
INSERT INTO [dbo].[BrokerageAccounts] ([Id], [AccountNumber], [AccountTitle], [Total], [MarginBalance], [IsRetirement], [CustomerId], [CashTotal], [PositionsTotal], [WatchListId]) VALUES (115, N'Z485739882', N'Brokerage Account', 811247.00, 270415.67, 0, 40, 15000.00, 796247.00, 118)
SET IDENTITY_INSERT [dbo].[BrokerageAccounts] OFF

-- Add 4 rows to [dbo].[Securities_MutualFund]
INSERT INTO [dbo].[Securities_MutualFund] ([Id], [MorningStarRating]) VALUES (2153, 4)
INSERT INTO [dbo].[Securities_MutualFund] ([Id], [MorningStarRating]) VALUES (2155, 4)
INSERT INTO [dbo].[Securities_MutualFund] ([Id], [MorningStarRating]) VALUES (2157, 4)
INSERT INTO [dbo].[Securities_MutualFund] ([Id], [MorningStarRating]) VALUES (2164, 4)

-- Add 50 rows to [dbo].[Securities_Stock]
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2137, 18.06, 17.45, 0.00, 17.54, 30601038.00, 0.00, 0.00, 27523.00, 19181.53, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2138, 342.25, 336.00, 0.00, 336.99, 17248687.00, 0.00, 0.00, 18749.00, 312211.91, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2139, 186.36, 181.80, 0.00, 182.10, 5570058.00, 0.00, 0.00, 5918.00, 83566.49, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2140, 20.04, 19.72, 0.00, 19.95, 943152.00, 0.00, 0.00, 1596.00, 2138.86, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2141, 74.45, 72.71, 0.00, 73.51, 5231998.00, 0.00, 0.00, 5335.00, 53975.80, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2142, 13.50, 13.37, 0.00, 13.43, 65763004.00, 0.00, 0.00, 166027.00, 136331.89, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2143, 143.48, 140.30, 0.00, 143.20, 5826901.00, 0.00, 0.00, 7419.00, 49228.03, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2144, 4.48, 4.42, 0.00, 4.46, 409457240.00, 0.00, 0.00, 452187.00, 130160.04, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2145, 113.16, 111.91, 0.00, 112.97, 5352335.00, 0.00, 0.00, 6066.00, 71746.17, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2146, 134.38, 131.45, 0.00, 133.13, 2274516.00, 0.00, 0.00, 2989.00, 17756.76, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2147, 17.49, 17.12, 0.00, 17.16, 103519787.00, 0.00, 0.00, 86560.00, 95192.07, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2148, 109.80, 108.23, 0.00, 108.25, 6544828.00, 0.00, 0.00, 9066.00, 219474.51, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2149, 42.83, 42.20, 0.00, 42.66, 7642356.00, 0.00, 0.00, 11539.00, 80577.49, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2150, 32.85, 31.30, 0.00, 31.38, 12852287.00, 0.00, 0.00, 12684.00, 41314.56, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2151, 26.21, 25.82, 0.00, 26.07, 14710946.00, 0.00, 0.00, 25985.00, 53487.62, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2152, 15.81, 15.55, 0.00, 15.65, 72461668.00, 0.00, 0.00, 106856.00, 59729.00, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2154, 57.34, 55.11, 0.00, 55.28, 17434485.00, 0.00, 0.00, 19496.00, 53581.26, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2156, 95.28, 94.11, 0.00, 94.69, 1438229.00, 0.00, 0.00, 2883.00, 29731.81, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2158, 74.89, 73.02, 0.00, 73.25, 3091857.00, 0.00, 0.00, 2169.00, 27852.52, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2159, 20.63, 20.30, 0.00, 20.48, 41616511.00, 0.00, 0.00, 64597.00, 215891.38, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2160, 581.49, 565.68, 0.00, 581.08, 6048187.00, 0.00, 0.00, 2814.00, 182975.02, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2161, 42.80, 42.10, 0.00, 42.34, 192971.00, 0.00, 0.00, 239.00, 7343.19, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2162, 164.70, 163.62, 0.00, 163.81, 3616188.00, 0.00, 0.00, 5433.00, 199991.71, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2163, 19.88, 19.55, 0.00, 19.59, 62621153.00, 0.00, 0.00, 56977.00, 108168.47, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2165, 46.77, 46.05, 0.00, 46.17, 21199013.00, 0.00, 0.00, 32071.00, 185551.90, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2166, 54.23, 53.93, 0.00, 54.08, 1327757.00, 0.00, 0.00, 2814.00, 19786.07, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2167, 35.25, 34.95, 0.00, 34.96, 4163745.00, 0.00, 0.00, 8462.00, 40529.84, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2168, 81.63, 80.41, 0.00, 80.55, 2007405.00, 0.00, 0.00, 2813.00, 28349.80, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2169, 26.18, 25.74, 0.00, 25.82, 73693937.00, 0.00, 0.00, 63298.00, 216613.41, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2170, 24.88, 23.83, 0.00, 24.25, 239735.00, 0.00, 0.00, 384.00, 794.68, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2171, 78.00, 76.85, 0.00, 77.18, 3195890.00, 0.00, 0.00, 2341.00, 37289.09, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2172, 62.94, 62.06, 0.00, 62.56, 1507300.00, 0.00, 0.00, 1742.00, 18122.58, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2173, 8.84, 8.72, 0.00, 8.75, 31788733.00, 0.00, 0.00, 39842.00, 33319.37, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2174, 34.40, 33.91, 0.00, 34.29, 30286173.00, 0.00, 0.00, 23726.00, 171652.69, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2175, 62.26, 61.60, 0.00, 62.02, 9118051.00, 0.00, 0.00, 11204.00, 172724.34, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2176, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 95)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2177, 13.65, 13.48, 0.00, 13.55, 289285.00, 0.00, 0.00, 415.00, 39746.05, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2178, 51.00, 50.25, 0.00, 50.32, 2102266.00, 0.00, 0.00, 2909.00, 18189.72, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2179, 4.62, 4.54, 0.00, 4.61, 25527919.00, 0.00, 0.00, 51589.00, 13606.34, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2180, 94.18, 92.39, 0.00, 92.59, 7529671.00, 0.00, 0.00, 8758.00, 126288.43, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2181, 3.65, 3.51, 0.00, 3.63, 1827322.00, 0.00, 0.00, 2344.00, 720.46, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2182, 31.00, 30.62, 0.00, 30.67, 29194286.00, 0.00, 0.00, 26740.00, 181481.02, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2183, 30.84, 30.32, 0.00, 30.34, 1407300.00, 0.00, 0.00, 1955.00, 91758.35, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2184, 75.92, 74.80, 0.00, 75.18, 4523989.00, 0.00, 0.00, 6576.00, 53893.46, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2185, 53.19, 52.67, 0.00, 52.70, 8873315.00, 0.00, 0.00, 14383.00, 184125.78, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2186, 55.54, 53.62, 0.00, 53.82, 10010889.00, 0.00, 0.00, 11265.00, 7855.21, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2187, 85.94, 84.56, 0.00, 84.68, 17140055.00, 0.00, 0.00, 23523.00, 423563.43, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2188, 10.95, 10.76, 0.00, 10.80, 11273971.00, 0.00, 0.00, 14935.00, 15169.94, 93)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2189, 17.29, 16.79, 0.00, 16.81, 18465120.00, 0.00, 0.00, 23822.00, 22404.04, 94)
INSERT INTO [dbo].[Securities_Stock] ([Id], [DayHigh], [DayLow], [Dividend], [Open], [Volume], [YearHigh], [YearLow], [AverageVolume], [MarketCap], [ExchangeId]) VALUES (2190, 24.35, 24.03, 0.00, 24.35, 3833403.00, 0.00, 0.00, 3764.00, 4443.65, 94)

-- Add 24 rows to [dbo].[WatchListSecurity]
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2137)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2138)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2139)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2140)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2141)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2142)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2143)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (116, 2144)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2137)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2138)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2139)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2140)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2141)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2142)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2143)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (117, 2144)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2137)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2138)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2139)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2140)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2141)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2142)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2143)
INSERT INTO [dbo].[WatchListSecurity] ([WatchListId], [SecurityId]) VALUES (118, 2144)

-- Add 29 rows to [dbo].[Positions]
SET IDENTITY_INSERT [dbo].[Positions] ON
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1065, 2152, 1500, 23685, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1066, 2187, 4600, 392932, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1067, 2153, 5000, 356450, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1068, 2165, 2400, 111792, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1069, 2172, 3100, 192851, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1070, 2161, 2100, 88641, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1071, 2145, 800, 89848, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1072, 2158, 1800, 134280, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1073, 2183, 4200, 129318, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1074, 2151, 1400, 36302, 113)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1075, 2149, 1200, 51516, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1076, 2175, 3400, 228684, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1077, 2155, 5100, 151521, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1078, 2150, 1300, 46449, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1079, 2168, 2700, 243918, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1080, 2189, 4800, 73296, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1081, 2162, 2200, 453310, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1082, 2144, 700, 24528, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1083, 2165, 2400, 106584, 114)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1084, 2178, 3700, 187109, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1085, 2159, 1900, 38627, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1086, 2151, 1400, 36302, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1087, 2139, 200, 37058, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1088, 2140, 300, 6003, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1089, 2138, 100, 33889, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1090, 2155, 5100, 155856, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1091, 2175, 3400, 209678, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1092, 2143, 600, 84990, 115)
INSERT INTO [dbo].[Positions] ([Id], [SecurityId], [Shares], [Total], [BrokerageAccountId]) VALUES (1093, 2142, 500, 6735, 115)
SET IDENTITY_INSERT [dbo].[Positions] OFF

-- Add constraints to [dbo].[Positions]
ALTER TABLE [dbo].[Positions] ADD CONSTRAINT [FK_AccountPositionBrokerageAccount] FOREIGN KEY ([BrokerageAccountId]) REFERENCES [dbo].[BrokerageAccounts] ([Id])
ALTER TABLE [dbo].[Positions] ADD CONSTRAINT [FK_SecurityAccountPosition] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id])

-- Add constraints to [dbo].[WatchListSecurity]
ALTER TABLE [dbo].[WatchListSecurity] ADD CONSTRAINT [FK_WatchListSecurity_Security] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id])
ALTER TABLE [dbo].[WatchListSecurity] ADD CONSTRAINT [FK_WatchListSecurity_WatchList] FOREIGN KEY ([WatchListId]) REFERENCES [dbo].[WatchLists] ([Id])

-- Add constraints to [dbo].[Securities_Stock]
ALTER TABLE [dbo].[Securities_Stock] ADD CONSTRAINT [FK_ExchangeStock] FOREIGN KEY ([ExchangeId]) REFERENCES [dbo].[Exchanges] ([Id])
ALTER TABLE [dbo].[Securities_Stock] ADD CONSTRAINT [FK_Stock_inherits_Security] FOREIGN KEY ([Id]) REFERENCES [dbo].[Securities] ([Id])

-- Add constraints to [dbo].[Securities_MutualFund]
ALTER TABLE [dbo].[Securities_MutualFund] ADD CONSTRAINT [FK_MutualFund_inherits_Security] FOREIGN KEY ([Id]) REFERENCES [dbo].[Securities] ([Id])

-- Add constraints to [dbo].[BrokerageAccounts]
ALTER TABLE [dbo].[BrokerageAccounts] ADD CONSTRAINT [FK_BrokerageAccountWatchList] FOREIGN KEY ([WatchListId]) REFERENCES [dbo].[WatchLists] ([Id])
ALTER TABLE [dbo].[BrokerageAccounts] ADD CONSTRAINT [FK_CustomerBrokerageAccount] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id])

-- Add constraint FK_BrokerageAccountOrder to [dbo].[Orders]
ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD CONSTRAINT [FK_BrokerageAccountOrder] FOREIGN KEY ([BrokerageAccountId]) REFERENCES [dbo].[BrokerageAccounts] ([Id])

-- Add constraint FK_OrderSecurity to [dbo].[Orders]
ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD CONSTRAINT [FK_OrderSecurity] FOREIGN KEY ([SecurityId]) REFERENCES [dbo].[Securities] ([Id])

COMMIT TRANSACTION
GO
