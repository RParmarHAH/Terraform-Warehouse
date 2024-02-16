resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_CAREGIVERMAXVISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "CAREGIVERMAXVISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERMAXVISITS

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
	name = "CAREGIVERINFOID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATURDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUESDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDNESDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THURSDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRIDAYMAXVISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EDITCAREGIVERAVAILABILITYVIAMOBILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AIDEEDITCAREGIVERAVAILABILITYVIAMOBILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESVIEW"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASESREQUESTACCEPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVEROPENCASEREQUESTLIMITVALUE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERRIDEVISITTIMECORRECTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCAREGIVERVISITTIMECORRECTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWCAREGIVERVISITTIMECORRECTIONWITHOUTEVV"
	type = "BOOLEAN"
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

