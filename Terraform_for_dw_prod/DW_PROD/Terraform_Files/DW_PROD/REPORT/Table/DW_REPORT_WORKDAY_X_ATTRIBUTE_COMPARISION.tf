resource "snowflake_table" "DW_REPORT_WORKDAY_X_ATTRIBUTE_COMPARISION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "WORKDAY_X_ATTRIBUTE_COMPARISION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.WORKDAY_X_ATTRIBUTE_COMPARISION

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ROW_IS_MATCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_CODE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_EMAIL_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_WORK_PHONE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_PID_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_AMS"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_WD"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_AMS_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_PAY_WD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE_IS_MATCH_FULL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY_WD"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

