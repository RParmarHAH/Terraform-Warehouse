resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_RATEBILLSHIFTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_RATEBILLSHIFTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_RATEBILLSHIFTS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXPENSEID"
	type = "NUMBER(19,0)"
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
	name = "SHIFTNO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "UNITTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "UNITS"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "HOLLIDAYADD"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOLLIDAYMULT"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "ACTUALRATE"
	type = "NUMBER(20,6)"
	nullable = true
}


column {
	name = "ISSERVICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALAMOUNT"
	type = "NUMBER(29,10)"
	nullable = true
}


column {
	name = "CS_BILLSHIFT"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "RBS_OTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RBS_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
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

