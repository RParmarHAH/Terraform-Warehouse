resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_RATESCHEDULELASTCHANGES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_RATESCHEDULELASTCHANGES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_RATESCHEDULELASTCHANGES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BILLARGS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYARGS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIENTREGIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERREGIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PRIMPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BILLUNITS"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "PAYUNITS"
	type = "NUMBER(8,4)"
	nullable = true
}


column {
	name = "BILLFLAGSOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYFLAGSOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILLFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILLUNITFLAG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYUNITFLAG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERSOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILLRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLRATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BILLRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILLRATEOVRDSEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYRATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYRATEOVRDSEQ"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEDULESTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEBILLEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEPAYEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESOLVEDBILLFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RESOLVEDPAYFLAG"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEDULESTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BILLEXCLUDEHOLIDAYS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYEXCLUDEHOLIDAYS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLBYSHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADDONRATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADDONRATESOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAYHOLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BILLHOLIDAYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ISBILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISPAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALBILLAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALPAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MARGIN"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ISSERVICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISMULTISERVICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATEDRIVERPROCESSLOGID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CS_ALL"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYORBILLFLAG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RSLC_TOTALOTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OT_CALCRATES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
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

