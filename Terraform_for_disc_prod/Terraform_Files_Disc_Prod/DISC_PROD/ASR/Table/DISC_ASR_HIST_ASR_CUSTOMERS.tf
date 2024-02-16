resource "snowflake_table" "DISC_ASR_HIST_ASR_CUSTOMERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_CUSTOMERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_CUSTOMERS

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
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
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
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASEWORKERID"
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
	name = "EMERGENCYPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTREVIEWDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEXTREVIEWDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEXTREVIEWTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISORID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIORITYLEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MONITORSERVICEVISITCHECKINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEENDDATE"
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
	name = "EVV_SEQUENCEID"
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
	name = "IMPORTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_LASTSUBMITTEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVIEWPERIOD"
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

