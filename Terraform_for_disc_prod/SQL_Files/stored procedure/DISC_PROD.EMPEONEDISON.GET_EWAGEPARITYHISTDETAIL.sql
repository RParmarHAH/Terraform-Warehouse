CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EWAGEPARITYHISTDETAIL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EWageParityHistDetail 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EWageParityHistDetail (SELECT t.$1 AS wageParityId, t.$2 AS co, t.$3 AS id, t.$4 AS wpCode, t.$5 AS beginDate, t.$6 AS endDate, t.$7 AS hours, t.$8 AS rate, t.$9 AS amount, t.$10 AS transType, t.$11 AS cc1, t.$12 AS cc2, t.$13 AS cc3, t.$14 AS cc4, t.$15 AS cc5, t.$16 AS shift, t.$17 AS jobCode, t.$18 AS comment, t.$19 AS lastChange, t.$20 AS lastChangeUser, t.$21 AS trans, t.$22 AS subTrans, t.$23 AS EAccrualTransGuidfield, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EWageParityHistDetail.*[.]csv.gz'')T);

    return ''Success'';
END;
';