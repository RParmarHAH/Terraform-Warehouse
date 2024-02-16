CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CAREINSIGHTSALERTNOTE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_CareInsightsAlertNote 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.CareInsightsAlertNote (SELECT t.$1 AS AgencyID, t.$2 AS VBCAlertFeedbackActionID, t.$3 AS VBCAlertFeedbackDetailID, t.$4 AS AlertTime, t.$5 AS VisitDate, t.$6 AS VisitStartTime, t.$7 AS VisitEndTime, t.$8 AS Alert, t.$9 AS AlertStatus, t.$10 AS Priority, t.$11 AS Date_Time, t.$12 AS User, t.$13 AS Nurse, t.$14 AS ActionTaken, t.$15 AS Note, t.$16 AS Status, t.$17 AS Assignee, t.$18 AS CreatedDate, t.$19 AS CreatedByUser, t.$20 AS CreatedBy, t.$21 AS UpdatedDate, t.$22 AS UpdatedByUser, t.$23 AS UpdatedBy, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/HHAEXCHANGEOSHAH_dbo_CareInsightsAlertNote.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;
';