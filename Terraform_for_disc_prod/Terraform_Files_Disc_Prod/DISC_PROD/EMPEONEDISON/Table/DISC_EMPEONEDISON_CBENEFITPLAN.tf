resource "snowflake_table" "DISC_EMPEONEDISON_CBENEFITPLAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "CBENEFITPLAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.CBENEFITPLAN

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BENEFITPLANID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PLANCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PLANNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BENEFITTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CARRIERID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "EMPLOYEEDISPLAYNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "POLICYGROUPNUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUBGROUPNUMBER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SELFINSURED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MINIMUMVALUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDITIONALPLANINFO"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "ANNUALMAXIMUMBENEFIT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COINSURANCE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "COPAY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DEDUCTIBLE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DENTALCOVERAGE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ENROLLMENTFORM"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "HOSPITAL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MAXIMUMOUTOFPOCKET"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ORTHODONTICS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OUTOFNETWORKCOVERAGEDETAILS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "PHARMACYCOPAY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PLANINFODOCUMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SPOUSECOVERAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOMESTICPARTNERCOVERAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHILDRENCOVERAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHILDMAXAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STUDENTCHILDMAXAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISABLEDCHILDMAXAGE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRIBUTIONSCHEDULE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DEDUCTIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEDUCTIONTAXABILITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYERCONTRIBUTIONCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPPORTSPAYROLLDEDUCTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TERMINATIONCOVERAGEEND"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MONTHLYPREMIUMCHILDREN"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MONTHLYPREMIUMEMPLOYEE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MONTHLYPREMIUMFAMILY"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MONTHLYPREMIUMSPOUSE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PLANID"
	type = "VARCHAR(10)"
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

