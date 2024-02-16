resource "snowflake_procedure" "DISC_CLEARCARE_GET_REFUND_TRANSACTION" {
	name ="GET_REFUND_TRANSACTION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_refund_transaction 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.refund_transaction  (SELECT t.$1 AS transaction_ptr_id, t.$2 AS payee_id, t.$3 AS refund_method, t.$4 AS agency_id, t.$5 AS refund_id, t.$6 AS id, t.$7 AS transaction_date, t.$8 AS description, t.$9 AS created_timestamp, t.$10 AS modified_timestamp, t.$11 AS amount, t.$12 AS qb_queued, t.$13 AS qb_exported, t.$14 AS locked, t.$15 AS taxes_total, t.$16 AS mileage_total, t.$17 AS visit_notes_total, t.$18 AS expenses_total, t.$19 AS travel_total, t.$20 AS splits_total, t.$21 AS bulk_added_expense_total, t.$22 AS interest_total, t.$23 AS created, t.$24 AS updated, t.$25 AS deleted, t.$26 AS originator_id, t.$27 AS last_updated_by_id, t.$28 AS deleted_by_id, t.$29 AS ab_estimates_total, t.$30 AS ab_adjustments_total, t.$31 AS date_deleted, t.$32 AS franchisor_id, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_refund_transaction.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

