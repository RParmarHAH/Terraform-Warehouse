resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_PAYMENTSOURCES" {
	name ="GET_AXXESS_PAYMENTSOURCES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_PAYMENTSOURCES 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PAYMENTSOURCES ( SELECT BI.$1 AS Insurance_Id, BI.$2 AS Payor_Id, BI.$3 AS Agency_Id, BI.$4 AS Agency_Name,BI.$5 AS Insurance_Name, BI.$6 AS Payor_Name, BI.$7 AS Payor_Type_Name, BI.$8 AS Payer_Category_Name, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/PaymentSources(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) BI );

    return ''Success'';
END;

 EOT
}

