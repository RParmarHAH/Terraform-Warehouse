resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CLINICALPOCDETAIL485" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CLINICALPOCDETAIL485"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CLINICALPOCDETAIL485

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
	name = "POCDETAIL485ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "POCHEADER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTER485ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCTASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCPERREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMESPERWEEK"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MINUTES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TIMESPERWEEKMIN"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TIMESPERWEEKMAX"
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
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TASKNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SUNDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MONDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TUESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEDNESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THURSDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SATURDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASNEEDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TASKINSTRUCTION"
	type = "VARCHAR(250)"
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

