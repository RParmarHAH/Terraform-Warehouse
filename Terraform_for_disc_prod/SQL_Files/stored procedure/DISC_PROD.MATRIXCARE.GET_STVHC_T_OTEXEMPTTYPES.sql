CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_OTEXEMPTTYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_OTExemptTypes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_OTExemptTypes FROM (SELECT t.$1 AS otextyp_ID, t.$2 AS otextyp_Name, t.$3 AS otextyp_OTExemptHrs, t.$4 AS otextyp_ListItemType, t.$5 AS otextyp_BranchID, t.$6 AS otextyp_RptGroupID, t.$7 AS otextyp_OverrideID, t.$8 AS otextyp_Active, t.$9 AS otextyp_CreatedDate, t.$10 AS otextyp_CreatedUser, t.$11 AS otextyp_ModifiedDate, t.$12 AS otextyp_ModifiedUser, t.$13 AS otextyp_TS, t.$14 AS otextyp_Description, t.$15 AS otextyp_Bill, t.$16 AS otextyp_Pay, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_OTExemptTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_OTExemptTypes AS WITH curr_v AS (SELECT otextyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_OTExemptTypes GROUP BY otextyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT OTEXTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_OTExemptTypes br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.OTEXTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_OTExemptTypes t INNER JOIN curr_v v ON t.otextyp_ID = v.otextyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.OTEXTYP_BRANCHID,-1) NOT IN (SELECT OTEXTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';