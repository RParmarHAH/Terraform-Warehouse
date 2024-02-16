CREATE OR REPLACE PROCEDURE DISC_PROD.DEVERO.GET_DEVERO_PATIENT_PROFILE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DEVERO.GET_DEVERO_PATIENT_PROFILE 
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
    INSERT INTO DISC_PROD.DEVERO.HIST_DEVERO_PATIENT_PROFILE (SELECT DISTINCT XMLGET(FORM.$1, ''FORM_ID''):"$"::STRING AS FORM_ID,XMLGET(FORM.$1, ''PATIENT_CODE''):"$"::STRING AS PATIENT_CODE,XMLGET(FORM.$1, ''CHART_NUMBER''):"$"::STRING AS CHART_NUMBER,XMLGET(FORM.$1,''DATE_MODIFIED''):"$" :: STRING AS DATE_MODIFIED,FORM.$1 :: STRING AS FORM_XML,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Devero/DEVERO_FILES/form-bulk-data-export(file_format => DISC_PROD.STAGE.XML_STRIPOUT_FORMAT_AB) AS FORM WHERE XMLGET(FORM.$1, ''FORM_NAME''):"$"::STRING = ''Patient Profile'');

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.DEVERO.DEVERO_PATIENT_PROFILE AS (SELECT * FROM DISC_PROD.DEVERO.VIEW_DEVERO_PATIENT_PROFILE);

    return ''Success'';
END;
';