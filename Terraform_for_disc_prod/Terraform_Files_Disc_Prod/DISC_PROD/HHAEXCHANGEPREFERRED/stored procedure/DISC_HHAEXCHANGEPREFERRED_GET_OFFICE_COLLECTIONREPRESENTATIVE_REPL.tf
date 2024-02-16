resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_OFFICE_COLLECTIONREPRESENTATIVE_REPL" {
	name ="GET_OFFICE_COLLECTIONREPRESENTATIVE_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_Office_CollectionRepresentative_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.Office_CollectionRepresentative_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS CollectionRepID, t.$3 AS CollectionRepName, t.$4 AS Active, t.$5 AS CreatedDate, t.$6 AS LastUpdatedDate, t.$7 AS CreatedBy, t.$8 AS LastUpdatedBy, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_Office_CollectionRepresentative_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

