resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_SCHEDULES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_SCHEDULES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_SCHEDULES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCH_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "SCH_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_SCHEDULESTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_DESCRIPTION"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "SCH_CHARGERATEOVERRIDEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_CHARGERATEOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_CHARGERATEOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_PAYRATEOVERRIDEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_PAYRATEOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_PAYRATEOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_CHARGERATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_CHARGERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_UNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_BILLRATEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_PAYRATEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_PAYUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_OTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_NOTESDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_PAYREVIEWFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCH_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_PAYNOTES"
	type = "VARCHAR(128)"
	nullable = true
}


column {
	name = "SCH_PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_PAYCODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCH_REVENUECODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCH_BILLINGSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCH_AUTHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_1500POS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500TOS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500DIAG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500EPSDT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_1500EMG"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_1500COB"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_1500LOCALUSE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_USERDEFINED1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_RECURRENCEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_ISRECURRINGAPPOINTMENTROOT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCH_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCH_ISRECURRENCEUNIQUE"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_TOTALCHARGE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_LEGACYBRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_TZID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SCH_TIMEZONEID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_STARTOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_ENDOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_OTMULTI"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_SCHEDSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_SCHEDENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_SCHEDUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_SCHEDUPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_SCHEDOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_SCHEDOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_TELUPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_OTEXEMPTHOURS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCH_OTEXEMPTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500BILLINGMODIFIERID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500BILLINGMODIFIERID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500BILLINGMODIFIERID3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_1500BILLINGMODIFIERID4"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_ORIGINALPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_TOTALBILLABLE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_TOTALBILLED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_TOTALPAID"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_ARRIVALCALLID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_DEPARTURECALLID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCH_TELEPHONYSTATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_INVOICEDETAILDESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCH_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_BILLEDPAIDREGION"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_QCODE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SCH_PAYNONWORKSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_PAYNONWORKENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_BILLNONWORKTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCH_BILLNONWORKSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_BILLNONWORKENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_BILLNONWORKSTARTTIMEOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_BILLNONWORKENDTIMEOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_PAYNONWORKSTARTTIMEOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_PAYNONWORKENDTIMEOFFSET"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCH_NOTERECEIVED"
	type = "DATE"
	nullable = true
}


column {
	name = "SCH_OTRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCH_BILLOTOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCH_BILLOTOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCH_BILLINGOTCALCTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCH_SERVICEPLANHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
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

