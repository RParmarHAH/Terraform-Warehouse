resource "snowflake_table" "DISC_PAYLOCITY_EMPLOYEE_DETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYLOCITY"
	name = "EMPLOYEE_DETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PAYLOCITY.EMPLOYEE_DETAILS

    -- Purpose : Discovery Data Population

    -- Project : PAYLOCITY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "COMPANYID"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_ACCOUNTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_ACCOUNTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_AMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_AMOUNTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_BLOCKSPECIAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_ISSKIPPRENOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_NAMEONACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_PRENOTEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALDIRECTDEPOSIT_ROUTINGNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_CHANGEREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_COSTCENTER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_COSTCENTER2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_COSTCENTER3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_EFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_ENDCHECKDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_JOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_RATE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_RATECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_RATENOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_RATEPER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATE_SHIFT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITSETUP_BENEFITCLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITSETUP_BENEFITCLASSEFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITSETUP_BENEFITSALARY"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BENEFITSETUP_BENEFITSALARYEFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITSETUP_DONOTAPPLYADMINISTRATIVEPERIOD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BENEFITSETUP_ISMEASUREACAELIGIBILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYFEIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMBOOLEANFIELDS_CATEGORY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMBOOLEANFIELDS_LABEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMBOOLEANFIELDS_VALUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUSTOMDATEFIELDS_CATEGORY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMDATEFIELDS_LABEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMDATEFIELDS_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMDROPDOWNFIELDS_CATEGORY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMDROPDOWNFIELDS_LABEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMDROPDOWNFIELDS_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMNUMBERFIELDS_CATEGORY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMNUMBERFIELDS_LABEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMNUMBERFIELDS_VALUE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "CUSTOMTEXTFIELDS_CATEGORY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMTEXTFIELDS_LABEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMTEXTFIELDS_VALUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_CHANGEREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_CLOCKBADGENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_COSTCENTER1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_COSTCENTER2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_COSTCENTER3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_EFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_EMPLOYEETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_EQUALEMPLOYMENTOPPORTUNITYCLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_ISMINIMUMWAGEEXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_ISOVERTIMEEXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_ISSUPERVISORREVIEWER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_ISUNIONDUESCOLLECTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_ISUNIONINITIATIONCOLLECTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_JOBTITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_PAYGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_POSITIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_REVIEWERCOMPANYNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_REVIEWEREMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_SHIFT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_SUPERVISORCOMPANYNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_SUPERVISOREMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_TIPPED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_UNIONAFFILIATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_UNIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_UNIONPOSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENTPOSITION_WORKERSCOMPENSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISABILITYDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_PAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_PRIMARYPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_PRIORITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_RELATIONSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_SYNCEMPLOYEEINFO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_WORKEXTENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_WORKPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMERGENCYCONTACTS_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALTAX_AMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_DEDUCTIONSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_DEPENDENTSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_EXEMPTIONS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_FILINGSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALTAX_HIGHERRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEDERALTAX_OTHERINCOMEAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_PERCENTAGE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FEDERALTAX_TAXCALCULATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FEDERALTAX_W4FORMYEAR"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_EMAILADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEADDRESS_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISHIGHLYCOMPENSATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISSMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALTAX_EXEMPTIONS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "LOCALTAX_EXEMPTIONS2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "LOCALTAX_FILINGSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALTAX_RESIDENTPSD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALTAX_TAXCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCALTAX_WORKPSD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_ACCOUNTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_ACCOUNTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_BLOCKSPECIAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_ISSKIPPRENOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_NAMEONACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_PRENOTEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAINDIRECTDEPOSIT_ROUTINGNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_AMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_DEDUCTIONSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_DEPENDENTSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_EXEMPTIONS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_EXEMPTIONS2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_FILINGSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_HIGHERRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_OTHERINCOMEAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_PERCENTAGE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_RECIPROCITYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_SPECIALCHECKCALC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_TAXCALCULATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_TAXCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NONPRIMARYSTATETAX_W4FORMYEAR"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "OWNERPERCENT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PREFERREDNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_ANNUALSALARY"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_BASERATE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_BEGINCHECKDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_CHANGEREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_DEFAULTHOURS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_EFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_ISAUTOPAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_PAYFREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_PAYGRADE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_PAYRATENOTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_PAYTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_RATEPER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYPAYRATE_SALARY"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_AMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_DEDUCTIONSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_DEPENDENTSAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_EXEMPTIONS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_EXEMPTIONS2"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_FILINGSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_HIGHERRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_OTHERINCOMEAMOUNT"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_PERCENTAGE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_SPECIALCHECKCALC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_TAXCALCULATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_TAXCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSTATETAX_W4FORMYEAR"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "PRIORLASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SALUTATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_ADJUSTEDSENIORITYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CHANGEREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_EFFECTIVEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_EMPLOYEESTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_HIREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_ISELIGIBLEFORREHIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_REHIREDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_STATUSTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_TERMINATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_FITWEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_FITWEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_FUTAEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_FUTAEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_ISEMPLOYEE943"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXSETUP_ISPENSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXSETUP_ISSTATUTORY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXSETUP_MEDEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_MEDEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SITWEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SITWEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SSEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SSEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SUIEXEMPTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SUIEXEMPTREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_SUISTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_TAXDISTRIBUTIONCODE1099R"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXSETUP_TAXFORM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VETERANDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEBTIME_BADGENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEBTIME_CHARGERATE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "WEBTIME_ISTIMELABORENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKADDRESS_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_EMAILADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_MAILSTOP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_PAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_PHONEEXTENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKADDRESS_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_ALIENORADMISSIONDOCUMENTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_ATTESTEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_COUNTRYOFISSUANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_FOREIGNPASSPORTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_I94ADMISSIONNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_I9DATEVERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_I9NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_ISI9VERIFIED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_ISSSNVERIFIED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_SSNDATEVERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_SSNNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_VISATYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_WORKAUTHORIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKELIGIBILITY_WORKUNTIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
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
	type = "NUMBER(1,0)"
	nullable = true
}

}

