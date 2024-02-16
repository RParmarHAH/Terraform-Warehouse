CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_INSURANCEFEESCHEDULE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_INSURANCEFEESCHEDULE 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_INSURANCEFEESCHEDULE ( SELECT BI.$1 AS INSURANCE_FEE_SCHEDULE_ID, BI.$2 AS CUSTOM_ID, BI.$3 AS UNIT, BI.$4 AS CHARGE, BI.$5 AS CODE, BI.$6 AS EXPECTED_RATE, BI.$7 AS INSURANCE_ID, BI.$8 AS PREFERRED_DESCRIPTION, BI.$9 AS REVENUE_CODE, BI.$10 AS TAXONOMY_CODE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/InsuranceFeeSchedule(file_format => DISC_PROD.STAGE.PSV_FORMAT) BI );

    return ''Success'';
END;
';