resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_TRAINEEPROFILE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "TRAINEEPROFILE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TRAINEEPROFILE

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
	name = "TRAINEEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "OFFICE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PROGRAMENROLLEDIN"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLASSSTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMPLETIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROGRAMENROLLED"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DATEOFENROLLMENT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATEAWARDED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CERTIFICATEPRINTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFIEDHCR"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TRAININGSCHOOL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COUNTRYOFBIRTH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFERRALSOURCE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INITIALS"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "LANGUAGE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ETHNICITYTEXT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LANGUAGE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(50)"
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
	name = "TEAM"
	type = "VARCHAR(111)"
	nullable = true
}


column {
	name = "VERIFICATIONMETHOD1"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "VERIFICATIONMETHOD2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "VERIFIED1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VERIFIED2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(111)"
	nullable = true
}


column {
	name = "COMPETENCY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(111)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CROSSSTREET"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PHONE"
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
	name = "EMERGENCY1RELATIONSHIP"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMERGENCY1ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCY1NAME"
	type = "VARCHAR(200)"
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
	name = "EMERGENCY2RELATIONSHIP"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMERGENCY2ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMERGENCY2NAME"
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
	name = "GPA"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HCRCERTIFICATERECEIVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HHAFINALGRADE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SPT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPPRACTICALTRAINING"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRAININGSITE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VERIFICATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AVERAGE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLASSCOMPLETIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSTRUCTOR"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INSTRUCTORNAME"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TUITIONSPONSORSHIP"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "JOBPLACEMENT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PCASCHOOL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VERIFIED"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRANCEEXAMINATION"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "ATBTEST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SIGNEDBYRN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCORE"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "PCACERTIFICATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PCAFINALGRADE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HIGHSCHOOLDIPLOMA"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "I9DOCUMENT1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "I9DOCUMENT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "I9DOCUMENTTEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EVERIFYNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "I9DOCUMENTEXPIRATION"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "I9VERIFIED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RELATIONSHIPNAME1"
	type = "VARCHAR(111)"
	nullable = true
}


column {
	name = "RELATIONSHIPNAME2"
	type = "VARCHAR(111)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRAINEETEAMID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
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

