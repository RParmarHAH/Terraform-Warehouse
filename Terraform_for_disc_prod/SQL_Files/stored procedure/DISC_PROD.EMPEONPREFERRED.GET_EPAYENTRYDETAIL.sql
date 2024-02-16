CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_EPAYENTRYDETAIL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_EPayEntryDetail 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.EPayEntryDetail (SELECT t.$1 AS Trans, t.$2 AS subTrans, t.$3 AS TransType, t.$4 AS det, t.$5 AS detCode, t.$6 AS hours, t.$7 AS rate, t.$8 AS amount, t.$9 AS rateCode, t.$10 AS tcode1, t.$11 AS tcode2, t.$12 AS tcode3, t.$13 AS tcode4, t.$14 AS beginDate, t.$15 AS endDate, t.$16 AS shift, t.$17 AS wcc, t.$18 AS cc1, t.$19 AS cc2, t.$20 AS cc3, t.$21 AS cc4, t.$22 AS cc5, t.$23 AS jobCode, t.$24 AS dirDepTransit, t.$25 AS account, t.$26 AS comment, t.$27 AS agencyProcess, t.$28 AS guidfield, t.$29 AS lastChange, t.$30 AS lastChangeUser, t.$31 AS co, t.$32 AS ImportGuid, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/EmpeonPreferred_dbo_EPayEntryDetail.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.EPayEntryDetail AS WITH curr_v AS (SELECT Trans, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.EPayEntryDetail GROUP BY Trans) SELECT t.* FROM EmpeonPreferred.EPayEntryDetail t INNER JOIN curr_v v ON t.Trans = v.Trans AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';