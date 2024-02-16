resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_EBENEFITENROLLMENT" {
	name ="GET_EBENEFITENROLLMENT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_EBenefitEnrollment 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.EBenefitEnrollment (SELECT t.$1 AS benefitEnrollmentId, t.$2 AS benefitPlanId, t.$3 AS co, t.$4 AS id, t.$5 AS startDate, t.$6 AS eventDetail, t.$7 AS lastChange, t.$8 AS lastChangeUser, t.$9 AS event, t.$10 AS coverageLevelOverride, t.$11 AS arrear, t.$12 AS dependentId, t.$13 AS endDate, t.$14 AS terminationEvent, t.$15 AS terminationEventDetail, t.$16 AS lastDate, t.$17 AS arrearCap, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EBenefitEnrollment.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

