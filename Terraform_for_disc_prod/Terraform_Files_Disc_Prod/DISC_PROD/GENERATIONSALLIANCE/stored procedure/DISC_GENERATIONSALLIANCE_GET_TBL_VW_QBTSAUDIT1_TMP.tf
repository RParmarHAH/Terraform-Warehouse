resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TBL_VW_QBTSAUDIT1_TMP" {
	name ="GET_TBL_VW_QBTSAUDIT1_TMP"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_tbl_vw_qbTSAudit1_tmp 
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
    COPY INTO GENERATIONSALLIANCE.tbl_vw_qbTSAudit1_tmp FROM (SELECT t.$1 AS ID, t.$2 AS PayPeriodID, t.$3 AS SocialSecNum, t.$4 AS ClientID, t.$5 AS Date, t.$6 AS StartTime, t.$7 AS EndTime, t.$8 AS RunSum, t.$9 AS totalhours, t.$10 AS itemName, t.$11 AS IsHoliday, t.$12 AS paid, t.$13 AS ServiceCode, t.$14 AS Modifier, t.$15 AS CostPerUnit, t.$16 AS timesheetID, t.$17 AS notes, t.$18 AS Tsdatetime, t.$19 AS billed, t.$20 AS flatrate, t.$21 AS payEndDate, t.$22 AS RunSumPerDay, t.$23 AS OTPerWeekLimit, t.$24 AS OTPerDayLimit, t.$25 AS mnyRate, t.$26 AS mnyOTRate, t.$27 AS bOTExempt, t.$28 AS mnyHolRate, t.$29 AS SYS_CHANGE_VERSION, t.$30 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$30,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_vw_qbTSAudit1_tmp.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_vw_qbTSAudit1_tmp AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_vw_qbTSAudit1_tmp GROUP BY ID) SELECT t.* FROM GENERATIONSALLIANCE.tbl_vw_qbTSAudit1_tmp t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

