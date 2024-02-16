resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_UNTOUCHEDVISITS_BKCP_10032023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "UNTOUCHEDVISITS_BKCP_10032023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.UNTOUCHEDVISITS_BKCP_10032023

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
	name = "ADMISSIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEPATIENTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAIDNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTPATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULETIME"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "AIDENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AIDECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITSTATUSTEXT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHHANAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITTIME"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEDULEDMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITMINS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITHRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COORDINATORNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESHEETREQUIRE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYRATECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VENDORINVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITCREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "ONHOLDVISIT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MISSEDVISIT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTYNAME"
	type = "VARCHAR(16777216)"
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

