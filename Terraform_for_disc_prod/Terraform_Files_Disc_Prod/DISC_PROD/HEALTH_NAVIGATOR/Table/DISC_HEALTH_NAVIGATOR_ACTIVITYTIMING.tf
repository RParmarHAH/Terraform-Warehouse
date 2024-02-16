resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_ACTIVITYTIMING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "ACTIVITYTIMING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.ACTIVITYTIMING

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

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
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMINGCODEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COUNTINPERIOD"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "LASTREFERENCEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REPETITIONCYCLELENGTH"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "USAGETYPE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACTIVITYDURATIONUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ACTIVITYTIMEOFFSET"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "PERIODENDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PERIODLENGTHUPPERLIMIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MAXACTIVITYDURATION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "PERIODLENGTHUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEMIDENTIFIER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REPETITIONCYCLEUNITID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MAXCOUNTINPERIOD"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SOURCESYSTEMMODIFIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKLYACTIVITYTIMEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "MAXREPETITIONCYCLELENGTH"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PERIODLENGTHLOWERLIMIT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MAXACTIVITYCOUNTPERREPETITION"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "PERIODSTARTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTVIEWEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIVITYDURATION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PERIODLENGTH"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIVITYCOUNTPERREPETITION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTIVITYTIME"
	type = "VARCHAR(4099)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(64)"
	nullable = true
}

}

