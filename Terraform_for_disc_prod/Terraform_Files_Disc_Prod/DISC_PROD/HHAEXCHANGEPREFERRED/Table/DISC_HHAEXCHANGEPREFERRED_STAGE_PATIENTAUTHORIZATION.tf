resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_STAGE_PATIENTAUTHORIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "STAGE_PATIENTAUTHORIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHORIZATIONNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FROMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TODATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "MAXUNITSFORAUTH"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "BANKEDHOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SATHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "SUNHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "MONHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "TUEHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "WEDHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "THUHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "FRIHOURS"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "MAXUNITSFORPERIOD"
	type = "NUMBER(11,2)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "REMAININGUNITS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "AUTHATTACHMENT"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SERVICETYPEID"
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

