resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CAREGIVERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CAREGIVERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERS

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
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INITIALS"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERCODE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "TIMEANDATTENDANCEPIN"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ALTERNATECAREGIVERCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REHIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COUNTRYOFBIRTH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DEPENDENTS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEETYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INACTIVEREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INACTIVENOTE"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "TERMINATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SENT105"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMPLOYMENTTYPE"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "APPLICATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEAMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYER"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "REGISTRYNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "REGISTRYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFERRALPERSON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NYCREGISTRYCHECKEDON"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "NYCREGISTRYCHECKEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTCHECKEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXCLUSIONLISTSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STREET1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STREET2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP5"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMERGENCY1NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMERGENCY1ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPNAME1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPOTHER1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY1PHONE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY1PHONE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY2NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY2ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCY2RELATIONSHIPID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMERGENCY2RELATIONSHIPNAME1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMERGENCY1RELATIONSHIPOTHER2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY2PHONE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMERGENCY2PHONE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTIFICATIONMETHOD"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "NOTIFICATIONEMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTIFICATIONTEXTNUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NOTIFICATIONVOICEMAIL"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "I9DOCUMENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "I9DOCUMENT2"
	type = "VARCHAR(29)"
	nullable = true
}


column {
	name = "I9EXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "I9VERIFIED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "I9COMMENTS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REFERENCE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFERENCE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT1"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT2"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDDATE3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRESULT3"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "CRIMINALBACKGROUNDRECEIVEDDATE3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTAGENCY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTEMPLOYMENTENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROFESSIONALLICENSENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LICENSEDATEVERIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROFESSIONALREGISTRATIONEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTOMOBILEINSURANCEEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NOCAR"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MALPRACTICEINSURANCEEXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CPRVERIFIEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PICCCERTIFICATIONDATEVERIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NPINUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LANGUAGE1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LANGUAGE2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LANGUAGE3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LANGUAGE4"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FEDEXEMPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PENSIONPROFITSHARING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EXEMPTIONFROMOVERTIME"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DIRECTDEPOSIT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "NYCRESIDENT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "EMPLOYEE1099"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "UNIONREDUCTION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MEDICALDEDUCTIONCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYCYCLE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UNIQUEMOBILEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UNIQUEMOBILETYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BRANCHNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FIRSTDAYWORKED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTDAYWORKED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFERRALSOURCE"
	type = "VARCHAR(100)"
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

