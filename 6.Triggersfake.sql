USE [sadganPaloodDev]
GO
/****** Object:  Trigger [dbo].[trg_ReturnExportHeader_audit]    Script Date: 2/27/2021 12:54:35 PM ******/
-------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportDetailIncrementalFactor]
ON [sadganPaloodDev].[STO].[ImportDetailIncrementalFactor]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportDetailIncrementalFactor(
	   [RefImportHeaderID]
      ,[RefCategoryID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[RefBaseOfSharingID]
      ,[Comment]
      ,[RowNo]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefImportHeaderID]
      ,[RefCategoryID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[RefBaseOfSharingID]
      ,[Comment]
      ,[RowNo]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefImportHeaderID]
      ,[RefCategoryID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[RefBaseOfSharingID]
      ,[Comment]
      ,[RowNo]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportDetailItem]
ON [sadganPaloodDev].[STO].[ImportDetailItem]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportDetailItem(
	   [RefImportHeaderID]
      ,[RowNo]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
      ,[RefBuyFactorDetailID]
      ,[LastRateBuy]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefImportHeaderID]
      ,[RowNo]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
      ,[RefBuyFactorDetailID]
      ,[LastRateBuy]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefImportHeaderID]
      ,[RowNo]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
      ,[RefBuyFactorDetailID]
      ,[LastRateBuy]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportDetailOppositLedger]
ON [sadganPaloodDev].[STO].[ImportDetailOppositLedger]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportDetailOppositLedger(
	   [RefImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportDetailPaymentMethod]
ON [sadganPaloodDev].[STO].[ImportDetailPaymentMethod]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportDetailPaymentMethod(
	   [RefImportHeaderID]
      ,[RowNo]
      ,[RefPaymentTypeID]
      ,[PaymentDate]
      ,[PaymentPrice]
      ,[IsPaid]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefImportHeaderID]
      ,[RowNo]
      ,[RefPaymentTypeID]
      ,[PaymentDate]
      ,[PaymentPrice]
      ,[IsPaid]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefImportHeaderID]
      ,[RowNo]
      ,[RefPaymentTypeID]
      ,[PaymentDate]
      ,[PaymentPrice]
      ,[IsPaid]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportDetailTransport]
ON [sadganPaloodDev].[STO].[ImportDetailTransport]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportDetailTransport(
	   [RefImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ImportHeader]
ON [sadganPaloodDev].[STO].[ImportHeader]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ImportHeader(
	   [RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ImportNo]
      ,[ImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
      --,[TotalDiscount]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ImportNo]
      ,[ImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
      --,[TotalDiscount]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ImportNo]
      ,[ImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[Discount]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[IncrementalFactorPrice]
      ,[IncrementalFactorTaxPrice]
      ,[IncrementalFactorChargePrice]
      ,[DiscountedPrice]
      ,[PayablePrice]
      ,[FinalPrice]
      ,[TotalPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
      --,[TotalDiscount]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ReturnImportDetailItem]
ON [sadganPaloodDev].[STO].[ReturnImportDetailItem]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ReturnImportDetailItem(
	   [RefReturnImportHeaderID]
      ,[RowNo]
      ,[RefImportDetailItemID]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgRate]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefReturnImportHeaderID]
      ,[RowNo]
      ,[RefImportDetailItemID]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgRate]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefReturnImportHeaderID]
      ,[RowNo]
      ,[RefImportDetailItemID]
      ,[RefGoodsID]
      ,[RefBaseUnitID]
      ,[BaseAmount]
      ,[RefLateralUnitID]
      ,[LateralAmount]
      ,[BaseRate]
      ,[LateralRate]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgRate]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[Comment]
      ,[OrderValue]
      ,[RemainRate]
      ,[RemainPrice]
      ,[RemainAmount]
      ,[RefPricingHeaderID]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
-------------------------------------------------------------------------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ReturnImportDetailOppositLedger]
ON [sadganPaloodDev].[STO].[ReturnImportDetailOppositLedger]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ReturnImportDetailOppositLedger(
	   [RefReturnImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefReturnImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefReturnImportHeaderID]
      ,[RefLedgerAccountID]
      ,[RefDetailAccountID]
      ,[RefDetailAccount2ID]
      ,[RefDetailAccount3ID]
      ,[Percentage]
      ,[Price]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
-------------------------------------------------------------------------------------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ReturnImportDetailTransport]
ON [sadganPaloodDev].[STO].[ReturnImportDetailTransport]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ReturnImportDetailTransport(
	   [RefReturnImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefReturnImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefReturnImportHeaderID]
      ,[RefDetailAccountID]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[SharingBasis]
      ,[Deliverer]
      ,[Comment]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
-------------------------------------------------------------------------------------------------------------------------------------------------------


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create TRIGGER [STO].[Trg_ReturnImportHeader]
ON [sadganPaloodDev].[STO].[ReturnImportHeader]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO sadganDBLOG.STO.ReturnImportHeader(
	   [RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ReturnImportNo]
      ,[ReturnImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
		,[DateTime]
		,[IPAddress]
		,[HostName]
		,[SessionId]
		,[ActionStatus]
		,[ParentID]
    )
    SELECT
	[RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ReturnImportNo]
      ,[ReturnImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,1,ID
    FROM
        inserted i
	
    UNION ALL
    SELECT
	[RefVoucherTypeID]
      ,[RefFiscalYearID]
      ,[RefVoucherHeaderID]
      ,[ReturnImportNo]
      ,[ReturnImportDate]
      ,[RefKindID]
      ,[RefWarehouseID]
      ,[RefDetailAccountID]
      ,[ByRefrence]
      ,[Comment]
      ,[Price]
      ,[TaxPrice]
      ,[ChargePrice]
      ,[TotalPrice]
      ,[AvgPrice]
      ,[TotalAvgPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
		,
      getdate(),(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
-------------------------------------------------------------------------------------------------------------------------------------------------------


