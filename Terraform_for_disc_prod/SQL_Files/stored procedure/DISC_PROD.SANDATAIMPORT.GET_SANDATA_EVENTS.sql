CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_EVENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_Events 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_Events FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS EventCode, t.$4 AS Description, t.$5 AS IsBillable, t.$6 AS IsPayable, t.$7 AS IsActive, t.$8 AS CreatedAt, t.$9 AS UpdatedAt, t.$10 AS HashedRowValues, t.$11 AS BatchId, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Events.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Events AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Events GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Events t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';