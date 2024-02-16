resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TIMESHEETEXPENSES" {
	name ="GET_TIMESHEETEXPENSES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_timesheetexpenses 
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
    COPY INTO GENERATIONSALLIANCE.timesheetexpenses FROM (SELECT t.$1 AS payperiodId, t.$2 AS SocialSecNum, t.$3 AS clientid, t.$4 AS servicecode, t.$5 AS totalUnits, t.$6 AS costPerUnit, t.$7 AS ExpenseId, t.$8 AS DateOfExpense, t.$9 AS Isbillable, t.$10 AS createdBy, t.$11 AS created, t.$12 AS updatedBy, t.$13 AS lastUpdated, t.$14 AS billed, t.$15 AS billSource, t.$16 AS billDtm, t.$17 AS paid, t.$18 AS paySource, t.$19 AS payDtm, t.$20 AS Invoice_Number, t.$21 AS Estimate_Number, t.$22 AS IsPayable, t.$23 AS scheduleExpenseId, t.$24 AS scheduleExpenseChanged, t.$25 AS scheduleExpenseDeleted, t.$26 AS bit_EnableTotalCostInWeightedAvg, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_timesheetexpenses.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.timesheetexpenses AS WITH curr_v AS (SELECT ExpenseId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.timesheetexpenses GROUP BY ExpenseId) SELECT t.* FROM GENERATIONSALLIANCE.timesheetexpenses t INNER JOIN curr_v v ON t.ExpenseId = v.ExpenseId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

