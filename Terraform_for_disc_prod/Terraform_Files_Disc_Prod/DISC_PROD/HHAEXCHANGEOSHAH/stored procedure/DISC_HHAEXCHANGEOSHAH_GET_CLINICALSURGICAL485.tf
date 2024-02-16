resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_CLINICALSURGICAL485" {
	name ="GET_CLINICALSURGICAL485"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ClinicalSurgical485 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ClinicalSurgical485 (SELECT t.$1 AS AgencyID, t.$2 AS Surgical485ID, t.$3 AS SurgicalID, t.$4 AS Master485ID, t.$5 AS PatientID, t.$6 AS SurgicalCode, t.$7 AS Description, t.$8 AS IsPrimarySurgical, t.$9 AS OnSetDate, t.$10 AS status, t.$11 AS CreatedBy, t.$12 AS CreatedDate, t.$13 AS UpdatedBy, t.$14 AS UpdatedDate, t.$15 AS DateOfSurgery, t.$16 AS ICD, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalSurgical485.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

