resource "snowflake_table" "DISC_ASR_ASR_SPECIALTRAINING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_SPECIALTRAINING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_SPECIALTRAINING

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
	name = "SPECIALTRAININGID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIALTRAININGNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIALTRAININGDESCR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSUEDATEAPPLIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPARATIONDATEAPPLIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NUMUNITSBEFOREALERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNITSBEFOREALERTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISBCII"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISFBI"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIALTRAININGTYPE"
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

