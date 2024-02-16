CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_INVOICEGROUPINGTYPE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_InvoiceGroupingType 
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
    COPY INTO MatrixCare.HIST_STVHC_T_InvoiceGroupingType FROM (SELECT t.$1 AS invgr_ID, t.$2 AS invgr_Name, t.$3 AS invgr_Description, t.$4 AS invgr_SPStampID, t.$5 AS invgr_SPDynamicGroup, t.$6 AS invgr_Active, t.$7 AS invgr_CreatedDate, t.$8 AS invgr_CreatedUser, t.$9 AS invgr_ModifiedDate, t.$10 AS invgr_ModifiedUser, t.$11 AS invgr_TS, t.$12 AS InsertDate, t.$13 AS UpdateDate, t.$14 AS DeletedFlag, t.$15 AS SYS_CHANGE_VERSION, CASE WHEN t.$14 = True THEN ''D'' WHEN t.$12 = t.$13 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$14, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_InvoiceGroupingType.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_InvoiceGroupingType AS WITH curr_v AS (SELECT invgr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_InvoiceGroupingType GROUP BY invgr_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_InvoiceGroupingType t INNER JOIN curr_v v ON t.invgr_ID = v.invgr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';