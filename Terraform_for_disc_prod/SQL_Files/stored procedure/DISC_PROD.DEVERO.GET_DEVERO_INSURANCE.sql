CREATE OR REPLACE PROCEDURE DISC_PROD.DEVERO.GET_DEVERO_INSURANCE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DEVERO.GET_DEVERO_INSURANCE 
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
    INSERT INTO DISC_PROD.DEVERO.HIST_DEVERO_INSURANCE (SELECT DISTINCT XMLGET(INSURANCE.$1, ''INSURANCE_ID''):"$" :: STRING AS INSURANCE_ID,  INSURANCE.$1 :: STRING AS INSURANCE_XML,XMLGET(INSURANCE.$1,''DATE_MODIFIED''):"$" :: STRING AS DATE_MODIFIED,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Devero/DEVERO_FILES/insurance-library-bulk-data-export(FILE_FORMAT => DISC_PROD.STAGE.XML_STRIPOUT_FORMAT_AB) INSURANCE);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.DEVERO.DEVERO_INSURANCE AS (SELECT * FROM DISC_PROD.DEVERO.VIEW_DEVERO_INSURANCE);

    return ''Success'';
END;
';