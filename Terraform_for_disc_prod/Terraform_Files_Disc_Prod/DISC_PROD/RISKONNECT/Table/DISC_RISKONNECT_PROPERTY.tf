resource "snowflake_table" "DISC_RISKONNECT_PROPERTY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "PROPERTY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.PROPERTY

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
	name = "ADDRESS_LINE1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS_LINE2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRE_ALARM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AREA_OCCUPIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BUILDING_HEIGHT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COASTAL_DISTANCE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONSTRUCTION_RISK__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_LANDLORD_NAME_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONSTRUCTION_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTRY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_STREET_ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_INACTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_ACTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_SOLD__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_INITIAL_LEASE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EARTHQUAKE_ZONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ELEVATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRE_AREAS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRE_DEPT_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRE_DEPT_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRE_HYDRANT_DISTANCE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_LANDLORD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FLOOD_ZONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FLOORS_OCCUPIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BUILDING_SQUARE_FOOTAGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_STREET_ADDRESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HIERARCHY_NODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTERIOR_COLUMNS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEED_CERTIFICATION_LEVEL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEED_CERTIFIED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LATITUDE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEVELS_ABOVE_GRADE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEVELS_BELOW_GRADE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LONGITUDE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAICS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NUMBER_OF_FIRE_HYDRANTS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SIGNED_LEASE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OCCUPATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERIMETER_WALL_CONSTRUCTION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHOTO__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROPERTY_ZONING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROTECTION_CLASS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RENOVATION_YEAR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_ZIP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LESSOR_CONTACT_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ROOF_FLASHING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ROOF_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SIC_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEASE_EXPIRATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "SECURITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEASE_TERM_MONTHS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYEES_PAID__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SQUARE_FOOTAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TELEPHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_CUSTOMERS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "USE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WATER_SUPPLY_TEST_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "WATER_SUPPLY_TEST_RESULTS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WATER_SUPPLY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WIND_STORM_ZONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_OF_MOST_CURRENT_PROPERTY_VALUES__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_OF_MOST_RECENT_INSPECTION__C"
	type = "DATE"
	nullable = true
}


column {
	name = "PROPERTY_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RENEWAL_VALUE_UPDATE_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AGE_IN_MONTHS_OF_PROPERTY_VALUES__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISTRICT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXTERNAL_CONTACTS_EMAIL_LIST__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INTERNAL_CONTACTS_EMAIL_LIST__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RENT_PAYMENT__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PERSONAL_PROPERTY_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EQUIPMENT_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BUILDING_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "IMPROVEMENTS_BETTERMENTS_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BRANCH_MANAGER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_FAX__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONSTRUCTION_YEAR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BUSINESS_INCOME_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REGION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TRIPLE_NET_LEASE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANNUAL_TOTAL_HOURS_WORKED__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PRIMARY_LOCATION_INDICATOR__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPRINKLERS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NOTES__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LOCATION_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AVG_OF_EMPLOYEES__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AVG_MONTH__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AVG_MONTHLY_ADMIN_EES__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLEAN_UP__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LANDLORD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHANGE_REASON__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OFFICE_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OSHA_YEAR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PURCHASE_PRICE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROPERTY_NOTES__C"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NUMBER_OF_BEDS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STORIES_FLOORS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YEAR_OF_ELECTRICAL__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YEAR_OF_PLUMBING__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YEAR_OF_ROOF__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "YEAR_OF_HVAC__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OF_BATHS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OF_BEDROOMS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FACILITIES_NOTES__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SUPPORT_LEASE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXTRA_EXPENSE_COVERAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LEASE_QUERY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GROUP_HOME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LEASE_STATUS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OCCUPANCY_STATUS__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

