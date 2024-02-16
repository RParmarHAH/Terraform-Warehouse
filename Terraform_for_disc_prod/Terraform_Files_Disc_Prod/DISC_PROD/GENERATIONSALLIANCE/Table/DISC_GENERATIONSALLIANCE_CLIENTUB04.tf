resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENTUB04" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENTUB04"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENTUB04

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "HCFAID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "BILLTYPE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(24)"
	nullable = true
}


column {
	name = "ADMISSIONTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMISSIONSRC"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DISCHARGESTATUS"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RELEASEOFINFORMATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ASSIGNMENTBENEFITS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "OVERRIDEPATIENT_NUMBER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIAGNOSISCODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "OVERRIDEDIAGNOSISCODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OCCURENCECODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OCCURENCEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OCCURENCESPANCODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OCCURENCESPANFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OCCURENCESPANTHROUGH"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADMITDX"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PATIENTCONTROLID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INSUREDNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "RELATIONSHIPTOINSURED"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INSUREDUNIQUEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INSUREDGROUPNAME"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "INSUREDGROUPID"
	type = "VARCHAR(17)"
	nullable = true
}


column {
	name = "OTHERPROVIDER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CONDITIONCODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OTHERINSUREDNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "OTHERINSUREDRELATIONSHIP"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OTHERINSUREDUNIQUEID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OTHERINSUREDGROUPNAME"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "OTHERINSUREDGROUPID"
	type = "VARCHAR(17)"
	nullable = true
}


column {
	name = "REMARKS1"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "CODE39A"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AMOUNT39A"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "CODE39B"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AMOUNT39B"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "CODE39C"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AMOUNT39C"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "CODE39D"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AMOUNT39D"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "DOCUMENTCONTROLNUMBER"
	type = "VARCHAR(26)"
	nullable = true
}


column {
	name = "OTHERPAYORNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "OTHERPAYORID"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "OTHERPAYORRELEASEINFO"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "OTHERPAYORASSIGNMENTBENEFITS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADMISSIONHOUR"
	type = "VARCHAR(2)"
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

