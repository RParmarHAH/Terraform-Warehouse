CREATE OR REPLACE PROCEDURE DISC_PROD.BI_REPOSITORY.GET_ALAUTHENTICARECONTRACTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.BI_Repository.GET_ALAuthenticareContracts 
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
    INSERT OVERWRITE INTO DISC_PROD.BI_Repository.ALAuthenticareContracts (SELECT t.$1 AS ServiceCode, t.$2 AS AAA, t.$3 AS ServiceName, t.$4 AS DfContract, t.$5 AS DfServiceCode, t.$6 AS FundingCode, t.$7 AS ProcedureCode, t.$8 AS Modifier, t.$9 AS UnitHourRatio, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_ALAuthenticareContracts.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    return ''Success'';
END;
';