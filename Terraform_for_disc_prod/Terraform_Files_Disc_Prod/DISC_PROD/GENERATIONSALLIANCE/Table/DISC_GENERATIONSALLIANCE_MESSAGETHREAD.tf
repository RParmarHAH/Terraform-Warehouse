resource "snowflake_table" "DISC_GENERATIONSALLIANCE_MESSAGETHREAD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "MESSAGETHREAD"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.MESSAGETHREAD

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MESSAGETHREADID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "MESSAGECENTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FROMS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TOS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BODY"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "ISREAD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SENDERTYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ATTACHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTACHMENTTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ATTACHEDFILENAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USERTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USERREFERENCEID"
	type = "VARCHAR(15)"
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

