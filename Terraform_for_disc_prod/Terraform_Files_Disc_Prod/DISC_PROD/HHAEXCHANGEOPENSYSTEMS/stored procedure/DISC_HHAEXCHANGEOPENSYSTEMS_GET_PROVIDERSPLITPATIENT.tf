resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_PROVIDERSPLITPATIENT" {
	name ="GET_PROVIDERSPLITPATIENT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ProviderSplitPatient 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ProviderSplitPatient (SELECT t.$1 AS ProviderSplitPatientID, t.$2 AS ProviderSplitBasePatientID, t.$3 AS PatientID, t.$4 AS Action, t.$5 AS Status, t.$6 AS AgencyID, t.$7 AS OfficeID, t.$8 AS CreatedBy, t.$9 AS CreatedByUser, t.$10 AS CreatedDate, t.$11 AS CreatedUTCDate, t.$12 AS UpdatedBy, t.$13 AS UpdatedByUser, t.$14 AS UpdatedDate, t.$15 AS UpdatedUTCDate, t.$16 AS ErrorMessage, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ProviderSplitPatient.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

