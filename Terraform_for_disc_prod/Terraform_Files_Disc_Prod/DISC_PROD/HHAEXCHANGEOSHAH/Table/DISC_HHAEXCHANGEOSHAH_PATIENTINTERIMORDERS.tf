resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PATIENTINTERIMORDERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PATIENTINTERIMORDERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PATIENTINTERIMORDERS

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
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOCID"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "DETAILID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CREATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATIONSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATIONENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATUSTEXT"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CANDELETE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISAUTO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCANFILENAME"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "SCANFILEGUID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "DATAVERSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FAXLOGSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FAXLOGSTATUSTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PHYSICIANFAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHYSICIANNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIAGNOSISCODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DIAGNOSISDESCRIPTION"
	type = "VARCHAR(500)"
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

