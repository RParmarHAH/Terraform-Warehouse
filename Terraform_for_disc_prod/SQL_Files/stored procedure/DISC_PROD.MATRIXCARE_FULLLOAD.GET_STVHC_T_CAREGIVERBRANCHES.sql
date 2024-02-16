CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CAREGIVERBRANCHES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverBranches 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverBranches FROM (SELECT t.$1 AS carbr_ID, t.$2 AS carbr_CaregiverID, t.$3 AS carbr_Branch_ID, t.$4 AS carbr_CreatedUser, t.$5 AS carbr_CreatedDate, t.$6 AS carbr_ModifiedUser, t.$7 AS carbr_ModifiedDate, t.$8 AS carbr_TS, t.$9 AS carbr_WageChartID, t.$10 AS carbr_ADPFileNum, t.$11 AS InsertDate, t.$12 AS UpdateDate, t.$13 AS DeletedFlag, t.$14 AS SYS_CHANGE_VERSION, CASE WHEN t.$13 = True THEN ''D'' WHEN t.$11 = t.$12 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$13, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverBranches.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverBranches AS WITH curr_v AS (SELECT carbr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverBranches GROUP BY carbr_ID),EXCLUDE_LIST AS ( SELECT DISTINCT CARBR_BRANCH_ID FROM MatrixCare.HIST_STVHC_T_CaregiverBranches br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CARBR_BRANCH_ID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverBranches t INNER JOIN curr_v v ON t.carbr_ID = v.carbr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CARBR_BRANCH_ID NOT IN (SELECT CARBR_BRANCH_ID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';