CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_REFERRALSUBMISSIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_ReferralSubmissions 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.ReferralSubmissions (SELECT t.$1 AS AgencyID, t.$2 AS ReferralSubmissionID, t.$3 AS ReferralID, t.$4 AS SubmittedTo, t.$5 AS SubmittedDate, t.$6 AS FollowUpDate, t.$7 AS RejectedSubmissionReason, t.$8 AS Note, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/HHAEXCHANGEPREFERRED_dbo_ReferralSubmissions.csv.gz (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';