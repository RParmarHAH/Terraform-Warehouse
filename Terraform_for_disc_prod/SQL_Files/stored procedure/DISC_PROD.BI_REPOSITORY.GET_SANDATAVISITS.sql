CREATE OR REPLACE PROCEDURE DISC_PROD.BI_REPOSITORY.GET_SANDATAVISITS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.BI_Repository.GET_SanDataVisits 
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
    COPY INTO BI_Repository.HIST_SanDataVisits FROM (SELECT t.$1 AS id, t.$2 AS AgencyID, t.$3 AS ScheduleID, t.$4 AS ScheduleDate, t.$5 AS Status, t.$6 AS ServiceID, t.$7 AS EVVTimeIn, t.$8 AS EVVTimeOut, t.$9 AS EVVDuration, t.$10 AS ScheduledTimeIn, t.$11 AS ScheduledTimeOut, t.$12 AS ScheduledDuration, t.$13 AS PayorName, t.$14 AS LocationID, t.$15 AS AdmissionType, t.$16 AS ClientId, t.$17 AS ChartID, t.$18 AS MRN, t.$19 AS ClientLastName, t.$20 AS ClientFirstName, t.$21 AS ClientMiddleInitial, t.$22 AS StaffAgencyID, t.$23 AS StaffLastName, t.$24 AS StaffFirstName, t.$25 AS StaffMiddleInitial, t.$26 AS AddedDateTime, t.$27 AS AddedFileName, t.$28 AS LastUpdatedDateTime, t.$29 AS LastUpdatedFileName, t.$30 AS PlanID, t.$31 AS VerificationType, t.$32 AS AdmissionID, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_SanDataVisits.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE BI_Repository.SanDataVisits AS WITH curr_v AS (SELECT id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM BI_Repository.HIST_SanDataVisits GROUP BY id) SELECT t.* FROM BI_Repository.HIST_SanDataVisits t INNER JOIN curr_v v ON t.id = v.id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';