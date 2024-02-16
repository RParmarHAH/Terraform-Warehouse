CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_REFERRAL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_Referral 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.Referral (SELECT t.$1 AS AgencyID, t.$2 AS ReferralID, t.$3 AS FirstName, t.$4 AS MiddleName, t.$5 AS LastName, t.$6 AS DateOfBirth, t.$7 AS Gender, t.$8 AS Coordinator_1, t.$9 AS Coordinator_2, t.$10 AS Coordinator_3, t.$11 AS PriorityCode, t.$12 AS SourceOfAdmission, t.$13 AS AcceptedServices, t.$14 AS SSN, t.$15 AS LinkWith, t.$16 AS PatientID, t.$17 AS MedicaidNumber, t.$18 AS MedicareNumber, t.$19 AS Location, t.$20 AS Team, t.$21 AS Branch, t.$22 AS Language1, t.$23 AS Language2, t.$24 AS AllowDuplicate, t.$25 AS ServiceRequestStartDate, t.$26 AS MaritalStatus, t.$27 AS PatientAwareOfReferral, t.$28 AS Alerts, t.$29 AS Address1, t.$30 AS Address2, t.$31 AS Zip, t.$32 AS City, t.$33 AS State, t.$34 AS CrossStreet, t.$35 AS HomePhone, t.$36 AS Phone2, t.$37 AS Phone2Description, t.$38 AS Phone3, t.$39 AS Phone3Description, t.$40 AS Direction, t.$41 AS AlternateBillingAddress, t.$42 AS BillingFirstName, t.$43 AS BillingMiddleName, t.$44 AS BillingLastName, t.$45 AS BillingStreet, t.$46 AS BillingZip, t.$47 AS BillingCity, t.$48 AS BillingState, t.$49 AS EmergencyContactName, t.$50 AS EmergencyContactRelationship, t.$51 AS EmergencyContactLivesWithPatient, t.$52 AS EmergencyContactHaveKeys, t.$53 AS EmergencyContactPhone1, t.$54 AS EmergencyContactPhone2, t.$55 AS EmergencyContactAddress, t.$56 AS EmergencyContact2Name, t.$57 AS EmergencyContact2Relationship, t.$58 AS EmergencyContact2Lives, t.$59 AS EmergencyContact2HaveKeys, t.$60 AS EmergencyContact2Phone1, t.$61 AS EmergencyContact2Phone2, t.$62 AS EmergencyContact2Address, t.$63 AS PriorityCodeID, t.$64 AS EvacuationZoneID, t.$65 AS MobilityStatusID, t.$66 AS EvacuationLocationID, t.$67 AS OtherEvacuationLocation, t.$68 AS EmergencyDescription, t.$69 AS ElectricEquipDependency, t.$70 AS ReceivedDate, t.$71 AS ReferralStatus, t.$72 AS CommissionStatus, t.$73 AS AdmissionID, t.$74 AS CallerName, t.$75 AS CallDate, t.$76 AS CallerPhone, t.$77 AS CallerNote, t.$78 AS ReferralSource, t.$79 AS ReferralContact, t.$80 AS IntakePersonName, t.$81 AS AccountManager, t.$82 AS ClinicalComments, t.$83 AS Allergies, t.$84 AS PatientHIClaimNo, t.$85 AS OfficeID, t.$86 AS SYS_CHANGE_VERSION, t.$87 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$87,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/HHAEXCHANGEPREFERRED_dbo_Referral.csv.gz (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';