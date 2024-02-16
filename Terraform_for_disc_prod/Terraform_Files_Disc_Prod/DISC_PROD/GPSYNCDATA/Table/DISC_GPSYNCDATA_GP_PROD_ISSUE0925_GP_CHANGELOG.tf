resource "snowflake_table" "DISC_GPSYNCDATA_GP_PROD_ISSUE0925_GP_CHANGELOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GP_PROD_ISSUE0925_GP_CHANGELOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GP_PROD_ISSUE0925_GP_CHANGELOG

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
	name = "USERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COLUMNNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETIMECHANGED"
	type = "DATE"
	nullable = true
}


column {
	name = "OLDVALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEWVALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

