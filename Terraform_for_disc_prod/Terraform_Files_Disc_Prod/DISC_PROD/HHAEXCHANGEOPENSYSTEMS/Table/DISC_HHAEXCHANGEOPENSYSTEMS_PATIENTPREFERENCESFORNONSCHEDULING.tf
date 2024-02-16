resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_PATIENTPREFERENCESFORNONSCHEDULING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "PATIENTPREFERENCESFORNONSCHEDULING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PATIENTPREFERENCESFORNONSCHEDULING

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	name = "SCHEDULINGPREFERENCEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PATIENTSCHEDULINGPREFERENCEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PREFERENCE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PREFERENCEVALUE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "APPLIESTOPATIENT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "APPLIESTOCAREGIVER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "USEDFORSCHEDULING"
	type = "NUMBER(5,0)"
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
	name = "OFFICEID"
	type = "NUMBER(10,0)"
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

