CREATE OR REPLACE PROCEDURE DISC_PROD.DEVERO.GET_DEVERO_AGENCY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DEVERO.GET_DEVERO_AGENCY 
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
    INSERT INTO DISC_PROD.DEVERO.HIST_DEVERO_AGENCY (SELECT DISTINCT XMLGET(AGENCY.$1, ''AGENCY_ID''):"$" :: STRING AS AGENCY_ID,  AGENCY.$1 :: STRING AS AGENCY_XML,XMLGET(AGENCY.$1,''DATE_MODIFIED''):"$" :: STRING AS DATE_MODIFIED,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Devero/DEVERO_FILES/agency-bulk-data-export(file_format => DISC_PROD.STAGE.XML_STRIPOUT_FORMAT_AB) AGENCY);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.DEVERO.DEVERO_AGENCY AS (SELECT * FROM DISC_PROD.DEVERO.VIEW_DEVERO_AGENCY);

    return ''Success'';
END;
';