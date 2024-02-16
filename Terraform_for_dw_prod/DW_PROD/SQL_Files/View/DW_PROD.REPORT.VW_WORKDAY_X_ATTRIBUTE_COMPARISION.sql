create or replace view DW_PROD.REPORT.VW_WORKDAY_X_ATTRIBUTE_COMPARISION(
	EMPLOYEE_ENTERPRISE_ID,
	ROW_IS_MATCH,
	EMPLOYEE_ID_AMS,
	EMPLOYEE_ID_WD,
	EMPLOYEE_ID_PAY,
	PRIMARY_BRANCH_STATE_AMS,
	SOURCE_CODE_AMS,
	PRIMARY_BRANCH_NAME_AMS,
	PRIMARY_BRANCH_NAME_WD,
	PRIMARY_BRANCH_NAME_PAY,
	PRIMARY_BRANCH_NAME_IS_MATCH_AMS_WD,
	PRIMARY_BRANCH_NAME_IS_MATCH_PAY_WD,
	PRIMARY_BRANCH_NAME_IS_MATCH_FULL,
	EMPLOYEE_FIRST_NAME_AMS,
	EMPLOYEE_FIRST_NAME_WD,
	EMPLOYEE_FIRST_NAME_PAY,
	EMPLOYEE_FIRST_NAME_IS_MATCH_AMS_WD,
	EMPLOYEE_FIRST_NAME_IS_MATCH_PAY_WD,
	EMPLOYEE_FIRST_NAME_IS_MATCH_FULL,
	EMPLOYEE_LAST_NAME_AMS,
	EMPLOYEE_LAST_NAME_WD,
	EMPLOYEE_LAST_NAME_PAY,
	EMPLOYEE_LAST_NAME_IS_MATCH_AMS_WD,
	EMPLOYEE_LAST_NAME_IS_MATCH_PAY_WD,
	EMPLOYEE_LAST_NAME_IS_MATCH_FULL,
	EMPLOYEE_WORK_EMAIL_AMS,
	EMPLOYEE_WORK_EMAIL_WD,
	EMPLOYEE_WORK_EMAIL_PAY,
	EMPLOYEE_WORK_EMAIL_IS_MATCH_AMS_WD,
	EMPLOYEE_WORK_EMAIL_IS_MATCH_PAY_WD,
	EMPLOYEE_WORK_EMAIL_IS_MATCH_FULL,
	EMPLOYEE_PERSONAL_EMAIL_AMS,
	EMPLOYEE_PERSONAL_EMAIL_WD,
	EMPLOYEE_PERSONAL_EMAIL_PAY,
	EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_AMS_WD,
	EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_PAY_WD,
	EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_FULL,
	EMPLOYEE_CELL_PHONE_AMS,
	EMPLOYEE_CELL_PHONE_WD,
	EMPLOYEE_CELL_PHONE_PAY,
	EMPLOYEE_CELL_PHONE_IS_MATCH_AMS_WD,
	EMPLOYEE_CELL_PHONE_IS_MATCH_PAY_WD,
	EMPLOYEE_CELL_PHONE_IS_MATCH_FULL,
	EMPLOYEE_HOME_PHONE_AMS,
	EMPLOYEE_HOME_PHONE_WD,
	EMPLOYEE_HOME_PHONE_PAY,
	EMPLOYEE_HOME_PHONE_IS_MATCH_AMS_WD,
	EMPLOYEE_HOME_PHONE_IS_MATCH_PAY_WD,
	EMPLOYEE_HOME_PHONE_IS_MATCH_FULL,
	EMPLOYEE_WORK_PHONE_AMS,
	EMPLOYEE_WORK_PHONE_WD,
	EMPLOYEE_WORK_PHONE_PAY,
	EMPLOYEE_WORK_PHONE_IS_MATCH_AMS_WD,
	EMPLOYEE_WORK_PHONE_IS_MATCH_PAY_WD,
	EMPLOYEE_WORK_PHONE_IS_MATCH_FULL,
	EMPLOYEE_ADDRESS1_AMS,
	EMPLOYEE_ADDRESS1_WD,
	EMPLOYEE_ADDRESS1_PAY,
	EMPLOYEE_ADDRESS1_IS_MATCH_AMS_WD,
	EMPLOYEE_ADDRESS1_IS_MATCH_PAY_WD,
	EMPLOYEE_ADDRESS1_IS_MATCH_FULL,
	EMPLOYEE_ADDRESS2_AMS,
	EMPLOYEE_ADDRESS2_WD,
	EMPLOYEE_ADDRESS2_PAY,
	EMPLOYEE_ADDRESS2_IS_MATCH_AMS_WD,
	EMPLOYEE_ADDRESS2_IS_MATCH_PAY_WD,
	EMPLOYEE_ADDRESS2_IS_MATCH_FULL,
	EMPLOYEE_CITY_AMS,
	EMPLOYEE_CITY_WD,
	EMPLOYEE_CITY_PAY,
	EMPLOYEE_CITY_IS_MATCH_AMS_WD,
	EMPLOYEE_CITY_IS_MATCH_PAY_WD,
	EMPLOYEE_CITY_IS_MATCH_FULL,
	EMPLOYEE_STATE_CODE_AMS,
	EMPLOYEE_STATE_CODE_WD,
	EMPLOYEE_STATE_CODE_PAY,
	EMPLOYEE_STATE_CODE_IS_MATCH_AMS_WD,
	EMPLOYEE_STATE_CODE_IS_MATCH_PAY_WD,
	EMPLOYEE_STATE_CODE_IS_MATCH_FULL,
	EMPLOYEE_ZIP_AMS,
	EMPLOYEE_ZIP_WD,
	EMPLOYEE_ZIP_PAY,
	EMPLOYEE_ZIP_IS_MATCH_AMS_WD,
	EMPLOYEE_ZIP_IS_MATCH_PAY_WD,
	EMPLOYEE_ZIP_IS_MATCH_FULL,
	EMPLOYEE_HIRE_DATE_AMS,
	EMPLOYEE_HIRE_DATE_WD,
	EMPLOYEE_HIRE_DATE_PAY,
	EMPLOYEE_HIRE_DATE_IS_MATCH_AMS_WD,
	EMPLOYEE_HIRE_DATE_IS_MATCH_PAY_WD,
	EMPLOYEE_HIRE_DATE_IS_MATCH_FULL,
	EMPLOYEE_DOB_AMS,
	EMPLOYEE_DOB_WD,
	EMPLOYEE_DOB_PAY,
	EMPLOYEE_DOB_IS_MATCH_AMS_WD,
	EMPLOYEE_DOB_IS_MATCH_PAY_WD,
	EMPLOYEE_DOB_IS_MATCH_FULL,
	EMPLOYEE_GENDER_AMS,
	EMPLOYEE_GENDER_WD,
	EMPLOYEE_GENDER_PAY,
	EMPLOYEE_GENDER_IS_MATCH_AMS_WD,
	EMPLOYEE_GENDER_IS_MATCH_PAY_WD,
	EMPLOYEE_GENDER_IS_MATCH_FULL,
	EMPLOYEE_PID_AMS,
	EMPLOYEE_PID_WD,
	EMPLOYEE_PID_PAY,
	EMPLOYEE_PID_IS_MATCH_AMS_WD,
	EMPLOYEE_PID_IS_MATCH_PAY_WD,
	EMPLOYEE_PID_IS_MATCH_FULL,
	EMPLOYEE_TERMINATE_DATE_AMS,
	EMPLOYEE_TERMINATE_DATE_WD,
	EMPLOYEE_TERMINATE_DATE_PAY,
	EMPLOYEE_TERMINATE_DATE_IS_MATCH_AMS_WD,
	EMPLOYEE_TERMINATE_DATE_IS_MATCH_PAY_WD,
	EMPLOYEE_TERMINATE_DATE_IS_MATCH_FULL,
	EMPLOYEE_CATEGORY_WD
) as
 select
 EMPLOYEE_ENTERPRISE_ID,
ROW_IS_MATCH,
EMPLOYEE_ID_AMS,
EMPLOYEE_ID_WD,
EMPLOYEE_ID_PAY,
PRIMARY_BRANCH_STATE_AMS,
system_code_AMS as SOURCE_CODE_AMS,
PRIMARY_BRANCH_NAME_AMS,
PRIMARY_BRANCH_NAME_WD,
PRIMARY_BRANCH_NAME_PAY,
PRIMARY_BRANCH_NAME_IS_MATCH_AMS_WD,
PRIMARY_BRANCH_NAME_IS_MATCH_PAY_WD,
PRIMARY_BRANCH_NAME_IS_MATCH_FULL,
EMPLOYEE_FIRST_NAME_AMS,
EMPLOYEE_FIRST_NAME_WD,
EMPLOYEE_FIRST_NAME_PAY,
EMPLOYEE_FIRST_NAME_IS_MATCH_AMS_WD,
EMPLOYEE_FIRST_NAME_IS_MATCH_PAY_WD,
EMPLOYEE_FIRST_NAME_IS_MATCH_FULL,
EMPLOYEE_LAST_NAME_AMS,
EMPLOYEE_LAST_NAME_WD,
EMPLOYEE_LAST_NAME_PAY,
EMPLOYEE_LAST_NAME_IS_MATCH_AMS_WD,
EMPLOYEE_LAST_NAME_IS_MATCH_PAY_WD,
EMPLOYEE_LAST_NAME_IS_MATCH_FULL,
EMPLOYEE_WORK_EMAIL_AMS,
EMPLOYEE_WORK_EMAIL_WD,
EMPLOYEE_WORK_EMAIL_PAY,
EMPLOYEE_WORK_EMAIL_IS_MATCH_AMS_WD,
EMPLOYEE_WORK_EMAIL_IS_MATCH_PAY_WD,
EMPLOYEE_WORK_EMAIL_IS_MATCH_FULL,
EMPLOYEE_PERSONAL_EMAIL_AMS,
EMPLOYEE_PERSONAL_EMAIL_WD,
EMPLOYEE_PERSONAL_EMAIL_PAY,
EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_AMS_WD,
EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_PAY_WD,
EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_FULL,
EMPLOYEE_CELL_PHONE_AMS,
EMPLOYEE_CELL_PHONE_WD,
EMPLOYEE_CELL_PHONE_PAY,
EMPLOYEE_CELL_PHONE_IS_MATCH_AMS_WD,
EMPLOYEE_CELL_PHONE_IS_MATCH_PAY_WD,
EMPLOYEE_CELL_PHONE_IS_MATCH_FULL,
EMPLOYEE_HOME_PHONE_AMS,
EMPLOYEE_HOME_PHONE_WD,
EMPLOYEE_HOME_PHONE_PAY,
EMPLOYEE_HOME_PHONE_IS_MATCH_AMS_WD,
EMPLOYEE_HOME_PHONE_IS_MATCH_PAY_WD,
EMPLOYEE_HOME_PHONE_IS_MATCH_FULL,
EMPLOYEE_WORK_PHONE_AMS,
EMPLOYEE_WORK_PHONE_WD,
EMPLOYEE_WORK_PHONE_PAY,
EMPLOYEE_WORK_PHONE_IS_MATCH_AMS_WD,
EMPLOYEE_WORK_PHONE_IS_MATCH_PAY_WD,
EMPLOYEE_WORK_PHONE_IS_MATCH_FULL,
EMPLOYEE_ADDRESS1_AMS,
EMPLOYEE_ADDRESS1_WD,
EMPLOYEE_ADDRESS1_PAY,
EMPLOYEE_ADDRESS1_IS_MATCH_AMS_WD,
EMPLOYEE_ADDRESS1_IS_MATCH_PAY_WD,
EMPLOYEE_ADDRESS1_IS_MATCH_FULL,
EMPLOYEE_ADDRESS2_AMS,
EMPLOYEE_ADDRESS2_WD,
EMPLOYEE_ADDRESS2_PAY,
EMPLOYEE_ADDRESS2_IS_MATCH_AMS_WD,
EMPLOYEE_ADDRESS2_IS_MATCH_PAY_WD,
EMPLOYEE_ADDRESS2_IS_MATCH_FULL,
EMPLOYEE_CITY_AMS,
EMPLOYEE_CITY_WD,
EMPLOYEE_CITY_PAY,
EMPLOYEE_CITY_IS_MATCH_AMS_WD,
EMPLOYEE_CITY_IS_MATCH_PAY_WD,
EMPLOYEE_CITY_IS_MATCH_FULL,
EMPLOYEE_STATE_CODE_AMS,
EMPLOYEE_STATE_CODE_WD,
EMPLOYEE_STATE_CODE_PAY,
EMPLOYEE_STATE_CODE_IS_MATCH_AMS_WD,
EMPLOYEE_STATE_CODE_IS_MATCH_PAY_WD,
EMPLOYEE_STATE_CODE_IS_MATCH_FULL,
EMPLOYEE_ZIP_AMS,
EMPLOYEE_ZIP_WD,
EMPLOYEE_ZIP_PAY,
EMPLOYEE_ZIP_IS_MATCH_AMS_WD,
EMPLOYEE_ZIP_IS_MATCH_PAY_WD,
EMPLOYEE_ZIP_IS_MATCH_FULL,
EMPLOYEE_HIRE_DATE_AMS,
EMPLOYEE_HIRE_DATE_WD,
EMPLOYEE_HIRE_DATE_PAY,
EMPLOYEE_HIRE_DATE_IS_MATCH_AMS_WD,
EMPLOYEE_HIRE_DATE_IS_MATCH_PAY_WD,
EMPLOYEE_HIRE_DATE_IS_MATCH_FULL,
EMPLOYEE_DOB_AMS,
EMPLOYEE_DOB_WD,
EMPLOYEE_DOB_PAY,
EMPLOYEE_DOB_IS_MATCH_AMS_WD,
EMPLOYEE_DOB_IS_MATCH_PAY_WD,
EMPLOYEE_DOB_IS_MATCH_FULL,
EMPLOYEE_GENDER_AMS,
EMPLOYEE_GENDER_WD,
EMPLOYEE_GENDER_PAY,
EMPLOYEE_GENDER_IS_MATCH_AMS_WD,
EMPLOYEE_GENDER_IS_MATCH_PAY_WD,
EMPLOYEE_GENDER_IS_MATCH_FULL,
EMPLOYEE_PID_AMS,
EMPLOYEE_PID_WD,
EMPLOYEE_PID_PAY,
EMPLOYEE_PID_IS_MATCH_AMS_WD,
EMPLOYEE_PID_IS_MATCH_PAY_WD,
EMPLOYEE_PID_IS_MATCH_FULL,
EMPLOYEE_TERMINATE_DATE_AMS,
EMPLOYEE_TERMINATE_DATE_WD,
EMPLOYEE_TERMINATE_DATE_PAY,
EMPLOYEE_TERMINATE_DATE_IS_MATCH_AMS_WD,
EMPLOYEE_TERMINATE_DATE_IS_MATCH_PAY_WD,
EMPLOYEE_TERMINATE_DATE_IS_MATCH_FULL,
EMPLOYEE_CATEGORY_WD

 FROM DW_PROD.INTEGRATION.WORKDAY_X_ATTRIBUTE_COMPARISION;