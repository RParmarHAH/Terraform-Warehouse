resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_CLIENTINQUIRYFIELDS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_CLIENTINQUIRYFIELDS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_CLIENTINQUIRYFIELDS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIQF_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIQF_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIQF_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIQF_TABID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIQF_ROWNUMBER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CLIQF_COLNUMBER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CLIQF_FIELDTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIQF_DEFAULTVALUE"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "CLIQF_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIQF_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIQF_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIQF_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIQF_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIQF_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIQF_NAMEID"
	type = "VARCHAR(50)"
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

