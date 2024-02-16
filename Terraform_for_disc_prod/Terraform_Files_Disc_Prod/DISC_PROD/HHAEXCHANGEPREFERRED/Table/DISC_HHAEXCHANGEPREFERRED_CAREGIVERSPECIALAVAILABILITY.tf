resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_CAREGIVERSPECIALAVAILABILITY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "CAREGIVERSPECIALAVAILABILITY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.CAREGIVERSPECIALAVAILABILITY

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
	name = "CAREGIVERSPECIALAVAILABILITYID"
	type = "NUMBER(10,0)"
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
	name = "FROMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TODATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SATURDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SATURDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SATURDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SATURDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SUNDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUNDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUNDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SUNDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MONDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MONDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MONDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MONDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TUESDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUESDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TUESDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TUESDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "WEDNESDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WEDNESDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "WEDNESDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "WEDNESDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THURSDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THURSDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "THURSDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "THURSDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRIDAYAVAILABILITYTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRIDAYLIVEIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRIDAYFROM"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "FRIDAYTO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

