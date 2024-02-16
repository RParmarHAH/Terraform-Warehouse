resource "snowflake_table" "DISC_GPSYNCDATA_UPR00500" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "UPR00500"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.UPR00500

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
	name = "AMNTTAKEN"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BSDORCDS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "COURTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COURTNAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "DATAENTDFLT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEDBEGDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEDCAMNT_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDCAMNT_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDCAMNT_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDCAMNT_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDCAMNT_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDENDDT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEDFRMLA"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEDLTMAX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDNFREQ"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEDNMTHD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEDNPRCT_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDNPRCT_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDNPRCT_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDNPRCT_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDNPRCT_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDTRMAX_1"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDTRMAX_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDTRMAX_3"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDTRMAX_4"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDTRMAX_5"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDUCTION_FISCAL_YR_MAX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEDUCTON"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DEDYRMAX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DEPYPRMX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DETRMXUN_1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DETRMXUN_2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DETRMXUN_3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DETRMXUN_4"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DETRMXUN_5"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DOCDESCR"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EARNINGSCODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMPLOYID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FEDMAXDED"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "LTDDEDTN"
	type = "NUMBER(19,5)"
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
	name = "ORIGINALAMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SFRFEDTX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SFRLCLTX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SHFRFICA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SHFRFICAMED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SHFRSTTX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATEMAXDED"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "TXSHANTY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VARDEDTN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "VENDORID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "W2BXLABL"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "W2BXLABL2"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "W2BXLABL3"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "W2BXLABL4"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "W2BXNMBR"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "W2BXNMBR2"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "W2BXNMBR3"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "W2BXNMBR4"
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

