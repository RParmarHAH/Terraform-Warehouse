CREATE OR REPLACE PROCEDURE DISC_PROD.TRUSTPOINTDATA.GET_PAYROLL_DETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--TARGETSQL
INSERT  INTO DISC_PROD.TRUSTPOINTDATA.HIST_PAYROLL_DETAILS 
SELECT 1 as ID,*,
	NULL AS ADDED_DATE_UTC ,
	NULL AS ADDED_FILENAME,
	NULL AS UPDATED_DATE_UTC,
	NULL AS UPDATED_FILENAME,
	NULL AS SYS_CHANGE_VERSION,
	NULL AS SYS_CHANGE_OPERATION,
	:TaskKey AS ETL_TASK_KEY,
	:TaskKey AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
	 FROM (
	SELECT ''ALTRUS'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Altrus.*Detail.*[.]csv'')wm
	UNION
	SELECT ''COASTAL'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Coastal.*Detail.*[.]csv'')wm
	UNION
	SELECT ''E3'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*E3.*Detail.*[.]csv'')wm
	UNION
	SELECT ''EXCEL'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Excel.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIMEHHA'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format => DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Prime.*HHA.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIME'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Prime.*Home.*Care.*Detail.*[.]csv'')wm
	UNION
	SELECT ''PRIMEMIDWAY'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Midway.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''ANSWERCARE'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*AnswerCare.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''HAHMI'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*HAHMI.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''HAHDELAWARE'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*HAH.*DELAWARE.*Detail.*[.]csv'')wm
	UNION 
	SELECT ''CARECOORDINATION'' AS COMPANY, wm.$1 as "Record Type" ,wm.$2 as "E/D/T Code" ,TRY_TO_DATE(wm.$3, ''MM/DD/YYYY'') as PAYROLL_DATE ,wm.$4 as EMPLOYEE_ID ,wm.$5 as BRANCH_NAME ,wm.$6 as SYSTEM_CODE ,TRY_TO_DATE(wm.$7, ''MM/DD/YYYY'') as PAY_PERIOD_START_DATE ,TRY_TO_DATE(wm.$8, ''MM/DD/YYYY'') as PAY_PERIOD_END_DATE ,wm.$9 as CHECK_NUMBER ,wm.$10 as PAY_CODE ,regexp_replace(wm.$11,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_HOURS ,regexp_replace(wm.$12,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_RATE ,regexp_replace(wm.$13,''\\\\(|\\\\)|\\\\$|\\\\|\\\\)|\\\\,'','''') as PAY_AMOUNT FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/TRUSTPOINT_SFTP_LOAD(file_format =>DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE_Mitul,PATTERN => ''.*Care.*Coordination.*Detail.*[.]csv'')wm
	);
-- VIEWSQL
CREATE OR REPLACE TABLE DISC_PROD.TRUSTPOINTDATA.Payroll_Details as WITH curr_v AS ( 
  SELECT COMPANY, RECORD_TYPE, PAYROLL_DATE, CHECK_NUMBER, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE   
  FROM DISC_PROD.TRUSTPOINTDATA.HIST_Payroll_Details GROUP BY COMPANY, RECORD_TYPE, PAYROLL_DATE, CHECK_NUMBER, PAY_CODE)  
  SELECT t.* FROM DISC_PROD.TRUSTPOINTDATA.HIST_Payroll_Details t   INNER JOIN curr_v v ON t.COMPANY = v.COMPANY   
  AND t.RECORD_TYPE = v.RECORD_TYPE AND t.PAYROLL_DATE = v.PAYROLL_DATE   AND t.CHECK_NUMBER = v.CHECK_NUMBER AND t.PAY_CODE = v.PAY_CODE  
  AND t.ETL_DELETED_FLAG = FALSE   AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
END;
';