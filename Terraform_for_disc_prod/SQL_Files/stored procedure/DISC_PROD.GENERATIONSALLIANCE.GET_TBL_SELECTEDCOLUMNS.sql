CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TBL_SELECTEDCOLUMNS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_tbl_selectedcolumns 
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
    COPY INTO GENERATIONSALLIANCE.tbl_selectedcolumns FROM (SELECT t.$1 AS int_userid, t.$2 AS bit_lastName, t.$3 AS bit_firstName, t.$4 AS bit_middleinit, t.$5 AS bit_address1, t.$6 AS bit_address2, t.$7 AS bit_city, t.$8 AS bit_county, t.$9 AS bit_state, t.$10 AS bit_zip, t.$11 AS bit_ValidDriversLicense, t.$12 AS bit_Smoker, t.$13 AS bit_WeightRestriction, t.$14 AS bit_WeightLimit, t.$15 AS bit_ClassificationID, t.$16 AS bit_DateofBirth, t.$17 AS bit_Status, t.$18 AS bit_StatusDate, t.$19 AS bit_InactiveDate, t.$20 AS bit_Email, t.$21 AS bit_Phone1, t.$22 AS bit_Phone2, t.$23 AS bit_BackgroundCheck, t.$24 AS bit_className, t.$25 AS bit_independentContractor, t.$26 AS bit_telephonyID, t.$27 AS bit_doNotRehire, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_selectedcolumns.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_selectedcolumns AS WITH curr_v AS (SELECT int_userid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_selectedcolumns GROUP BY int_userid) SELECT t.* FROM GENERATIONSALLIANCE.tbl_selectedcolumns t INNER JOIN curr_v v ON t.int_userid = v.int_userid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';