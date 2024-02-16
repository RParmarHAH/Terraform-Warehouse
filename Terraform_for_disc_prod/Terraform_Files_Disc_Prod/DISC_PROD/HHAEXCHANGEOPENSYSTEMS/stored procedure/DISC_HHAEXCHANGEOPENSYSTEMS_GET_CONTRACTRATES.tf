resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CONTRACTRATES" {
	name ="GET_CONTRACTRATES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ContractRates 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ContractRates (SELECT t.$1 AS AgencyID, t.$2 AS ContractRateID, t.$3 AS ContractID, t.$4 AS Discipline, t.$5 AS ServiceCode, t.$6 AS ServiceCodeID, t.$7 AS FromDate, t.$8 AS ToDate, t.$9 AS Rate, t.$10 AS Units, t.$11 AS IsBillingHourlyCap, t.$12 AS HourlyCapHH, t.$13 AS HourlyCapMM, t.$14 AS MinHr, t.$15 AS RateType, t.$16 AS ModifiedDate, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ContractRates.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

