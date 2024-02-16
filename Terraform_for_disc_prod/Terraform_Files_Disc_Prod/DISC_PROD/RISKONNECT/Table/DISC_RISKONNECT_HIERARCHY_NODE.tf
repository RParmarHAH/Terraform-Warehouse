resource "snowflake_table" "DISC_RISKONNECT_HIERARCHY_NODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIERARCHY_NODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIERARCHY_NODE

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(100)"
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
	name = "ACTIVE__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDRESS_LINE1__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS_LINE2__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTRY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_ACTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_INACTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_LOCATION_CLOSED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_LOCATION_OPENED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_PARENT_RELATIONSHIP_EFFECTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LATITUDE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATION_10_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_10_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_10_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_1_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_1_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_1_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_2_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_2_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_2_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_3_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_3_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_3_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_4_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_4_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_4_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_5_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_5_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_5_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_6_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_6_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_6_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_7_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_7_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_7_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_8_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_8_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_8_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_9_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_9_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOCATION_9_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LONGITUDE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NODE_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NODE_KEY__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NODE_LEVEL__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NODE_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NUMBER_OF_OFFSET_LEVELS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PARENT_CODE_FORMULA__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARENT_LEVEL_FORMULA__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PARENT_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARENT_NODE_KEY__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARENT_NODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARENT_SIC_OR_NAICS_CODE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PERMIT_CLAIMS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POSTAL_CODE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PRIMARY_CONTACT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SIC_OR_NAICS_NODE_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "IS_LEAF__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LABOR_HOURS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SALES__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYROLL__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HEADCOUNT__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MILES_DRIVEN__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROPERTY_COLLECTION_STATUS__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPOSURE_SUMMARY_1__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPOSURE_SUMMARY_2__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPOSURE_SUMMARY_3__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPOSURE_SUMMARY_4__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPOSURE_SUMMARY_5__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RK_TEST_ROLLUP__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SEARCH_LOCATION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AE_REVIEWER_1__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY_LOCATION_INDICATOR__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION_LEVEL_NAME__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICE_MANAGER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PHONE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FAX__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RK_SHARE_GROUP_1__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CODE_LOSSES_TO_THIS_LOCATION__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TAX_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLS_DD_MANAGER_PHONE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLS_DD_MANAGER_EMAIL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOTAL_ANNUAL_HOURS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLS_DD_MANAGER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SKILLED_MANAGER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOTAL_ANNUAL_VISITS__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROPERTY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_ANNUAL_PAYROLL__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RK_SHARE_GROUP_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOTAL_EMPLOYEE_COUNT__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "RK_SHARE_GROUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RENEWAL_CONTACT__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SKILLED_MANAGER_PHONE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REGION__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RENEWAL_USER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SKILLED_MANAGER_EMAIL__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HIERARCHY_NOTES__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLEAN_UP__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHANGE_REASON__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "UNION_BRANCH__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPERVISOR_HEADCOUNT__C"
	type = "NUMBER(10,2)"
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

