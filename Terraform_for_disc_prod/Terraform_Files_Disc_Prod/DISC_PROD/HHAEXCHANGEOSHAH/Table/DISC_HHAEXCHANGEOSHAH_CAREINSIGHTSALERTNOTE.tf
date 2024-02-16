resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CAREINSIGHTSALERTNOTE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CAREINSIGHTSALERTNOTE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CAREINSIGHTSALERTNOTE

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
	name = "VBCALERTFEEDBACKACTIONID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "VBCALERTFEEDBACKDETAILID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "ALERTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ALERT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ALERTSTATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "USER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NURSE"
	type = "VARCHAR(153)"
	nullable = true
}


column {
	name = "ACTIONTAKEN"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ASSIGNEE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYUSER"
	type = "VARCHAR(255)"
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
	name = "UPDATEDBYUSER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "UPDATEDBY"
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

