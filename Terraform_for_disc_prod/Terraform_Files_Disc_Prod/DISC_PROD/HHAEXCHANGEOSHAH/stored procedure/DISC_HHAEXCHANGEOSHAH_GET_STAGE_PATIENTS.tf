resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_STAGE_PATIENTS" {
	name ="GET_STAGE_PATIENTS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_stage_Patients 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.stage_Patients (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS PayerID, t.$4 AS PatientID, t.$5 AS FirstName, t.$6 AS MiddleName, t.$7 AS LastName, t.$8 AS StatusID, t.$9 AS AdmissionID, t.$10 AS MRNumber, t.$11 AS Gender, t.$12 AS DateOfBirth, t.$13 AS PriorityCode, t.$14 AS AcceptedServices, t.$15 AS MedicaidNumber, t.$16 AS MedicareNumber, t.$17 AS SSN, t.$18 AS Address1, t.$19 AS Address2, t.$20 AS City, t.$21 AS State, t.$22 AS Zip5, t.$23 AS Zip4, t.$24 AS CrossStreet, t.$25 AS Direction, t.$26 AS HomePhone, t.$27 AS Phone2, t.$28 AS Phone2Description, t.$29 AS Phone3, t.$30 AS Phone3Description, t.$31 AS WageParity, t.$32 AS WageParityFromDate1, t.$33 AS WageParityToDate1, t.$34 AS WageParityFromDate2, t.$35 AS WageParityToDate2, t.$36 AS IsAlternateBilling, t.$37 AS AlternateBillingFirstName, t.$38 AS AlternateBillingLastName, t.$39 AS AlternateBillingMiddleName, t.$40 AS AlternateBillingStreet, t.$41 AS AlternateBillingCity, t.$42 AS AlternateBillingState, t.$43 AS AlternateBillingZipCode, t.$44 AS EmergencyContact1Name, t.$45 AS EmergencyContact1RelationshipID, t.$46 AS EmergencyContact1RelationshipName, t.$47 AS EmergencyContact1RelationshipOther, t.$48 AS EmergencyContact1LivesWithParent, t.$49 AS EmergencyContact1HaveKeys, t.$50 AS EmergencyContact1Phone1, t.$51 AS EmergencyContact1Phone2, t.$52 AS EmergencyContact1Address, t.$53 AS EmergencyContact2Name, t.$54 AS EmergencyContact2RelationshipID, t.$55 AS EmergencyContact2RelationshipName, t.$56 AS EmergencyContact2RelationshipOther, t.$57 AS EmergencyContact2LivesWithParent, t.$58 AS EmergencyContact2HaveKeys, t.$59 AS EmergencyContact2Phone1, t.$60 AS EmergencyContact2Phone2, t.$61 AS EmergencyContact2Address, t.$62 AS MobilityStatusID, t.$63 AS EvacuationZoneID, t.$64 AS EvacuationLocationID, t.$65 AS OtherEvacuationLocation, t.$66 AS ElectricEquipmentDependency, t.$67 AS EmergencyPreparednessDescription, t.$68 AS NurseID, t.$69 AS Coordinators, t.$70 AS Frequency, t.$71 AS Cluster, t.$72 AS IsMutualLinked, t.$73 AS MutualLinkPatientID, t.$74 AS IsPrimaryPatient, t.$75 AS ServiceStartDate, t.$76 AS ProjectedDCDate, t.$77 AS SourceOfAdmissionID, t.$78 AS LocationID, t.$79 AS TeamID, t.$80 AS BranchID, t.$81 AS Alert, t.$82 AS ReferralMasterID, t.$83 AS ReferralReceivedDate, t.$84 AS ReferralSourceId, t.$85 AS ReferralStatus, t.$86 AS ReferralLostReasonId, t.$87 AS ReferralLostReasonNote, t.$88 AS CommissionStatus, t.$89 AS ReferralContactId, t.$90 AS ReferralIntakePersonId, t.$91 AS AccountManagerId, t.$92 AS RequestSpecialAgencyID, t.$93 AS RequestGender, t.$94 AS RequestPrimaryLanguage, t.$95 AS RequestSecondaryLanguage, t.$96 AS RequestOther, t.$97 AS EVVRequired, t.$98 AS ModifiedDate, t.$99 AS BranchName, t.$100 AS PayerCoordinators, t.$101 AS ProfileHeaderAlert, t.$102 AS HomePhoneLocationAddress, t.$103 AS HomePhone2LocationAddress, t.$104 AS HomePhone3LocationAddress, t.$105 AS OfficeAdmissionID, t.$106 AS UsePaperSheet, t.$107 AS ValidatePaperDutySheet, t.$108 AS LinkedPatient, t.$109 AS PayerPriorityCode, t.$110 AS ProviderPriorityCode, t.$111 AS Race, t.$112 AS Ethnicity, t.$113 AS DischargeDate, t.$114 AS Language3, t.$115 AS Language4, t.$116 AS PatientsNurse, t.$117 AS SYS_CHANGE_VERSION, t.$118 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$118,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_stage_Patients.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

