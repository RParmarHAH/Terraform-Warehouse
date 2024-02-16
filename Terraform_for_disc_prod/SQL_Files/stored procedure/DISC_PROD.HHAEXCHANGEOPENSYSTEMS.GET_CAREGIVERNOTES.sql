CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREGIVERNOTES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverNotes 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CaregiverNotes (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverNoteID, t.$3 AS CaregiverID, t.$4 AS CaregiverName, t.$5 AS CaregiverNote, t.$6 AS Subject, t.$7 AS NoteDate, t.$8 AS CreatedByUser, t.$9 AS CaregiverNotified, t.$10 AS PatientID, t.$11 AS PatientName, t.$12 AS MessageInOut, t.$13 AS VoiceMessageToCaregiver, t.$14 AS CaregiverNotificationVoiceMail, t.$15 AS Mobile_TextMessageToCaregiver, t.$16 AS CaregiverNotificationTextNumber, t.$17 AS EmailMessageToCaregiver, t.$18 AS CaregiverNotificationEmail, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverNotes.*[.]csv.gz'') T);

    return ''Success'';
END;
';