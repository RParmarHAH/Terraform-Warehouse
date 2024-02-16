CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYMENTPOSTING("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PaymentPosting 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentPosting FROM (SELECT t.$1 AS post_ID, t.$2 AS post_PaymentRegisterID, t.$3 AS post_Amount, t.$4 AS post_PostedDate, t.$5 AS post_InvoiceDetailID, t.$6 AS post_PaymentPostingTypeID, t.$7 AS post_Notes, t.$8 AS post_PeriodClosedID, t.$9 AS post_CreatedDate, t.$10 AS post_CreatedUser, t.$11 AS post_ModifiedDate, t.$12 AS post_ModifiedUser, t.$13 AS post_TS, t.$14 AS post_AcctExtID, t.$15 AS post_AcctExtDate, t.$16 AS post_ControlNo, t.$17 AS post_EdiID, t.$18 AS post_EFTID, t.$19 AS post_IncludeEFT, t.$20 AS post_DeleteWithInvoice, t.$21 AS post_DeleteWithInvoiceHeaderID, t.$22 AS InsertDate, t.$23 AS UpdateDate, t.$24 AS DeletedFlag, t.$25 AS SYS_CHANGE_VERSION, CASE WHEN t.$24 = True THEN ''D'' WHEN t.$22 = t.$23 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$24, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentPosting[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentPosting AS WITH curr_v AS (SELECT post_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentPosting GROUP BY post_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentPosting t INNER JOIN curr_v v ON t.post_ID = v.post_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';