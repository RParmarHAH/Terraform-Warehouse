resource "snowflake_table" "DISC_ASR_HIST_ASR_SERVICETYPES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_SERVICETYPES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_SERVICETYPES

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_TYPE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_TYPE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPEDESCR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTONOTIFYLATECHECKINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTONOTIFYLATECHECKINSEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTNEXTREVIEWPERIODDAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSKILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDERMEDICAIDID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDERNPINUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_CREDENTIALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLABLERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GLACCOUNTNUMBER"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

