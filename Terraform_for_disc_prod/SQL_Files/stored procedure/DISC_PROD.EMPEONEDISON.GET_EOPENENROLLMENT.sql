CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EOPENENROLLMENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EOpenEnrollment 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EOpenEnrollment (SELECT t.$1 AS openEnrollmentId, t.$2 AS co, t.$3 AS id, t.$4 AS openEnrollmentSessionId, t.$5 AS enrollmentStatus, t.$6 AS planSelections, t.$7 AS stepsCompleted, t.$8 AS lastChange, t.$9 AS lastChangeUser, t.$10 AS benefitOfferId, t.$11 AS employerComment, t.$12 AS extendedSessionEnd, t.$13 AS employeeComment, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EOpenEnrollment.*[.]csv.gz'')T);

    return ''Success'';
END;
';