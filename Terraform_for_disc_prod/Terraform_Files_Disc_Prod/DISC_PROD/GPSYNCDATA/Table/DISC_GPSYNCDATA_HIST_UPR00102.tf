resource "snowflake_table" "DISC_GPSYNCDATA_HIST_UPR00102" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_UPR00102"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_UPR00102

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ADDRESS1"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ADDRESS3"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ADRSCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "FOREIGN_ADDRESS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FOREIGN_POSTAL_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FOREIGN_STATEPROVINCE"
	type = "VARCHAR(23)"
	nullable = true
}


column {
	name = "PHONE1"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(29)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(11)"
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

