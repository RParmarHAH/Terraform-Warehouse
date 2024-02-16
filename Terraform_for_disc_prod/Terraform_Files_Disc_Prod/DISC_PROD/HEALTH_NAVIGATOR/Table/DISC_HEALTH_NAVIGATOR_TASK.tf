resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_TASK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "TASK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.TASK

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

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
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACCOUNTID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CALLDISPOSITION"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REMINDERDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TESTING_STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RECURRENCEREGENERATEDTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "QUESTION_CATEGORY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RECURRENCEINTERVAL"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RECURRENCEACTIVITYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HAH_EVENT_TYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANTEMPLATE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "COMPLETED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CATEGORY__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "WHOID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACTIVITYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CALLDURATIONINSECONDS"
	type = "NUMBER(8,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__SORTORDER__C"
	type = "NUMBER(15,2)"
	nullable = true
}


column {
	name = "PRIORITY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECURRENCETYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__TASKTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RECORD_LOCKED__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HAH_TASK_TYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ISRECURRENCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECURRENCETIMEZONESIDKEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TIME_OPEN_IN_DAYS__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EVENT_COMPLETED_DATETIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONTRACT_TRACING_STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TASKSUBTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "RECURRENCEMONTHOFYEAR"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECURRENCEINSTANCE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__MONITORED_AT_HOME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RECURRENCESTARTDATEONLY"
	type = "DATE"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(32000)"
	nullable = true
}


column {
	name = "WHATID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "RECURRENCEDAYOFWEEKMASK"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "WHATCOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "RECURRENCEENDDATEONLY"
	type = "DATE"
	nullable = true
}


column {
	name = "CALLTYPE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ISHIGHPRIORITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISCLOSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WHOCOUNT"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANPROBLEM__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CAREPLANGOAL__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "OWNERID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "ACUITY_SCORE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "RECORDTYPEID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "HAH_TASK_SUBTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__AGE__C"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "ISREMINDERSET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_INTERVENTION_TYPE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "TIME_OPEN__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__CONDITIONS_STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HAH_EVENT_SUBTYPE__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RELATED_TO_CAREPLAN__C"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_OBSERVATION_ACTION__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SYSTEMMODSTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISARCHIVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALLOBJECT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HEALTHCLOUDGA__GENDER__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "RECURRENCEDAYOFMONTH"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "COMPLETEDDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVENT_STATUS__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

