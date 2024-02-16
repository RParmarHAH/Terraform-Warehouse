CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CAREBRIDGELOG("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_CareBridgeLog 
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
    COPY INTO GENERATIONSALLIANCE.CareBridgeLog FROM (SELECT t.$1 AS LogID, t.$2 AS LogDate, t.$3 AS Status, t.$4 AS ScheduleId, t.$5 AS PayorId, t.$6 AS Type, t.$7 AS Errors, t.$8 AS Details, t.$9 AS LogFileName, t.$10 AS ExportedBy, t.$11 AS ExportedOn, t.$12 AS RequestData, t.$13 AS AppointmentStatus, t.$14 AS HasErrors, t.$15 AS BilledUnits, t.$16 AS BilledAmount, t.$17 AS Claim1Status, t.$18 AS Claim1InvoiceNumber, t.$19 AS Claim1PayerClaimNumber, t.$20 AS Claim1StatusDate, t.$21 AS Claim1DateLastChecked, t.$22 AS Claim1PayerStatusCode, t.$23 AS Claim1PayerStatusDescription, t.$24 AS Claim2Status, t.$25 AS Claim2InvoiceNumber, t.$26 AS Claim2PayerClaimNumber, t.$27 AS Claim2StatusDate, t.$28 AS Claim2DateLastChecked, t.$29 AS Claim2PayerStatusCode, t.$30 AS Claim2PayerStatusDescription, t.$31 AS TransactionID, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_CareBridgeLog.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.CareBridgeLog AS WITH curr_v AS (SELECT LogID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.CareBridgeLog GROUP BY LogID) SELECT t.* FROM GENERATIONSALLIANCE.CareBridgeLog t INNER JOIN curr_v v ON t.LogID = v.LogID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';