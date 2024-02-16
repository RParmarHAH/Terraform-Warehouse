resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_PLACEMENTMASTERWEEK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "PLACEMENTMASTERWEEK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.PLACEMENTMASTERWEEK

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTERWEEKHEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MASTERWEEKFROMDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MASTERWEEKTODATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SATURDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SATURDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SATURDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATURDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SATURDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SATPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATURDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATCONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SATHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SATMINUTES1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SATPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATCONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SATHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SATMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SATPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SATINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SUNDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SUNDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "SUNDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SUNDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUNPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNCONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SUNHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SUNMINUTES1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SUNPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNCONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SUNHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SUNMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "SUNPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUNINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MONDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "MONDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "MONDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "MONDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MONPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONCONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "MONHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MONMINUTES1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MONPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONCONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "MONHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MONMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "MONPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TUESDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "TUESDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "TUESDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUESDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "TUESDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TUEPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUESDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUEBILLTO"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TUEHOURS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TUEMINUTES"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "TUEPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUECONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TUEHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TUEMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "TUEPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TUEINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WEDNESDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "WEDNESDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "WEDNESDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDNESDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "WEDNESDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WEDPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDNESDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDCONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "WEDHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WEDMINUTES1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "WEDPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDCONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "WEDHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WEDMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "WEDPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEDINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "THURSDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "THURSDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "THURSDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THURSDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "THURSDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "THUPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THURSDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THUCONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "THUHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "THUMINUTES1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "THUPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THUCONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "THUHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "THUMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "THUPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "THUINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FRIDAYFROMTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FRIDAYTOTIME"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "FRIDAYAIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRIDAYASSIGNMENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "FRIDAYRATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FRIPAYRATEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRIDAYPOC"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRICONTRACTID1"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "FRIHOURS1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FRIMINUTES1"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FRIPAYRATEID1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRICONTRACTID2"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "FRIHOURS2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FRIMINUTES2"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FRIPAYRATEID2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FRIINCLUDEMILEAGEEXPENSE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

