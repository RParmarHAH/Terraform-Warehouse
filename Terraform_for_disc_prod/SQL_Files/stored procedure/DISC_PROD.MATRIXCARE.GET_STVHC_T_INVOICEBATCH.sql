CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_INVOICEBATCH("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_InvoiceBatch 
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
    COPY INTO MatrixCare.HIST_STVHC_T_InvoiceBatch FROM (SELECT t.$1 AS invb_ID, t.$2 AS invb_BranchID, t.$3 AS invb_InvProcessID, t.$4 AS invb_StartDate, t.$5 AS invb_EndDate, t.$6 AS invb_PayerID, t.$7 AS invb_ServiceCodeID, t.$8 AS invb_FinalizedDate, t.$9 AS invb_ServCategoryID, t.$10 AS invb_LastDraftDate, t.$11 AS invb_LastDraftUser, t.$12 AS invb_CreatedDate, t.$13 AS invb_CreatedUser, t.$14 AS invb_ModifiedDate, t.$15 AS invb_ModifiedUser, t.$16 AS invb_TS, t.$17 AS invb_InvoiceDate, t.$18 AS invb_ClientID, t.$19 AS invb_ReDraft, t.$20 AS InsertDate, t.$21 AS UpdateDate, t.$22 AS DeletedFlag, t.$23 AS SYS_CHANGE_VERSION, CASE WHEN t.$22 = True THEN ''D'' WHEN t.$20 = t.$21 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$22, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_InvoiceBatch[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_InvoiceBatch AS WITH curr_v AS (SELECT invb_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_InvoiceBatch GROUP BY invb_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT INVB_BRANCHID FROM MatrixCare.HIST_STVHC_T_InvoiceBatch br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.INVB_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_InvoiceBatch t INNER JOIN curr_v v ON t.invb_ID = v.invb_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.INVB_BRANCHID NOT IN (SELECT INVB_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';