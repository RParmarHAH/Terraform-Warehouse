resource "snowflake_table" "DISC_GPSYNCDATA_UPR00400" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "UPR00400"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.UPR00400

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
	name = "ACRUSTIM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ACRUVACN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BASE_STEP_INCREASED_ON"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BSDONRTE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BSPAYRCD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DATAENTDFLT"
	type = "NUMBER(3,0)"
	nullable = true
}


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
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FFEDTXRT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FLSTTXRT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "MXPYPPER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NOTEINDX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYADVNC"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYFACTR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYPEROD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAYPRPRD"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYRCORD"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYRTAMT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYTYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAYUNIT"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PAYUNPER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PYADVTKN"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PYSTPTBLID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RPTASWGS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTFDTX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTFUTA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTLTAX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTMCAR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTSSEC"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTSTTX"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SBJTSUTA"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SHFTCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "STEP"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "STEP_EFFECTIVE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STEP_FTE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "STRTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUTASTAT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TAXABLE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "TIPTYPE"
	type = "NUMBER(5,0)"
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

