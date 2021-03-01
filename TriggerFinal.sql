SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [STO].[Trg_ImportHeader]
ON [sadganPaloodDev].[STO].[ImportHeader]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;

	--DECLARE @Nt_Domain varchar(max)=(SELECT TOP 1 nt_domain from sys.dm_exec_sessions WHERE session_id=@@SPID)
	--DECLARE @Nt_User varchar(max)=(SELECT TOP 1 nt_user_name from sys.dm_exec_sessions WHERE session_id=@@SPID)
	--DECLARE @Client_NetAddress varchar(max)=(SELECT TOP 1 client_net_address from sys.dm_exec_connections WHERE session_id=@@SPID)
	DECLARE @User_LoginId ndtid
	--=(SELECT TOP 1 id FROM GNR.UserLogin WHERE 
	----LocalIP=@Client_NetAddress AND 
	--LocalUser=@Nt_User AND ComputerName=@Nt_Domain
	----AND ISNULL(BatchStarted,0)=1
	--)
	select @User_LoginId=(SELECT TOP 1 ID FRom GNR.UserLogin where SessionId=@@SPID)
    INSERT INTO sadganBase.STO.ImportHeader(
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
	  ,[_TotalPrice]
	  ,[_TotalDiscount]
	  ,[_TotalTaxPrice]
	  ,[_TotalChargePrice]
	  ,[_TotalTransportPrice]
	  ,[_TotalTransportTaxPrice]
	  ,[_TotalTransportChargePrice]
      ,[_TotalNetPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
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
	  ,[Price]
	  ,[__Updated315__]
	  ,[ID]
	  ,[LogDate]
	  ,[User_LoginId]
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
	  ,[_TotalPrice]
	  ,[_TotalDiscount]
	  ,[_TotalTaxPrice]
	  ,[_TotalChargePrice]
	  ,[_TotalTransportPrice]
	  ,[_TotalTransportTaxPrice]
	  ,[_TotalTransportChargePrice]
      ,[_TotalNetPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
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
	  ,[Price]
	  ,[__Updated315__]
	  ,[ID]
	  ,getdate()
	  ,@User_LoginId
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
	  ,[_TotalPrice]
	  ,[_TotalDiscount]
	  ,[_TotalTaxPrice]
	  ,[_TotalChargePrice]
	  ,[_TotalTransportPrice]
	  ,[_TotalTransportTaxPrice]
	  ,[_TotalTransportChargePrice]
      ,[_TotalNetPrice]
      ,[RefStatusID]
      ,[RefWriterID]
      ,[CreateDate]
      ,[RefEditorID]
      ,[UpdateDate]
      ,[RefAmountConfirmStatusID]
      ,[AmountConfirmStatusUpdateDate]
      ,[BuyFactorNo]
      ,[BuyFactorDate]
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
	  ,[Price]
	  ,[__Updated315__]
	  ,[ID]
	  ,getdate()
	  ,@User_LoginId
	  --(select client_net_address from sys.dm_exec_connections where session_id=@@SPID),(select HOST_NAME from sys.dm_exec_sessions where session_id=@@SPID),@@SPID,3,ID
	Date
    FROM
        deleted d;
END
----------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO

--select * from sadganBase.STO.ImportHeader

--select  TotalDiscount from sadganBase.STO.ImportHeader

--select  TotalDiscount from sadganPaloodDev.STO.ImportHeader
