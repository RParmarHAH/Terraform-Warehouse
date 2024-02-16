CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_CJOB("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_CJob 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-11-30		Komal Dhokai			Removed VIEWSQL
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.CJob (SELECT t.$1 AS co, t.$2 AS jobCode, t.$3 AS description, t.$4 AS address1, t.$5 AS address2, t.$6 AS city, t.$7 AS state, t.$8 AS zip, t.$9 AS county, t.$10 AS country, t.$11 AS overrideShift, t.$12 AS overrideRateCode, t.$13 AS overrideRate, t.$14 AS addToRate, t.$15 AS certifiedJob, t.$16 AS rateMultiplier, t.$17 AS startDate, t.$18 AS endDate, t.$19 AS guidfield, t.$20 AS lastChange, t.$21 AS lastChangeUser, t.$22 AS addlTaxData1, t.$23 AS cmsLaborJobCode, t.$24 AS Obsolete, t.$25 AS cStartDate, t.$26 AS fedEin, t.$27 AS finalFilingQ, t.$28 AS finalFilingY, t.$29 AS localTaxCode, t.$30 AS localTaxId, t.$31 AS sitwFreq, t.$32 AS stateEin, t.$33 AS status, t.$34 AS suiRate, t.$35 AS suiTaxId, t.$36 AS location, t.$37 AS subjectWP, t.$38 AS pbjCode, t.$39 AS hppdType, t.$40 AS SYS_CHANGE_VERSION, t.$41 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$41,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_CJob.*[.]csv.gz'')T);

    return ''Success'';
END;
';