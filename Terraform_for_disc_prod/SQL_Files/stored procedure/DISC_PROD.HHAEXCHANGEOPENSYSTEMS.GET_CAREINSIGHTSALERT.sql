CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREINSIGHTSALERT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CareInsightsAlert 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CareInsightsAlert (SELECT t.$1 AS AgencyID, t.$2 AS VBCAlertFeedbackDetailID, t.$3 AS Priority, t.$4 AS Received, t.$5 AS Patient, t.$6 AS Coordinator, t.$7 AS Caregiver, t.$8 AS Nurse, t.$9 AS Assignee, t.$10 AS AlertStatus, t.$11 AS AlertDescription, t.$12 AS PatientID, t.$13 AS CaregiverID, t.$14 AS Type, t.$15 AS VisitID, t.$16 AS OfficeID, t.$17 AS NurseID, t.$18 AS Linked_with_Visit, t.$19 AS CreatedByUser, t.$20 AS CreatedBy, t.$21 AS UpdatedDate, t.$22 AS UpdatedByUser, t.$23 AS UpdatedBy, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/HHAEXCHANGEOPENSYSTEMS_dbo_CareInsightsAlert.csv.gz (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;
';