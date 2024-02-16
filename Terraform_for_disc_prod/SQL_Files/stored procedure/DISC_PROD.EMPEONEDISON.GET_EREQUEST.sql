CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EREQUEST("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_ERequest 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.ERequest (SELECT t.$1 AS requestId, t.$2 AS co, t.$3 AS id, t.$4 AS type, t.$5 AS subType, t.$6 AS name, t.$7 AS description, t.$8 AS requesterComment, t.$9 AS reviewerComment, t.$10 AS referenceId, t.$11 AS details, t.$12 AS prevDetails, t.$13 AS state, t.$14 AS requestedOn, t.$15 AS reviewed, t.$16 AS reviewedOn, t.$17 AS reviewedBy, t.$18 AS lastChange, t.$19 AS lastChangeUser, t.$20 AS referenceDate, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_ERequest.*[.]csv.gz'')T);

    return ''Success'';
END;
';