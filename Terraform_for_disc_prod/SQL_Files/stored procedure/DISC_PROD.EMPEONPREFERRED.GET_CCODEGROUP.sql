CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_CCODEGROUP("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_CCodeGroup 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.CCodeGroup (SELECT t.$1 AS co, t.$2 AS codeGroup, t.$3 AS description, t.$4 AS includeNewCodes, t.$5 AS includeEarnings, t.$6 AS includeDeductions, t.$7 AS includeTaxes, t.$8 AS includeDirDep, t.$9 AS codegroupguid, t.$10 AS lastChange, t.$11 AS lastChangeUser, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/EmpeonPreferred_dbo_CCodeGroup.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    
    return ''Success'';
END;
';