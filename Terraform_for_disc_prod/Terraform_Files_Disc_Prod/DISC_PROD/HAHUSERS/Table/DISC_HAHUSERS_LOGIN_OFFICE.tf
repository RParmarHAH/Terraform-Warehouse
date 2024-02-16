resource "snowflake_table" "DISC_HAHUSERS_LOGIN_OFFICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAHUSERS"
	name = "LOGIN_OFFICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAHUSERS.LOGIN_OFFICE

    -- Purpose : Discovery Data Population

    -- Project : HAHUSERS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICELOCATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICEMANAGER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOLLFREE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USERCREATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATECREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USERUPDATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATEUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYROLLNAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "GP_DB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IPRANGESTART"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IPRANGEEND"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

