resource "snowflake_procedure" "DISC_PUBLIC_HIST_STVHC_T_AUTHORIZATIONDATES" {
	name ="HIST_STVHC_T_AUTHORIZATIONDATES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN

COPY INTO DISC_${var.SF_ENVIRONMENT}.PUBLIC.HIST_STVHC_T_AuthorizationDates FROM (SELECT t.$1 AS authdt_AdmissionID, t.$2 AS authdt_PayerID, t.$3 AS authdt_ServiceCodeID, t.$4 AS authdt_BeginDate, t.$5 AS authdt_EndDate, t.$6 AS authdt_UnitFlag, t.$7 AS authdt_FreqType, t.$8 AS authdt_DetailID, t.$9 AS authdt_MaxUnits, t.$10 AS authdt_ID, t.$11 AS InsertDate, t.$12 AS UpdateDate, t.$13 AS DeletedFlag, t.$14 AS SYS_CHANGE_VERSION, CASE WHEN t.$13 = True THEN ''D'' WHEN t.$11 = t.$12 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, 1 AS ETL_TASK_KEY, 1 AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$13, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AzStageProd/TEST_STAGE/ (PATTERN = ''.*BIDW_17523_AdaptiveNursing_STVHC_T_AuthorizationDates.*[.]csv.gz'',FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT) t) ;

END;

 EOT
}

