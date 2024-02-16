CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_REFERRALTERRITORIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ReferralTerritories 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralTerritories FROM (SELECT t.$1 AS refter_ID, t.$2 AS refter_Name, t.$3 AS refter_Description, t.$4 AS refter_BranchID, t.$5 AS refter_Active, t.$6 AS refter_CreatedDate, t.$7 AS refter_CreatedUser, t.$8 AS refter_ModifiedDate, t.$9 AS refter_ModifiedUser, t.$10 AS refter_TS, t.$11 AS InsertDate, t.$12 AS UpdateDate, t.$13 AS DeletedFlag, t.$14 AS SYS_CHANGE_VERSION, CASE WHEN t.$13 = True THEN ''D'' WHEN t.$11 = t.$12 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$13, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralTerritories.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralTerritories AS WITH curr_v AS (SELECT refter_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralTerritories GROUP BY refter_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT REFTER_BRANCHID FROM MatrixCare.HIST_STVHC_T_ReferralTerritories  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.REFTER_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralTerritories t INNER JOIN curr_v v ON t.refter_ID = v.refter_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.REFTER_BRANCHID NOT IN (SELECT REFTER_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';