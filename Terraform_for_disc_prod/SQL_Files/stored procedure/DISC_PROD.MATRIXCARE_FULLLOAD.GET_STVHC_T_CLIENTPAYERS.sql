CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CLIENTPAYERS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_ClientPayers 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientPayers FROM (SELECT t.$1 AS clipay_ID, t.$2 AS clipay_ClientID, t.$3 AS clipay_PayerID, t.$4 AS clipay_SeqNo, t.$5 AS clipay_PolicyNumber, t.$6 AS clipay_EffectiveDate, t.$7 AS clipay_ExpirationDate, t.$8 AS clipay_BillSplitTypeID, t.$9 AS clipay_DefaultFlag, t.$10 AS clipay_Amount, t.$11 AS clipay_Percent, t.$12 AS clipay_DiscountAmount, t.$13 AS clipay_DiscountPercent, t.$14 AS clipay_Deductible, t.$15 AS clipay_DeductibleBalance, t.$16 AS clipay_CopayerID, t.$17 AS clipay_CopayAmount, t.$18 AS clipay_CopayPercent, t.$19 AS clipay_CopayMultiplier, t.$20 AS clipay_CopayInvoiceNote, t.$21 AS clipay_Notes, t.$22 AS clipay_BillNote, t.$23 AS clipay_ActiveFlag, t.$24 AS clipay_ExcludeHoliday, t.$25 AS clipay_CreatedDate, t.$26 AS clipay_CreatedUser, t.$27 AS clipay_ModifiedDate, t.$28 AS clipay_ModifiedUser, t.$29 AS clipay_TS, t.$30 AS clipay_AuthRequired, t.$31 AS clipay_AuthsUseServiceCategories, t.$32 AS clipay_AuthorizationConflictsAllow, t.$33 AS clipay_AddressBookID, t.$34 AS clipay_ChargeAllocationSeqNo, t.$35 AS clipay_ManageCOB, t.$36 AS InsertDate, t.$37 AS UpdateDate, t.$38 AS DeletedFlag, t.$39 AS SYS_CHANGE_VERSION, CASE WHEN t.$38 = True THEN ''D'' WHEN t.$36 = t.$37 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$38, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientPayers.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientPayers AS WITH curr_v AS (SELECT clipay_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientPayers GROUP BY clipay_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientPayers t INNER JOIN curr_v v ON t.clipay_ID = v.clipay_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';