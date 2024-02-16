resource "snowflake_table" "DISC_ALAYACARE_MEDICATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "MEDICATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.MEDICATION

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "MEDICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDADMIN_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PK_MEDICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MED_EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MED_EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MEDADMIN_EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MEDADMIN_EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_COMPLETED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MEDADMIN_HELD"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "MEDICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIGH_ALERT"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "MEDICATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMINISTERED_BY_NURSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOSAGE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ROUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELIVERY_MODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMINISTRATION_TIMES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORDERING_PHYSICIAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INFORMATION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCREPANCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCREPANCY_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TIME_INSTRUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPECIAL_INSTRUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCREPANCY_NOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_CONCENTRATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_CREATED_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_DATE_COMPLETE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_DID_NOT_ADMINISTER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_MEDICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_ROUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_UPDATED_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTERED_BY_NURSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATION_TIMES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ADMINISTRATOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_CREATED_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_CREATED_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DELIVERY_MODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DISCREPANCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DISCREPANCY_NOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DISCREPANCY_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DOSAGE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_DOSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_END_DATE_UNKNOWN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_HIGH_ALERT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_INFORMATION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_MEDICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_MEDICATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ORDERING_PHYSICIAN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_ROUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_SPECIAL_INSTRUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_START_DATE_UNKNOWN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_TIME_INSTRUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_UPDATED_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_MEDICATION_UPDATED_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

