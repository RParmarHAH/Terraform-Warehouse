resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_TBLVISITS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "TBLVISITS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.TBLVISITS_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

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
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "MASTERWEEKHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ALLOCATIONID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "COORDINATORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDENDTIME"
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
	name = "APPROVEDSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "APPROVEDOVERTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "APPROVEDTRAVELTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "POCCOMPLIANT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HASOPENEVENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IMPORTREFERENCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATECOMMENTS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "UPDATEREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VDISCIPLINE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PERMANENTDELETE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEVISITACTIONTAKENREASON"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACCRUEDMINUTEVISIT"
	type = "VARCHAR(10)"
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
	name = "LASTMODIFIEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISMISSEDVISIT"
	type = "NUMBER(5,0)"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

