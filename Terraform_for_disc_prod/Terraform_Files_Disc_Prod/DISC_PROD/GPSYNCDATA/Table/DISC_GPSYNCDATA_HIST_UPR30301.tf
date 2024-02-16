resource "snowflake_table" "DISC_GPSYNCDATA_HIST_UPR30301" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_UPR30301"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_UPR30301

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
	name = "LCTXBLWG_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LCTXBLWG_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDHOURS_1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_10"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_11"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_12"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_4"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_5"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_6"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_7"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_8"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDHOURS_9"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MTDWAGES_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MTDWAGES_9"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYROLCD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PYRLRTYP"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STXBLWGS_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_10"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_11"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_12"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_6"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_7"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_8"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STXBLWGS_9"
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

