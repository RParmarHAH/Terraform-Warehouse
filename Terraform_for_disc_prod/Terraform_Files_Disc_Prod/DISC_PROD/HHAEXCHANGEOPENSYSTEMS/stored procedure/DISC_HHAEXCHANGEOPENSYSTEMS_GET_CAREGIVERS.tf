resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CAREGIVERS" {
	name ="GET_CAREGIVERS"
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
-- NAME:  GET_CAREGIVERS 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE            	AUTHOR                  	NOTES:
-- ----------      	-------------------     	-----------------------------------------------------------------------------------------------
-- 2023-11-20     	JIGAR PRAJAPATI          	INITIAL DEVELOPMENT
--*****************************************************************************************************************************

    BEGIN
--------------HHAEXCHANGEOPENSYSTEMS---------------
INSERT INTO  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Hist_Caregivers (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverID, t.$3 AS FirstName, t.$4 AS MiddleName, t.$5 AS LastName, t.$6 AS Initials, t.$7 AS Gender, t.$8 AS DateofBirth, t.$9 AS CaregiverCode, t.$10 AS TimeAndAttendancePIN, t.$11 AS AlternateCaregiverCode, t.$12 AS SSN, t.$13 AS Ethnicity, t.$14 AS RehireDate, t.$15 AS CountryofBirth, t.$16 AS MaritalStatus, t.$17 AS Dependents, t.$18 AS EmployeeType, t.$19 AS Status, t.$20 AS InactiveReasonID, t.$21 AS InactiveNote, t.$22 AS TerminatedDate, t.$23 AS Sent105, t.$24 AS EmploymentType, t.$25 AS EmployeeID, t.$26 AS ApplicationDate, t.$27 AS TeamID, t.$28 AS LocationID, t.$29 AS BranchID, t.$30 AS Payer, t.$31 AS Registrynumber, t.$32 AS RegistryDate, t.$33 AS ReferralSourceID, t.$34 AS ReferralPerson, t.$35 AS NYCRegistryCheckedOn, t.$36 AS NYCRegistryCheckedDate, t.$37 AS ExclusionListCheckedOn, t.$38 AS ExclusionListStatus, t.$39 AS Street1, t.$40 AS Street2, t.$41 AS City, t.$42 AS State, t.$43 AS Zip5, t.$44 AS Zip4, t.$45 AS HomePhone, t.$46 AS Phone2, t.$47 AS Phone3, t.$48 AS Emergency1Name, t.$49 AS Emergency1Address, t.$50 AS Emergency1RelationshipID1, t.$51 AS Emergency1RelationshipName1, t.$52 AS Emergency1RelationshipOther1, t.$53 AS Emergency1Phone1, t.$54 AS Emergency1Phone2, t.$55 AS Emergency2Name, t.$56 AS Emergency2Address, t.$57 AS Emergency2RelationshipID2, t.$58 AS Emergency2RelationshipName1, t.$59 AS Emergency1RelationshipOther2, t.$60 AS Emergency2Phone1, t.$61 AS Emergency2Phone2, t.$62 AS NotificationMethod, t.$63 AS NotificationEmail, t.$64 AS NotificationTextNumber, t.$65 AS NotificationVoiceMail, t.$66 AS HireDate, t.$67 AS I9DocumentID, t.$68 AS I9Document2, t.$69 AS I9ExpirationDate, t.$70 AS I9Verified, t.$71 AS I9Comments, t.$72 AS Reference1, t.$73 AS Reference2, t.$74 AS Degree, t.$75 AS CriminalBackgroundDate1, t.$76 AS CriminalBackgroundResult1, t.$77 AS CriminalBackgroundReceivedDate1, t.$78 AS CriminalBackgroundDate2, t.$79 AS CriminalBackgroundResult2, t.$80 AS CriminalBackgroundReceivedDate2, t.$81 AS CriminalBackgroundDate3, t.$82 AS CriminalBackgroundResult3, t.$83 AS CriminalBackgroundReceivedDate3, t.$84 AS LastEmploymentAgency, t.$85 AS LastEmploymentStartDate, t.$86 AS LastEmploymentEndDate, t.$87 AS ProfessionalLicensenumber, t.$88 AS Licensedateverified, t.$89 AS ProfessionalRegistrationExpirationDate, t.$90 AS AutomobileInsuranceExpirationDate, t.$91 AS NoCar, t.$92 AS MalpracticeInsuranceExpirationDate, t.$93 AS CPRVerifiedon, t.$94 AS PICCCertificationDateVerified, t.$95 AS NPINumber, t.$96 AS Language1, t.$97 AS Language2, t.$98 AS Language3, t.$99 AS Language4, t.$100 AS Other, t.$101 AS CoCode, t.$102 AS FedExemption, t.$103 AS RateType, t.$104 AS PensionProfitSharing, t.$105 AS ExemptionFromOvertime, t.$106 AS DirectDeposit, t.$107 AS NycResident, t.$108 AS Employee1099, t.$109 AS UnionReduction, t.$110 AS MedicalDeductionCode, t.$111 AS PayCycle, t.$112 AS OfficeID, t.$113 AS ModifiedDate, t.$114 AS UniqueMobileID, t.$115 AS UniqueMobileType, t.$116 AS BranchName, t.$117 AS FirstDayWorked, t.$118 AS LastDayWorked,t.$119 AS ReferralSource , t.$120 AS SYS_CHANGE_VERSION, t.$121 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$121,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_Caregivers.*[.]csv.gz'') T);

CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Caregivers 
 AS WITH curr_v AS 
 (SELECT AgencyID, CaregiverID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE 
 FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Hist_Caregivers GROUP BY AgencyID, CaregiverID) 
 SELECT P.* exclude ETL_DELETED_FLAG,
 CASE WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE ELSE P.ETL_DELETED_FLAG END AS ETL_DELETED_FLAG 
 FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Hist_Caregivers P 
 INNER JOIN curr_v v ON P.AgencyID = v.AgencyID AND P.CaregiverID = v.CaregiverID
 AND P.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

 ----REPLACE HIST TABLE WITH CURRENT TABLE 
create OR REPLACE table DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Hist_Caregivers CLONE DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.Caregivers;
------------------------------------------------------------------------------------------------------
 END;

 EOT
}

