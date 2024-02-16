resource "snowflake_table" "DISC_RISKONNECT_HIST_INTAKE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_INTAKE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_INTAKE

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
	name = "ADDITIONAL_WITNESSES__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "AUTO_COMPANY_VEHICLE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTO_INCIDENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTO_NON_EMPLOYEE_INJURY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUTO_NON_EMPLOYEE_PROPERTY_DAMAGE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMMENTS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMPANY_PROPERTY_DAMAGE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_INJURY__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "IM_DELETE_FLAG__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IM_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_ADDRESS_2__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INCIDENT_ADDRESS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INCIDENT_CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "INCIDENT_DAY_OF_WEEK__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INCIDENT_DESCRIPTION__C"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "INCIDENT_LOCATION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_POSTAL_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INCIDENT_REGION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_STATE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEAR_MISS_GROUPING__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEAR_MISS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OCCUR_ON_COMPANY_PREMISES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REPORT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "REPORT_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REPORTED_BY_CONTACT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_FIRST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_LAST_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTED_BY_PHONE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "UNSAFE_ACT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNSAFE_CONDITION__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNSAFE_EQUIPMENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNSAFE_USE_OF_EQUIPMENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WITNESS_1_CONTACT_INFORMATION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WITNESS_1_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WITNESS_2_CONTACT_INFORMATION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WITNESS_2_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WITNESS_3_CONTACT_INFORMATION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WITNESS_3_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WITNESSES__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "X3RD_PARTY_BODILY_INJURY__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "X3RD_PARTY_PROPERTY_DAMAGE__C"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ADDITIONAL_ENTITIES__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADDITIONAL_EXPOSURES__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADMIT_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "CRITICAL_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DISCOVERY_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DISCOVERY_TIME_PICKLIST__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITIES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_1_CONTACT_NAME__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ENTITY_1_NOTIFICATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ENTITY_1_NOTIFICATION_METHOD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_1_NOTIFICATION_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_1_NOTIFICATION_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_1_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTITY_2_CONTACT_NAME__C"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ENTITY_2_NOTIFICATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ENTITY_2_NOTIFICATION_METHOD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_2_NOTIFICATION_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_2_NOTIFICATION_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_2_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTITY_3_CONTACT_NAME__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ENTITY_3_NOTIFICATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ENTITY_3_NOTIFICATION_METHOD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_3_NOTIFICATION_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_3_NOTIFICATION_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_3_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTITY_4_CONTACT_NAME__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ENTITY_4_NOTIFICATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ENTITY_4_NOTIFICATION_METHOD__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_4_NOTIFICATION_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_4_NOTIFICATION_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENTITY_4_TYPE__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ENTITY_TYPE_1_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ENTITY_TYPE_2_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ENTITY_TYPE_3_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ENTITY_TYPE_4_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPOSED_1_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_2_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_3_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_4_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_5_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_6_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSED_7_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_1_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_1_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_1_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_1_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_2_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_2_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_2_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_2_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_3_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_3_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_3_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_3_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_4_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_4_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_4_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_4_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_5_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_5_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_5_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_5_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_6_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_6_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_6_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_6_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_7_DATE_OF_EXPOSURE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXPOSURE_7_EMPLOYEE_OR_CLIENT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXPOSURE_7_QUARANTINED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURE_7_WEARING_PPE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXPOSURES__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FACILITY__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "HOW_WAS_EVENT_PREVENTABLE__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IMMEDIATE_ACTIONS_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "IMMEDIATE_ACTIONS__C"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INCIDENT_DATE_AND_OR_TIME_APPROXIMATED__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INCIDENT_LOCATION_NAME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_LOCATION_TYPE_DETAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_LOCATION_TYPE_OTHER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_LOCATION_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCIDENT_TIME_AM_PM__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INCIDENT_TIME__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NON_CRITICAL_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OFFICE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PARTICIPANT_STATUS_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PARTICIPANT_STATUS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PREVENTABLE_EVENT__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RELATIONSHIP_TO_PARTICIPANT__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "REPORTED_BY_EMAIL__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "REPORTED_BY_TITLE__C"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "SERVICE_LINE_OTHER_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SERVICE_LINE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEVERITY_LEVEL__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SEVERITY_FOR_PARTICIPANT_EMPLOYEE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "WITNESS_1_RELATIONSHIP_TO_PARTICIPANT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WITNESS_2_RELATIONSHIP_TO_PARTICIPANT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WITNESS_3_RELATIONSHIP_TO_PARTICIPANT__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "X3RD_PARTY_REPORTER__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "X3RD_PARTY_WITNESS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVIEWED_BY_QUALITY__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EVENT_LAG_TIME__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RESOLUTION_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RESOLUTION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "RESOLUTION_TIME__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONVERT_TO_CLAIM__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DAYS_TO_NOTIFY_ENTITY__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRANCH_STATE__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "INCIDENT_DURING_STAFF_S_SCHEDULED_SHIFT__C"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REQUEST_CLAIM_BE_CONVERTED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLEGED_THEFT__C"
	type = "VARCHAR(50)"
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

