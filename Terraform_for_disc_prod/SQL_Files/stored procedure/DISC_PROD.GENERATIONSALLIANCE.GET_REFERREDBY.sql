CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_REFERREDBY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_Referredby 
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
    COPY INTO GENERATIONSALLIANCE.Referredby FROM (SELECT t.$1 AS ReferredById, t.$2 AS Name, t.$3 AS Company, t.$4 AS Phone, t.$5 AS Address, t.$6 AS Notes, t.$7 AS createdBy, t.$8 AS created, t.$9 AS updatedBy, t.$10 AS lastUpdated, t.$11 AS email, t.$12 AS Salutation, t.$13 AS Title, t.$14 AS Department, t.$15 AS Website, t.$16 AS Mobile, t.$17 AS ReferralStatus, t.$18 AS Fax, t.$19 AS referralStatusId, t.$20 AS ReferralCity, t.$21 AS ReferralState, t.$22 AS ReferralZip, t.$23 AS referralTypeID, t.$24 AS referralLocationID, t.$25 AS isActive, t.$26 AS NotifiedUsers, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_Referredby.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.Referredby AS WITH curr_v AS (SELECT ReferredById, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.Referredby GROUP BY ReferredById) SELECT t.* FROM GENERATIONSALLIANCE.Referredby t INNER JOIN curr_v v ON t.ReferredById = v.ReferredById AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';