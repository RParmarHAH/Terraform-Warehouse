resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_EVVVISITEXCEPTIONDETAILS" {
	name ="GET_AXXESS_EVVVISITEXCEPTIONDETAILS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_EvvVisitExceptionDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EvvVisitExceptionDetails(SELECT A.$1 AS Task_Id, A.$2 AS Task_Name, A.$3 AS Visit_End_Time, A.$4 AS Visit_Date, A.$5 AS Start_Time, A.$6 AS End_Time,A.$7 AS Patient_Id,A.$8 AS Company,A.$9 AS Branch,A.$10 AS Assigned_To,A.$11 AS Evv_Status,A.$12 AS Adjusted_Time_In,A.$13 AS Adjusted_Time_Out,A.$14 AS Exception_Date,A.$15 AS ExceptionDate, A.$16 AS Exception_Message, A.$17 AS Patient_Name, A.$18 AS Patient_Location_Id, A.$19 AS Provider, A.$20 AS Patient_Administrative_Area, A.$21 AS Payment_Source ,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/EvvVisitExceptionDetails(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}

