resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TIMESHEETDETAILAB" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TIMESHEETDETAILAB"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TIMESHEETDETAILAB

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
	name = "PAYPERIODID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SOCIALSECNUM"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "TIMESHEETID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(18,2)"
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
	name = "MODIFIER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISTHIRDSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WAGETYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COSTPERUNIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSTOQBOOKS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ITEMNAME"
	type = "VARCHAR(31)"
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
	name = "NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLSOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLDTM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYSOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYDTM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULECHANGED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULEDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLLHOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISOVERRIDETOTALHOUR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISOVERRIDEPAYROLLHOUR"
	type = "BOOLEAN"
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

