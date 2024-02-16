CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_PATIENTMEDPROFILE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_PatientMedProfile 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.PatientMedProfile (SELECT t.$1 AS AgencyID, t.$2 AS MedProfileID, t.$3 AS MedDescription, t.$4 AS PatientID, t.$5 AS Status, t.$6 AS PhysicianName, t.$7 AS Dose, t.$8 AS DoseOther, t.$9 AS Form, t.$10 AS FormOther, t.$11 AS Route, t.$12 AS RouteOther, t.$13 AS Amount, t.$14 AS Class, t.$15 AS FrequencyDescription, t.$16 AS StartDate, t.$17 AS OrderDate, t.$18 AS TaughtDate, t.$19 AS DiscontinueDate, t.$20 AS DiscontinueOrderDate, t.$21 AS PharmacyName, t.$22 AS Comments, t.$23 AS CreatedUserName, t.$24 AS CertificationStartDate, t.$25 AS CertificationEndDate, t.$26 AS OtherFrequencyText, t.$27 AS ModifiedDate, t.$28 AS IsDeleted, t.$29 AS MedicationID, t.$30 AS PhysicianID, t.$31 AS DOCID, t.$32 AS PayerID, t.$33 AS CertificationPeriodID, t.$34 AS DoseID, t.$35 AS FormID, t.$36 AS RouteID, t.$37 AS FrequencyID, t.$38 AS PreferredPharmacyID, t.$39 AS SYS_CHANGE_VERSION, t.$40 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$40,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_PatientMedProfile.*[.]csv.gz'')T);

    return ''Success'';
END;
';