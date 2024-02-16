resource "snowflake_table" "DISC_DATA_VAULT_VW_SAT_EMPLOYEE_DATAFLEX" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_VAULT"
	name = "VW_SAT_EMPLOYEE_DATAFLEX"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_VAULT.VW_SAT_EMPLOYEE_DATAFLEX

    -- Purpose : Discovery Data Population

    -- Project : DATA_VAULT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "HASH_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DBNAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PAYROLLID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PHONENUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ABLETOREHIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "ETHICS"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PAYROLLIDINDEXNO"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "LASTCHECKDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATEADDED"
	type = "DATE"
	nullable = true
}


column {
	name = "DATECHANGED"
	type = "DATE"
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

