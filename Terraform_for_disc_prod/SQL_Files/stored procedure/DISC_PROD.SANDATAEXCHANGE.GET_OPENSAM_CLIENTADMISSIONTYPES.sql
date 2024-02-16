CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAEXCHANGE.GET_OPENSAM_CLIENTADMISSIONTYPES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SanDataExchange.GET_OpenSam_ClientAdmissionTypes 
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
    COPY INTO DISC_PROD.SanDataExchange.HIST_OpenSam_ClientAdmissionTypes FROM (SELECT t.$1 AS HahDfDb, t.$2 AS ContractCode, t.$3 AS AdmissionTypeId, t.$4 AS PayorId, t.$5 AS PayorName, t.$6 AS DefaultService, t.$7 AS BillCode, t.$8 AS SYS_CHANGE_VERSION, t.$9 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$9,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_OpenSam_ClientAdmissionTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.OpenSam_ClientAdmissionTypes AS WITH curr_v AS (SELECT HahDfDb, ContractCode, DefaultService, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_OpenSam_ClientAdmissionTypes GROUP BY HahDfDb, ContractCode, DefaultService) SELECT t.* FROM SanDataExchange.HIST_OpenSam_ClientAdmissionTypes t INNER JOIN curr_v v ON t.HahDfDb = v.HahDfDb AND t.ContractCode = v.ContractCode AND t.DefaultService = v.DefaultService AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';