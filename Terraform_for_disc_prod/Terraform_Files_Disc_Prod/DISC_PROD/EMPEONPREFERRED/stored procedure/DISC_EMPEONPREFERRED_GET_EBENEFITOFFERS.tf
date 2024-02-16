resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_EBENEFITOFFERS" {
	name ="GET_EBENEFITOFFERS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_EBenefitOffers 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.EBenefitOffers (SELECT t.$1 AS benefitOfferId, t.$2 AS co, t.$3 AS id, t.$4 AS name, t.$5 AS effectiveDate, t.$6 AS offerStart, t.$7 AS offerEnd, t.$8 AS event, t.$9 AS lastChange, t.$10 AS lastChangeUser, t.$11 AS employeeResponded, t.$12 AS rejectReason, t.$13 AS rejectedByEmployer, t.$14 AS eventDetails, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EBenefitOffers.*[.]csv.gz'')T);

    
    return ''Success'';
END;

 EOT
}

