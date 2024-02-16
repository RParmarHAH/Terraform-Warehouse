resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_IL_HOURSOL1" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_IL_HOURSOL1"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_IL_HOURSOL1

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "WEEK_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMP_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "MON_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "MON_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TUE_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "TUE_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WED_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "WED_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "THU_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "THU_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FRI_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "FRI_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SAT_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "SAT_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SUN_HOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "SUN_BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DUMMY"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLED_FLAG"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLED_SUPPL_NO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HIGH_SUPPL_NO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHANGED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHANGED_BY"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LOGIN_NAME"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "PAID_FLAG"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MON_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TUE_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WED_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "THU_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FRI_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SAT_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SUN_PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUDIT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SEQ_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISOR"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "HOLD_TIMESHEET"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REVIEW_AUDIT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHANGED_TIME"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TRACKINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISEVV"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "OLDRECNUM"
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

