resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_RATEBILLSHIFTS" {
	name ="GET_STVHC_T_RATEBILLSHIFTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_RateBillShifts 
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
    COPY INTO MatrixCare.HIST_STVHC_T_RateBillShifts FROM (SELECT t.$1 AS ScheduleID, t.$2 AS SchExpenseID, t.$3 AS StartTime, t.$4 AS EndTime, t.$5 AS ShiftNo, t.$6 AS UnitType, t.$7 AS Units, t.$8 AS Rate, t.$9 AS HolidayID, t.$10 AS HollidayAdd, t.$11 AS HollidayMult, t.$12 AS ActualRate, t.$13 AS IsService, t.$14 AS TotalAmount, t.$15 AS cs_Billshift, t.$16 AS rbs_OTAmount, t.$17 AS rbs_ID, t.$18 AS InsertDate, t.$19 AS UpdateDate, t.$20 AS DeletedFlag, t.$21 AS SYS_CHANGE_VERSION, CASE WHEN t.$20 = True THEN ''D'' WHEN t.$18 = t.$19 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$20, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_RateBillShifts.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_RateBillShifts AS WITH curr_v AS (SELECT ScheduleID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_RateBillShifts GROUP BY ScheduleID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_RateBillShifts t INNER JOIN curr_v v ON t.ScheduleID = v.ScheduleID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

