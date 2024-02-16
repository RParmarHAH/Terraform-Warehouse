resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_CCALENDARDETAIL" {
	name ="GET_CCALENDARDETAIL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_CCalendarDetail 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.CCalendarDetail (SELECT t.$1 AS co, t.$2 AS calendarId, t.$3 AS batch, t.$4 AS description, t.$5 AS status, t.$6 AS lastEditedBy, t.$7 AS lastEditDate, t.$8 AS approvedBy, t.$9 AS approvedDate, t.$10 AS editedBy, t.$11 AS periodBegin, t.$12 AS periodEnd, t.$13 AS payGroup, t.$14 AS frequency, t.$15 AS emplType, t.$16 AS emplFilter, t.$17 AS autoPayEmployees, t.$18 AS autoPostRecurring, t.$19 AS defaultCheckAttributes, t.$20 AS guidfield, t.$21 AS lastChange, t.$22 AS lastChangeUser, t.$23 AS calendarScheduleDetailID, t.$24 AS sequence, t.$25 AS userVerifiedResults, t.$26 AS userViewedRegister, t.$27 AS dataChangedAfterRegisterViewed, t.$28 AS auditProcessed, t.$29 AS payEntryCompleted, t.$30 AS autoIncludeEmployees, t.$31 AS auditProcessing, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/EmpeonEdison_dbo_CCalendarDetail.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT)T);
    
    return ''Success'';
END;

 EOT
}

