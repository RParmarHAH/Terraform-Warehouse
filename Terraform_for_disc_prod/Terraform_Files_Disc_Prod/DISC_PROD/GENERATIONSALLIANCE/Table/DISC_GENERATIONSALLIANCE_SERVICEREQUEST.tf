resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SERVICEREQUEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SERVICEREQUEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SERVICEREQUEST

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
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SERVICEREQUESTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COSTPERUNIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OCCURANCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SUNDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MONDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TUESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEDNESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THURSDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SATURDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DAYOFMONTH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FLEXIBLETIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DEFAULT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALAPPROVEDUNITS"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "TOTALAPPROVEDAMT"
	type = "NUMBER(16,3)"
	nullable = true
}


column {
	name = "UNITSPERHOUR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FLEXIBLEDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALAPPROVEDVISITS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MANUALOVERRIDEBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SERVICESTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PATIENTNUMBER"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "MANUALOVERRIDEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DAYOFWEEK"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "INCLUDEMODIFIERIN837I"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ARPROVIDERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREBRIDGEPROVIDERID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SANTRAXPROVIDERID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROVIDERATYPICALID"
	type = "VARCHAR(8)"
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

