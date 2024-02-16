CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_PAYMENTREGISTERSTATUS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PaymentRegisterStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentRegisterStatus FROM (SELECT t.$1 AS pmtrstat_ID, t.$2 AS pmtrstat_Name, t.$3 AS pmtrstat_Active, t.$4 AS pmtrstat_CreatedDate, t.$5 AS pmtrstat_CreatedUser, t.$6 AS pmtrstat_ModifiedDate, t.$7 AS pmtrstat_ModifiedUser, t.$8 AS pmtrstat_TS, t.$9 AS pmtrstat_ListItemType, t.$10 AS pmtrstat_RptGroupID, t.$11 AS pmtrstat_BranchID, t.$12 AS pmtrstat_OverrideID, t.$13 AS pmtrstat_Description, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentRegisterStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentRegisterStatus AS WITH curr_v AS (SELECT pmtrstat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentRegisterStatus GROUP BY pmtrstat_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PMTRSTAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_PaymentRegisterStatus  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PMTRSTAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentRegisterStatus t INNER JOIN curr_v v ON t.pmtrstat_ID = v.pmtrstat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.PMTRSTAT_BRANCHID,-1) NOT IN (SELECT PMTRSTAT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';