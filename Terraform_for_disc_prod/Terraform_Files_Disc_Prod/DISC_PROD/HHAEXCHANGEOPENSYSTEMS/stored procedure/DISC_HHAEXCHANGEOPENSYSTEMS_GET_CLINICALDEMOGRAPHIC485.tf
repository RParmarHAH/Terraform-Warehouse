resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CLINICALDEMOGRAPHIC485" {
	name ="GET_CLINICALDEMOGRAPHIC485"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalDemographic485 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ClinicalDemographic485 (SELECT t.$1 AS AgencyID, t.$2 AS DemographicID, t.$3 AS Master485ID, t.$4 AS PatientID, t.$5 AS VendorID, t.$6 AS PatientHIClaimNo, t.$7 AS StartOfCare, t.$8 AS MedicalRecord, t.$9 AS ProviderID, t.$10 AS PatientFirstName, t.$11 AS PatientLastName, t.$12 AS SSN, t.$13 AS Address1, t.$14 AS Address2, t.$15 AS City, t.$16 AS State, t.$17 AS Zip, t.$18 AS ProviderName, t.$19 AS ProviderAddress, t.$20 AS ProviderTelephone, t.$21 AS PatientDOB, t.$22 AS PatientSex, t.$23 AS Allergies, t.$24 AS NurseName, t.$25 AS VerbalSOCDate, t.$26 AS PhysicianID, t.$27 AS PhysicianName, t.$28 AS PhysicianAddress, t.$29 AS CreatedBy, t.$30 AS CreatedDate, t.$31 AS UpdatedBy, t.$32 AS UpdatedDate, t.$33 AS NurseID, t.$34 AS PhysicianNPI, t.$35 AS PhysicianPhone, t.$36 AS PhysicianFax, t.$37 AS PatientPhone, t.$38 AS ProviderFax, t.$39 AS PhysicianAddressID, t.$40 AS PhysicianAddressPhone2, t.$41 AS PhysicianAddressPhone3, t.$42 AS SYS_CHANGE_VERSION, t.$43 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$43,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalDemographic485.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

