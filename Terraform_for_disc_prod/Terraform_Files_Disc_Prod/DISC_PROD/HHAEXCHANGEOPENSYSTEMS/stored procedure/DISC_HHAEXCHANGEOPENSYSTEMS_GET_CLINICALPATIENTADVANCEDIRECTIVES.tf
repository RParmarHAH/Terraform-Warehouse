resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CLINICALPATIENTADVANCEDIRECTIVES" {
	name ="GET_CLINICALPATIENTADVANCEDIRECTIVES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalPatientAdvanceDirectives 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ClinicalPatientAdvanceDirectives (SELECT t.$1 AS AgencyID, t.$2 AS PatientAdvanceDirectivesID, t.$3 AS PatientID, t.$4 AS AdvanceDirectiveID, t.$5 AS onFile, t.$6 AS PhysycianId, t.$7 AS PhysicianName, t.$8 AS DateRecieve, t.$9 AS EffectiveDate, t.$10 AS AttachmentExists, t.$11 AS Createdby, t.$12 AS CreatedDate, t.$13 AS UpdatedBy, t.$14 AS updatedDate, t.$15 AS AdvanceDirectiveText, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalPatientAdvanceDirectives.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

