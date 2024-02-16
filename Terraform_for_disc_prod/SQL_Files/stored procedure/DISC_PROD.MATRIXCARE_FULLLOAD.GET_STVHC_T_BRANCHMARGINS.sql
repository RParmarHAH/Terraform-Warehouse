CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_BRANCHMARGINS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_BranchMargins 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BranchMargins FROM (SELECT t.$1 AS brmarg_ID, t.$2 AS brmarg_BranchID, t.$3 AS brmarg_TypeID, t.$4 AS brmarg_Name, t.$5 AS brmarg_Desc, t.$6 AS brmarg_Percent, t.$7 AS brmarg_FixedAmt, t.$8 AS brmarg_EffectiveStart, t.$9 AS brmarg_EffectiveEnd, t.$10 AS brmarg_CreatedDate, t.$11 AS brmarg_CreatedUser, t.$12 AS brmarg_ModifiedDate, t.$13 AS brmarg_ModifiedUser, t.$14 AS brmarg_TS, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BranchMargins.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BranchMargins AS WITH curr_v AS (SELECT brmarg_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BranchMargins GROUP BY brmarg_ID),EXCLUDE_LIST AS ( SELECT DISTINCT BRMARG_BRANCHID FROM MatrixCare.HIST_STVHC_T_BranchMargins br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BRMARG_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_BranchMargins t INNER JOIN curr_v v ON t.brmarg_ID = v.brmarg_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.BRMARG_BRANCHID NOT IN (SELECT BRMARG_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';