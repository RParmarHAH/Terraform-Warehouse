CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_SERVICEREQUEST("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_servicerequest 
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
    COPY INTO GENERATIONSALLIANCE.servicerequest FROM (SELECT t.$1 AS ClientId, t.$2 AS ServiceRequestId, t.$3 AS ServiceCode, t.$4 AS StartDate, t.$5 AS EndDate, t.$6 AS StartTime, t.$7 AS EndTime, t.$8 AS CostPerUnit, t.$9 AS Frequency, t.$10 AS Occurance, t.$11 AS Sunday, t.$12 AS Monday, t.$13 AS Tuesday, t.$14 AS Wednesday, t.$15 AS Thursday, t.$16 AS Friday, t.$17 AS Saturday, t.$18 AS Notes, t.$19 AS DayOfMonth, t.$20 AS FlexibleTime, t.$21 AS TotalHours, t.$22 AS Default, t.$23 AS totalApprovedUnits, t.$24 AS totalApprovedAmt, t.$25 AS unitsPerHour, t.$26 AS createdBy, t.$27 AS created, t.$28 AS updatedBy, t.$29 AS lastUpdated, t.$30 AS authNumber, t.$31 AS PayorId, t.$32 AS FlexibleDay, t.$33 AS totalApprovedVisits, t.$34 AS ManualOverrideBy, t.$35 AS ServiceStatus, t.$36 AS PatientNumber, t.$37 AS ManualOverrideDate, t.$38 AS DayofWeek, t.$39 AS IncludeModifierin837i, t.$40 AS ARProviderID, t.$41 AS CarebridgeProviderID, t.$42 AS SantraxProviderID, t.$43 AS ProviderAtypicalID, t.$44 AS SYS_CHANGE_VERSION, t.$45 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$45,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_servicerequest.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.servicerequest AS WITH curr_v AS (SELECT ClientId, ServiceRequestId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.servicerequest GROUP BY ClientId, ServiceRequestId) SELECT t.* FROM GENERATIONSALLIANCE.servicerequest t INNER JOIN curr_v v ON t.ClientId = v.ClientId AND t.ServiceRequestId = v.ServiceRequestId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';