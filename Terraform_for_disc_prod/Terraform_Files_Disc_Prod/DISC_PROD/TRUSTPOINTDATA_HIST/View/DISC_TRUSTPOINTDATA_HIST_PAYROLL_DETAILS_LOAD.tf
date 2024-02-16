resource "snowflake_view" "DISC_TRUSTPOINTDATA_HIST_PAYROLL_DETAILS_LOAD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA_HIST"
	name = "PAYROLL_DETAILS_LOAD"
	statement = <<-SQL
	 
SELECT 1 as ID,*,
NULL AS ADDED_DATE_UTC	,
NULL AS ADDED_FILENAME,
NULL AS UPDATED_DATE_UTC,
NULL AS UPDATED_FILENAME,
NULL AS SYS_CHANGE_VERSION,
NULL AS SYS_CHANGE_OPERATION,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,
convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY,
convert_timezone('UTC', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,
0 as ETL_DELETED_FLAG
 FROM (
SELECT 'ALTRUS' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT	FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Altrus.*[.]csv')wm
UNION
SELECT 'COASTAL' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Coastal.*[.]csv')wm
UNION
SELECT 'E3' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*E3.*[.]csv')wm
UNION
SELECT 'EXCEL' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Excel.*[.]csv')wm
UNION
SELECT 'PRIMEHHA' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Prime HHA.*[.]csv')wm
UNION
SELECT 'PRIME' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Prime Home Care.*[.]csv')wm
UNION
SELECT 'PRIMEMIDWAY' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Midway.*[.]csv')wm
UNION 
SELECT 'ANSWERCARE' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*AnswerCare.*[.]csv')wm
UNION 
SELECT 'HAHMI' AS COMPANY, wm.$1	as	"Record Type"	,wm.$2	as	"E/D/T Code"	,TRY_TO_DATE(wm.$3, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$4	as	EMPLOYEE_ID	,wm.$5	as	BRANCH_NAME	,wm.$6	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$7, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$8, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$9	as	CHECK_NUMBER	,wm.$10	as	PAY_CODE	,regexp_replace(wm.$11,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_HOURS	,regexp_replace(wm.$12,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$13,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_AMOUNT FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_DETAILS(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*HAHMI.*[.]csv')wm

) ;
SQL
	or_replace = true 
	is_secure = false 
}

