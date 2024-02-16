resource "snowflake_procedure" "DISC_CLEARCARE_GET_BILLING_PAYRATE" {
	name ="GET_BILLING_PAYRATE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_billing_payrate 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.billing_payrate  (SELECT t.$1 AS id, t.$2 AS name, t.$3 AS amount, t.$4 AS type, t.$5 AS agency_id, t.$6 AS pro_rate, t.$7 AS care_manager, t.$8 AS payroll_code, t.$9 AS schedule, t.$10 AS custom, t.$11 AS created, t.$12 AS updated, t.$13 AS deleted, t.$14 AS originator_id, t.$15 AS last_updated_by_id, t.$16 AS deleted_by_id, t.$17 AS has_caregiverrateschedule, t.$18 AS meta, t.$19 AS enable_tiered_rates_by_clients, t.$20 AS tiered_custom, t.$21 AS enable_tiered_rates, t.$22 AS date_deleted, t.$23 AS franchisor_id, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_billing_payrate.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

