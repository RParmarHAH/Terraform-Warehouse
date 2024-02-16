CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_PAYROLLBATCH("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayrollBatch 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollBatch FROM (SELECT t.$1 AS prollb_ID, t.$2 AS prollb_BranchID, t.$3 AS prollb_ExtractTypeID, t.$4 AS prollb_PayDate, t.$5 AS prollb_FinalizedDate, t.$6 AS prollb_CaregiverGroupID, t.$7 AS prollb_PayrollCompanyExtractTypeID, t.$8 AS prollb_LastPRCompanyExtractDate, t.$9 AS prollb_LastPRCompanyExtractUser, t.$10 AS prollb_CreatedDate, t.$11 AS prollb_CreatedUser, t.$12 AS prollb_ModifiedDate, t.$13 AS prollb_ModifiedUser, t.$14 AS prollb_TS, t.$15 AS prollb_CancelUser, t.$16 AS prollb_CancelDate, t.$17 AS prollb_ServiceThroughDate, t.$18 AS prollb_LastDraftDate, t.$19 AS prollb_LastDraftUser, t.$20 AS prollb_CaregiverID, t.$21 AS prollb_OTSettings, t.$22 AS prollb_IsHolidayOTEligible, t.$23 AS InsertDate, t.$24 AS UpdateDate, t.$25 AS DeletedFlag, t.$26 AS SYS_CHANGE_VERSION, CASE WHEN t.$25 = True THEN ''D'' WHEN t.$23 = t.$24 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$25, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollBatch.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollBatch AS WITH curr_v AS (SELECT prollb_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollBatch GROUP BY prollb_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PROLLB_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayrollBatch  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PROLLB_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollBatch t INNER JOIN curr_v v ON t.prollb_ID = v.prollb_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PROLLB_BRANCHID NOT IN (SELECT PROLLB_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';