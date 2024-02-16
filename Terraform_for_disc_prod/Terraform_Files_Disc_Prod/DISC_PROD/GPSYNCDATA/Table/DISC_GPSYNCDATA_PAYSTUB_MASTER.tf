resource "snowflake_table" "DISC_GPSYNCDATA_PAYSTUB_MASTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "PAYSTUB_MASTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.PAYSTUB_MASTER

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CHECKID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "AUDITTRAILNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISADMIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEETYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "GENERATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODEND"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "FULLNAME"
	type = "VARCHAR(150)"
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANYNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANYADDRESS1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "COMPANYADDRESS2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "COMPANYCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANYSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMPANYZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NETWAGES"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "GROSSWAGES"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "NETWAGESYTD"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "GROSSWAGESYTD"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "VACATIONHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "SICKHOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "WORKSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUTASTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REIMBURSEMENTS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "UNIONDUES"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "OTHERDEDUCTIONS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "TOTALUNITS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "TOTALTAXES"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "TOTALDEDUCTIONS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKMESSAGE"
	type = "VARCHAR(2048)"
	nullable = true
}


column {
	name = "EMPLOYEEFEDFILINGSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEESTATEFILINGSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEEFEDALLOW"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEESTATEALLOW"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GPTRANSPERIODSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GPTRANSPERIODEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SHORTENEDEMPLOYEEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SANTRAXID"
	type = "VARCHAR(50)"
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

