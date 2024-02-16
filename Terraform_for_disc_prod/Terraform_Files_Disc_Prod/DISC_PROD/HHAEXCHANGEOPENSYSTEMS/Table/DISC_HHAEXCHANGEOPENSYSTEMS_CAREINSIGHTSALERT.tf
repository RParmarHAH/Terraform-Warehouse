resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CAREINSIGHTSALERT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CAREINSIGHTSALERT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREINSIGHTSALERT

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "VBCALERTFEEDBACKDETAILID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECEIVED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENT"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "COORDINATOR"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CAREGIVER"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "NURSE"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "ASSIGNEE"
	type = "VARCHAR(140)"
	nullable = true
}


column {
	name = "ALERTSTATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ALERTDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NURSEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LINKED_WITH_VISIT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CREATEDBYUSER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBYUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
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

