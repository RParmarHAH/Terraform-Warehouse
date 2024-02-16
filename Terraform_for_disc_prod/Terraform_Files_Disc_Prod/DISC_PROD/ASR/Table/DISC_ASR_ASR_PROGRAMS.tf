resource "snowflake_table" "DISC_ASR_ASR_PROGRAMS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_PROGRAMS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_PROGRAMS

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PROGRAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTPAYRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTPAYFEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTNEXTREVIEWPERIODDAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSKILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLABLERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

