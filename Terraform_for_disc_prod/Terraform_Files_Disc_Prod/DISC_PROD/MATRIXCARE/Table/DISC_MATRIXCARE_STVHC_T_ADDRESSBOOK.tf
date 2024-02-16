resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_ADDRESSBOOK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_ADDRESSBOOK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_ADDRESSBOOK

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
	name = "ADDBK_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADDBK_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_COMPANYNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ADDBK_TITLE"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ADDBK_CONTACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_POSITION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_BIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDBK_TYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDBK_ADDRESS1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDBK_ADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "ADDBK_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_STATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ADDBK_POSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ADDBK_COUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_COUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_EMAIL2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDBK_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDBK_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_TS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDBK_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDBK_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_SALUTATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_CONTACTTYPEBITWISE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ADDBK_HOBBIES"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "ADDBK_TEXTMESSAGE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDBK_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDBK_WEBSITE"
	type = "VARCHAR(192)"
	nullable = true
}


column {
	name = "TEMP_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TEMP_TABLE"
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

