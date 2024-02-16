resource "snowflake_table" "DISC_ACTIVE_DIRECTORY_HIST_ADUSERS_RAW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ACTIVE_DIRECTORY"
	name = "HIST_ADUSERS_RAW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ACTIVE_DIRECTORY.HIST_ADUSERS_RAW

    -- Purpose : Discovery Data Population

    -- Project : ACTIVE_DIRECTORY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ACCOUNTEXPIRATIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTEXPIRES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTLOCKOUTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNTNOTDELEGATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMINCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOWREVERSIBLEPASSWORDENCRYPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHENTICATIONPOLICY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHENTICATIONPOLICYSILO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BADLOGONCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BADPASSWORDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BADPWDCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "C"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANNOTCHANGEPASSWORD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANONICALNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CERTIFICATES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODEPAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPOUNDIDENTITYSUPPORTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTRYCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATETIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISPLAYNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISTINGUISHEDNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DIVISION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOESNOTREQUIREPREAUTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DSCOREPROPAGATIONDATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAILADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENABLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GIVENNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEDIRECTORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEDIRREQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEDRIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPAGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOMEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INITIALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSTANCETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISCRITICALSYSTEMOBJECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ISDELETED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "KERBEROSENCRYPTIONTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTBADPASSWORDATTEMPT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTKNOWNPARENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTLOGOFF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTLOGON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTLOGONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTLOGONTIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCKEDOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCKOUTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOGONCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOGONWORKSTATIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEMBEROF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MNSLOGONACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MOBILEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MODIFYTIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MSDS_SUPPORTEDENCRYPTIONTYPES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MSDS_USER_ACCOUNT_CONTROL_COMPUTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MSMQDIGESTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MSMQSIGNCERTIFICATES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NTSECURITYDESCRIPTOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBJECTCATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBJECTCLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBJECTGUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OBJECTSID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEPHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORGANIZATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OTHERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PASSWORDEXPIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PASSWORDLASTSET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PASSWORDNEVEREXPIRES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PASSWORDNOTREQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POBOX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTALCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYGROUP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYGROUPID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRINCIPALSALLOWEDTODELEGATETOACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILEPATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROTECTEDFROMACCIDENTALDELETION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PWDLASTSET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SAMACCOUNTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SAMACCOUNTTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCRIPTPATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SDRIGHTSEFFECTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEPRINCIPALNAMES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SIDHISTORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SMARTCARDLOGONREQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STREETADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SURNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRUSTEDFORDELEGATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRUSTEDTOAUTHFORDELEGATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USEDESKEYONLY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USERACCOUNTCONTROL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USERCERTIFICATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USERPRINCIPALNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USNCHANGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USNCREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WHENCHANGED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WHENCREATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

