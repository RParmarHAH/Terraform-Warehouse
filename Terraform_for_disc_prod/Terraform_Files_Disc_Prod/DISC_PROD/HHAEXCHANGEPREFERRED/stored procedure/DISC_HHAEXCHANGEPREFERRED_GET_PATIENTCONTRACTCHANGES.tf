resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_PATIENTCONTRACTCHANGES" {
	name ="GET_PATIENTCONTRACTCHANGES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_PatientContractChanges 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.PatientContractChanges (SELECT t.$1 AS AgencyID, t.$2 AS ContractChangeID, t.$3 AS OfficeID, t.$4 AS PatientID, t.$5 AS PlacementID, t.$6 AS ContractID, t.$7 AS IsPrimaryContract, t.$8 AS AltPatientID, t.$9 AS StartDate, t.$10 AS SourceOfAdmissionID, t.$11 AS ServiceCodeID, t.$12 AS DischargeDate, t.$13 AS DischargeTo, t.$14 AS ActionDateUTC, t.$15 AS CreatedBy, t.$16 AS CreatedDate, t.$17 AS UpdatedBy, t.$18 AS UpdatedDate, t.$19 AS HospitalizedDate, t.$20 AS HoldDate, t.$21 AS DischargeReasonID, t.$22 AS DischargeReasonText, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_PatientContractChanges.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

