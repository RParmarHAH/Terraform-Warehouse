resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CLINICALPATIENTSURGICAL" {
	name ="GET_CLINICALPATIENTSURGICAL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalPatientSurgical 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ClinicalPatientSurgical (SELECT t.$1 AS AgencyID, t.$2 AS PatientSurgicalID, t.$3 AS SurgicalID, t.$4 AS SurgicalCode, t.$5 AS Description, t.$6 AS status, t.$7 AS CreatedBy, t.$8 AS CreatedDate, t.$9 AS UpdatedBy, t.$10 AS UpdatedDate, t.$11 AS PatientID, t.$12 AS DateOfSurgery, t.$13 AS ICD, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalPatientSurgical.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

