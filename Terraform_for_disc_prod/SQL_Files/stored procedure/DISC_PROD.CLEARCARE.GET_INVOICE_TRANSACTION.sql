CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_INVOICE_TRANSACTION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_invoice_transaction 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.invoice_transaction  (SELECT t.$1 AS transaction_ptr_id, t.$2 AS due_date, t.$3 AS paid, t.$4 AS invoice_id, t.$5 AS agency_id, t.$6 AS interest_charges_added, t.$7 AS qb_invoice_id, t.$8 AS sent_by_email, t.$9 AS email_sent_timestamp, t.$10 AS total, t.$11 AS outstanding_balance, t.$12 AS previous_balance, t.$13 AS new_balance, t.$14 AS interest_charged_until, t.$15 AS start_date, t.$16 AS end_date, t.$17 AS subtotal, t.$18 AS carelogs_total, t.$19 AS items_total, t.$20 AS payments_total, t.$21 AS tax_rate, t.$22 AS compound_tax_rate, t.$23 AS authorization_id, t.$24 AS payer_id, t.$25 AS charge_tax, t.$26 AS tax_carelogs, t.$27 AS tax_expenses, t.$28 AS tax_mileage, t.$29 AS royalty_percentage, t.$30 AS autopay_rule_id, t.$31 AS is_adjustment, t.$32 AS scheduled_for_auto_pay, t.$33 AS prepayments_total, t.$34 AS scheduled_start, t.$35 AS scheduled_end, t.$36 AS icd9, t.$37 AS cci_care_summary, t.$38 AS cci_prepay_summary, t.$39 AS royalty_reporting_flag, t.$40 AS id, t.$41 AS client_id, t.$42 AS transaction_date, t.$43 AS description, t.$44 AS created_timestamp, t.$45 AS modified_timestamp, t.$46 AS amount, t.$47 AS qb_queued, t.$48 AS qb_exported, t.$49 AS locked, t.$50 AS taxes_total, t.$51 AS mileage_total, t.$52 AS visit_notes_total, t.$53 AS expenses_total, t.$54 AS travel_total, t.$55 AS splits_total, t.$56 AS bulk_added_expense_total, t.$57 AS interest_total, t.$58 AS created, t.$59 AS updated, t.$60 AS deleted, t.$61 AS originator_id, t.$62 AS last_updated_by_id, t.$63 AS deleted_by_id, t.$64 AS ab_estimates_total, t.$65 AS ab_adjustments_total, t.$66 AS date_deleted, t.$67 AS franchisor_id, t.$68 AS SYS_CHANGE_VERSION, t.$69 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$69,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_invoice_transaction.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';