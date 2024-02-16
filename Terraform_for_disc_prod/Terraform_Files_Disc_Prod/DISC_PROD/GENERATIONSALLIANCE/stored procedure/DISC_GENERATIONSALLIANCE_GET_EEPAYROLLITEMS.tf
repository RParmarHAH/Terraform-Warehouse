resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_EEPAYROLLITEMS" {
	name ="GET_EEPAYROLLITEMS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_eePayrollItems 
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
    COPY INTO GENERATIONSALLIANCE.eePayrollItems FROM (SELECT t.$1 AS SocialSecNum, t.$2 AS ItemName, t.$3 AS Rate, t.$4 AS Default, t.$5 AS createdBy, t.$6 AS created, t.$7 AS updatedBy, t.$8 AS lastUpdated, t.$9 AS Inactive, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_eePayrollItems.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.eePayrollItems AS WITH curr_v AS (SELECT SocialSecNum, ItemName, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.eePayrollItems GROUP BY SocialSecNum, ItemName) SELECT t.* FROM GENERATIONSALLIANCE.eePayrollItems t INNER JOIN curr_v v ON t.SocialSecNum = v.SocialSecNum AND t.ItemName = v.ItemName AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

