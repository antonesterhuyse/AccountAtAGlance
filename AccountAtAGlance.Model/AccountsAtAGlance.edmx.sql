
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 02/27/2011 15:58:20
-- Generated from EDMX file: D:\Websites\AccountsAtAGlance\AccountsAtAGlance.Model\AccountsAtAGlance.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [AccountsAtAGlance];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_AccountPositionBrokerageAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Positions] DROP CONSTRAINT [FK_AccountPositionBrokerageAccount];
GO
IF OBJECT_ID(N'[dbo].[FK_BrokerageAccountOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_BrokerageAccountOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_BrokerageAccountWatchList]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BrokerageAccounts] DROP CONSTRAINT [FK_BrokerageAccountWatchList];
GO
IF OBJECT_ID(N'[dbo].[FK_CustomerBrokerageAccount]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BrokerageAccounts] DROP CONSTRAINT [FK_CustomerBrokerageAccount];
GO
IF OBJECT_ID(N'[dbo].[FK_ExchangeStock]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Securities_Stock] DROP CONSTRAINT [FK_ExchangeStock];
GO
IF OBJECT_ID(N'[dbo].[FK_MutualFund_inherits_Security]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Securities_MutualFund] DROP CONSTRAINT [FK_MutualFund_inherits_Security];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderSecurity]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_OrderSecurity];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderTypeOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_OrderTypeOrder];
GO
IF OBJECT_ID(N'[dbo].[FK_SecurityAccountPosition]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Positions] DROP CONSTRAINT [FK_SecurityAccountPosition];
GO
IF OBJECT_ID(N'[dbo].[FK_Stock_inherits_Security]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Securities_Stock] DROP CONSTRAINT [FK_Stock_inherits_Security];
GO
IF OBJECT_ID(N'[dbo].[FK_WatchListSecurity_Security]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WatchListSecurity] DROP CONSTRAINT [FK_WatchListSecurity_Security];
GO
IF OBJECT_ID(N'[dbo].[FK_WatchListSecurity_WatchList]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WatchListSecurity] DROP CONSTRAINT [FK_WatchListSecurity_WatchList];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[BrokerageAccounts]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BrokerageAccounts];
GO
IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customers];
GO
IF OBJECT_ID(N'[dbo].[Exchanges]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Exchanges];
GO
IF OBJECT_ID(N'[dbo].[MarketIndexes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MarketIndexes];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[OrderTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderTypes];
GO
IF OBJECT_ID(N'[dbo].[Positions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Positions];
GO
IF OBJECT_ID(N'[dbo].[Securities]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Securities];
GO
IF OBJECT_ID(N'[dbo].[Securities_MutualFund]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Securities_MutualFund];
GO
IF OBJECT_ID(N'[dbo].[Securities_Stock]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Securities_Stock];
GO
IF OBJECT_ID(N'[dbo].[WatchLists]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WatchLists];
GO
IF OBJECT_ID(N'[dbo].[WatchListSecurity]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WatchListSecurity];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [NumberOfShares] decimal(18,2)  NOT NULL,
    [Price] decimal(18,2)  NOT NULL,
    [OrderTypeId] int  NOT NULL,
    [SecurityId] int  NOT NULL,
    [BrokerageAccountOrder_Order_Id] int  NOT NULL
);
GO

-- Creating table 'Securities'
CREATE TABLE [dbo].[Securities] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Change] decimal(18,2)  NOT NULL,
    [PercentChange] decimal(18,2)  NOT NULL,
    [Last] decimal(18,2)  NOT NULL,
    [Shares] decimal(18,2)  NOT NULL,
    [Symbol] nvarchar(5)  NOT NULL,
    [RetrievalDateTime] datetime  NOT NULL,
    [Company] nvarchar(250)  NOT NULL
);
GO

-- Creating table 'WatchLists'
CREATE TABLE [dbo].[WatchLists] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'OrderTypes'
CREATE TABLE [dbo].[OrderTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Type] nvarchar(10)  NOT NULL
);
GO

-- Creating table 'Exchanges'
CREATE TABLE [dbo].[Exchanges] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(25)  NOT NULL
);
GO

-- Creating table 'BrokerageAccounts'
CREATE TABLE [dbo].[BrokerageAccounts] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [AccountNumber] nvarchar(15)  NOT NULL,
    [AccountTitle] nvarchar(250)  NOT NULL,
    [Total] decimal(18,2)  NOT NULL,
    [MarginBalance] decimal(18,2)  NOT NULL,
    [IsRetirement] bit  NOT NULL,
    [CustomerId] int  NOT NULL,
    [CashTotal] decimal(18,0)  NOT NULL,
    [PositionsTotal] decimal(18,0)  NOT NULL,
    [WatchList_Id] int  NOT NULL
);
GO

-- Creating table 'MarketIndexes'
CREATE TABLE [dbo].[MarketIndexes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Last] decimal(18,2)  NOT NULL,
    [Change] decimal(18,2)  NOT NULL,
    [PercentChange] decimal(18,2)  NOT NULL,
    [DayHigh] decimal(18,2)  NOT NULL,
    [DayLow] decimal(18,2)  NOT NULL,
    [YearHigh] decimal(18,2)  NOT NULL,
    [YearLow] decimal(18,2)  NOT NULL,
    [Open] decimal(18,2)  NOT NULL,
    [Volume] decimal(18,2)  NOT NULL,
    [Title] nvarchar(250)  NOT NULL,
    [Symbol] nvarchar(5)  NOT NULL,
    [RetrievalDateTime] datetime  NOT NULL
);
GO

-- Creating table 'Positions'
CREATE TABLE [dbo].[Positions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [SecurityId] int  NOT NULL,
    [Shares] decimal(18,0)  NOT NULL,
    [Total] decimal(18,0)  NOT NULL,
    [BrokerageAccountId] int  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(25)  NOT NULL,
    [LastName] nvarchar(50)  NOT NULL,
    [Address] nvarchar(250)  NOT NULL,
    [City] nvarchar(50)  NOT NULL,
    [State] nvarchar(2)  NOT NULL,
    [Zip] int  NOT NULL,
    [CustomerId] nvarchar(10)  NOT NULL
);
GO

-- Creating table 'Securities_Stock'
CREATE TABLE [dbo].[Securities_Stock] (
    [DayHigh] decimal(18,2)  NOT NULL,
    [DayLow] decimal(18,2)  NOT NULL,
    [Dividend] decimal(18,2)  NOT NULL,
    [Open] decimal(18,2)  NOT NULL,
    [Volume] decimal(18,2)  NOT NULL,
    [YearHigh] decimal(18,2)  NOT NULL,
    [YearLow] decimal(18,2)  NOT NULL,
    [AverageVolume] decimal(18,2)  NOT NULL,
    [MarketCap] decimal(18,2)  NOT NULL,
    [ExchangeId] int  NOT NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'Securities_MutualFund'
CREATE TABLE [dbo].[Securities_MutualFund] (
    [MorningStarRating] int  NOT NULL,
    [Id] int  NOT NULL
);
GO

-- Creating table 'WatchListSecurity'
CREATE TABLE [dbo].[WatchListSecurity] (
    [WatchListSecurity_Security_Id] int  NOT NULL,
    [Securities_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Securities'
ALTER TABLE [dbo].[Securities]
ADD CONSTRAINT [PK_Securities]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'WatchLists'
ALTER TABLE [dbo].[WatchLists]
ADD CONSTRAINT [PK_WatchLists]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'OrderTypes'
ALTER TABLE [dbo].[OrderTypes]
ADD CONSTRAINT [PK_OrderTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Exchanges'
ALTER TABLE [dbo].[Exchanges]
ADD CONSTRAINT [PK_Exchanges]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'BrokerageAccounts'
ALTER TABLE [dbo].[BrokerageAccounts]
ADD CONSTRAINT [PK_BrokerageAccounts]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'MarketIndexes'
ALTER TABLE [dbo].[MarketIndexes]
ADD CONSTRAINT [PK_MarketIndexes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Positions'
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT [PK_Positions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Securities_Stock'
ALTER TABLE [dbo].[Securities_Stock]
ADD CONSTRAINT [PK_Securities_Stock]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Securities_MutualFund'
ALTER TABLE [dbo].[Securities_MutualFund]
ADD CONSTRAINT [PK_Securities_MutualFund]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [WatchListSecurity_Security_Id], [Securities_Id] in table 'WatchListSecurity'
ALTER TABLE [dbo].[WatchListSecurity]
ADD CONSTRAINT [PK_WatchListSecurity]
    PRIMARY KEY NONCLUSTERED ([WatchListSecurity_Security_Id], [Securities_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [BrokerageAccountOrder_Order_Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_BrokerageAccountOrder]
    FOREIGN KEY ([BrokerageAccountOrder_Order_Id])
    REFERENCES [dbo].[BrokerageAccounts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrokerageAccountOrder'
CREATE INDEX [IX_FK_BrokerageAccountOrder]
ON [dbo].[Orders]
    ([BrokerageAccountOrder_Order_Id]);
GO

-- Creating foreign key on [ExchangeId] in table 'Securities_Stock'
ALTER TABLE [dbo].[Securities_Stock]
ADD CONSTRAINT [FK_ExchangeStock]
    FOREIGN KEY ([ExchangeId])
    REFERENCES [dbo].[Exchanges]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ExchangeStock'
CREATE INDEX [IX_FK_ExchangeStock]
ON [dbo].[Securities_Stock]
    ([ExchangeId]);
GO

-- Creating foreign key on [OrderTypeId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_OrderTypeOrder]
    FOREIGN KEY ([OrderTypeId])
    REFERENCES [dbo].[OrderTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderTypeOrder'
CREATE INDEX [IX_FK_OrderTypeOrder]
ON [dbo].[Orders]
    ([OrderTypeId]);
GO

-- Creating foreign key on [WatchList_Id] in table 'BrokerageAccounts'
ALTER TABLE [dbo].[BrokerageAccounts]
ADD CONSTRAINT [FK_BrokerageAccountWatchList]
    FOREIGN KEY ([WatchList_Id])
    REFERENCES [dbo].[WatchLists]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_BrokerageAccountWatchList'
CREATE INDEX [IX_FK_BrokerageAccountWatchList]
ON [dbo].[BrokerageAccounts]
    ([WatchList_Id]);
GO

-- Creating foreign key on [WatchListSecurity_Security_Id] in table 'WatchListSecurity'
ALTER TABLE [dbo].[WatchListSecurity]
ADD CONSTRAINT [FK_WatchListSecurity_WatchList]
    FOREIGN KEY ([WatchListSecurity_Security_Id])
    REFERENCES [dbo].[WatchLists]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Securities_Id] in table 'WatchListSecurity'
ALTER TABLE [dbo].[WatchListSecurity]
ADD CONSTRAINT [FK_WatchListSecurity_Security]
    FOREIGN KEY ([Securities_Id])
    REFERENCES [dbo].[Securities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WatchListSecurity_Security'
CREATE INDEX [IX_FK_WatchListSecurity_Security]
ON [dbo].[WatchListSecurity]
    ([Securities_Id]);
GO

-- Creating foreign key on [SecurityId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_OrderSecurity]
    FOREIGN KEY ([SecurityId])
    REFERENCES [dbo].[Securities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderSecurity'
CREATE INDEX [IX_FK_OrderSecurity]
ON [dbo].[Orders]
    ([SecurityId]);
GO

-- Creating foreign key on [SecurityId] in table 'Positions'
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT [FK_SecurityAccountPosition]
    FOREIGN KEY ([SecurityId])
    REFERENCES [dbo].[Securities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_SecurityAccountPosition'
CREATE INDEX [IX_FK_SecurityAccountPosition]
ON [dbo].[Positions]
    ([SecurityId]);
GO

-- Creating foreign key on [BrokerageAccountId] in table 'Positions'
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT [FK_AccountPositionBrokerageAccount]
    FOREIGN KEY ([BrokerageAccountId])
    REFERENCES [dbo].[BrokerageAccounts]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_AccountPositionBrokerageAccount'
CREATE INDEX [IX_FK_AccountPositionBrokerageAccount]
ON [dbo].[Positions]
    ([BrokerageAccountId]);
GO

-- Creating foreign key on [CustomerId] in table 'BrokerageAccounts'
ALTER TABLE [dbo].[BrokerageAccounts]
ADD CONSTRAINT [FK_CustomerBrokerageAccount]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_CustomerBrokerageAccount'
CREATE INDEX [IX_FK_CustomerBrokerageAccount]
ON [dbo].[BrokerageAccounts]
    ([CustomerId]);
GO

-- Creating foreign key on [Id] in table 'Securities_Stock'
ALTER TABLE [dbo].[Securities_Stock]
ADD CONSTRAINT [FK_Stock_inherits_Security]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Securities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Id] in table 'Securities_MutualFund'
ALTER TABLE [dbo].[Securities_MutualFund]
ADD CONSTRAINT [FK_MutualFund_inherits_Security]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[Securities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------