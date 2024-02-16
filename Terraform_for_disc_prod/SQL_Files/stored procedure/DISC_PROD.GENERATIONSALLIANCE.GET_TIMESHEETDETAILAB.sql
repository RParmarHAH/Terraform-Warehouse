CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TIMESHEETDETAILAB("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_timesheetdetailab 
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
    COPY INTO GENERATIONSALLIANCE.timesheetdetailab FROM (SELECT t.$1 AS PayPeriodID, t.$2 AS SocialSecNum, t.$3 AS ClientID, t.$4 AS TimesheetId, t.$5 AS Date, t.$6 AS TotalHours, t.$7 AS StartTime, t.$8 AS EndTime, t.$9 AS Modifier, t.$10 AS IsThirdShift, t.$11 AS WageType, t.$12 AS ServiceCode, t.$13 AS CostPerUnit, t.$14 AS IsHoliday, t.$15 AS TransToQBooks, t.$16 AS itemName, t.$17 AS createdBy, t.$18 AS created, t.$19 AS updatedBy, t.$20 AS lastUpdated, t.$21 AS notes, t.$22 AS scheduleID, t.$23 AS billed, t.$24 AS billSource, t.$25 AS billDtm, t.$26 AS paid, t.$27 AS paySource, t.$28 AS payDtm, t.$29 AS scheduleChanged, t.$30 AS scheduleDeleted, t.$31 AS PayrollHours, t.$32 AS IsOverrideTotalHour, t.$33 AS IsOverridePayrollHour, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_timesheetdetailab.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.timesheetdetailab AS WITH curr_v AS (SELECT PayPeriodID, SocialSecNum, ClientID, TimesheetId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.timesheetdetailab GROUP BY PayPeriodID, SocialSecNum, ClientID, TimesheetId) SELECT t.* FROM GENERATIONSALLIANCE.timesheetdetailab t INNER JOIN curr_v v ON t.PayPeriodID = v.PayPeriodID AND t.SocialSecNum = v.SocialSecNum AND t.ClientID = v.ClientID AND t.TimesheetId = v.TimesheetId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';