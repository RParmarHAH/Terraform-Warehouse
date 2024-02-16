CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_INVOICEHEADER("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_InvoiceHeader 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_InvoiceHeader FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS InvoiceNumber, t.$4 AS PayorID, t.$5 AS AdmissionID, t.$6 AS PeriodID, t.$7 AS AuthorizationID, t.$8 AS StatusID, t.$9 AS StatusChangeDate, t.$10 AS InvoiceDate, t.$11 AS DateFrom, t.$12 AS DateTo, t.$13 AS ReferenceNumber, t.$14 AS OriginalAmount, t.$15 AS AdjustedAmount, t.$16 AS Balance, t.$17 AS Comment, t.$18 AS BillCode, t.$19 AS CSCode, t.$20 AS CreatedAt, t.$21 AS UpdatedAt, t.$22 AS HashedRowValues, t.$23 AS BatchId, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_InvoiceHeader.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_InvoiceHeader AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_InvoiceHeader GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_InvoiceHeader t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';