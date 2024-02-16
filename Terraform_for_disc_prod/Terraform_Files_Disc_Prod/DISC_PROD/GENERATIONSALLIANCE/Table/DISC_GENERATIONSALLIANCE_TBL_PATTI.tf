resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TBL_PATTI" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TBL_PATTI"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TBL_PATTI

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
	name = "INT_PATTIID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DTM_SAVEDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "CLIENTID"
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "PHONEDIALEDTO"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PID"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "PURPOSE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "EMID"
	type = "VARCHAR(30)"
	nullable = false
}


column {
	name = "LNAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "JNAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "CLID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLID_NAME"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "W_MIN"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "HRS"
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
	name = "M1"
	type = "VARCHAR(11)"
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
	name = "DTM_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INT_SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DTM_SCHEDULETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ROUNDEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLSID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LATTITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "NUMBER(18,12)"
	nullable = true
}


column {
	name = "CALLTYPE"
	type = "VARCHAR(20)"
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

