resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_PHYSICIANORDERSHEADERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_PHYSICIANORDERSHEADERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_PHYSICIANORDERSHEADERS

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(25)"
	nullable = false
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ORDER_NUMBER"
	type = "VARCHAR(11)"
	nullable = false
}


column {
	name = "PROGRESS_NOTES_NUMBER"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "SEND_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEND_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATRT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END__DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DDL_PHYSICIAN_ORDER_STAT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ORDER_TYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MEDICATION_CODE"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "ROUTE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FREQUENCY_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FREQUENCY_UNITS_ARR2_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FREQUENCY_UNITS_ARR2_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FREQUENCY_INT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_UNITS_FREQ_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FORMAT"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "TIME_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "PRESCRIPTION_NUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "DDL_ORDER_CONTROL_CODES"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PREVIOUS_ORDER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "INTERFACE_UNIQUE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LENGTHVALUE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_VISITS_DURATION_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_ORDER_TYPE_GROUP"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PHYSICIAN_ORDER_CODE"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DOSE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CB_READY_TO_PRINT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_PRINTED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LAST_PRINTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NUMBER_OF_REFILLS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "REFILLS_COMPLETED"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "LAST_REFILL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORDER_CYCLE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "INVENTORY_ORDER_CYCLE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "QUANTITY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PHARMACY_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MEDICATION_DESCRIPTION"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "CERT_TRAN_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FDB_NDC"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_RFB"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_PORTAL_ORDER_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CP_PURPOSE"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "CB_SIGN_BY_PORTAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "NEW_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NEW_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IN_PROCESS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IN_PROCESS_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMPLETED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMPLETED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SENT_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECEIVE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECEIVE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIGNED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DENIED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DENIED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCONTINUED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCONTINUED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLOSED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLOSED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHANGED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHANGED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLARIFY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLARIFY_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CORRECTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CORRECTED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFIED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFIED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INACTIVATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INACTIVATED_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_ORDER_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_REQUIREMENT_CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_SQL_UPGRADE_01"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_3"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_4"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_5"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_6"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_7"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_8"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_9"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DURATION_INT10_10"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_DURATION_TYPE_ARR2_1"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_DURATION_TYPE_ARR2_2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "TAKE_QUANTITY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CB_DISPENSE_AS_PRESCRIBE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_SUBSTITUTE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PHARMACY_CODE_FROM"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DDL_TRANSMIT_OPTION"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_OTC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_COVERED"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_OTHER_PRES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_MEDICATION_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CP_CLINICAL_NOTE_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CARE_PLAN_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CP_WOUND_NUMBER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ORDER_NUMBER2"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "OUTSIDE_FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PRES_LOC_ID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NOTE30"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "LAST_EPRESC_STATUS"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHARMACY_RX_REF_NO"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "DDL_QUANTITY_QUALIFIER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_REFILL_QTY_QUALIFIER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CB_REOPEN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "REOPEN_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "REOPEN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REOPEN_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_CONTROLLED_DRUG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_ORDER_BY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MEDICATION_CATEGORY"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_STAT_ORDER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_TREATMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "COVERED_REASON_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CB_START_OF_CARE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_RESUMPTION_OF_CARE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_HOLD"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "HOLD_FROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOLD_UNTIL"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_SELF_ADMINISTERED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_ORDER_READ_BACK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ORDER_READ_BACK_TO"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCONTINUED_NOTE"
	type = "VARCHAR(2048)"
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

