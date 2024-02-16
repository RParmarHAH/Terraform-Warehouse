CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_RATESOVERRIDETYPE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_RatesOverrideType 
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
    COPY INTO MatrixCare.HIST_STVHC_T_RatesOverrideType FROM (SELECT t.$1 AS rateot_OverrideType, t.$2 AS rateot_Description, t.$3 AS InsertDate, t.$4 AS UpdateDate, t.$5 AS DeletedFlag, t.$6 AS SYS_CHANGE_VERSION, CASE WHEN t.$5 = True THEN ''D'' WHEN t.$3 = t.$4 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$5, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_RatesOverrideType.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_RatesOverrideType AS WITH curr_v AS (SELECT rateot_OverrideType, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_RatesOverrideType GROUP BY rateot_OverrideType) SELECT t.* FROM MatrixCare.HIST_STVHC_T_RatesOverrideType t INNER JOIN curr_v v ON t.rateot_OverrideType = v.rateot_OverrideType AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';