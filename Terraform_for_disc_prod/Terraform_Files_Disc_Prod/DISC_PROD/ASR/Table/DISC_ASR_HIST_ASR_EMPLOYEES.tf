resource "snowflake_table" "DISC_ASR_HIST_ASR_EMPLOYEES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_EMPLOYEES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_EMPLOYEES

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEPUBLICID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLEOFCOURTESY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REPORTSTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHOTOPATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPENDANTSCLAIMED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECTDEPOSIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATIONREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVIEWPERIOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEESTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISORID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEETYPEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADPFILENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONLATITUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONLONGITUDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_SEQUENCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_LASTSUBMITTEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_TRANSACTIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_LASTSUBMITTEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_LASTMODIFIEDON"
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
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

