CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREGIVERMAXVISITS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverMaxVisits 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CaregiverMaxVisits (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverInfoID, t.$3 AS CaregiverID, t.$4 AS SaturdayMaxVisit, t.$5 AS SundayMaxVisit, t.$6 AS MondayMaxVisit, t.$7 AS TuesdayMaxVisit, t.$8 AS WednesdayMaxVisit, t.$9 AS ThursdayMaxVisit, t.$10 AS FridayMaxVisit, t.$11 AS EditCaregiverAvailabilityViaMobile, t.$12 AS AideEditCaregiverAvailabilityViaMobile, t.$13 AS CaregiverOpenCasesView, t.$14 AS CaregiverOpenCasesRequestAccept, t.$15 AS CaregiverOpenCaseRequestLimit, t.$16 AS CaregiverOpenCaseRequestLimitValue, t.$17 AS OverrideVisitTimeCorrection, t.$18 AS AllowCaregiverVisitTimeCorrection, t.$19 AS AllowCaregiverVisitTimeCorrectionWithoutEVV, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverMaxVisits.*[.]csv.gz'') T);

    return ''Success'';
END;
';