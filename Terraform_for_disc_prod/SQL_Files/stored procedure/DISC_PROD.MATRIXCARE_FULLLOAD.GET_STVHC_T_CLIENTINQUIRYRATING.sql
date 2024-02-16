CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CLIENTINQUIRYRATING("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ClientInquiryRating 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientInquiryRating FROM (SELECT t.$1 AS cliinqrat_ID, t.$2 AS cliinqrat_Name, t.$3 AS cliinqrat_Description, t.$4 AS cliinqrat_Active, t.$5 AS cliinqrat_CreatedDate, t.$6 AS cliinqrat_CreatedUser, t.$7 AS cliinqrat_ModifiedDate, t.$8 AS cliinqrat_ModifiedUser, t.$9 AS cliinqrat_TS, t.$10 AS cliinqrat_ListItemType, t.$11 AS cliinqrat_RptGroupID, t.$12 AS cliinqrat_BranchID, t.$13 AS cliinqrat_OverrideID, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientInquiryRating.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientInquiryRating AS WITH curr_v AS (SELECT cliinqrat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientInquiryRating GROUP BY cliinqrat_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIINQRAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_ClientInquiryRating br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIINQRAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientInquiryRating t INNER JOIN curr_v v ON t.cliinqrat_ID = v.cliinqrat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.CLIINQRAT_BRANCHID,-1) NOT IN (SELECT CLIINQRAT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';