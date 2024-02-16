resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_VISITINFO_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "VISITINFO_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.VISITINFO_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	name = "VISITINFOID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "NONBILLABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISUPDATEDBYPOPUP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVERRATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "CAREGIVERADJMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISSKILLEDVISIT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IVRCALLIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IVRCALLOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCDUTIES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "IVRDUTIES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMUTUALLINKEDFAILED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ISTEMPSCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISTEMPCAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELETEDINVOICENUMBER1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DELETEDINVOICENUMBER2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXPENSE1"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "EXPENSE2"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REASONEXPENSE1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REASONEXPENSE2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBYOTHER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "VISITAUDITDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITAUDITSUPERVISOR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ABSENCECODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "OVERTIMECODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FULLSERVICECODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ISVNSRESUBMIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARYSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PARENTVISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SERVICECATEGORYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICETYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ONHOLDVISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLVISITWITHZERORATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLINICALEDOCID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLINICALEDOCSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INCLUDEMILEAGEEXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POCDUTIESWITHADDITIONALVALUE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OVERRIDEMILEAGEEXPENSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MILEAGEDISTANCE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "MILEAGERATE"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "MILEAGEPAYTOTAL"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALVISITPOCMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TOTALVISITPOCMINUTESROUNDED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXCLUDEPAYCODERECALCULATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCLUDEPAYCODEPAYDIFFERENTIAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLPOCDUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMISSIONUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MANUALAUTHORIZATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXTERNALINVOICENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BROADCASTTYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "BROADCASTSTATUS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CAREGIVERREQUESTCOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICELINEITEMID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICELOCATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIONTAKENREASONID"
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

