resource "snowflake_table" "DISC_VIVENTIUM_EXPORTCHECKS_UNFLATTEN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "EXPORTCHECKS_UNFLATTEN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.EXPORTCHECKS_UNFLATTEN

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "RUNNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERIODBEGINDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIODENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYMETHOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VOUCHERNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHECKORVOUCHERNUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TOTALWORKEDHOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALGROSS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALDEDUCTIONS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALTAXES"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NETCHECKAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NETDIRECTDEPOSITAMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTALNET"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TAXES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EARNINGS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "DEDUCTIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "COSTCENTERS"
	type = "VARIANT"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

