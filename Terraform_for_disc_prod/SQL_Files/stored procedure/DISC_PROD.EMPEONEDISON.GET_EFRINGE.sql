CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EFRINGE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EFringe 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EFringe (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS ecode, t.$4 AS calcCode, t.$5 AS rateCode, t.$6 AS tabled, t.$7 AS units, t.$8 AS rate, t.$9 AS ratePer, t.$10 AS amount, t.$11 AS startDate, t.$12 AS endDate, t.$13 AS cc1, t.$14 AS cc2, t.$15 AS cc3, t.$16 AS cc4, t.$17 AS cc5, t.$18 AS jobCode, t.$19 AS otc1, t.$20 AS otc2, t.$21 AS otc3, t.$22 AS goal, t.$23 AS paidTowardsGoal, t.$24 AS frequency, t.$25 AS lastDate, t.$26 AS annualMaximum, t.$27 AS minimum, t.$28 AS maximum, t.$29 AS agency, t.$30 AS miscInfo, t.$31 AS guidfield, t.$32 AS lastChange, t.$33 AS lastChangeUser, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EFringe.*[.]csv.gz'')T);

    return ''Success'';
END;
';