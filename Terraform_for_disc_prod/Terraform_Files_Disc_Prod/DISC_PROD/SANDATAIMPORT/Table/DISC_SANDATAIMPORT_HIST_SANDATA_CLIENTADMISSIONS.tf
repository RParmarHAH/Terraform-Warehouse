resource "snowflake_table" "DISC_SANDATAIMPORT_HIST_SANDATA_CLIENTADMISSIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "HIST_SANDATA_CLIENTADMISSIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.HIST_SANDATA_CLIENTADMISSIONS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

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
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "LOCATIONNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADMISSIONTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CHARTID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ADMISSIONSTATUS"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "ADMISSIONSTATUS2"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "SOC"
	type = "DATE"
	nullable = true
}


column {
	name = "ROC"
	type = "DATE"
	nullable = true
}


column {
	name = "EOC"
	type = "DATE"
	nullable = true
}


column {
	name = "USESEVV"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFERRALSOURCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFERRALSOURCETYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "COORDINATORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MANAGERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MARKETERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TEAMNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARYPHYSICIANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SECONDARYPHYSICANID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISCOMPLIANT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "COMPLIANTTHRUDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ISLIVEIN"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ISCLUSTER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLUSTERGROUP"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUSASOFDATE"
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

