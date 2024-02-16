resource "snowflake_table" "DISC_GPSYNCDATA_UPR00900" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "UPR00900"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.UPR00900

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
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FDWTHLDG_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FDWTHLDG_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FEDERAL_WAGES_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWDG_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICAMWGS_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWG_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FICASSWH_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "FUTAWAGS_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "GROSWAGS_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LPCHKAMT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LPCHKNUM"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "LSTPCKDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NETWAGES_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NETWAGES_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SUTAWAGS_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "YEAR1"
	type = "NUMBER(5,0)"
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

