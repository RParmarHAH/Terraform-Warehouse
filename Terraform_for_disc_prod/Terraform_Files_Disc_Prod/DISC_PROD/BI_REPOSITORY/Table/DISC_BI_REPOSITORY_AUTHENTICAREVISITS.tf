resource "snowflake_table" "DISC_BI_REPOSITORY_AUTHENTICAREVISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	name = "AUTHENTICAREVISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.BI_REPOSITORY.AUTHENTICAREVISITS

    -- Purpose : Discovery Data Population

    -- Project : BI_REPOSITORY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "CLAIMID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PROVIDERID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PROVIDERNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "WORKERID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "WORKERNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EXTERNALWORKERID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIENTBILLINGMEDICAIDID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIENTNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TEAMASSIGNMENT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CASEMANAGERID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CASEMANAGERNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SERVICE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DATEOFSERVICE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CHECKIN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CHECKOUT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACTUALUNITS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AUTHORIZEDUNITS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LASTBILLINGDATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTPAYMENTDATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLAIMSTATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACTIVITYCODES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MILEAGE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TRAVELTIME"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EXCEPTIONS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CREATEDATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTUPDATEDATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AUTHORIZATION"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PAYERNAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EXTERNALCLIENTID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DEVICEID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLAIMNOTEREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AAANUMBER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDEDFILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTUPDATEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTUPDATEDFILENAME"
	type = "VARCHAR(100)"
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

