resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_TBLVISITS_REPL_27" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "TBLVISITS_REPL_27"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.TBLVISITS_REPL_27

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MASTERWEEKHEADERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COORDINATORID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCHEADERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDSTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPROVEDSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPROVEDOVERTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPROVEDTRAVELTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCCOMPLIANT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HASOPENEVENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTREFERENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATECOMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEREASONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VDISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERMANENTDELETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEVISITACTIONTAKENREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCRUEDMINUTEVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISMISSEDVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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

