CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAEXCHANGE.GET_DFIMPORT_DATAFLEXTIMESHEETSANDATAVISITMAPPINGS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SanDataExchange.GET_DfImport_DataFlexTimeSheetSanDataVisitMappings 
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
    COPY INTO DISC_PROD.SanDataExchange.HIST_DfImport_DataFlexTimeSheetSanDataVisitMappings FROM (SELECT t.$1 AS TRACKING_ID, t.$2 AS SCHEDULE_ID, t.$3 AS SYSTEM_CODE, t.$4 AS SANDATA_AGENCY_ID, t.$5 AS SYS_CHANGE_VERSION, t.$6 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$6,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_DfImport_DataFlexTimeSheetSanDataVisitMappings.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.DfImport_DataFlexTimeSheetSanDataVisitMappings AS WITH curr_v AS (SELECT TRACKING_ID, SCHEDULE_ID, SANDATA_AGENCY_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheetSanDataVisitMappings GROUP BY TRACKING_ID, SCHEDULE_ID, SANDATA_AGENCY_ID) SELECT t.* FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheetSanDataVisitMappings t INNER JOIN curr_v v ON t.TRACKING_ID = v.TRACKING_ID AND t.SCHEDULE_ID = v.SCHEDULE_ID AND t.SANDATA_AGENCY_ID = v.SANDATA_AGENCY_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';