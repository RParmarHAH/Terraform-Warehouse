resource "snowflake_table" "DISC_RISKONNECT_HIST_CONTACT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "HIST_CONTACT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.HIST_CONTACT

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
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MASTERRECORDID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERSTREET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERPOSTALCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERLATITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERLONGITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERGEOCODEACCURACY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGSTREET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGPOSTALCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGLATITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGLONGITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAILINGGEOCODEACCURACY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSISTANTPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REPORTSTOID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ASSISTANTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LEADSOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "OWNERID"
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
	name = "LASTCUREQUESTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCUUPDATEDATE"
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
	name = "EMAILBOUNCEDREASON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMAILBOUNCEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ISEMAILBOUNCED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PHOTOURL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "JIGSAW"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "JIGSAWCONTACTID"
	type = "VARCHAR(50)"
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
	name = "INDIVIDUALID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNT_ID_PRIOR_C__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APARTMENT_NUMBER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AVERAGE_WEEKLY_WAGE__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CITY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTACT_TYPE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTRY__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DATE_OF_DEATH__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DRIVER_S_LICENSE_STATE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RUN_MVR__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_AGE__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LAST_MVR_RUN_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENDER__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HIRE_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_CODE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LEVEL__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOCATION__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_TYPE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PRIOR_INCIDENT_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PRIOR_LOCATION_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REPORTS_TO_ID_PRIOR__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SSN__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SALARY__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "STATE__C"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SUPERVISOR_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TAX_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TERMINATION_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ZIP_CODE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PERMANENT_ACCOMMODATION__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOCATION_NAME__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SUPERVISOR_NAME__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUPERVISOR_TITLE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ROLE__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDRESS_1__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PORTAL_TESTER__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "WATCH_LEVEL__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MVR_STATUS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CHART_ID_PA_ONLY__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIENT__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MARITAL_STATUS__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INITIAL_HIRE_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "ACTIVE_INACTIVE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_END_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "IS_EE_A_PASSENGER_VAN_DRIVER__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICE_START_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "FORMATTING_ERROR__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_ID_FORMULA__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEPARTMENT_CODE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ETHNIC_ORIGIN__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONTACT_EMAIL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERMANENT_RESTRICTIONS__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICAID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIENT_ID__C"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TRAINING_HOURS_EARNED_2017__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAINING_HOURS_NEEDED__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXAM_DATE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "TRAINING_NOTES__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TRAINING_YEAR__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COMMENTS__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "IDOA_HOURS__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATE_LITIGATION_HOLD_REQUESTED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "TRAINING_HOURS_EARNED_2018__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAINING_EARNED__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTAL_HOURS_EARNED__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHER_TRAINING_HOURS_EARNED__C"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REPORT_RECEIVED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GRADE__C"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REFERRED_BY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MAIL_MERGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOA_LETTER_ADDRESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIELD_OR_ADMIN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIOR_ID_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATA_WAREHOUSE_ID__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POSITION__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RISKONNECT_LICENSE_HOLDER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MASKED_SSN__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS_2__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DRIVER_S_LICENSE_NUMBER__C"
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

