resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_REFERRALSTAFFJOIN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_REFERRALSTAFFJOIN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_REFERRALSTAFFJOIN

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
	name = "REFSTAFFJ_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "REFSTAFFJ_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFSTAFFJ_REFERRALENTITIESID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "REFSTAFFJ_REFERRALRECORDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFSTAFFJ_STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFSTAFFJ_ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFSTAFFJ_NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REFSTAFFJ_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFSTAFFJ_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFSTAFFJ_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFSTAFFJ_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFSTAFFJ_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REFSTAFFJ_REFERRALCONTACTRECORDID"
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

