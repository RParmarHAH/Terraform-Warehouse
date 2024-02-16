resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_TBLPOCDETAIL_REPL" {
	name ="GET_TBLPOCDETAIL_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_tblPOCDetail_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.tblPOCDetail_REPL (SELECT t.$1 AS AgencyID, t.$2 AS POCDetailID, t.$3 AS POCHeaderID, t.$4 AS POCTaskID, t.$5 AS TimesPerWeekMin, t.$6 AS TimesPerWeekMax, t.$7 AS Monday, t.$8 AS Sunday, t.$9 AS Tuesday, t.$10 AS Wednesday, t.$11 AS Thursday, t.$12 AS Friday, t.$13 AS Saturday, t.$14 AS AsNeeded, t.$15 AS TaskInstruction, t.$16 AS TimesPerWeekMinMax, t.$17 AS DaysOfWeek, t.$18 AS OfficeID, t.$19 AS POCPatientID, t.$20 AS PatientPOCMinutes, t.$21 AS LongTermRequired, t.$22 AS Createdby, t.$23 AS CreatedDate, t.$24 AS LastModifiedDate, t.$25 AS LastModifiedBy, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_tblPOCDetail_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

