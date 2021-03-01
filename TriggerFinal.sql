SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [STO].[Trg_ImportHeader]
ON [sadganPaloodDev].[STO].[ImportHeader]
AFTER INSERT, DELETE,UPDATE
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @User_LoginId ndtid
	
	select @User_LoginId=(SELECT TOP 1 ID FRom GNR.UserLogin where SessionId=@@SPID order by ServerTime desc)

	declare @act int = 0/*insert*/
	if exists(select id from deleted where id in (select id from inserted))
		set @act=1/*update*/
	else if exists(select 1 from deleted)
		set @act=2/*delete*/

		if @act=0 or @act=1
		begin
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
	  ,[Log_Action]
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
	  ,@act
    FROM
        inserted i
		end


		else
		begin
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
	  ,[Log_Action]
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
	  ,@act
    FROM
        deleted i
	end
    
END
----------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO

--select * from sadganBase.STO.ImportHeader

--select  TotalDiscount from sadganBase.STO.ImportHeader

--select  TotalDiscount from sadganPaloodDev.STO.ImportHeader
