resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_PAYROLL_DETAILS_LOAD" {
	name ="PAYROLL_DETAILS_LOAD"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


INSERT  INTO DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_PAYROLL_DETAILS 

SELECT 1 as ID,*,
	NULL AS ADDED_DATE_UTC ,
	NULL AS ADDED_FILENAME,
	NULL AS UPDATED_DATE_UTC,
	NULL AS UPDATED_FILENAME,
	NULL AS SYS_CHANGE_VERSION,
	NULL AS SYS_CHANGE_OPERATION,
	-1 AS ETL_TASK_KEY,
	-1 AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
	 FROM (
	SELECT ''ALTRUS'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Altrus.*Detail.*[.]csv'')wm
	UNION
	SELECT ''COASTAL'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Coastal.*Detail.*[.]csv'')wm
	UNION
	SELECT ''E3'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*E3.*Detail.*[.]csv'')wm
	UNION
	SELECT ''EXCEL'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Excel.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIMEHHA'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Prime.*HHA.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIME'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Prime.*Home.*Care.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIMEMIDWAY'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Midway.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''ANSWERCARE'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*AnswerCare.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''HAHMI'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*HAHMI.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''HAHDELAWARE'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*HAH.*DELAWARE.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''CARECOORDINATION'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TRUSTPOINT,PATTERN => ''.*Care.*Coordination.*Detail.*[.]csv'')wm
	);

 EOT
}

