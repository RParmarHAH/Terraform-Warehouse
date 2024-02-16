resource "snowflake_procedure" "DISC_CLEARCARE_GET_RECEIVABLES_INVOICE" {
	name ="GET_RECEIVABLES_INVOICE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 
--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_receivables_invoice 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.receivables_invoice  (SELECT t.$1 AS transaction_ptr_id, t.$2 AS due_date, t.$3 AS paid, t.$4 AS invoice_id, t.$5 AS agency_id, t.$6 AS interest_charges_added, t.$7 AS qb_invoice_id, t.$8 AS sent_by_email, t.$9 AS email_sent_timestamp, t.$10 AS total, t.$11 AS outstanding_balance, t.$12 AS previous_balance, t.$13 AS new_balance, t.$14 AS interest_charged_until, t.$15 AS start_date, t.$16 AS end_date, t.$17 AS subtotal, t.$18 AS carelogs_total, t.$19 AS items_total, t.$20 AS payments_total, t.$21 AS tax_rate, t.$22 AS compound_tax_rate, t.$23 AS authorization_id, t.$24 AS payer_id, t.$25 AS charge_tax, t.$26 AS tax_carelogs, t.$27 AS tax_expenses, t.$28 AS tax_mileage, t.$29 AS royalty_percentage, t.$30 AS autopay_rule_id, t.$31 AS is_adjustment, t.$32 AS scheduled_for_auto_pay, t.$33 AS prepayments_total, t.$34 AS scheduled_start, t.$35 AS scheduled_end, t.$36 AS icd9, t.$37 AS cci_care_summary, t.$38 AS cci_prepay_summary, t.$39 AS royalty_reporting_flag, t.$40 AS eclaim_status, t.$41 AS add_surcharge, t.$42 AS surcharge_apply_to_credits, t.$43 AS surcharge_apply_to_expenses, t.$44 AS surcharge_apply_to_interest, t.$45 AS surcharge_apply_to_mileage, t.$46 AS surcharge_apply_to_visit_notes, t.$47 AS surcharge_label, t.$48 AS surcharge_rate, t.$49 AS surcharge_type, t.$50 AS tax_surcharge, t.$51 AS is_eclaim, t.$52 AS eclaim_voided, t.$53 AS eclaim_txn_status, t.$54 AS service_taxes, t.$55 AS taxable_carelogs_total, t.$56 AS franchisor_id, t.$57 AS SYS_CHANGE_VERSION, t.$58 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$58,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_receivables_invoice.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

