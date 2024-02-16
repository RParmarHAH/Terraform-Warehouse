CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_INVOICEBATCHTAXES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_InvoiceBatchTaxes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_InvoiceBatchTaxes FROM (SELECT t.$1 AS invbtx_ID, t.$2 AS invbtx_InvBatchGroupID, t.$3 AS invbtx_TaxTypeID, t.$4 AS invbtx_TaxID, t.$5 AS invbtx_Percent, t.$6 AS invbtx_FixedAmt, t.$7 AS invbtx_Description, t.$8 AS invbtx_EffectiveStart, t.$9 AS invbtx_EffectiveEnd, t.$10 AS invbtx_HCPCS, t.$11 AS invbtx_Desc, t.$12 AS InsertDate, t.$13 AS UpdateDate, t.$14 AS DeletedFlag, t.$15 AS SYS_CHANGE_VERSION, CASE WHEN t.$14 = True THEN ''D'' WHEN t.$12 = t.$13 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$14, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_InvoiceBatchTaxes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_InvoiceBatchTaxes AS WITH curr_v AS (SELECT invbtx_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_InvoiceBatchTaxes GROUP BY invbtx_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_InvoiceBatchTaxes t INNER JOIN curr_v v ON t.invbtx_ID = v.invbtx_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';