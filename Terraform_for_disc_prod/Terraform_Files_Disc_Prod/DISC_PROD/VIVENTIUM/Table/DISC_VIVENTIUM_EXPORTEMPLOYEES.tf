resource "snowflake_table" "DISC_VIVENTIUM_EXPORTEMPLOYEES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "VIVENTIUM"
	name = "EXPORTEMPLOYEES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.VIVENTIUM.EXPORTEMPLOYEES

    -- Purpose : Discovery Data Population

    -- Project : VIVENTIUM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERSONALID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MIDDLEINITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRIMARYLANGUAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEESTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEESTATUSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEESTATUSDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULLORPARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINALHIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REHIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HIREDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATIONDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATIONREASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BASERATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYFREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STANDARDHOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ADDRESSLINE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESSLINE2"
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
	name = "ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGADDRESSLINE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGADDRESSLINE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGCITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGSTATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGCOUNTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MAILINGCOUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLOCKNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "DATE"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKEXTENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISPRIMARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTCHECKDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LASTCHECKPERIODEND"
	type = "DATE"
	nullable = true
}


column {
	name = "COSTCENTERS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "BENEFITCATEGORYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITCATEGORYDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BENEFITCATEGORYSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BENEFITCATEGORYENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTOPAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BASERATESTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BENEFITSENIORITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CITIZENSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATACONTROLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTTAXLOCATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEFAULTTAXLOCATIONDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPENDENTHEALTHINSELIGIBLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPENDENTHEALTHINSELIGIBILITYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHIFTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DONOTPRODUCE1099"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETHNICCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSSUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HASPENSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HASSHIFTPREMIUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "I9REVIEWDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISASUPERVISOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISI9VERIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISEXEMPTFROMOT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSEASONAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISSTATUTORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOBTRAININGCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONDESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OCCUPATIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMETHOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STUBMESSAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISOREMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIONCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISAEXPIRATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISANUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISATYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKERSCOMPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPERVISOREMPLOYEEKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIEDON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKAUTHORIZATIONSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDITIONALRATES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TAXCODES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CUSTOMFIELDS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "NOTELIGIBLEFORREHIRE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOCATIONSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ALLOCATIONENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "POSITIONSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "POSITIONENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYINFOSTARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYINFOENDDATE"
	type = "DATE"
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
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

