resource "snowflake_table" "DISC_COSTALSYNCDATA_GPALLPAYCHECKDETAILSBASE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "GPALLPAYCHECKDETAILSBASE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DB"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "AUDITTRAILNUMBER"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYCODETYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAYCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "JOBTITLECODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYPERIODBEGINDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYPERIODENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STATECODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SUTASTATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "EMPLOYEECLASS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "GPROWID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
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

