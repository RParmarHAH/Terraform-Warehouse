resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SCHEDULES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SCHEDULES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SCHEDULES

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
	name = "SOCIALSECNUM"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATE"
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
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISCONFIRMED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICEREQUESTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ITEMNAME"
	type = "VARCHAR(31)"
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
	name = "NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "TIMEMATCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INT_MISSEDSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TELEPHONYALERTENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MILEAGEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLECLIENTQA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ORIGINALSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORIGINALENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISCLIENTSIGNREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCGSIGNREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULTCARENOTE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISCARENOTEREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISWOUNDNOTEREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISEXPORTEDSTATEEVV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCANCELLEDSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANCELLEDSHIFTREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CANCELLEDSHIFTACTIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DMAS90ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INT_MISSEDLOGOUT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TELLUSPOSTFIX"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AUTHENTICAREPOSTFIX"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INITIALSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INITIALENDTIME"
	type = "TIMESTAMP_NTZ(9)"
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

