resource "snowflake_procedure" "DISC_CLEARCARE_GET_PAYMENT_TRANSACTION" {
	name ="GET_PAYMENT_TRANSACTION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_payment_transaction 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.payment_transaction  (SELECT t.$1 AS transaction_ptr_id, t.$2 AS payee_id, t.$3 AS payment_method, t.$4 AS agency_id, t.$5 AS qb_payment_id, t.$6 AS payment_id, t.$7 AS previous_balance, t.$8 AS new_balance, t.$9 AS unallocated_amount, t.$10 AS epay_transaction_number, t.$11 AS id, t.$12 AS client_id, t.$13 AS transaction_date, t.$14 AS description, t.$15 AS created_timestamp, t.$16 AS modified_timestamp, t.$17 AS amount, t.$18 AS qb_queued, t.$19 AS qb_exported, t.$20 AS locked, t.$21 AS taxes_total, t.$22 AS mileage_total, t.$23 AS visit_notes_total, t.$24 AS expenses_total, t.$25 AS travel_total, t.$26 AS splits_total, t.$27 AS bulk_added_expense_total, t.$28 AS interest_total, t.$29 AS created, t.$30 AS updated, t.$31 AS deleted, t.$32 AS originator_id, t.$33 AS last_updated_by_id, t.$34 AS deleted_by_id, t.$35 AS ab_estimates_total, t.$36 AS ab_adjustments_total, t.$37 AS payment_apply_by_items, t.$38 AS payment_type, t.$39 AS date_deleted, t.$40 AS franchisor_id, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_payment_transaction.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

