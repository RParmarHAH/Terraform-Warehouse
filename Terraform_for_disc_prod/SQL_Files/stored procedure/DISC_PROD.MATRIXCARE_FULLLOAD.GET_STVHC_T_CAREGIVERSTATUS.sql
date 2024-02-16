CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CAREGIVERSTATUS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverStatus FROM (SELECT t.$1 AS carstat_ID, t.$2 AS carstat_Code, t.$3 AS carstat_Name, t.$4 AS carstat_Certs, t.$5 AS carstat_AllowSchedule, t.$6 AS carstat_Active, t.$7 AS carstat_CreatedUser, t.$8 AS carstat_CreatedDate, t.$9 AS carstat_ModifiedUser, t.$10 AS carstat_ModifiedDate, t.$11 AS carstat_TS, t.$12 AS carstat_ListItemType, t.$13 AS carstat_RptGroupID, t.$14 AS carstat_BranchID, t.$15 AS carstat_OverrideID, t.$16 AS carstat_Description, t.$17 AS carstat_UploadTelephony, t.$18 AS InsertDate, t.$19 AS UpdateDate, t.$20 AS DeletedFlag, t.$21 AS SYS_CHANGE_VERSION, CASE WHEN t.$20 = True THEN ''D'' WHEN t.$18 = t.$19 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$20, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverStatus AS WITH curr_v AS (SELECT carstat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverStatus GROUP BY carstat_ID),EXCLUDE_LIST AS ( SELECT DISTINCT CARSTAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_CaregiverStatus br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CARSTAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverStatus t INNER JOIN curr_v v ON t.carstat_ID = v.carstat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CARSTAT_BRANCHID NOT IN (SELECT CARSTAT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';