resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_ECERTIFICATE" {
	name ="GET_ECERTIFICATE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_ECertificate 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.ECertificate (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS certificateType, t.$4 AS certificateId, t.$5 AS issueDate, t.$6 AS expirationDate, t.$7 AS notes, t.$8 AS guidfield, t.$9 AS lastChange, t.$10 AS lastChangeUser, t.$11 AS issueAgency, t.$12 AS issueState, t.$13 AS active, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_ECertificate.*[.]csv.gz'')T);

    
    return ''Success'';
END;

 EOT
}

