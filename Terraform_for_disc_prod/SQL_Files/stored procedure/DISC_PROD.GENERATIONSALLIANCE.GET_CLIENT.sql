CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CLIENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_client 
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
    COPY INTO GENERATIONSALLIANCE.client FROM (SELECT t.$1 AS ClientId, t.$2 AS FirstName, t.$3 AS LastName, t.$4 AS MiddleInit, t.$5 AS DateOfBirth, t.$6 AS Weight, t.$7 AS Address1, t.$8 AS Address2, t.$9 AS City, t.$10 AS County, t.$11 AS State, t.$12 AS Zip, t.$13 AS CaseManagerId, t.$14 AS Ambulatory, t.$15 AS PrimaryDiagnosis, t.$16 AS ReferredBy, t.$17 AS Status, t.$18 AS PayorId, t.$19 AS Priority, t.$20 AS Gender, t.$21 AS QuickbooksId, t.$22 AS ServiceStartDate, t.$23 AS ServiceEndDate, t.$24 AS ReferralNumber, t.$25 AS Physician, t.$26 AS DNR, t.$27 AS PhysicianPhone, t.$28 AS Phone, t.$29 AS MedicalRecord_NUMBER, t.$30 AS clientTypeID, t.$31 AS notes, t.$32 AS ssn, t.$33 AS createdBy, t.$34 AS created, t.$35 AS updatedBy, t.$36 AS lastUpdated, t.$37 AS diagnosisCode, t.$38 AS locationID, t.$39 AS enable1500, t.$40 AS telephonyID, t.$41 AS gstExempt, t.$42 AS DonotConfirm, t.$43 AS int_statusid, t.$44 AS str_reason, t.$45 AS RefNumber, t.$46 AS bit_Alert, t.$47 AS Email, t.$48 AS AccountingID, t.$49 AS InitialContactID, t.$50 AS countyid, t.$51 AS InquiryDate, t.$52 AS AssessmentDate, t.$53 AS ServiceRequestNo, t.$54 AS Phone2, t.$55 AS EnableEmailNotification, t.$56 AS GPSVerified, t.$57 AS Latitude, t.$58 AS Longitude, t.$59 AS SalesRepId, t.$60 AS ServiceOrderRequired, t.$61 AS EnableAssistedGPS, t.$62 AS EnableAppQA, t.$63 AS EnablePhoneQA, t.$64 AS enableUB04, t.$65 AS GeocodeUpdateStatus, t.$66 AS GeocodeLastUpdated, t.$67 AS GeocodeUpdatedBy, t.$68 AS IsClientSignRequired, t.$69 AS IsCGSignRequired, t.$70 AS ClientAccess, t.$71 AS InitialDischargeDate, t.$72 AS DesignatedCareNoteID, t.$73 AS WoundNoteCaregiverAccess, t.$74 AS CareNoteCaregiverAccess, t.$75 AS AlertNote, t.$76 AS ClientAccesAlert, t.$77 AS ScheduleAccessAlert, t.$78 AS PayorClientIdentifier, t.$79 AS ERVisitDate, t.$80 AS StartAddressType, t.$81 AS EndAddressType, t.$82 AS ContingencyPlanReviewDate, t.$83 AS ContingencyPlanID, t.$84 AS IsVaccinated, t.$85 AS VaccineCard, t.$86 AS VaccineType, t.$87 AS FirstVaccineDate, t.$88 AS SecondVaccineDate, t.$89 AS VaccineRefusedReason, t.$90 AS IsVaccinationRefused, t.$91 AS ThirdVaccineDate, t.$92 AS SYS_CHANGE_VERSION, t.$93 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$93,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_client.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.client AS WITH curr_v AS (SELECT ClientId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.client GROUP BY ClientId) SELECT t.* FROM GENERATIONSALLIANCE.client t INNER JOIN curr_v v ON t.ClientId = v.ClientId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';