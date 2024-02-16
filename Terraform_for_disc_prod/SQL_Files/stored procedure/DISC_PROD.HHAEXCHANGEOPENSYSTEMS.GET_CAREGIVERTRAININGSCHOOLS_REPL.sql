CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CAREGIVERTRAININGSCHOOLS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverTrainingSchools_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CaregiverTrainingSchools_REPL (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverTrainingSchoolID, t.$3 AS CaregiverID, t.$4 AS TrainingSchoolName, t.$5 AS CertificationDate, t.$6 AS InstructorName, t.$7 AS CertificationVerified, t.$8 AS CertificationVerifiedDate, t.$9 AS OnFile, t.$10 AS Default, t.$11 AS ScanFileName, t.$12 AS TrainingSchoolMasterId, t.$13 AS DisciplineID, t.$14 AS CreatedDate, t.$15 AS CreatedBy, t.$16 AS CreatedByUser, t.$17 AS CreatedUTCDate, t.$18 AS UpdatedDate, t.$19 AS UpdatedBy, t.$20 AS UpdatedByUser, t.$21 AS UpdatedUTCDate, t.$22 AS DisciplineText, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverTrainingSchools_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';