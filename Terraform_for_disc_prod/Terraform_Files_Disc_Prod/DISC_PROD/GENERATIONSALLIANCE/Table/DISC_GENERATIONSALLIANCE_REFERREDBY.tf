resource "snowflake_table" "DISC_GENERATIONSALLIANCE_REFERREDBY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "REFERREDBY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.REFERREDBY

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "REFERREDBYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MOBILE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REFERRALSTATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REFERRALSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REFERRALSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "REFERRALZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "REFERRALTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALLOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NOTIFIEDUSERS"
	type = "VARCHAR(8000)"
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

