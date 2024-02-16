create or replace view DISC_PROD.TRUSTPOINTDATA.PAYROLL_LOAD(
	ID,
	COMPANY,
	PAYROLL_DATE,
	EMPLOYEE_ID,
	BRANCH_NAME,
	SYSTEM_CODE,
	PAY_PERIOD_START_DATE,
	PAY_PERIOD_END_DATE,
	CHECK_NUMBER,
	PAY_HOURS,
	SERVICE_HOURS,
	OVERTIME_HOURS,
	NON_SERVICE_UNITS,
	SICK_HOURS,
	VACATION_HOURS,
	PAY_RATE,
	OVERTIME_RATE,
	GROSS_PAY_AMOUNT,
	SERVICE_PAY_AMOUNT,
	OVERTIME_PAY_AMOUNT,
	NON_SERVICE_PAY_AMOUNT,
	TAX_AMOUNT,
	NET_PAY_AMOUNT,
	OTHER_DEDUCTIONS_AMOUNT,
	UNION_DUES_AMOUNT,
	REIMBURSEMENT_AMOUNT,
	ADDED_DATE_UTC,
	ADDED_FILENAME,
	UPDATED_DATE_UTC,
	UPDATED_FILENAME,
	SYS_CHANGE_VERSION,
	SYS_CHANGE_OPERATION,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG
) as 
SELECT 1 as ID, 
COMPANY,
PAYROLL_DATE,
EMPLOYEE_ID,
BRANCH_NAME,
SYSTEM_CODE,
PAY_PERIOD_START_DATE,
PAY_PERIOD_END_DATE,
CHECK_NUMBER,
PAY_HOURS::number PAY_HOURS,
SERVICE_HOURS::number SERVICE_HOURS,
OVERTIME_HOURS::number OVERTIME_HOURS,
NON_SERVICE_UNITS::number NON_SERVICE_UNITS,
SICK_HOURS,
VACATION_HOURS::number VACATION_HOURS,
PAY_RATE,
OVERTIME_RATE::number OVERTIME_RATE,
GROSS_PAY_AMOUNT::number GROSS_PAY_AMOUNT,
REPLACE(SERVICE_PAY_AMOUNT, '\'', '')::NUMBER(10, 2) SERVICE_PAY_AMOUNT,
REPLACE(OVERTIME_PAY_AMOUNT, '\'', '')::NUMBER(10, 2) OVERTIME_PAY_AMOUNT,  
REPLACE(NON_SERVICE_PAY_AMOUNT, '\'', '')::NUMBER(10, 2) NON_SERVICE_PAY_AMOUNT,
REPLACE(TAX_AMOUNT, '\'', '')::NUMBER(10, 2) TAX_AMOUNT,
REPLACE(NET_PAY_AMOUNT, '\'', '')::NUMBER(10, 2) NET_PAY_AMOUNT,
REPLACE(OTHER_DEDUCTIONS_AMOUNT, '\'', '')::NUMBER(10, 2) OTHER_DEDUCTIONS_AMOUNT,
REPLACE(UNION_DUES_AMOUNT, '\'', '')::NUMBER(10, 2) UNION_DUES_AMOUNT,
REPLACE(REIMBURSEMENT_AMOUNT, '\'', '')::NUMBER(10, 2)  REIMBURSEMENT_AMOUNT,
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
FROM  (
SELECT 'ALTRUS' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Altrus.*[.]csv')wm
UNION
SELECT 'COASTAL' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Coastal.*[.]csv')wm
UNION
SELECT 'E3' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*E3.*[.]csv')wm
UNION
SELECT 'EXCEL' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Excel.*[.]csv')wm
UNION
SELECT 'PRIMEHHA' AS COMPANY, TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Prime HHA.*[.]csv')wm
UNION
SELECT 'PRIME' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Prime Home Care.*[.]csv')wm
UNION
SELECT 'PRIMEMIDWAY' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*Midway.*[.]csv')wm
UNION 
SELECT 'ANSWERCARE' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*AnswerCare.*[.]csv')wm
UNION 
SELECT 'HAHMI' AS COMPANY,TRY_TO_DATE(wm.$1, 'MM/DD/YYYY')	as	PAYROLL_DATE	,wm.$2	as	EMPLOYEE_ID	,wm.$3	as	BRANCH_NAME	,wm.$4	as	SYSTEM_CODE	,TRY_TO_DATE(wm.$5, 'MM/DD/YYYY')	as	PAY_PERIOD_START_DATE	,TRY_TO_DATE(wm.$6, 'MM/DD/YYYY')	as	PAY_PERIOD_END_DATE	,wm.$7	as	CHECK_NUMBER	,wm.$8	as	PAY_HOURS	,wm.$9	as	SERVICE_HOURS	,wm.$10	as	OVERTIME_HOURS	,wm.$11	as	NON_SERVICE_UNITS	,wm.$12	as	SICK_HOURS	,wm.$13	as	VACATION_HOURS	,regexp_replace(wm.$14,'\\(|\\)|\\$|\\|\\)|\\,','')	as	PAY_RATE	,regexp_replace(wm.$15,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_RATE	,regexp_replace(wm.$16,'\\(|\\)|\\$|\\|\\)|\\,','')	as	GROSS_PAY_AMOUNT	,regexp_replace(wm.$17,'\\(|\\)|\\$|\\|\\)|\\,','')	as	SERVICE_PAY_AMOUNT	,regexp_replace(wm.$18,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OVERTIME_PAY_AMOUNT	,regexp_replace(wm.$19,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NON_SERVICE_PAY_AMOUNT	,regexp_replace(wm.$20,'\\(|\\)|\\$|\\|\\)|\\,','')	as	TAX_AMOUNT	,regexp_replace(wm.$21,'\\(|\\)|\\$|\\|\\)|\\,','')	as	NET_PAY_AMOUNT	,regexp_replace(wm.$22,'\\(|\\)|\\$|\\|\\)|\\,','')	as	OTHER_DEDUCTIONS_AMOUNT	,regexp_replace(wm.$23,'\\(|\\)|\\$|\\|\\)|\\,','')	as	UNION_DUES_AMOUNT	,regexp_replace(wm.$24,'\\(|\\)|\\$|\\|\\)|\\,','')	as	REIMBURSEMENT_AMOUNT FROM @DISC_PROD.STAGE.AZSTAGEPROD/TRUSTPOINT_DATA/PAYROLL_SUMMARY(file_format => DW_PROD.PUBLIC.CSV_FORMAT_TEST,PATTERN => '.*HAHMI.*[.]csv')wm
);