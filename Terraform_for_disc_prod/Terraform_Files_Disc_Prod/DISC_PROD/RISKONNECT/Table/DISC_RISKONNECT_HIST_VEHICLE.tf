resource "snowflake_table" "DISC_RISKONNECT_HIST_VEHICLE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_VEHICLE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_VEHICLE

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CONNECTIONRECEIVEDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONNECTIONSENTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BODY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COLOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAIR_MARKET_VALUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FLEET_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GROSS_WEIGHT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAKE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MODEL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NET_BOOK_VALUE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERSHIP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHOTO__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PLATE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_SECTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGISTRATION_RENEWAL_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "STATE_DMV__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_COST__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_PLATE_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VIN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "YEAR_SAFETY_INSPECTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "YEAR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEARCH_DISPLAY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_BRANCH__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VEHICLE_IS_GARAGED_AT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_VERIFIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INSURANCE_CARD_CONTACT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEASE_START_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "LEASE_EXPIRATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CHANGE_REASON__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LEASE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTES__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REGION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEASING_COMPANY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FLEET_VEHICLE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POPULATES_DATE_FOR_LETTERS__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CLEAN_UP__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSURANCE_CARD_CONTACT_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REQUEST_NEW_INSURANCE_CARD__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COVERAGE_END_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "COVERAGE_START_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "WHEELCHAIR_LIFT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VELCOR_ASSET__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DL_STATE__C"
	type = "VARCHAR(5)"
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

