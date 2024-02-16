resource "snowflake_table" "DISC_EMPEONPREFERRED_CDEPT5" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "CDEPT5"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.CDEPT5

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CC5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERRIDECHECKCALCCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WCC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OVERRIDERATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OVERRIDERATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "OVERRIDESHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OVERRIDECHECKACCTNAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USETHISADDRONCHECKS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDLTAXDATA1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CMSLABORJOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OBSOLETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUBJECTWP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PBJCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HPPDTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GL"
	type = "VARCHAR(36)"
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

