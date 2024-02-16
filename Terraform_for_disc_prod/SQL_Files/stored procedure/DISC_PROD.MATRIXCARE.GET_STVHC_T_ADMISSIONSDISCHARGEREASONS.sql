CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_ADMISSIONSDISCHARGEREASONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_AdmissionsDischargeReasons 
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
    COPY INTO MatrixCare.HIST_STVHC_T_AdmissionsDischargeReasons FROM (SELECT t.$1 AS admdcr_ID, t.$2 AS admdcr_CreatedDate, t.$3 AS admdcr_CreatedUser, t.$4 AS admdcr_ModifiedDate, t.$5 AS admdcr_ModifiedUser, t.$6 AS admdcr_TS, t.$7 AS admdcr_Name, t.$8 AS admdcr_ListItemType, t.$9 AS admdcr_RptGroupID, t.$10 AS admdcr_BranchID, t.$11 AS admdcr_OverrideID, t.$12 AS admdcr_Active, t.$13 AS admdcr_Description, t.$14 AS admdcr_Code, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_AdmissionsDischargeReasons.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_AdmissionsDischargeReasons AS WITH curr_v AS (SELECT admdcr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_AdmissionsDischargeReasons GROUP BY admdcr_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT ADMDCR_BRANCHID FROM MatrixCare.HIST_STVHC_T_AdmissionsDischargeReasons br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.ADMDCR_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_AdmissionsDischargeReasons t INNER JOIN curr_v v ON t.admdcr_ID = v.admdcr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ADMDCR_BRANCHID NOT IN (SELECT ADMDCR_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';