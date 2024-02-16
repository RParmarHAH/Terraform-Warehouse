CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EACCRUALTRANS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EAccrualTrans 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EAccrualTrans (SELECT t.$1 AS guidfield, t.$2 AS co, t.$3 AS id, t.$4 AS amount, t.$5 AS postDate, t.$6 AS payHist, t.$7 AS payHistSub, t.$8 AS ActionCode, t.$9 AS ActionType, t.$10 AS Comments, t.$11 AS createdDate, t.$12 AS lastChange, t.$13 AS lastChangeUser, t.$14 AS postOrder, t.$15 AS employeesBankId, t.$16 AS bankCode, t.$17 AS calendarId, t.$18 AS baseAmount, t.$19 AS accrualRate, t.$20 AS TransType, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EAccrualTrans.*[.]csv.gz'')T);

    return ''Success'';
END;
';