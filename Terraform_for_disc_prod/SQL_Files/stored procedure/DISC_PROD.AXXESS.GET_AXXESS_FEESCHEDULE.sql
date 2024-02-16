CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_FEESCHEDULE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_FeeSchedule 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		KDHOKAI/RSUTHAR            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_FeeSchedule ( SELECT EI.$1 VISIT_BILL_RATE_ID, EI.$2 UNIT,EI.$3 PREFERRED_DESCRIPTION,EI.$4 REVENUE_CODE,EI.$5 CODE,EI.$6 COMPANY,EI.$7 EXPECTED_RATE,EI.$8 CHARGE,EI.$9 DISCIPLINE_TASK_NAME, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/FeeSchedule(file_format => DISC_PROD.STAGE.PSV_ZIPCODES) EI );

    return ''Success'';
END;
';