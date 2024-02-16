CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CLINICALMEDICATIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ClinicalMedications 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ClinicalMedications (SELECT t.$1 AS AgencyID, t.$2 AS ClinicalDocumentMedicationID, t.$3 AS PatientID, t.$4 AS MedProfileID, t.$5 AS ClinicalDocID, t.$6 AS Status, t.$7 AS PStatus, t.$8 AS MedicationID, t.$9 AS MedDescription, t.$10 AS PhysicianID, t.$11 AS DoseID, t.$12 AS DoseOther, t.$13 AS FormID, t.$14 AS FormOther, t.$15 AS RouteID, t.$16 AS RouteOther, t.$17 AS Amount, t.$18 AS Class, t.$19 AS FrequencyID, t.$20 AS OtherFrequencyText, t.$21 AS StartDate, t.$22 AS OrderDate, t.$23 AS TaughtDate, t.$24 AS DiscontinueDate, t.$25 AS DiscontinueOrderDate, t.$26 AS PreferredPharmacyID, t.$27 AS COMMENTS, t.$28 AS OrderType, t.$29 AS CertificationPeriodID, t.$30 AS IncludeInMedProfile, t.$31 AS IsDeleted, t.$32 AS CreatedDate, t.$33 AS CreatedBy, t.$34 AS UpdatedDate, t.$35 AS UpdatedBy, t.$36 AS CreatedUTCDate, t.$37 AS UpdatedUTCDate, t.$38 AS Dose, t.$39 AS Form, t.$40 AS Route, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalMedications.*[.]csv.gz'') T);

    return ''Success'';
END;
';