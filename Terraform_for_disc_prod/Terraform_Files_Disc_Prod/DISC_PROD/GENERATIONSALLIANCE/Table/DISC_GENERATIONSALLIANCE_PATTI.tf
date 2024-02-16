resource "snowflake_table" "DISC_GENERATIONSALLIANCE_PATTI" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "PATTI"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.PATTI

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
	name = "PATTIUNIQUE"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SOCIALSECNUM"
	type = "VARCHAR(9)"
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
	name = "ROUNDEDSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ROUNDEDENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MILEGE"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "UPDATEDSCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPDATEDSTARTTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPDATEDENDTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULENOTFOUND"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STR_CALLERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STR_CALLERNAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "INT_PURPOSEID"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STR_PURPOSE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STR_EMPLOYEENAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "STR_CLIENTNAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "INT_WORKMIN"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STR_WORKHOURS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "F1"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "F2"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "F3"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "F4"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "T0"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "D0"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "Q0"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DTM_CREATED"
	type = "TIMESTAMP_NTZ(9)"
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

