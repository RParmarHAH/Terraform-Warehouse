resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_WORKERDETAILS" {
	name ="GET_AXXESS_WORKERDETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_WORKERDETAILS 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_WorkerDetails (SELECT DISTINCT * FROM (SELECT A.$1 AS Account_Id ,A.$2 AS Account_Name ,A.$3 AS Branch_Id ,A.$4 AS Branch_Name ,A.$5 AS Worker_Id ,A.$6 AS Worker_Firstname ,A.$7 AS Worker_Lastname ,A.$8 AS Date_Of_Hire ,A.$9 AS Termination_Date ,A.$10 AS Worker_Type ,A.$11 AS Worker_Status ,A.$12 AS Discipline ,A.$13 AS Email_Address ,A.$14 AS Phone_Number,  A.$15 AS EMPLOYEE_ID, A.$16 AS COMMENTS, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG  FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/WorkerDetails(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A));

    return ''Success'';
END;

 EOT
}

