resource "snowflake_table" "DISC_GENERATIONSALLIANCE_MASSACHUSETTSEXPORTEDDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "MASSACHUSETTSEXPORTEDDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.MASSACHUSETTSEXPORTEDDETAILS

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
	name = "EXPORTEDDETAILSID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "EXPORTEDID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASSHEALTHID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SIMSCONSUMERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROVIDERFEINNUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "WORKERID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORKERFIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WORKERMIDDLEINITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WORKERLASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ASSOCIATEDASAP"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CONSUMERFIRSTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONSUMERMIDDLEINITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CONSUMERLASTNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISITIDENTIFIER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITRECORDINGMETHOD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ELECTRONICVERIFICATIONMETHODTYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "VISITRECORDUPLOADSTATUS"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "NON_ELECTRONICVERIFICATIONVISITREASON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICEBEGINDATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICEBEGINTIME"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "SERVICEENDDATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICEENDTIME"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "SERVICEBEGINGPSLATITUDE"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "SERVICEBEGINGPSLONGITUDE"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "SERVICEENDGPSLATITUDE"
	type = "VARCHAR(13)"
	nullable = true
}


column {
	name = "SERVICEENDGPSLONGITUDE"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "CAREPROGRAM"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HCPCSCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BILLABLEMINUTES"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SERVICEADDRESSLINE1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICEADDRESSLINE2"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICEADDRESSCITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICEADDRESSSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SERVICEADDRESSZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "SERVICEBEGINPHONENUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICEENDPHONENUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RESOURCEID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "ASSOCIATEDORGANIZATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DATEOFBIRTH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HCPCSMODIFIER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TYPEOFSERVICEPROVIDED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDITECHID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILLABLEUNITS"
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

