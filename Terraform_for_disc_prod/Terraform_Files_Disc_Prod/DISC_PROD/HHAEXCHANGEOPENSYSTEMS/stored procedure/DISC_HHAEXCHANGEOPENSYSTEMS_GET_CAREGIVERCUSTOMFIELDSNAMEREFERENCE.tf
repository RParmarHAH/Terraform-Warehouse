resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CAREGIVERCUSTOMFIELDSNAMEREFERENCE" {
	name ="GET_CAREGIVERCUSTOMFIELDSNAMEREFERENCE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverCustomFieldsNameReference 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.CaregiverCustomFieldsNameReference (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverFieldID, t.$3 AS CustomFieldColumn, t.$4 AS ColumnNameReference, t.$5 AS ColumnValue, t.$6 AS OfficeID, t.$7 AS SYS_CHANGE_VERSION, t.$8 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$8,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverCustomFieldsNameReference.csv.gz (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}

