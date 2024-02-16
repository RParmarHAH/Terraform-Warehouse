resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_AUTHORIZATIONBILLINGDIAGNOSIS" {
	name ="GET_AUTHORIZATIONBILLINGDIAGNOSIS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_AuthorizationBillingDiagnosis 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.AuthorizationBillingDiagnosis (SELECT t.$1 AS BillingDiagnosisID, t.$2 AS AgencyID, t.$3 AS DiagnosisID, t.$4 AS DiagnosisCode, t.$5 AS DiagnosisDescription, t.$6 AS ContractID, t.$7 AS AuthID, t.$8 AS PatientID, t.$9 AS OfficeID, t.$10 AS PrimaryDiagnosis, t.$11 AS AdmittingDiagnosis, t.$12 AS ICD, t.$13 AS DisplayOrder, t.$14 AS CreatedBy, t.$15 AS CreatedByUser, t.$16 AS CreatedDate, t.$17 AS CreatedUTCDate, t.$18 AS UpdatedBy, t.$19 AS UpdatedByUser, t.$20 AS UpdatedDate, t.$21 AS UpdatedUTCDate, t.$22 AS PayerID, t.$23 AS IsValid, t.$24 AS PayerBillingDiagnosisID, t.$25 AS AddedBy, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/HHAEXCHANGEOPENSYSTEMS_dbo_AuthorizationBillingDiagnosis.csv.gz (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}

