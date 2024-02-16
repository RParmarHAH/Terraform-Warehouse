resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_EMPLOYEE" {
	name ="GET_EMPLOYEE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_employee 
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
    COPY INTO GENERATIONSALLIANCE.employee FROM (SELECT t.$1 AS SocialSecurityNum, t.$2 AS LastName, t.$3 AS FirstName, t.$4 AS MiddleInit, t.$5 AS Address1, t.$6 AS Address2, t.$7 AS City, t.$8 AS County, t.$9 AS State, t.$10 AS Zip, t.$11 AS ValidDriversLicense, t.$12 AS Smoker, t.$13 AS WeightRestriction, t.$14 AS WeightLimit, t.$15 AS ClassificationID, t.$16 AS DateofBirth, t.$17 AS Status, t.$18 AS StatusDate, t.$19 AS InactiveDate, t.$20 AS Email, t.$21 AS QuickBooksId, t.$22 AS CertExpirationDate, t.$23 AS Certification, t.$24 AS payOvertime, t.$25 AS CreateQbTSheets, t.$26 AS Phone1, t.$27 AS Phone2, t.$28 AS BackgroundCheck, t.$29 AS className, t.$30 AS notes, t.$31 AS createdBy, t.$32 AS created, t.$33 AS updatedBy, t.$34 AS lastUpdated, t.$35 AS independentContractor, t.$36 AS telephonyID, t.$37 AS doNotRehire, t.$38 AS int_statusid, t.$39 AS str_reason, t.$40 AS paychexID, t.$41 AS NPI, t.$42 AS str_Gender, t.$43 AS MessageID, t.$44 AS TextMessage, t.$45 AS countyid, t.$46 AS StateLicenseNo, t.$47 AS OnlineApplicationNo, t.$48 AS bit_OptoutMail, t.$49 AS bit_ExcemptFTE, t.$50 AS CaregiverProfile, t.$51 AS aca_startDate, t.$52 AS aca_statusId, t.$53 AS is_insured, t.$54 AS Latitude, t.$55 AS Longitude, t.$56 AS GeocodeUpdateStatus, t.$57 AS GeocodeLastUpdated, t.$58 AS GeocodeUpdatedBy, t.$59 AS ApplicationDate, t.$60 AS ReferredByID, t.$61 AS OtherReferredBy, t.$62 AS AlertNote, t.$63 AS CaregiverAccesAlert, t.$64 AS ScheduleAccessAlert, t.$65 AS IsVaccinated, t.$66 AS VaccineCard, t.$67 AS VaccineType, t.$68 AS FirstVaccineDate, t.$69 AS SecondVaccineDate, t.$70 AS VaccineRefusedReason, t.$71 AS IsVaccinationRefused, t.$72 AS CaregiverOtherID, t.$73 AS ThirdVaccineDate, t.$74 AS SYS_CHANGE_VERSION, t.$75 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$75,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_employee.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.employee AS WITH curr_v AS (SELECT SocialSecurityNum, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.employee GROUP BY SocialSecurityNum) SELECT t.* FROM GENERATIONSALLIANCE.employee t INNER JOIN curr_v v ON t.SocialSecurityNum = v.SocialSecurityNum AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

