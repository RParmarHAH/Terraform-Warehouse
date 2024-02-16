resource "snowflake_table" "DISC_GPSYNCDATA_HIST_UPR00100" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_UPR00100"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_UPR00100

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ACTINDX"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADRSCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "AFSMVET"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ALTERNATENAME"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "ATACRSTM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ATACRVAC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BENADJDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BENEFITEXPIRE_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIRTHDAY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BIRTHMONTH"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALC_MIN_WAGE_BAL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHANGEBY_I"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CHANGEDATE_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CITIZEN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DATEOFLASTREVIEW_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATEOFNEXTREVIEW_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEMPINAC"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPRTMNT"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEX_ROW_TS"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABLEDVETERAN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DIVISIONCODE_I"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLCLAS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMPLOYMENTTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "EMPLSUFF"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ETHNORGN"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FEDCLSSCD"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FRSTNAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "GENDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "HANDICAPPED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "HRSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "I9RENEW"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LASTDAYWORKED_I"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "LOCATNID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MARITALSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "MIDLNAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MILITARY_DISCHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MINETPAY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NICKNAME"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "NOTEINDX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NOTEINDX2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "OTHERVET"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRIMARY_PAY_RECORD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "RATECLSS"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RECSEPVET"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RSNEMPIN"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "SIKTIMAV"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SKTMACAM"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SKTMHPYR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SMOKER_I"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SOCSCNUM"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SPOUSE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SPOUSESSN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STATUSCD"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STMACMTH"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STRTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUPERVISORCODE_I"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SUTASTAT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UNIONCD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "UNIONEMPLOYEE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "USERDEF1"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "USERDEF2"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "USERID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "VACAPRYR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VACAVLBL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VACCRAMT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VACCRMTH"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "VERIFIED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VETERAN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VIETNAMVETERAN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WCACFPAY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WKHRPRYR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WORKFLOW_APPROVAL_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WORKFLOW_PRIORITY"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WORKFLOW_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WRKRCOMP"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "WRNSTFLSBLWZR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "WRNVCNFLSBLWZR"
	type = "NUMBER(3,0)"
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

