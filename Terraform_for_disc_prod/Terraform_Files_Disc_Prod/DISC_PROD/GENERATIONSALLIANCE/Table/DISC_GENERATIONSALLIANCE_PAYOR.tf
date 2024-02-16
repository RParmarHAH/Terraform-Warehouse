resource "snowflake_table" "DISC_GENERATIONSALLIANCE_PAYOR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "PAYOR"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.PAYOR

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
	name = "PAYORID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "BADDRESS1"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "BADDRESS2"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "BCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(6000)"
	nullable = true
}


column {
	name = "BADDRESS3"
	type = "VARCHAR(41)"
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
	name = "PHONE1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SENDERCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RECEIVERCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EDIVERSION"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "SUBMITTERNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "SUBMITTERETIN"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "RECEIVERNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "RECEIVERETIN"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "EDICONTACTNAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "EDICONTACTNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLAIMFILINGINDICATOR"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "INTERCHANGEIDQUALIFIER"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "ISA07RECEIVERIDQUALIFIER"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "HHAXENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BIT_INCLUDEOTHERPROVIDERNUMBER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SANDATAENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYORPROGRAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROCEDURECODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ENABLEDMAS90"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDECGNAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDECLIENTADDRESS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROVIDERCOMMERCIALNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVVID"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "ISSANTRAXFIELDUPDATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELLUSENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USEMODIFIER76"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REMOVEGS06GE02LEADINGZERO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDETAXONOMYCODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHENTICAREENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLEMASSACHUSETTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DONOTPRINT2420PRV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISENABLEDNYMEDICAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREBRIDGEENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERRIDENPI"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SANTRAXJURISDICTIONID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "APDICONNECTFLENABLED"
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

