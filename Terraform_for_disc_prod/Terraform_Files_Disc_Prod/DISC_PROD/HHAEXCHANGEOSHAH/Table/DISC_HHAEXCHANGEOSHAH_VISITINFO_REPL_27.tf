resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_VISITINFO_REPL_27" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "VISITINFO_REPL_27"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.VISITINFO_REPL_27

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITINFOID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONBILLABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISUPDATEDBYPOPUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERADJMINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSKILLEDVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IVRCALLIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IVRCALLOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCDUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IVRDUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISMUTUALLINKEDFAILED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISTEMPSCHEDULE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISTEMPCAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELETEDINVOICENUMBER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELETEDINVOICENUMBER2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPENSE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPENSE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASONEXPENSE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASONEXPENSE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITVERIFIEDBYOTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITDATETIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITAUDITSUPERVISOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ABSENCECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIMECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULLSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISVNSRESUBMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSERVICECODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENTVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECATEGORYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ONHOLDVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLVISITWITHZERORATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICALEDOCID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLINICALEDOCSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POCDUTIESWITHADDITIONALVALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERRIDEMILEAGEEXPENSE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILEAGEDISTANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILEAGERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILEAGEPAYTOTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTALVISITPOCMINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTALVISITPOCMINUTESROUNDED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUDEPAYCODERECALCULATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUDEPAYCODEPAYDIFFERENTIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLPOCDUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMISSIONUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANUALAUTHORIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNALINVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BROADCASTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BROADCASTSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERREQUESTCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICELINEITEMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICELOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIONTAKENREASONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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
	type = "BOOLEAN"
	nullable = true
}

}

