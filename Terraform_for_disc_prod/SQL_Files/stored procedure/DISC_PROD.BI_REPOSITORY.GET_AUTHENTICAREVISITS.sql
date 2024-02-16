CREATE OR REPLACE PROCEDURE DISC_PROD.BI_REPOSITORY.GET_AUTHENTICAREVISITS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.BI_Repository.GET_AuthenticareVisits 
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
    COPY INTO BI_Repository.HIST_AuthenticareVisits FROM (SELECT t.$1 AS Id, t.$2 AS ClaimID, t.$3 AS ProviderID, t.$4 AS ProviderName, t.$5 AS WorkerID, t.$6 AS WorkerName, t.$7 AS ExternalWorkerID, t.$8 AS ClientID, t.$9 AS ClientBillingMedicaidID, t.$10 AS ClientName, t.$11 AS TeamAssignment, t.$12 AS CaseManagerID, t.$13 AS CaseManagerName, t.$14 AS Service, t.$15 AS DateOfService, t.$16 AS CheckIn, t.$17 AS CheckOut, t.$18 AS ActualUnits, t.$19 AS AuthorizedUnits, t.$20 AS BilledAmount, t.$21 AS PaidAmount, t.$22 AS LastBillingDate, t.$23 AS LastPaymentDate, t.$24 AS ClaimStatus, t.$25 AS ActivityCodes, t.$26 AS Mileage, t.$27 AS TravelTime, t.$28 AS Exceptions, t.$29 AS CreateDate, t.$30 AS LastUpdateDate, t.$31 AS Authorization, t.$32 AS PayerName, t.$33 AS ExternalClientID, t.$34 AS DeviceID, t.$35 AS Source, t.$36 AS ClaimNoteReason, t.$37 AS AAANumber, t.$38 AS AddedDateTime, t.$39 AS AddedFileName, t.$40 AS LastUpdatedDateTime, t.$41 AS LastUpdatedFileName, t.$42 AS SYS_CHANGE_VERSION, t.$43 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$43,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_AuthenticareVisits.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE BI_Repository.AuthenticareVisits AS WITH curr_v AS (SELECT Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM BI_Repository.HIST_AuthenticareVisits GROUP BY Id) SELECT t.* FROM BI_Repository.HIST_AuthenticareVisits t INNER JOIN curr_v v ON t.Id = v.Id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';