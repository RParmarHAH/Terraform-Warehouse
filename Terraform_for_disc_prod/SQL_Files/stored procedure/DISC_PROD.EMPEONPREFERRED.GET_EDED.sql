CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_EDED("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_EDed 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.EDed (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS dcode, t.$4 AS calcCode, t.$5 AS tabled, t.$6 AS units, t.$7 AS rate, t.$8 AS amount, t.$9 AS startDate, t.$10 AS endDate, t.$11 AS cc1, t.$12 AS cc2, t.$13 AS cc3, t.$14 AS cc4, t.$15 AS cc5, t.$16 AS jobCode, t.$17 AS otc1, t.$18 AS otc2, t.$19 AS otc3, t.$20 AS goal, t.$21 AS paidTowardsGoal, t.$22 AS frequency, t.$23 AS lastDate, t.$24 AS annualMaximum, t.$25 AS minimum, t.$26 AS maximum, t.$27 AS agency, t.$28 AS miscInfo, t.$29 AS arrear, t.$30 AS guidfield, t.$31 AS lastChange, t.$32 AS lastChangeUser, t.$33 AS useAlternateMax, t.$34 AS arrearCap, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EDed.*[.]csv.gz'')T);

    
    return ''Success'';
END;
';