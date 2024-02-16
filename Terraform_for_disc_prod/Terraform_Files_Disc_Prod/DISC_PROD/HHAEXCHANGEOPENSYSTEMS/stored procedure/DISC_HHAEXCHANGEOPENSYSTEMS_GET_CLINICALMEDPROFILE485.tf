resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CLINICALMEDPROFILE485" {
	name ="GET_CLINICALMEDPROFILE485"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalMedProfile485 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ClinicalMedProfile485 (SELECT t.$1 AS AgencyID, t.$2 AS MedProfile485ID, t.$3 AS PatientID, t.$4 AS MedProfileID, t.$5 AS Master485ID, t.$6 AS MedCode, t.$7 AS MedDescription, t.$8 AS PhysicianID, t.$9 AS Physician, t.$10 AS Dosage, t.$11 AS Route, t.$12 AS Class, t.$13 AS Frequency, t.$14 AS StartDate, t.$15 AS OrderDate, t.$16 AS TaughtDate, t.$17 AS DiscontinueDate, t.$18 AS DiscontinueOrderDate, t.$19 AS COMMENTS, t.$20 AS Status, t.$21 AS DoseForm, t.$22 AS MedicationID, t.$23 AS DoseScaleID, t.$24 AS DoseScale, t.$25 AS CreatedDate, t.$26 AS CreatedBy, t.$27 AS UpdatedDate, t.$28 AS UpdatedBy, t.$29 AS CertificationPeriodID, t.$30 AS CertificationStartDate, t.$31 AS CertificationEndDate, t.$32 AS CreatedUserName, t.$33 AS DOCID, t.$34 AS IsDeleted, t.$35 AS PatientName, t.$36 AS PatientNumber, t.$37 AS PStatus, t.$38 AS PhysicianAddress, t.$39 AS OtherFrequencyText, t.$40 AS IsDoseEdited, t.$41 AS ChhaID, t.$42 AS Address1, t.$43 AS Address2, t.$44 AS City, t.$45 AS State, t.$46 AS Zip, t.$47 AS PatientPhone, t.$48 AS DoseID, t.$49 AS DoseOther, t.$50 AS FormID, t.$51 AS FormOther, t.$52 AS RouteID, t.$53 AS RouteOther, t.$54 AS Amount, t.$55 AS PreferredPharmacyID, t.$56 AS Version, t.$57 AS SYS_CHANGE_VERSION, t.$58 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$58,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalMedProfile485.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

