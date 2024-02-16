resource "snowflake_procedure" "DISC_HAHUSERS_GET_LOGIN_OFFICE" {
	name ="GET_LOGIN_OFFICE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAHUSERS"
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HAHUsers.Login_Office (SELECT t.$1 AS OfficeID, t.$2 AS OfficeName, t.$3 AS OfficeNumber, t.$4 AS OfficeLocation, t.$5 AS OfficeManager, t.$6 AS Address, t.$7 AS City, t.$8 AS State, t.$9 AS Zip, t.$10 AS Phone, t.$11 AS Tollfree, t.$12 AS Fax, t.$13 AS Email, t.$14 AS Status, t.$15 AS Memo, t.$16 AS Company, t.$17 AS UserCreated, t.$18 AS DateCreated, t.$19 AS UserUpdated, t.$20 AS DateUpdated, t.$21 AS PayrollName, t.$22 AS GP_DB, t.$23 AS IPRangeStart, t.$24 AS IPRangeEnd, t.$25 AS Address2,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/HAHUSERS/ (PATTERN => ''.*HAHUsers_dbo_Login_Office.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    return ''Success'';
END;

 EOT
}

