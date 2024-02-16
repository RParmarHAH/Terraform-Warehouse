CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EDIRDEP("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EDirDep 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EDirDep (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS sequence, t.$4 AS transit, t.$5 AS account, t.$6 AS checking, t.$7 AS amountCode, t.$8 AS amount, t.$9 AS excludeSpecial, t.$10 AS prenoteDate, t.$11 AS nameOnAccount, t.$12 AS startDate, t.$13 AS endDate, t.$14 AS guidfield, t.$15 AS lastChange, t.$16 AS lastChangeUser, t.$17 AS dateEnded, t.$18 AS returnCode, t.$19 AS returnDescription, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EDirDep.*[.]csv.gz'')T);

    return ''Success'';
END;
';