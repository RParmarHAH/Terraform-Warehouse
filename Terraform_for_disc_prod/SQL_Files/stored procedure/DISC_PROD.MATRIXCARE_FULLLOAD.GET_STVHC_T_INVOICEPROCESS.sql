CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_INVOICEPROCESS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_InvoiceProcess 
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
    COPY INTO MatrixCare.HIST_STVHC_T_InvoiceProcess FROM (SELECT t.$1 AS invPr_ID, t.$2 AS invPr_Name, t.$3 AS invPr_Active, t.$4 AS invPr_SPDraftName, t.$5 AS invPr_SPCheckTSName, t.$6 AS invPr_SPFinalizeName, t.$7 AS invPr_SPUnbillBatch, t.$8 AS invPr_SPUnbillInvoice, t.$9 AS invPr_SPReverseInvoice, t.$10 AS invPr_SPTransferInvoice, t.$11 AS invPr_InfoClassID, t.$12 AS invPr_CreatedDate, t.$13 AS invPr_CreatedUser, t.$14 AS invPr_ModifiedDate, t.$15 AS invPr_ModifiedUser, t.$16 AS invPr_TS, t.$17 AS invPr_Description, t.$18 AS invPr_SPCheckEdits, t.$19 AS invPr_GroupBy, t.$20 AS invPr_GroupByAuth, t.$21 AS invPr_SPGroupingLogic, t.$22 AS invPr_SPLateGrouping, t.$23 AS invPr_KeyPrepareCOB, t.$24 AS invPr_KeyCreateCOB, t.$25 AS invPr_ProcessingInstructions, t.$26 AS invPr_IsPPS, t.$27 AS invPr_BaseDraftType, t.$28 AS InsertDate, t.$29 AS UpdateDate, t.$30 AS DeletedFlag, t.$31 AS SYS_CHANGE_VERSION, CASE WHEN t.$30 = True THEN ''D'' WHEN t.$28 = t.$29 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$30, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_InvoiceProcess.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_InvoiceProcess AS WITH curr_v AS (SELECT invPr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_InvoiceProcess GROUP BY invPr_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_InvoiceProcess t INNER JOIN curr_v v ON t.invPr_ID = v.invPr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';