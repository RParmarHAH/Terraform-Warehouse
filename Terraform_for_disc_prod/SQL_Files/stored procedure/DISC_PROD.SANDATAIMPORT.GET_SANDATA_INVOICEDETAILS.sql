CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_INVOICEDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_InvoiceDetails 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_InvoiceDetails FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS InvoiceLineID, t.$4 AS InvoiceNumber, t.$5 AS ServiceID, t.$6 AS StatusID, t.$7 AS DateFrom, t.$8 AS DateThru, t.$9 AS Duration, t.$10 AS Description, t.$11 AS UnitTypeID, t.$12 AS RevCode, t.$13 AS HCPCS, t.$14 AS POS, t.$15 AS TOS, t.$16 AS Modifiers, t.$17 AS RefNO, t.$18 AS Rate, t.$19 AS BilledAmount, t.$20 AS PaidAmount, t.$21 AS NetAmount, t.$22 AS ReasonCodes, t.$23 AS CreatedAt, t.$24 AS UpdatedAt, t.$25 AS HashedRowValues, t.$26 AS BatchId, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_InvoiceDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_InvoiceDetails AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_InvoiceDetails GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_InvoiceDetails t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';