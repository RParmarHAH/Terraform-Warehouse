resource "snowflake_table" "DISC_SANDATAEXCHANGE_HIST_OPENSAM_CLIENTADMISSIONTYPES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAEXCHANGE"
	name = "HIST_OPENSAM_CLIENTADMISSIONTYPES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAEXCHANGE.HIST_OPENSAM_CLIENTADMISSIONTYPES

    -- Purpose : Discovery Data Population

    -- Project : SANDATAEXCHANGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "HAHDFDB"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "ADMISSIONTYPEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYORNAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "DEFAULTSERVICE"
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "BILLCODE"
	type = "VARCHAR(15)"
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

