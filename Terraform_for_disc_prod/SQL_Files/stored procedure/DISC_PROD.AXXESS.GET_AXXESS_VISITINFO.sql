CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_VISITINFO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_VISITINFO 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_VISITINFO ( SELECT VI.$1 AS VISIT_ID, VI.$2 AS PATIENT_ID, VI.$3 AS EPISODE_ID, VI.$4 AS DISCIPLINE_TASK, VI.$5 AS VISIT_STATUS, VI.$6 AS VISIT_DATE, VI.$7 AS START_DATE, VI.$8 AS END_DATE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/VisitInfo(file_format => DISC_PROD.STAGE.PSV_FORMAT) VI );

    return ''Success'';
END;
';