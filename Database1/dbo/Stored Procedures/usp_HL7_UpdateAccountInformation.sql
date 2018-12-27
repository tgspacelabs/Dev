
/* [usp_HL7_UpdateAccountInformation] is used to update  the patient Account Information from Hl7 component*/
CREATE PROCEDURE [dbo].[usp_HL7_UpdateAccountInformation]
    (
     @accountId UNIQUEIDENTIFIER,
     @accountStatusCid INT,
     @badDebtSw TINYINT,
     @totPaymentsAmt SMALLMONEY,
     @totChargesAmt SMALLMONEY,
     @totAdjsAmt SMALLMONEY,
     @curBalAmt SMALLMONEY,
     @accountCloseDt DATETIME
    )
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_account]
    SET
        [account_status_cid] = @accountStatusCid,
        [bad_debt_sw] = @badDebtSw,
        [tot_payments_amt] = @totPaymentsAmt,
        [tot_charges_amt] = @totChargesAmt,
        [tot_adjs_amt] = @totAdjsAmt,
        [cur_bal_amt] = @curBalAmt,
        [account_close_dt] = @accountCloseDt
    WHERE
        [account_id] = @accountId;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Update the patient Account Information from HL7 component.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_UpdateAccountInformation';

