resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_CLIENTINQUIRY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_CLIENTINQUIRY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_CLIENTINQUIRY

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIINQ_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERRELATONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERPHONE1"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERPHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTBIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_SECONDCLIENTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_SECONDCLIENTRELATION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_SECONDCLIENTBIRTHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_LOCATIONISCLIENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLADDRESS2"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLSTATEORPROVINCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLPOSTALCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLCOUNTY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLCOUNTRY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLPHONE1"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLPHONE2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIINQ_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CLIINQ_NONADMISSIONREASONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_ACTUALSOCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_BILLTO"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIINQ_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_CONVERTEDCLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_CONVERTEDCLIENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_CONVERTEDCLIENTUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIINQ_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIINQ_LEGACYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERFIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERLASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_AMBULATORYFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_AMBULATORYNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIINQ_MEDICATIONSFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_MEDICATIONSNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIINQ_INCONTINENTFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_INCONTINENTNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIINQ_ALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_CALLEREMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_LOCATIONISSERVICECALL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_CALLERBROCHURESENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTBROCHURESENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLBROCHURESENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALENTITYTYPEID"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALENTITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALCONTACTJOINID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_STAFFID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_OASISPHYSICIANID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALNOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALCAMPAIGNID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALTAKENBY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALL_ACTIVITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTADDRESSFROM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLADDRESSFROM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTSALUTATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CALLERSALUTATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_NONADMISSIONNOTES"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "CLIINQ_REFERRALTAKENBYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTEMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTALLOWMASSEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIINQ_SERVICECALLSCHEDULEDBYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIINQ_REGIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIINQ_CLIENTINQUIRYRATINGID"
	type = "NUMBER(10,0)"
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

