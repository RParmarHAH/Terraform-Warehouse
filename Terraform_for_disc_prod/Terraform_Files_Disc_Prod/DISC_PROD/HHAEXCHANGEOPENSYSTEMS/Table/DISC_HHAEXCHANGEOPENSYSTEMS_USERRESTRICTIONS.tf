resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_USERRESTRICTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "USERRESTRICTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.USERRESTRICTIONS

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
	nullable = true
}


column {
	name = "RESTRICATEDID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "USERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IPRESTRICTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOURLYRESTRICTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IP1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IP2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IP3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MONFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MONTOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUEFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUETOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WEDFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WEDTOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THUFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THUTOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRIFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRITOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SATFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SATTOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUNFROMTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUNTOTIME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MONIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TUEIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WEDIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "THUIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FRIIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SATIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUNIP"
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

