resource "snowflake_table" "DISC_BI_REPOSITORY_ALAUTHENTICARECONTRACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "ALAUTHENTICARECONTRACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.ALAUTHENTICARECONTRACTS

    -- Purpose : Discovery Data Population

    -- Project : BI_REPOSITORY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICECODE"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "AAA"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SERVICENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DFCONTRACT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DFSERVICECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FUNDINGCODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "PROCEDURECODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MODIFIER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "UNITHOURRATIO"
	type = "NUMBER(18,5)"
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

