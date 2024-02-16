resource "snowflake_procedure" "DISC_DEVERO_GET_DEVERO_INSURANCE" {
	name ="GET_DEVERO_INSURANCE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DEVERO.GET_${var.SF_ENVIRONMENT}ERO_INSURANCE 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_INSURANCE (SELECT DISTINCT XMLGET(INSURANCE.$1, ''INSURANCE_ID''):"$" :: STRING AS INSURANCE_ID,  INSURANCE.$1 :: STRING AS INSURANCE_XML,XMLGET(INSURANCE.$1,''DATE_MODIFIED''):"$" :: STRING AS DATE_MODIFIED,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Devero/DEVERO_FILES/insurance-library-bulk-data-export(FILE_FORMAT => DISC_${var.SF_ENVIRONMENT}.STAGE.XML_STRIPOUT_FORMAT_AB) INSURANCE);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.DEVERO.DEVERO_INSURANCE AS (SELECT * FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.VIEW_${var.SF_ENVIRONMENT}ERO_INSURANCE);

    return ''Success'';
END;

 EOT
}

