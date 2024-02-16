resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PROVIDERMEASURES" {
	name ="GET_PROVIDERMEASURES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ProviderMeasures 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ProviderMeasures (SELECT t.$1 AS AgencyID, t.$2 AS MeasureId, t.$3 AS Name, t.$4 AS Description, t.$5 AS Active, t.$6 AS PayerId, t.$7 AS CreatedBy, t.$8 AS CreatedDate, t.$9 AS UpdatedBy, t.$10 AS UpdatedDate, t.$11 AS GUID, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ ( PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ProviderMeasures.*[.]csv.gz'', FILE_FORMAT =>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT )T);

    return ''Success'';
END;

 EOT
}

