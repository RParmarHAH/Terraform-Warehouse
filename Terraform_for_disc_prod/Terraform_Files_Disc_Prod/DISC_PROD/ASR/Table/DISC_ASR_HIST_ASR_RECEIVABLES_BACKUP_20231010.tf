resource "snowflake_table" "DISC_ASR_HIST_ASR_RECEIVABLES_BACKUP_20231010" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_RECEIVABLES_BACKUP_20231010"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_RECEIVABLES_BACKUP_20231010

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERSOURCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSASSIGNEDORIGSCHED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITACTUALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMECHECKEDIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMECHECKEDOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISCANCELLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESCHEDULEDTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESPONCIBLEFORCANCELATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANCELATIONCOMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMMLOGRECORDID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPCOMMLOGRECID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RANDOMCHECK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESCHEDULEDEMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LATECHECKINNOTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKEDINFROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECKEDOUTFROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESCHEDULEDVISITRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RESCHEDULEDVISITFEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERNOTIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENOTIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSCREDITED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSTATUSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISFINAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMECHECKEDINISFINAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMECHECKEDOUTISFINAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISPAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISTRIMMEDOVERMAXSHIFT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGCODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSAPPROVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILESTOMAKEVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMETOMAKEVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHINLAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHINLONG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHOUTLAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHOUTLONG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_SEQUENCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_REASONCODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_REASONMEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_EXCEPTIONSCLEARED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_CLIENTSIGNATUREISEMPTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBSERVATIONSNOTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISORNOTIFIEDOFOBSERVATIONSNOTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_TRANSACTIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_LASTSUBMITTEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOCUMENTATIONRECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUALVISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_PAYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDCHECKIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDCHECKOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDCHECKINORIGSCHED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDCHECKOUTORIGSCHED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEHOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUALORSCHEDULEDCHECKIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUALORSCHEDULEDCHECKOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANCELATIONCOMMENTSUSABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILAGECOMPENSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISFIRSTVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COPAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZONEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERNUMCOMMRECRODS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMCOMMRECRODS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDDURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUALDURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUALDURATIONADJUSTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLABLEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EARNEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILESCOMPENSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLDEDUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONTAXABLEPAYROLLDEDUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTALEARNEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUIREDHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECEIVABLEAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECEIVABLEFEEORRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFITAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISBILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGTRANSACTIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENUMBEREXTERN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGPREMIUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGPREMIUMTAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_RECEIVABLEFEEORRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMO_BILLABLEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGMEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIMNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RANK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATECHECKEDIN"
	type = "VARCHAR(16777216)"
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

