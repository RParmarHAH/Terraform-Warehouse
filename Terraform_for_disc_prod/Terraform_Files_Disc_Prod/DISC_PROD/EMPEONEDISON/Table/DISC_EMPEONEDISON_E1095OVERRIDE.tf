resource "snowflake_table" "DISC_EMPEONEDISON_E1095OVERRIDE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "E1095OVERRIDE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.E1095OVERRIDE

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "E1095OVERRIDEID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "YEAR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS6"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS7"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS8"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS9"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS10"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS11"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS12"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OFFER1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER3"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER4"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER5"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER6"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER7"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER8"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER9"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER10"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER11"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFER12"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CONTRIBUTION1"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION2"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION3"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION4"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION5"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION6"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION7"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION8"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION9"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION10"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION11"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRIBUTION12"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RELIEF1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF3"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF4"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF5"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF6"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF7"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF8"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF9"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF10"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF11"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELIEF12"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
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

