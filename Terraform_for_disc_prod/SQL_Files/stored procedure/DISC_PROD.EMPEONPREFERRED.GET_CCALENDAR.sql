CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_CCALENDAR("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_CCalendar 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.CCalendar (SELECT t.$1 AS co, t.$2 AS checkDate, t.$3 AS processGroup, t.$4 AS periodBegin, t.$5 AS periodEnd, t.$6 AS calendarId, t.$7 AS status, t.$8 AS periodBegunUserId, t.$9 AS scheduledProcessDate, t.$10 AS actualProcessDate, t.$11 AS processUserId, t.$12 AS process, t.$13 AS payrollNotes, t.$14 AS startPayrollJobId, t.$15 AS processPayrollJobId, t.$16 AS lastChange, t.$17 AS onhold, t.$18 AS processed, t.$19 AS packedUserId, t.$20 AS packedTime, t.$21 AS inTransitTime, t.$22 AS deliveredTime, t.$23 AS deliveryTracking, t.$24 AS deliveredBy, t.$25 AS lastChangeUser, t.$26 AS timeclockImportJobId, t.$27 AS submitPayrollJobId, t.$28 AS blockBilling, t.$29 AS blockAgency, t.$30 AS blockTransfers, t.$31 AS blockACH, t.$32 AS blockTaxDeposits, t.$33 AS blockAccruals, t.$34 AS deletePriorDep, t.$35 AS calendarScheduleID, t.$36 AS sequence, t.$37 AS blockReports, t.$38 AS blockChecks, t.$39 AS processFinishTime, t.$40 AS calculatingStatus, t.$41 AS timeActualProcessDate, t.$42 AS timeApprovedBy, t.$43 AS timeExclude, t.$44 AS timeProcessedBy, t.$45 AS timeStatus, t.$46 AS timeCalcStart, t.$47 AS calculatingJobId, t.$48 AS isConversion, t.$49 AS isAdjustment, t.$50 AS timeOnly, t.$51 AS shippingSettings, t.$52 AS blockArrearBatch, t.$53 AS SYS_CHANGE_VERSION, t.$54 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$54,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/EmpeonPreferred_dbo_CCalendar.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

   
    return ''Success'';
END;
';