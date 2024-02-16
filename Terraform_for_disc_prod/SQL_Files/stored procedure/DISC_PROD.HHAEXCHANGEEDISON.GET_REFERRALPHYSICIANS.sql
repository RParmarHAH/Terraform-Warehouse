CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_REFERRALPHYSICIANS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_ReferralPhysicians 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.ReferralPhysicians (SELECT t.$1 AS AgencyID, t.$2 AS ReferralPhysicianID, t.$3 AS ReferralID, t.$4 AS PhysicianName, t.$5 AS Note, t.$6 AS PrimaryReferralPhysician, t.$7 AS Address1, t.$8 AS Address2, t.$9 AS City, t.$10 AS State, t.$11 AS Zip, t.$12 AS Phone1, t.$13 AS Phone2, t.$14 AS Phone3, t.$15 AS NPI, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/edisonhomedb_dbo_ReferralPhysicians.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;
';