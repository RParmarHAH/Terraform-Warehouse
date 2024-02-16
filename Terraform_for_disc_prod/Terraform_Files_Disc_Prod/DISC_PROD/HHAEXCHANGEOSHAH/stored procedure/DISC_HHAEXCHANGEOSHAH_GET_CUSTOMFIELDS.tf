resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_CUSTOMFIELDS" {
	name ="GET_CUSTOMFIELDS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_CustomFields 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CustomFields (SELECT t.$1 AS CustomFieldID, t.$2 AS CustomFieldType, t.$3 AS CustomFieldTypeText, t.$4 AS AgencyID, t.$5 AS CompanyType, t.$6 AS CompanyTypeText, t.$7 AS ControlType, t.$8 AS ControlTypeText, t.$9 AS ControlSeq, t.$10 AS ControlValue, t.$11 AS ControlCaption, t.$12 AS ControlStatus, t.$13 AS ControlStatusText, t.$14 AS CreatedBy, t.$15 AS CreatedDate, t.$16 AS UpdatedBy, t.$17 AS UpdatedDate, t.$18 AS IsDateControl, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/HHAEXCHANGEOSHAH_dbo_CustomFields.csv.gz (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}

