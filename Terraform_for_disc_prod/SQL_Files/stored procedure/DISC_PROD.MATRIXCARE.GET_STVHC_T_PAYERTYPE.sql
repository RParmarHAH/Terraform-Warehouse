CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYERTYPE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayerType 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayerType FROM (SELECT t.$1 AS paytyp_ID, t.$2 AS paytyp_Name, t.$3 AS paytyp_Active, t.$4 AS paytyp_CreatedDate, t.$5 AS paytyp_CreatedUser, t.$6 AS paytyp_ModifiedDate, t.$7 AS paytyp_ModifiedUser, t.$8 AS paytyp_TS, t.$9 AS paytyp_ListItemType, t.$10 AS paytyp_RptGroupID, t.$11 AS paytyp_BranchID, t.$12 AS paytyp_OverrideID, t.$13 AS paytyp_Description, t.$14 AS paytyp_AcctID, t.$15 AS paytyp_DefAcctID, t.$16 AS paytyp_AcctCode, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayerType.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayerType AS WITH curr_v AS (SELECT paytyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayerType GROUP BY paytyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PAYTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayerType  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PAYTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayerType t INNER JOIN curr_v v ON t.paytyp_ID = v.paytyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.PAYTYP_BRANCHID,-1) NOT IN (SELECT PAYTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';