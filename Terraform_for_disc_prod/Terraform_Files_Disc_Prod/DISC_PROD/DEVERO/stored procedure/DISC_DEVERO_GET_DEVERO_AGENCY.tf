resource "snowflake_procedure" "DISC_DEVERO_GET_DEVERO_AGENCY" {
	name ="GET_DEVERO_AGENCY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DEVERO.GET_${var.SF_ENVIRONMENT}ERO_AGENCY 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.DEVERO.HIST_${var.SF_ENVIRONMENT}ERO_AGENCY (SELECT DISTINCT XMLGET(AGENCY.$1, ''AGENCY_ID''):"$" :: STRING AS AGENCY_ID,  AGENCY.$1 :: STRING AS AGENCY_XML,XMLGET(AGENCY.$1,''DATE_MODIFIED''):"$" :: STRING AS DATE_MODIFIED,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Devero/DEVERO_FILES/agency-bulk-data-export(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.XML_STRIPOUT_FORMAT_AB) AGENCY);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.DEVERO.DEVERO_AGENCY AS (SELECT * FROM DISC_${var.SF_ENVIRONMENT}.DEVERO.VIEW_${var.SF_ENVIRONMENT}ERO_AGENCY);

    return ''Success'';
END;

 EOT
}

