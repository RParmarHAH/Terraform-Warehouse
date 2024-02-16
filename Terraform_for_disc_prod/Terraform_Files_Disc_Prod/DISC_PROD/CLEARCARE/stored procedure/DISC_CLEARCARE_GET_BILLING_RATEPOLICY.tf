resource "snowflake_procedure" "DISC_CLEARCARE_GET_BILLING_RATEPOLICY" {
	name ="GET_BILLING_RATEPOLICY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_billing_ratepolicy 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.billing_ratepolicy  (SELECT t.$1 AS id, t.$2 AS mileage_rate, t.$3 AS overtime_day, t.$4 AS overtime_day_2, t.$5 AS overtime_week_hours, t.$6 AS overtime_week_days, t.$7 AS repeat_interval, t.$8 AS repeat_day, t.$9 AS salary_monthly, t.$10 AS first_last_day, t.$11 AS overtime_7th_day_hours, t.$12 AS use_default_mileage_rate, t.$13 AS use_average_rate, t.$14 AS agency_id, t.$15 AS updated, t.$16 AS pay_holiday_rate, t.$17 AS created, t.$18 AS deleted, t.$19 AS originator_id, t.$20 AS last_updated_by_id, t.$21 AS deleted_by_id, t.$22 AS default_travel_pay_rate_id, t.$23 AS overtime_rate_type, t.$24 AS group_concurrent_invoice, t.$25 AS overtime_combine_holiday_premium, t.$26 AS date_deleted, t.$27 AS franchisor_id, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_billing_ratepolicy.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

