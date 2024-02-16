resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_ADMISSIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_ADMISSIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_ADMISSIONS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ADM_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "ADM_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_MEDICALRECORDNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADM_REFERRALDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_REFERRALTAKENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADM_REFERRALTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_NONADMISSIONREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_STATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_INTERNALCASEMGRID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_VERBALSOCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_VERBALSOCTAKENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADM_SOURCEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_ACTUALSOCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_PRIMARYDIAGNOSIS"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "ADM_DIAGNOSISNOTES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "ADM_EXCLUDEBILLINGFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_DISCHARGEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_DISCHARGEREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_DISCHARGERECORDEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_LASTSERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_DISCHARGESUMMARYREASON"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_DISCHARGESUMMARYEVALUATIONOFGOALS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_DISCHARGESUMMARYCONDITIONOFCLIENT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_DISCHARGESUMMARYDISPOSITIONOFCLIENT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_OTHERDISCHARGENOTES_INTERNALUSE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADM_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADM_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADM_NONADMITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADM_HHASPECIALINSTRUCTIONS"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "ADM_HHAACTIVITIES"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "ADM_HHAOTHERINSTRUCTIONS"
	type = "VARCHAR(512)"
	nullable = true
}


column {
	name = "ADM_RELINFO"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADM_ASSIGNBENEFITS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADM_REFERRALENTITYTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ADM_REFERRALENTITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_REFERRALCONTACTJOINID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_STAFFID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_OASISPHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_REFERRALNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADM_REFERRALCAMPAIGNID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_ADMISSIONSDISPOSITIONREASONSID_NAR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_NONADMITNOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADM_ADMISSIONSDISPOSITIONREASONSID_DCHG"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADM_REFERRALTAKENBYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_CAHPSPARTICIPATIONDECLINED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_CAHPSRECEIVINGHOSPICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_CAHPSRECEIVINGPEDIATRIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_CAHPSRECEIVINGMATERNITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_F2FENCOUNTER"
	type = "DATE"
	nullable = true
}


column {
	name = "ADM_RECEIVINGINSULININJECTIONSERVICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_RECEIVINGHOSPICESERVICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADM_RECEIVINGINSULINSERVICESNOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADM_RECEIVINGHOSPICESERVICESNOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADM_CERTPHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_SUPERVISORID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_COORDINATORID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADM_FEATURES"
	type = "NUMBER(19,0)"
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

