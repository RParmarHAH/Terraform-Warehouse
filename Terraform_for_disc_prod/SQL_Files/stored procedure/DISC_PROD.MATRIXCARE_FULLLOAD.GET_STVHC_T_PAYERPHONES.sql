CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_PAYERPHONES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayerPhones 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayerPhones FROM (SELECT t.$1 AS payp_ID, t.$2 AS payp_PayerID, t.$3 AS payp_Phone, t.$4 AS payp_PhoneType, t.$5 AS payp_Note, t.$6 AS payp_Sequence, t.$7 AS InsertDate, t.$8 AS UpdateDate, t.$9 AS DeletedFlag, t.$10 AS SYS_CHANGE_VERSION, CASE WHEN t.$9 = True THEN ''D'' WHEN t.$7 = t.$8 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$9, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayerPhones.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayerPhones AS WITH curr_v AS (SELECT payp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayerPhones GROUP BY payp_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayerPhones t INNER JOIN curr_v v ON t.payp_ID = v.payp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';