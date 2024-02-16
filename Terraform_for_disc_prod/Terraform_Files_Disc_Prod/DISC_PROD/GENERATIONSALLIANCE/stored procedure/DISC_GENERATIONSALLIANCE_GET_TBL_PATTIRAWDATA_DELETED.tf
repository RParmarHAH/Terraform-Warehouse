resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TBL_PATTIRAWDATA_DELETED" {
	name ="GET_TBL_PATTIRAWDATA_DELETED"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_tbl_PattiRawData_deleted 
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
    COPY INTO GENERATIONSALLIANCE.tbl_PattiRawData_deleted FROM (SELECT t.$1 AS int_pattiid, t.$2 AS dtm_Savedt, t.$3 AS ClientId, t.$4 AS PhoneDialedTo, t.$5 AS PID, t.$6 AS Purpose, t.$7 AS EMID, t.$8 AS Lname, t.$9 AS Jname, t.$10 AS Clid, t.$11 AS Clid_Name, t.$12 AS W_Min, t.$13 AS Hrs, t.$14 AS f1, t.$15 AS f2, t.$16 AS f3, t.$17 AS f4, t.$18 AS M1, t.$19 AS T0, t.$20 AS D0, t.$21 AS Q0, t.$22 AS dtm_createddate, t.$23 AS int_scheduleid, t.$24 AS dtm_scheduletime, t.$25 AS RoundedTime, t.$26 AS ExpenseId, t.$27 AS IsCheckIn, t.$28 AS callsid, t.$29 AS Lattitude, t.$30 AS Longitude, t.$31 AS CallType, t.$32 AS GPSOption, t.$33 AS MatchedScheduleID, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_PattiRawData_deleted.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_PattiRawData_deleted AS WITH curr_v AS (SELECT int_pattiid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_PattiRawData_deleted GROUP BY int_pattiid) SELECT t.* FROM GENERATIONSALLIANCE.tbl_PattiRawData_deleted t INNER JOIN curr_v v ON t.int_pattiid = v.int_pattiid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

