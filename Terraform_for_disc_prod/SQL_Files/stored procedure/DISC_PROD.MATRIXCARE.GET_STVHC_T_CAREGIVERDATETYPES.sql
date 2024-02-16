CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_CAREGIVERDATETYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_CaregiverDateTypes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverDateTypes FROM (SELECT t.$1 AS cardttyp_ID, t.$2 AS cardttyp_Name, t.$3 AS cardttyp_Warn, t.$4 AS cardttyp_Active, t.$5 AS cardttyp_CreatedDate, t.$6 AS cardttyp_CreatedUser, t.$7 AS cardttyp_ModifiedDate, t.$8 AS cardttyp_ModifiedUser, t.$9 AS cardttyp_TS, t.$10 AS cardttyp_ListItemType, t.$11 AS cardttyp_RptGroupID, t.$12 AS cardttyp_BranchID, t.$13 AS cardttyp_OverrideID, t.$14 AS cardttyp_Description, t.$15 AS cardttyp_ReminderItem, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverDateTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverDateTypes AS WITH curr_v AS (SELECT cardttyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverDateTypes GROUP BY cardttyp_ID),EXCLUDE_LIST AS ( SELECT DISTINCT CARDTTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_CaregiverDateTypes br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CARDTTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverDateTypes t INNER JOIN curr_v v ON t.cardttyp_ID = v.cardttyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CARDTTYP_BRANCHID NOT IN (SELECT CARDTTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';