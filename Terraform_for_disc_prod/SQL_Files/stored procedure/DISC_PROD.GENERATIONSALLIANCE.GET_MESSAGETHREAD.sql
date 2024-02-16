CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_MESSAGETHREAD("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_MessageThread 
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
    COPY INTO GENERATIONSALLIANCE.MessageThread FROM (SELECT t.$1 AS MessageThreadID, t.$2 AS MessageCenterID, t.$3 AS Froms, t.$4 AS Tos, t.$5 AS Subject, t.$6 AS Body, t.$7 AS IsRead, t.$8 AS SendDate, t.$9 AS SenderType, t.$10 AS Attachment, t.$11 AS AttachmentType, t.$12 AS AttachedFileName, t.$13 AS Created, t.$14 AS CreatedBy, t.$15 AS LastUpdated, t.$16 AS UpdatedBy, t.$17 AS UserType, t.$18 AS UserReferenceID, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_MessageThread.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.MessageThread AS WITH curr_v AS (SELECT MessageThreadID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.MessageThread GROUP BY MessageThreadID) SELECT t.* FROM GENERATIONSALLIANCE.MessageThread t INNER JOIN curr_v v ON t.MessageThreadID = v.MessageThreadID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';