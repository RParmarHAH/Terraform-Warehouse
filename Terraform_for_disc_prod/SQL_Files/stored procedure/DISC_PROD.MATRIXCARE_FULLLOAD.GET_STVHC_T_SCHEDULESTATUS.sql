CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_SCHEDULESTATUS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ScheduleStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ScheduleStatus FROM (SELECT t.$1 AS schst_ID, t.$2 AS schst_Name, t.$3 AS schst_BackColor, t.$4 AS schst_ForeColor, t.$5 AS schst_ConflictCheck, t.$6 AS schst_OTCheck, t.$7 AS schst_Active, t.$8 AS schst_RecSameStartEndAction, t.$9 AS schst_RecOnlySameStartAction, t.$10 AS schst_RecSameDateDifStartAction, t.$11 AS schst_RecNoMatchAction, t.$12 AS schst_RecRootSchedChangeAction, t.$13 AS schst_ModifiedDate, t.$14 AS schst_ModifiedUser, t.$15 AS schst_CreatedDate, t.$16 AS schst_CreatedUser, t.$17 AS schst_TS, t.$18 AS schst_ListItemType, t.$19 AS schst_RptGroupID, t.$20 AS schst_BranchID, t.$21 AS schst_OverrideID, t.$22 AS schst_Description, t.$23 AS schst_IsACaregiverLastVisit, t.$24 AS schst_UploadTelephony, t.$25 AS schst_AvailCheck, t.$26 AS schst_DNUCheck, t.$27 AS schst_ExpirCheck, t.$28 AS schst_AuthCheck, t.$29 AS schst_CalcRates, t.$30 AS schst_DisplayOnClientPortal, t.$31 AS schst_DisplayOnCaregiverPortal, t.$32 AS schst_IncludeInTherapyCount, t.$33 AS schst_SkillGroupCheck, t.$34 AS schst_AutoCalcTravel, t.$35 AS InsertDate, t.$36 AS UpdateDate, t.$37 AS DeletedFlag, t.$38 AS SYS_CHANGE_VERSION, CASE WHEN t.$37 = True THEN ''D'' WHEN t.$35 = t.$36 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$37, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ScheduleStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ScheduleStatus AS WITH curr_v AS (SELECT schst_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ScheduleStatus GROUP BY schst_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT SCHST_BRANCHID FROM MatrixCare.HIST_STVHC_T_ScheduleStatus  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.SCHST_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ScheduleStatus t INNER JOIN curr_v v ON t.schst_ID = v.schst_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.SCHST_BRANCHID NOT IN (SELECT SCHST_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';