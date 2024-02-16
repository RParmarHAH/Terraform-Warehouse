resource "snowflake_procedure" "DISC_JAZZHR_LOAD_JAZZHR_APPLICANTS" {
	name ="LOAD_JAZZHR_APPLICANTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
	COPY INTO JAZZHR.HIST_APPLICANTS FROM (
		select DISTINCT REPLACE(j.$1:id,''\\\\\\"'') AS ID,REPLACE(j.$1:first_name,''\\\\\\"'') AS FIRST_NAME,REPLACE(j.$1:last_name,''\\\\\\"'') AS LAST_NAME,REPLACE(j.$1:prospect_phone,''\\\\\\"'') AS PROSPECT_PHONE,REPLACE(j.$1:apply_date::Date,''\\\\\\"'') AS APPLY_DATE,REPLACE(j.$1:job_id,''\\\\\\"'') AS JOB_ID,REPLACE(j.$1:job_title,''\\\\\\"'') AS JOB_TITLE,333381 AS ETL_TASK_KEY,333381 AS ETL_INSERTED_TASK_KEY,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,CURRENT_USER as ETL_INSERTED_BY ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,CURRENT_USER as ETL_LAST_UPDATED_BY,0 as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/JazzHR/WeeklyFiles/applicants(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.MY_JSON_FORMAT) j
	);
END;

 EOT
}

