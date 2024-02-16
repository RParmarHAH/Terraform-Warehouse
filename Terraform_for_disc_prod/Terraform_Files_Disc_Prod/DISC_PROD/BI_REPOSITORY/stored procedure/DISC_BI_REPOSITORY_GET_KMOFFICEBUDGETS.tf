resource "snowflake_procedure" "DISC_BI_REPOSITORY_GET_KMOFFICEBUDGETS" {
	name ="GET_KMOFFICEBUDGETS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN 
    --TargetSQL
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.BI_Repository.kmOfficeBudgets (SELECT t.$1 AS DbName, t.$2 AS OfficeNumber, t.$3 AS ServiceLine, t.$4 AS Metric, t.$5 AS Month, t.$6 AS Value, t.$7 AS Source, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$9,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/BI_Repository_dbo_kmOfficeBudgets.csv.gz (FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    return ''Success'';
END;

 EOT
}

