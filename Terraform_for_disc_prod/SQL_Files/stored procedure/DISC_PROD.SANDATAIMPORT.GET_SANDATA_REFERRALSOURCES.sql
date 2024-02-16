CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_REFERRALSOURCES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_ReferralSources 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_ReferralSources FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS ReferralID, t.$4 AS Person, t.$5 AS Title, t.$6 AS FirstName, t.$7 AS MiddleInitial, t.$8 AS LastName, t.$9 AS Suffix, t.$10 AS Sex, t.$11 AS SSN, t.$12 AS DOB, t.$13 AS DOD, t.$14 AS Address, t.$15 AS Address2, t.$16 AS AptNo, t.$17 AS County, t.$18 AS City, t.$19 AS State, t.$20 AS Zip, t.$21 AS HomePhone, t.$22 AS WorkPhone, t.$23 AS MobilePhone, t.$24 AS Fax, t.$25 AS Email, t.$26 AS SourceType, t.$27 AS Contact, t.$28 AS Representative, t.$29 AS IsActive, t.$30 AS CreatedAt, t.$31 AS UpdatedAt, t.$32 AS HashedRowValues, t.$33 AS BatchId, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_ReferralSources.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_ReferralSources AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_ReferralSources GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_ReferralSources t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';