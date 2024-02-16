resource "snowflake_table" "DISC_ASR_HIST_ASR_PLANOFSERVICE_26_SEP_2023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_PLANOFSERVICE_26_SEP_2023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_PLANOFSERVICE_26_SEP_2023

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
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSASSIGNED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKINTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITFEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECURRENCETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILESTODRIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOWEDEXTRATIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARLY_CHECKIN_ALLOWED_MINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTOEMAILLATECHECKINS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FORCECLIENTPHONEUSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IGNORELASTTWODIGITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECEIVABLERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECEIVABLEFEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERSOURCEID"
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
	name = "BILLINGCODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUIRESIGNATURES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOGPSVERIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DRIVINGCOMPENSATIONAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DRIVINGCOMPENSATIONRATE"
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

