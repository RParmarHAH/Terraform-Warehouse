CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_DOCUMENTATTACHMENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_DocumentAttachment 
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
    COPY INTO GENERATIONSALLIANCE.DocumentAttachment FROM (SELECT t.$1 AS AttachmentID, t.$2 AS FileName, t.$3 AS Description, t.$4 AS FolderID, t.$5 AS Location, t.$6 AS Class, t.$7 AS FileUrl, t.$8 AS Created, t.$9 AS CreatedBy, t.$10 AS Updated, t.$11 AS UpdatedBy, t.$12 AS AzureContainer, t.$13 AS AzureName, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_DocumentAttachment.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.DocumentAttachment AS WITH curr_v AS (SELECT AttachmentID, FolderID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.DocumentAttachment GROUP BY AttachmentID, FolderID) SELECT t.* FROM GENERATIONSALLIANCE.DocumentAttachment t INNER JOIN curr_v v ON t.AttachmentID = v.AttachmentID AND t.FolderID = v.FolderID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';