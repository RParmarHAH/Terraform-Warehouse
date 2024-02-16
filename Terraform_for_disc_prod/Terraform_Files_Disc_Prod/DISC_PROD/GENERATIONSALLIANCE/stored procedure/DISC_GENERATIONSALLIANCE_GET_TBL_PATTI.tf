resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TBL_PATTI" {
	name ="GET_TBL_PATTI"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_tbl_patti 
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
    COPY INTO GENERATIONSALLIANCE.tbl_patti FROM (SELECT t.$1 AS int_pattiid, t.$2 AS dtm_Savedt, t.$3 AS ClientId, t.$4 AS PhoneDialedTo, t.$5 AS PID, t.$6 AS Purpose, t.$7 AS EMID, t.$8 AS Lname, t.$9 AS Jname, t.$10 AS Clid, t.$11 AS Clid_Name, t.$12 AS W_Min, t.$13 AS Hrs, t.$14 AS f1, t.$15 AS f2, t.$16 AS f3, t.$17 AS f4, t.$18 AS M1, t.$19 AS T0, t.$20 AS D0, t.$21 AS Q0, t.$22 AS dtm_createddate, t.$23 AS int_scheduleid, t.$24 AS dtm_scheduletime, t.$25 AS RoundedTime, t.$26 AS callsid, t.$27 AS Lattitude, t.$28 AS Longitude, t.$29 AS CallType, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_patti.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_patti AS WITH curr_v AS (SELECT dtm_Savedt, ClientId, PID, EMID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_patti GROUP BY dtm_Savedt, ClientId, PID, EMID) SELECT t.* FROM GENERATIONSALLIANCE.tbl_patti t INNER JOIN curr_v v ON t.dtm_Savedt = v.dtm_Savedt AND t.ClientId = v.ClientId AND t.PID = v.PID AND t.EMID = v.EMID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

