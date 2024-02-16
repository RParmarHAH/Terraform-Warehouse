resource "snowflake_table" "DISC_PUBLIC_DATAFLEXSYNCDATA_DFEMPLOYEES_FULLLOAD_FOR_FAMILYCAREGIVER_20231004" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DATAFLEXSYNCDATA_DFEMPLOYEES_FULLLOAD_FOR_FAMILYCAREGIVER_20231004"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DATAFLEXSYNCDATA_DFEMPLOYEES_FULLLOAD_FOR_FAMILYCAREGIVER_20231004

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAMILYCAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

