resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_STAGE_LINKEDCONTRACTRATES" {
	name ="GET_STAGE_LINKEDCONTRACTRATES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_stage_LinkedContractRates 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.stage_LinkedContractRates  (SELECT t.$1 AS AgencyID, t.$2 AS VendorRateID, t.$3 AS OfficeID, t.$4 AS PayerID, t.$5 AS FromDate, t.$6 AS ToDate, t.$7 AS Status, t.$8 AS ServiceCategory, t.$9 AS ServiceCode, t.$10 AS ServiceType, t.$11 AS RateAmount, t.$12 AS RateType, t.$13 AS AllowProviderEditBillingRates, t.$14 AS Units, t.$15 AS MinHr, t.$16 AS ServiceCodeID, t.$17 AS IsNonBillable, t.$18 AS IsExpandCollapsVisible, t.$19 AS CreatedDate, t.$20 AS LastModifiedDate, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_stage_LinkedContractRates.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

