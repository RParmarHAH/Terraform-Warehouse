resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_STAGE_PATIENTCALENDARNOTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "STAGE_PATIENTCALENDARNOTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.STAGE_PATIENTCALENDARNOTES

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
	name = "PATIENTNOTEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NOTEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FROMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TODATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENTNOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTETYPE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "URGENTMESSAGE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
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
	name = "STATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FROMPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TOPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INTERNAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITNOTEID"
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

