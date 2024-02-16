resource "snowflake_table" "DISC_EMPEONPREFERRED_EREVIEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "EREVIEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.EREVIEW

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVIEWER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RATING"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVIEWERSNOTES"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "EMPLOYEESNOTES"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "RAISEAMOUNT"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "NEWPAYAMOUNT"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "NEWPAYPER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NEWPOSITION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NEXTREVIEWDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EFFECTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
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

