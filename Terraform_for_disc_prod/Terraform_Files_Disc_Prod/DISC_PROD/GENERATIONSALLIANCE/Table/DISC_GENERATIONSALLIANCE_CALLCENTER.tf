resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CALLCENTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CALLCENTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CALLCENTER

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
	name = "CALLID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CALLER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ENTEREDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERSONTAKINGCALL"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CALLDESCRIPTION"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "ISRESOLVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESOLVEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "XFERTONOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CALLERTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INT_REFERRALID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DTMDATEDUE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STRASSIGNEDTO"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CALLERID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "XFERTOOUTLOOK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SECONDARYCALLER"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "SECONDARYREFERRER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLASSNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NOTIFIEDUSERS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "NOTEPRIORITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISDELETEDATTACHEDNOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARENTCALLID"
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

