resource "snowflake_table" "DW_HAH_FACT_APPLICANT_WITH_PDR_STATUS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_APPLICANT_WITH_PDR_STATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_APPLICANT_WITH_PDR_STATUS

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CANDIDATE_ID"
	type = "NUMBER(16,0)"
	nullable = false
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TIME_ZONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP_CODE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BRANCH_GROUP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH_STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HOME_PHONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ALAYACARE_GROUP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_COST_CENTER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "POSITION_JOB"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ALAYACARE_ADMIN_ROLE_ID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ALAYACARE_FIELD_ROLE_PORTAL_ID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HAH_OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "NEWLY_CREATED_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "RHAPSODY_DATE_UPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

