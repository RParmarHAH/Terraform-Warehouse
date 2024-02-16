resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PROVIDERRATEDETAILS" {
	name ="GET_PROVIDERRATEDETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ProviderRateDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ProviderRateDetails (SELECT t.$1 AS AgencyID, t.$2 AS ProviderRateDetailID, t.$3 AS ProviderRateID, t.$4 AS PayerID, t.$5 AS ServiceCodeID, t.$6 AS PayerServiceCodeAreaID, t.$7 AS RateAmount, t.$8 AS CreatedBy, t.$9 AS CreatedByUserName, t.$10 AS CreatedDate, t.$11 AS CreatedUTCDate, t.$12 AS UpdatedBy, t.$13 AS UpdatedByUserName, t.$14 AS UpdatedDate, t.$15 AS UpdatedUTCDate, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ProviderRateDetails.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

