resource "snowflake_table" "DISC_APTITIVE_DEV_RL_DATAFLEX_IN_TRAINING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "APTITIVE_DEV"
	name = "RL_DATAFLEX_IN_TRAINING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.APTITIVE_DEV.RL_DATAFLEX_IN_TRAINING

    -- Purpose : Discovery Data Population

    -- Project : APTITIVE_DEV

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DATASET_NAME"
	type = "VARCHAR(5)"
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
	name = "BEGINSERVICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ENDSERVICEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "AGENCY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLOFFICE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BILLHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ETHICS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PHYSICANNO"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHYSICANNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IDOAID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEDICAIDNO"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ICD9CODES"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ICD10CODES"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DCNNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ONHOLDSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ONHOLDENDDATE"
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

