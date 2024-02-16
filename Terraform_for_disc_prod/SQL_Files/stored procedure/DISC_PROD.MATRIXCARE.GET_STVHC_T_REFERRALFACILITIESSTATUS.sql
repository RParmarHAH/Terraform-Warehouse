CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_REFERRALFACILITIESSTATUS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ReferralFacilitiesStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralFacilitiesStatus FROM (SELECT t.$1 AS reffac_ID, t.$2 AS reffac_Name, t.$3 AS reffac_ShowOrHide, t.$4 AS reffac_Active, t.$5 AS reffac_ListItemType, t.$6 AS reffac_RptGroupID, t.$7 AS reffac_BranchID, t.$8 AS reffac_OverrideID, t.$9 AS reffac_CreatedDate, t.$10 AS reffac_CreatedUser, t.$11 AS reffac_ModifiedDate, t.$12 AS reffac_ModifiedUser, t.$13 AS reffac_TS, t.$14 AS reffac_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralFacilitiesStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralFacilitiesStatus AS WITH curr_v AS (SELECT reffac_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesStatus GROUP BY reffac_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT REFFAC_BRANCHID FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesStatus  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.REFFAC_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesStatus t INNER JOIN curr_v v ON t.reffac_ID = v.reffac_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.REFFAC_BRANCHID,-1) NOT IN (SELECT REFFAC_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';