resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_TRAVELTIMETRIPDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "TRAVELTIMETRIPDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.TRAVELTIMETRIPDETAILS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	nullable = true
}


column {
	name = "TRAVELTIMETRIPDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAVELTIMECALCULATEDDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAVELTIMEBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAVELDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GAPTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CAREGIVERNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITHOURS1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITHOURS2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITSCHEDULEDHOURS1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITSCHEDULEDHOURS2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENTID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTNAME1"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "PATIENTNAME2"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "TRAVELTIMEVALUE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRANSPORTATIONMETHOD"
	type = "VARCHAR(200)"
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

