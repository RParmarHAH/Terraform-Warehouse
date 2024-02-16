resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CAREGIVERNOTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CAREGIVERNOTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERNOTES

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
	nullable = true
}


column {
	name = "CAREGIVERNOTEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CAREGIVERNOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(223)"
	nullable = true
}


column {
	name = "NOTEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVERNOTIFIED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "MESSAGEINOUT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VOICEMESSAGETOCAREGIVER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERNOTIFICATIONVOICEMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MOBILE_TEXTMESSAGETOCAREGIVER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERNOTIFICATIONTEXTNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMAILMESSAGETOCAREGIVER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERNOTIFICATIONEMAIL"
	type = "VARCHAR(200)"
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

