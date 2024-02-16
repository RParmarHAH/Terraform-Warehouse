resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CAREGIVERS_28" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CAREGIVERS_28"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CAREGIVERS_28

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
	name = "CAREGIVERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INITIALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEANDATTENDANCEPIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALTERNATECAREGIVERCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REHIREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRYOFBIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPENDENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INACTIVEREASONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INACTIVENOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SENT105"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEAMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGISTRYNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REGISTRYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALPERSON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NYCREGISTRYCHECKEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NYCREGISTRYCHECKEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTCHECKEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREET2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP5"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPID1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPNAME1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPOTHER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1PHONE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2RELATIONSHIPID2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2RELATIONSHIPNAME1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPOTHER2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2PHONE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCY2PHONE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTIFICATIONMETHOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTIFICATIONEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTIFICATIONTEXTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTIFICATIONVOICEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9DOCUMENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9DOCUMENT2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9EXPIRATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9VERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTAGENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTSTARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFESSIONALLICENSENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LICENSEDATEVERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFESSIONALREGISTRATIONEXPIRATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTOMOBILEINSURANCEEXPIRATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOCAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MALPRACTICEINSURANCEEXPIRATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CPRVERIFIEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PICCCERTIFICATIONDATEVERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NPINUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANGUAGE4"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDEXEMPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PENSIONPROFITSHARING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXEMPTIONFROMOVERTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIRECTDEPOSIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NYCRESIDENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE1099"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIONREDUCTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICALDEDUCTIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYCYCLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIQUEMOBILEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIQUEMOBILETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCHNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTDAYWORKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTDAYWORKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRALSOURCE"
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

