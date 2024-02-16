CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_PATIENTMDORDER("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_PatientMDOrder 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PatientMDOrder (SELECT t.$1 AS AgencyID, t.$2 AS MDOrderID, t.$3 AS PatientID, t.$4 AS MDOrder_NUMBER, t.$5 AS CertStartDate, t.$6 AS CertEndDate, t.$7 AS Status, t.$8 AS CreatedBy, t.$9 AS CreatedDate, t.$10 AS UpdatedBy, t.$11 AS UpdatedDate, t.$12 AS CertificationPeriodID, t.$13 AS PrintedDate, t.$14 AS SignedDate, t.$15 AS IsDeleted, t.$16 AS PatientName, t.$17 AS AdmissionID, t.$18 AS SentDate, t.$19 AS HHASignedDate, t.$20 AS DMEAndSupplies, t.$21 AS SafetyMeasures, t.$22 AS NutritionRequirements, t.$23 AS FunctionalLimitations, t.$24 AS ActivitiesPermitted, t.$25 AS MentalStatus, t.$26 AS Prognosis, t.$27 AS SNOrders, t.$28 AS SNGoals, t.$29 AS POCTasks, t.$30 AS OrderOthers, t.$31 AS GoalOthers, t.$32 AS ScanFileName, t.$33 AS ScanFileGUID, t.$34 AS MDOrderVersion, t.$35 AS ClinicalDocID, t.$36 AS ICD, t.$37 AS DisplayMDOrderAideTabAs, t.$38 AS FaxLogStatus, t.$39 AS FaxLogStatusText, t.$40 AS SentDateManual, t.$41 AS FormClinicalDocID, t.$42 AS SYS_CHANGE_VERSION, t.$43 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$43,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_PatientMDOrder.*[.]csv.gz'') T);

    return ''Success'';
END;
';