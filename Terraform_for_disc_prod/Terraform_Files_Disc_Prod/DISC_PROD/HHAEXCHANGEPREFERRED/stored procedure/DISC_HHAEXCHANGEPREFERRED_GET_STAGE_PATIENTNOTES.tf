resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_STAGE_PATIENTNOTES" {
	name ="GET_STAGE_PATIENTNOTES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_stage_PatientNotes 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.stage_PatientNotes (SELECT t.$1 AS AgencyID, t.$2 AS PatientNoteID, t.$3 AS PatientID, t.$4 AS Date, t.$5 AS Note, t.$6 AS CreatedDate, t.$7 AS CreatedBy, t.$8 AS CreatedByUserID, t.$9 AS ModifiedDate, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_stage_PatientNotes.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

