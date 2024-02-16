resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_VISITUNBILLEDDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "VISITUNBILLEDDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VISITUNBILLEDDETAILS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

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
	nullable = false
}


column {
	name = "VISITUNBILLEDDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESHEETREQUIRED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISSKILLEDVISIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITRATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "DISCIPLINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERNOTCOMPLIANT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CAREGIVEROVERLAPPING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLINICALDOCNOTCOMPLIANT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INCOMPLETECONFIRMATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INSUFFICIENTDUTYMINUTES"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "INVALIDOT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGABSENCECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGCAREGIVERSSN"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGHHAPCAREGINFO"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGMEDICAIDCOMPLIANCE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGOTCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSINGSERVICELOCATIONCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MORETHAN24HOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "NOPOCATTACHEDTOSCHEDULE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "POCNOTCOMPLIANT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "RESTRICTEDCAREGIVERS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SCHEDULEDWITHHOLDRATE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SHIFTOVERLAPPING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMESHEETNOTAPPROVED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TTOTNOTAPPROVED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "UNAUTHORIZED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "UNBALANCEDVISITS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "VISITMISSINGPAYCODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WITHTEMPCAREGIVER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PREBILLING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELETED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "APPROVEDTRAVELTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

