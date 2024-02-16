resource "snowflake_table" "DW_PUBLIC_WORKDAY_PAYROLL_MISMATCH_TEST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "WORKDAY_PAYROLL_MISMATCH_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.WORKDAY_PAYROLL_MISMATCH_TEST

    -- Purpose : 

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OLD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WORKER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERIODSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIODENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURSWORKED2"
	type = "NUMBER(38,3)"
	nullable = true
}

}

