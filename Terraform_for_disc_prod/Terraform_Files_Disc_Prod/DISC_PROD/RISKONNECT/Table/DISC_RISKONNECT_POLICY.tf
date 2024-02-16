resource "snowflake_table" "DISC_RISKONNECT_POLICY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	name = "POLICY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.RISKONNECT.POLICY

    -- Purpose : Discovery Data Population

    -- Project : RISKONNECT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTACTIVITYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BROKER_COMMISSION_PERCENT__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BROKER_COMPENSATION_TYPE__C"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "BROKER_FEE__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "BROKER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARRIER_COVERAGE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CARRIER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COVERAGE_LINE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATE_EXCESS_CARRIER_NOTIFIED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_POLICY_CANCELED__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_POLICY_EFFECTIVE__C"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_POLICY_EXPIRATION__C"
	type = "DATE"
	nullable = true
}


column {
	name = "EXCESS_POLICY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EXCISE_FEES__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "FRONTING_FEES__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "GROSS_PREMIUM__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HIERARCHY_LEVEL__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ID_PRIOR__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAYER_NUMBER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAMED_INSURED_ADDRESS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NAMED_INSURED__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NET_PREMIUM__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "NOTIFY_EXCESS_CARRIER__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OCCURRENCE_ATTACHMENT_POINT__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHER_FEES__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "POLICY_AGGREGATE_LIMIT__C"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "POLICY_BASIS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_DESCRIPTION__C"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "POLICY_DOCUMENT__C"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "POLICY_OCCURRENCE_LIMIT__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "POLICY_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARY__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRO_RATA_SHARE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRODUCER__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RENEWAL_POLICY__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RETENTION_AMOUNT__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RETENTION_TYPE__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SURPLUS_FEES__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TAX__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BROKER_PAID__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FEES_PAID__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GROSS_PREMIUM_PAID__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NET_PREMIUM_PAID__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TAXES_PAID__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARRIER_RATING_LOOKUP__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POLICY_DETAILS__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TPA__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RECORD__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COVERAGES__C"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COMP_DEDUCTIBLE__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COLLISON_DEDUCTIBLE__C"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIABILITY_DEDUCTIBLE__C"
	type = "NUMBER(38,0)"
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
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

