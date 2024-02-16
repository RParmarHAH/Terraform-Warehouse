CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_OFFICE_PAYROLLSETUP_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_Office_PayrollSetup_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.Office_PayrollSetup_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS PayrollSetupID, t.$3 AS PayrollSetupName, t.$4 AS PayPreferenceSkilled, t.$5 AS PayPreferenceNonSkilled, t.$6 AS Overtime, t.$7 AS OvertimeMins, t.$8 AS OverTimeRate, t.$9 AS MinDailyMinutes, t.$10 AS CalculateOTForPriorWeek, t.$11 AS PayrollWeekEndingDay, t.$12 AS MultiplePayrollPerCaregiverPerPayroll, t.$13 AS OfficeNames, t.$14 AS IsActive, t.$15 AS CutOffOTRate, t.$16 AS DisplayPatientonStub, t.$17 AS DailyCapped, t.$18 AS IsDailyHourlyPaid, t.$19 AS BlendedCutOffOTRate, t.$20 AS PrePayrollProcessAddDiscipline, t.$21 AS PrePayrollProcessUpdatePayCode, t.$22 AS PayrollCreationOnAnyWeekEndingDay, t.$23 AS PayTravelTimeToTheMinute, t.$24 AS CreatedBy, t.$25 AS CreatedDate, t.$26 AS CreatedUTCDate, t.$27 AS LastUpdatedBy, t.$28 AS LastUpdatedDate, t.$29 AS LastUpdatedUTCDate, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Office_PayrollSetup_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';