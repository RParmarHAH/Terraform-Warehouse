resource "snowflake_table" "DISC_DEVERO_DEVERO_BILLMASTERLIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DEVERO"
	name = "DEVERO_BILLMASTERLIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DEVERO.DEVERO_BILLMASTERLIST

    -- Purpose : Discovery Data Population

    -- Project : DEVERO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INSURANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTALAMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDAMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJAMT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMTDUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Current"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVER30"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVER60"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVER90"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVER120"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FROMDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TODATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DAYS2PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSCLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

