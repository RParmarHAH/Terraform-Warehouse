resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_SCHEDULES_NEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_SCHEDULES_NEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_SCHEDULES_NEW

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

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
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "STATUS2"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CANCELREASON"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SCHEDULEDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SCHEDULETIMEZONE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "PROPOSEDTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPOSEDTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPOSEDDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "EVVTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "SCHEDULEDTIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDTIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDDURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "VERIFICATIONTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "MILES"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "SUPPLIES"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISINSERVICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CANCELREASONNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTIONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REASONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RESOLUTIONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REJECTIONCODE"
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

