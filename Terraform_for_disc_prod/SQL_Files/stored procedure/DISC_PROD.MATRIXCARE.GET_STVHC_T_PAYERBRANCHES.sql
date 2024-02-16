CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYERBRANCHES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayerBranches 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayerBranches FROM (SELECT t.$1 AS paybr_ID, t.$2 AS paybr_PayerID, t.$3 AS paybr_Branch_ID, t.$4 AS paybr_CreatedUser, t.$5 AS paybr_CreatedDate, t.$6 AS paybr_ModifiedUser, t.$7 AS paybr_ModifiedDate, t.$8 AS paybr_TS, t.$9 AS paybr_AllowFlexibleTimeScheduling, t.$10 AS InsertDate, t.$11 AS UpdateDate, t.$12 AS DeletedFlag, t.$13 AS SYS_CHANGE_VERSION, CASE WHEN t.$12 = True THEN ''D'' WHEN t.$10 = t.$11 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$12, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayerBranches.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayerBranches AS WITH curr_v AS (SELECT paybr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayerBranches GROUP BY paybr_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PAYBR_BRANCH_ID FROM MatrixCare.HIST_STVHC_T_PayerBranches br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PAYBR_BRANCH_ID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayerBranches t INNER JOIN curr_v v ON t.paybr_ID = v.paybr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PAYBR_BRANCH_ID NOT IN (SELECT PAYBR_BRANCH_ID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';