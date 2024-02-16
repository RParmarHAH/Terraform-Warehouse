resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CAREGIVERTEAMS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CAREGIVERTEAMS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CAREGIVERTEAMS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CAREGIVERTEAMID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERTEAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAREGIVERTEAMDESC"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ISAGENCYDEFAULT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATE"
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

