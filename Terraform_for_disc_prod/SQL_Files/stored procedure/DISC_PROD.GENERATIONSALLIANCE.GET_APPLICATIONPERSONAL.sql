CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_APPLICATIONPERSONAL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ApplicationPersonal 
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
    COPY INTO GENERATIONSALLIANCE.ApplicationPersonal FROM (SELECT t.$1 AS Appid, t.$2 AS FirstName, t.$3 AS LastName, t.$4 AS Address1, t.$5 AS Address2, t.$6 AS HomePhone, t.$7 AS City, t.$8 AS WorkPhone, t.$9 AS CellPhone, t.$10 AS State, t.$11 AS Zip, t.$12 AS Email, t.$13 AS AtThisAddress, t.$14 AS CovictedCrime, t.$15 AS NatureOfConviction, t.$16 AS LikeMost, t.$17 AS LikeLeast, t.$18 AS ECName, t.$19 AS ECPhone, t.$20 AS ECAltPhone, t.$21 AS ECRelationShip, t.$22 AS ECAddress, t.$23 AS ECCity, t.$24 AS ECState, t.$25 AS ECZip, t.$26 AS MiddleInit, t.$27 AS CellPhoneProvider, t.$28 AS SSN, t.$29 AS PostionApplyingFor, t.$30 AS SignatureData, t.$31 AS TextMessage, t.$32 AS ReferredByID, t.$33 AS OtherReferredBy, t.$34 AS SSNStrong, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ApplicationPersonal.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ApplicationPersonal AS WITH curr_v AS (SELECT Appid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ApplicationPersonal GROUP BY Appid) SELECT t.* FROM GENERATIONSALLIANCE.ApplicationPersonal t INNER JOIN curr_v v ON t.Appid = v.Appid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';