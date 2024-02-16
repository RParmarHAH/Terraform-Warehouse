resource "snowflake_table" "DISC_EMPLOYEESETUP_ES_ENTRIESDATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPLOYEESETUP"
	name = "ES_ENTRIESDATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPLOYEESETUP.ES_ENTRIESDATA

    -- Purpose : Discovery Data Population

    -- Project : EMPLOYEESETUP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ENTRYID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(15)"
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
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DOB"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REHIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FEDERALEXEMPTIONS"
	type = "NUMBER(9,5)"
	nullable = true
}


column {
	name = "STATEEXEMPTIONS"
	type = "NUMBER(9,5)"
	nullable = true
}


column {
	name = "ADDITIONALFEDERALWITHHOLDINGS"
	type = "NUMBER(9,5)"
	nullable = true
}


column {
	name = "ADDITIONALSTATELWITHHOLDINGS"
	type = "NUMBER(9,5)"
	nullable = true
}


column {
	name = "POSITIONID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "PAYSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EICELIG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WHERETOCHECK"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "STATEFILLINGSTATUS"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BACKGROUNDCHECK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INUNION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINALEMPLOYEEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYMENTTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRAVELCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SEQUENCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "NURSELICENSENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LICENSEEXPIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERFEREDCAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCALTAXCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACTTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPLACEMENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TITLEID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "REFERRAL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ORDERNEWPAYCARD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICAREID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMAILTO"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "PERSONALEMAIL"
	type = "VARCHAR(150)"
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

