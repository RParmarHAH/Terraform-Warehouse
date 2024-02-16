resource "snowflake_table" "DISC_STAGE_COASTAL_OFFICE_MAPPING_PAYROLL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "COASTAL_OFFICE_MAPPING_PAYROLL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.COASTAL_OFFICE_MAPPING_PAYROLL

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(7)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

