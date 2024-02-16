resource "snowflake_table" "DISC_VIVENTIUM_LMSEXPORTEMPLOYEE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "LMSEXPORTEMPLOYEE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.LMSEXPORTEMPLOYEE

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLEINITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEESTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REHIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATIONDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHIFTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTER2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTER3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTER4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COSTCENTER5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIEDON"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

