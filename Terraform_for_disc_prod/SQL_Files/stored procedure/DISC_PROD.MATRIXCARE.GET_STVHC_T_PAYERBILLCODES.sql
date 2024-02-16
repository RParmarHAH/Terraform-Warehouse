CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYERBILLCODES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayerBillCodes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayerBillCodes FROM (SELECT t.$1 AS paybc_ID, t.$2 AS paybc_PayerID, t.$3 AS paybc_ServiceCodeID, t.$4 AS paybc_UnitFlag, t.$5 AS paybc_BillCodeID, t.$6 AS paybc_EffectiveStart, t.$7 AS paybc_EffectiveEnd, t.$8 AS paybc_CreatedDate, t.$9 AS paybc_CreatedUser, t.$10 AS paybc_ModifiedDate, t.$11 AS paybc_ModifiedUser, t.$12 AS paybc_TS, t.$13 AS InsertDate, t.$14 AS UpdateDate, t.$15 AS DeletedFlag, t.$16 AS SYS_CHANGE_VERSION, CASE WHEN t.$15 = True THEN ''D'' WHEN t.$13 = t.$14 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$15, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayerBillCodes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayerBillCodes AS WITH curr_v AS (SELECT paybc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayerBillCodes GROUP BY paybc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayerBillCodes t INNER JOIN curr_v v ON t.paybc_ID = v.paybc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';