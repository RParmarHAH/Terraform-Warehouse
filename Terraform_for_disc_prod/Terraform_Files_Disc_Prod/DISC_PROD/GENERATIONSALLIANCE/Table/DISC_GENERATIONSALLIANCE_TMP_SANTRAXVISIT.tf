resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TMP_SANTRAXVISIT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TMP_SANTRAXVISIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TMP_SANTRAXVISIT

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SANTRAXVISITID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEETELEPHONYID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CLIENTTELEPHONYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOGOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENTFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIENTLASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "OLDSCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTOTHERID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFLASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "TASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TASKNOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPOSEDSTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPOSEDEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENTCHARTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "STAFFMI"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STAFFAGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFOTHERID2"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFAPI"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STAFFTEAMID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CLIENTMI"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIENTCUSTOMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTADMITTYPE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ACTUALDURATION"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "PROPOSEDDURATION"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "ADJUSTEDTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTEDTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTEDDURATION"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "OVERRIDE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYQUANTITY"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "BILLTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HCPCSCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLQUANTITY"
	type = "NUMBER(9,2)"
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
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

