resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_CSCHEDULEPATTERNDETAILS" {
	name ="GET_CSCHEDULEPATTERNDETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_CSChedulePatternDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.CSChedulePatternDetails (SELECT t.$1 AS patternDetailId, t.$2 AS co, t.$3 AS cSchedulePatternId, t.$4 AS eSchedulePatternId, t.$5 AS dayOfWeek, t.$6 AS weekNumber, t.$7 AS systemHoliday, t.$8 AS companyHoliday, t.$9 AS start_id, t.$10 AS end_id, t.$11 AS duration, t.$12 AS marginBefore, t.$13 AS marginAfter, t.$14 AS cc1, t.$15 AS cc2, t.$16 AS cc3, t.$17 AS cc4, t.$18 AS cc5, t.$19 AS jobCode, t.$20 AS shift, t.$21 AS lastChange, t.$22 AS lastChangeUser, t.$23 AS graceAfter, t.$24 AS graceBefore, t.$25 AS lunch, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_CSChedulePatternDetails.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

