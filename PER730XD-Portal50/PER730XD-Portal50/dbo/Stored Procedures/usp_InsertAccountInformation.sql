
----Hl7Queries-----
/* usp_InsertAccountInformation is used to inser Account Information from any component
@accountId,@orgId,@accountNumber are mandatory and the remaining are optional with default NULL values*/
CREATE PROCEDURE [dbo].[usp_InsertAccountInformation]
(
    @accountId UNIQUEIDENTIFIER,
    @orgId UNIQUEIDENTIFIER,
    @accountNumber NVARCHAR(80),
    @accountStatusCid int=null,
    @badDebtSw tinyint=null,
    @totPaymentsAmt smallmoney=null,
    @totChargesAmt smallmoney=null,
    @totAdjsAmt smallmoney=null,
    @curBalAmt smallmoney=null,
    @accountOpenDt datetime=null,
    @accountCloseDt datetime=null
)
AS
BEGIN

IF @accountOpenDt IS NULL SET @accountOpenDt=GETDATE();

INSERT INTO 
int_account 
(
    account_id,
    organization_id,
    account_xid,
    account_status_cid,
    bad_debt_sw,
    tot_payments_amt,
    tot_charges_amt,
    tot_adjs_amt,
    cur_bal_amt,
    account_open_dt,
    account_close_dt
)
VALUES 
(
    @accountId, 
    @orgId, 
    @accountNumber, 
    @accountStatusCid,
    @badDebtSw,
    @totPaymentsAmt,
    @totChargesAmt,
    @totAdjsAmt,
    @curBalAmt,
    @accountOpenDt,
    @accountCloseDt
)
END
