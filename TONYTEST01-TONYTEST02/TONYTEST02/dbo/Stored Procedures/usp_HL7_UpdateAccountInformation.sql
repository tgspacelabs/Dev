
/* [usp_HL7_UpdateAccountInformation] is used to update  the patient Account Information from Hl7 component*/
CREATE PROCEDURE [dbo].[usp_HL7_UpdateAccountInformation]
(
	@accountId UNIQUEIDENTIFIER,
	@accountStatusCid int,
	@badDebtSw tinyint,
	@totPaymentsAmt smallmoney,
	@totChargesAmt smallmoney,
	@totAdjsAmt smallmoney,
	@curBalAmt smallmoney,
	@accountCloseDt datetime
)
AS
BEGIN

UPDATE int_account 
SET 
	account_status_cid=@accountStatusCid,
	bad_debt_sw=@badDebtSw,
	tot_payments_amt=@totPaymentsAmt,
	tot_charges_amt=@totChargesAmt,
	tot_adjs_amt=@totAdjsAmt,
	cur_bal_amt=@curBalAmt,
	account_close_dt=@accountCloseDt
	WHERE  account_id=@accountId;

END

