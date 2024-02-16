CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_CAREGIVERDATES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverDates 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverDates FROM (SELECT t.$1 AS cardt_ID, t.$2 AS cardt_CaregiverID, t.$3 AS cardt_Date, t.$4 AS cardt_TypeID, t.$5 AS cardt_Notes, t.$6 AS cardt_CreatedDate, t.$7 AS cardt_CreatedUser, t.$8 AS cardt_ModifiedDate, t.$9 AS cardt_ModifiedUser, t.$10 AS cardt_TS, t.$11 AS InsertDate, t.$12 AS UpdateDate, t.$13 AS DeletedFlag, t.$14 AS SYS_CHANGE_VERSION, CASE WHEN t.$13 = True THEN ''D'' WHEN t.$11 = t.$12 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$13, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverDates.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverDates AS WITH curr_v AS (SELECT cardt_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverDates GROUP BY cardt_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverDates t INNER JOIN curr_v v ON t.cardt_ID = v.cardt_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';