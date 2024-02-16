resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_INREVIEWVISITS_BACKUP_20230821" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "INREVIEWVISITS_BACKUP_20230821"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.INREVIEWVISITS_BACKUP_20230821

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
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AIDEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHHAID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "IVRCALLIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IVRCALLOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IVRCALLINROUNDED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IVRCALLOUTROUNDED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOTROUNDINGVISITTIME"
	type = "BOOLEAN"
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
	name = "SCHEDULEDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISMISSEDVISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISBILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCONFIRMED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISEXCEPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCEPTIONCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MANUALEDIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTEXPORTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALLINDEVICETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALLOUTDEVICETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALLINPHONENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLOUTPHONENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLINGPSCOORDINATES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CALLOUTGPSCOORDINATES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBYOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITAUDITSUPERVISOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VALIDATEPAPERDUTYSHEET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VDISCIPLINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCIPLINETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COORDINATORID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTTEAMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTLOCATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IVRVERIFICATION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITTYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITTYPETEXT"
	type = "VARCHAR(50)"
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

