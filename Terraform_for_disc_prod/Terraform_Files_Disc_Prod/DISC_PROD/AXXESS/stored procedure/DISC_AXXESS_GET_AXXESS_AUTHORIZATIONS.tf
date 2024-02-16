resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_AUTHORIZATIONS" {
	name ="GET_AXXESS_AUTHORIZATIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_AUTHORIZATIONS 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_AUTHORIZATIONS (SELECT A.$1 AS Authorization_Id, A.$2 AS Branch_Id, A.$3 AS Patient_Id, A.$4 AS Account, A.$5 AS Branch, A.$6 AS Authorization_Number, A.$7 AS Insurance, A.$8 AS Authorization_Type, A.$9 AS Start_Date, A.$10 AS End_Date, A.$11 AS Discipline, A.$12 AS Authorized_Units, A.$13 AS Used, A.$14 AS Un_Used, A.$15 AS Unit, A.$16 AS Authorization_Status, A.$17 AS Mrn, A.$18 AS Patient_Name, A.$19 AS Date_Of_Birth, A.$20 AS Is_Patient_Deleted, A.$21 AS INSURANCE_ID, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/Authorizations(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}

