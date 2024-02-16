resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TIMESHEETDETAIL" {
	name ="GET_TIMESHEETDETAIL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_timesheetdetail 
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
    COPY INTO GENERATIONSALLIANCE.timesheetdetail FROM (SELECT t.$1 AS PayPeriodID, t.$2 AS SocialSecNum, t.$3 AS ClientID, t.$4 AS TimesheetId, t.$5 AS Date, t.$6 AS TotalHours, t.$7 AS StartTime, t.$8 AS EndTime, t.$9 AS Modifier, t.$10 AS IsThirdShift, t.$11 AS WageType, t.$12 AS ServiceCode, t.$13 AS CostPerUnit, t.$14 AS IsHoliday, t.$15 AS TransToQBooks, t.$16 AS itemName, t.$17 AS createdBy, t.$18 AS created, t.$19 AS updatedBy, t.$20 AS lastUpdated, t.$21 AS notes, t.$22 AS scheduleID, t.$23 AS billed, t.$24 AS billSource, t.$25 AS billDtm, t.$26 AS paid, t.$27 AS paySource, t.$28 AS payDtm, t.$29 AS scheduleChanged, t.$30 AS scheduleDeleted, t.$31 AS Invoice_Number, t.$32 AS Estimate_Number, t.$33 AS PayrollHours, t.$34 AS IsOverrideTotalHour, t.$35 AS IsOverridePayrollHour, t.$36 AS IsPayrollHoursDSTAdjusted, t.$37 AS IsTotalHoursDSTAdjusted, t.$38 AS TotalHourDSTAdjustReason, t.$39 AS PayrollHourDSTAdjustReason, t.$40 AS SYS_CHANGE_VERSION, t.$41 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$41,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_timesheetdetail.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.timesheetdetail AS WITH curr_v AS (SELECT PayPeriodID, SocialSecNum, ClientID, TimesheetId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.timesheetdetail GROUP BY PayPeriodID, SocialSecNum, ClientID, TimesheetId) SELECT t.* FROM GENERATIONSALLIANCE.timesheetdetail t INNER JOIN curr_v v ON t.PayPeriodID = v.PayPeriodID AND t.SocialSecNum = v.SocialSecNum AND t.ClientID = v.ClientID AND t.TimesheetId = v.TimesheetId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

