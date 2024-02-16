resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_MONTHLYHOURS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_MONTHLYHOURS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_MONTHLYHOURS

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPERVISORNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICEMONTH"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SERVICEYEAR"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AUTHDATACOULDBEUPDATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLIENTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOURSAUTHORIZED"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "HOURSSERVED"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "REFERRALDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRSTDATEOFSERVICE"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRSTDATEOFSERVICE_CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FIRSTDATEOFSERVICE_CONTRACTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTDATEOFSERVICE_SERVICEMONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLRATE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(12)"
	nullable = false
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYHOURS"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "TOTALPAY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADMIT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_PLAN_FIRSTDATEOFSERVICE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_PLAN_LASTDATEOFSERVICE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NUMBEROFSCHEDULES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HOURSBILLED"
	type = "NUMBER(18,5)"
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

