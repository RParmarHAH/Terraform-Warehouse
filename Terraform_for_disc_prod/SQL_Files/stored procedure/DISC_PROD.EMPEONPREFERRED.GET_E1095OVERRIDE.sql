CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_E1095OVERRIDE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_E1095Override 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.E1095Override (SELECT t.$1 AS e1095OverrideId, t.$2 AS co, t.$3 AS id, t.$4 AS year, t.$5 AS status1, t.$6 AS status2, t.$7 AS status3, t.$8 AS status4, t.$9 AS status5, t.$10 AS status6, t.$11 AS status7, t.$12 AS status8, t.$13 AS status9, t.$14 AS status10, t.$15 AS status11, t.$16 AS status12, t.$17 AS offer1, t.$18 AS offer2, t.$19 AS offer3, t.$20 AS offer4, t.$21 AS offer5, t.$22 AS offer6, t.$23 AS offer7, t.$24 AS offer8, t.$25 AS offer9, t.$26 AS offer10, t.$27 AS offer11, t.$28 AS offer12, t.$29 AS contribution1, t.$30 AS contribution2, t.$31 AS contribution3, t.$32 AS contribution4, t.$33 AS contribution5, t.$34 AS contribution6, t.$35 AS contribution7, t.$36 AS contribution8, t.$37 AS contribution9, t.$38 AS contribution10, t.$39 AS contribution11, t.$40 AS contribution12, t.$41 AS relief1, t.$42 AS relief2, t.$43 AS relief3, t.$44 AS relief4, t.$45 AS relief5, t.$46 AS relief6, t.$47 AS relief7, t.$48 AS relief8, t.$49 AS relief9, t.$50 AS relief10, t.$51 AS relief11, t.$52 AS relief12, t.$53 AS lastChangeUser, t.$54 AS lastChange, t.$55 AS SYS_CHANGE_VERSION, t.$56 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$56,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_E1095Override.*[.]csv.gz'')T);

    
    return ''Success'';
END;
';