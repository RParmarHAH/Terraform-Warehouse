resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TBL_VW_QBTSAUDIT1_TMP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TBL_VW_QBTSAUDIT1_TMP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TBL_VW_QBTSAUDIT1_TMP

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
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PAYPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SOCIALSECNUM"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RUNSUM"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ITEMNAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ISHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MODIFIER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "COSTPERUNIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TIMESHEETID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "TSDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FLATRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RUNSUMPERDAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTPERWEEKLIMIT"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "OTPERDAYLIMIT"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "MNYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MNYOTRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BOTEXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MNYHOLRATE"
	type = "NUMBER(18,2)"
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

