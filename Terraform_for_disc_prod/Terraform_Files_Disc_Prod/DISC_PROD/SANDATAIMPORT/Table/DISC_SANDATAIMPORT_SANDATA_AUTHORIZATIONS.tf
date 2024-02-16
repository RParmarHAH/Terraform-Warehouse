resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_AUTHORIZATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_AUTHORIZATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_AUTHORIZATIONS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

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
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "AUTHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "MODIFIER1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFER2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFER3"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFER4"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "AUTHREFNO"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FORMAT"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "DATEBEGIN"
	type = "DATE"
	nullable = true
}


column {
	name = "DATEEND"
	type = "DATE"
	nullable = true
}


column {
	name = "MAXIMUM"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "LIMITTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "PERIODLIMIT"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "LIMITDAY1"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY1"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY2"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY2"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY3"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY3"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY4"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY4"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY5"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY5"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY6"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY6"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LIMITDAY7"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "TBDAY7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TEDAY7"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHVOIDED"
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

