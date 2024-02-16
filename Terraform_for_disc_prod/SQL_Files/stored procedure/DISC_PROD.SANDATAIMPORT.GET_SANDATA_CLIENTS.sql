CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_CLIENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_Clients 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_Clients FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS clientID, t.$4 AS Person, t.$5 AS Title, t.$6 AS FirstName, t.$7 AS MiddleInitial, t.$8 AS LastName, t.$9 AS Suffix, t.$10 AS Ethnicity, t.$11 AS Income, t.$12 AS Language, t.$13 AS Marital, t.$14 AS Religion, t.$15 AS Nationality, t.$16 AS Sex, t.$17 AS SSN, t.$18 AS DOB, t.$19 AS DOD, t.$20 AS Address, t.$21 AS Address2, t.$22 AS AptNo, t.$23 AS County, t.$24 AS City, t.$25 AS State, t.$26 AS Zip, t.$27 AS HomePhone, t.$28 AS WorkPhone, t.$29 AS MobilePhone, t.$30 AS Fax, t.$31 AS Email, t.$32 AS CustomID, t.$33 AS OtherID, t.$34 AS DNR, t.$35 AS DisasterID, t.$36 AS CreatedAt, t.$37 AS UpdatedAt, t.$38 AS HashedRowValues, t.$39 AS BatchId, t.$40 AS AddressType, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Clients.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Clients AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Clients GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Clients t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';