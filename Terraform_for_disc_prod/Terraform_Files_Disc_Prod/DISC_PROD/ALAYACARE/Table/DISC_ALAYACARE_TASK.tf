resource "snowflake_table" "DISC_ALAYACARE_TASK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "TASK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.TASK

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TASK_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATE_USER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATE_USER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DUE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OVERDUE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILLABLE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FORM_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_FULLTEXT_INDEX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_DUE_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_SOURCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_ASSIGNED_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_PRIORITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TASK_PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}

}

