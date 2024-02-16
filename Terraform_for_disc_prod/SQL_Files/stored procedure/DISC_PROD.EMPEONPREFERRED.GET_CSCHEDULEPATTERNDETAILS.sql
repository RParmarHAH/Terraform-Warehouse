CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_CSCHEDULEPATTERNDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_CSChedulePatternDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.CSChedulePatternDetails (SELECT t.$1 AS patternDetailId, t.$2 AS co, t.$3 AS cSchedulePatternId, t.$4 AS eSchedulePatternId, t.$5 AS dayOfWeek, t.$6 AS weekNumber, t.$7 AS systemHoliday, t.$8 AS companyHoliday, t.$9 AS start_date, t.$10 AS end_date, t.$11 AS duration, t.$12 AS marginBefore, t.$13 AS marginAfter, t.$14 AS cc1, t.$15 AS cc2, t.$16 AS cc3, t.$17 AS cc4, t.$18 AS cc5, t.$19 AS jobCode, t.$20 AS shift, t.$21 AS lastChange, t.$22 AS lastChangeUser, t.$23 AS graceAfter, t.$24 AS graceBefore, t.$25 AS lunch, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/EmpeonPreferred_dbo_CSChedulePatternDetails.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    
    return ''Success'';
END;
';