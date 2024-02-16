CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYMENTTYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PaymentTypes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentTypes FROM (SELECT t.$1 AS pmttyp_ID, t.$2 AS pmttyp_Name, t.$3 AS pmttyp_Notes, t.$4 AS pmttyp_Active, t.$5 AS pmttyp_CreatedDate, t.$6 AS pmttyp_CreatedUser, t.$7 AS pmttyp_ModifiedDate, t.$8 AS pmttyp_ModifiedUser, t.$9 AS pmttyp_TS, t.$10 AS pmttyp_ListItemType, t.$11 AS pmttyp_RptGroupID, t.$12 AS pmttyp_BranchID, t.$13 AS pmttyp_OverrideID, t.$14 AS pmttyp_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentTypes AS WITH curr_v AS (SELECT pmttyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentTypes GROUP BY pmttyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PMTTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_PaymentTypes  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PMTTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentTypes t INNER JOIN curr_v v ON t.pmttyp_ID = v.pmttyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.PMTTYP_BRANCHID,-1) NOT IN (SELECT PMTTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';