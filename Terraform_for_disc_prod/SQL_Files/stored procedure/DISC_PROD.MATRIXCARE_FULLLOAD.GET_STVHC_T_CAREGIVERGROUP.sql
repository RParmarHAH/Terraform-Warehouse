CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CAREGIVERGROUP("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverGroup 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverGroup FROM (SELECT t.$1 AS carg_ID, t.$2 AS carg_Name, t.$3 AS carg_Active, t.$4 AS carg_CreatedUser, t.$5 AS carg_CreatedDate, t.$6 AS carg_ModifiedUser, t.$7 AS carg_ModifiedDate, t.$8 AS carg_TS, t.$9 AS carg_ListItemType, t.$10 AS carg_RptGroupID, t.$11 AS carg_BranchID, t.$12 AS carg_OverrideID, t.$13 AS carg_Description, t.$14 AS carg_IsContractor, t.$15 AS carg_AutoCalcTravel, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverGroup.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverGroup AS WITH curr_v AS (SELECT carg_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverGroup GROUP BY carg_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CARG_BRANCHID FROM MatrixCare.HIST_STVHC_T_CaregiverGroup br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CARG_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverGroup t INNER JOIN curr_v v ON t.carg_ID = v.carg_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CARG_BRANCHID NOT IN (SELECT CARG_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';