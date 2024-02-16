CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_CDEPT4("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_CDept4 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.CDept4 (SELECT t.$1 AS co, t.$2 AS cc4, t.$3 AS name, t.$4 AS address1, t.$5 AS address2, t.$6 AS city, t.$7 AS state, t.$8 AS zip, t.$9 AS county, t.$10 AS country, t.$11 AS overrideCheckCalcCode, t.$12 AS wcc, t.$13 AS overrideRateCode, t.$14 AS overrideRate, t.$15 AS overrideShift, t.$16 AS overrideCheckAcctName, t.$17 AS guidfield, t.$18 AS lastChange, t.$19 AS lastChangeUser, t.$20 AS useThisAddrOnChecks, t.$21 AS addlTaxData1, t.$22 AS cmsLaborJobCode, t.$23 AS Obsolete, t.$24 AS location, t.$25 AS subjectWP, t.$26 AS pbjCode, t.$27 AS hppdType, t.$28 AS gl, t.$29 AS SYS_CHANGE_VERSION, t.$30 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$30,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_CDept4.*[.]csv.gz'')T);

    
    return ''Success'';
END;
';