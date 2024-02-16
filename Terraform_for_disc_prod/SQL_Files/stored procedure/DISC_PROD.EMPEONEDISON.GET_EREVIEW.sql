CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EREVIEW("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EReview 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EReview (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS date, t.$4 AS reviewer, t.$5 AS rating, t.$6 AS reviewersNotes, t.$7 AS employeesNotes, t.$8 AS raiseAmount, t.$9 AS newPayAmount, t.$10 AS newPayPer, t.$11 AS newPosition, t.$12 AS nextReviewDate, t.$13 AS effectiveDate, t.$14 AS guidfield, t.$15 AS lastChange, t.$16 AS lastChangeUser, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EReview.*[.]csv.gz'')T);

    return ''Success'';
END;
';