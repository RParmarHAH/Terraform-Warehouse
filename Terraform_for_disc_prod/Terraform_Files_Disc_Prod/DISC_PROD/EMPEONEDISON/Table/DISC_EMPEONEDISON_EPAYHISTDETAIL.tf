resource "snowflake_table" "DISC_EMPEONEDISON_EPAYHISTDETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EPAYHISTDETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EPAYHISTDETAIL

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
	name = "TRANS"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "SUBTRANS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRANSTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DET"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DETCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "RATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TCODE4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BEGINDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WCC"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DIRDEPTRANSIT"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ACCOUNT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AGENCYPROCESS"
	type = "NUMBER(10,0)"
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
	name = "CO"
	type = "VARCHAR(10)"
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

