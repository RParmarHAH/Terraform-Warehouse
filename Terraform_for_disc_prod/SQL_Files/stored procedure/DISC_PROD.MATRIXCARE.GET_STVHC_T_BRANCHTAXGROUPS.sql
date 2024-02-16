CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_BRANCHTAXGROUPS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_BranchTaxGroups 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BranchTaxGroups FROM (SELECT t.$1 AS brtg_ID, t.$2 AS brtg_BranchID, t.$3 AS brtg_Name, t.$4 AS brtg_CreatedDate, t.$5 AS brtg_CreatedUser, t.$6 AS brtg_ModifiedDate, t.$7 AS brtg_ModifiedUser, t.$8 AS brtg_TS, t.$9 AS brtg_Description, t.$10 AS InsertDate, t.$11 AS UpdateDate, t.$12 AS DeletedFlag, t.$13 AS SYS_CHANGE_VERSION, CASE WHEN t.$12 = True THEN ''D'' WHEN t.$10 = t.$11 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$12, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BranchTaxGroups.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BranchTaxGroups AS WITH curr_v AS (SELECT brtg_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BranchTaxGroups GROUP BY brtg_ID),EXCLUDE_LIST AS ( SELECT DISTINCT BRTG_BRANCHID FROM MatrixCare.HIST_STVHC_T_BranchTaxGroups br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BRTG_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_BranchTaxGroups t INNER JOIN curr_v v ON t.brtg_ID = v.brtg_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.BRTG_BRANCHID NOT IN (SELECT BRTG_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';