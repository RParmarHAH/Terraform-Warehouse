resource "snowflake_procedure" "DISC_ACTIVE_DIRECTORY_ADUSERS_RAW" {
	name ="ADUSERS_RAW"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ACTIVE_DIRECTORY"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


/*****************************************************************************************************************************
	NAME:  	 ADUSERS_RAW
	PURPOSE: 
	DATE           AUTHOR                NOTES:
	---------- 	   -------------------   -----------------------------------------------------------------------------------------------
	                                     
	27/07/2023     Ravi Suthar/Komal Dhokai    		 Changed Stage and File_Format 
	
	*****************************************************************************************************************************/
	

INSERT INTO DISC_${var.SF_ENVIRONMENT}.ACTIVE_DIRECTORY.HIST_ADUSERS_RAW

SELECT
	a.$1 as AccountExpirationDate, 
	a.$2 as accountExpires, 
	a.$3 as AccountLockoutTime, 
	a.$4 as AccountNotDelegated, 
	a.$5 as adminCount, 
	a.$6 as AllowReversiblePasswordEncryption, 
	a.$7 as AuthenticationPolicy, 
	a.$8 as AuthenticationPolicySilo, 
	a.$9 as BadLogonCount, 
	a.$10 as badPasswordTime, 
	a.$11 as badPwdCount, 
	a.$12 as c, 
	a.$13 as CannotChangePassword, 
	a.$14 as CanonicalName, 
	a.$15 as Certificates, 
	a.$16 as City, 
	a.$17 as CN, 
	a.$18 as codePage, 
	a.$19 as Company, 
	a.$20 as CompoundIdentitySupported, 
	a.$21 as Country, 
	a.$22 as countryCode, 
	a.$23 as Created, 
	a.$24 as createTimeStamp, 
	a.$25 as Deleted, 
	a.$26 as Department, 
	a.$27 as Description, 
	a.$28 as DisplayName, 
	a.$29 as DistinguishedName, 
	a.$30 as Division, 
	a.$31 as DoesNotRequirePreAuth, 
	a.$32 as dSCorePropagationData, 
	a.$33 as EmailAddress, 
	a.$34 as EmployeeID, 
	a.$35 as EmployeeNumber, 
	a.$36 as Enabled, 
	a.$37 as Fax, 
	a.$38 as GivenName, 
	a.$39 as HomeDirectory, 
	a.$40 as HomedirRequired, 
	a.$41 as HomeDrive, 
	a.$42 as HomePage, 
	a.$43 as HomePhone, 
	a.$44 as Initials, 
	a.$45 as instanceType, 
	a.$46 as isCriticalSystemObject, 
	a.$47 as isDeleted, 
	a.$48 as KerberosEncryptionType, 
	a.$49 as LastBadPasswordAttempt, 
	a.$50 as LastKnownParent, 
	a.$51 as lastLogoff,
	a.$52 as lastLogon,
	a.$53 as LastLogonDate,
	a.$54 as lastLogonTimestamp,
	a.$55 as LockedOut,
	a.$56 as lockoutTime,
	a.$57 as logonCount,
	a.$58 as LogonWorkstations,
	a.$59 as Manager,
	a.$60 as MemberOf,
	a.$61 as MNSLogonAccount,
	a.$62 as MobilePhone,
	a.$63 as Modified,
	a.$64 as modifyTimeStamp,
	a.$65 as msDS_SupportedEncryptionTypes,
	a.$66 as msDS_User_Account_Control_Computed,
	a.$67 as mSMQDigests,
	a.$68 as mSMQSignCertificates,
	a.$69 as Name,
	a.$70 as nTSecurityDescriptor,
	a.$71 as ObjectCategory,
	a.$72 as ObjectClass,
	a.$73 as ObjectGUID,
	a.$74 as objectSid,
	a.$75 as Office,
	a.$76 as OfficePhone,
	a.$77 as Organization,
	a.$78 as OtherName,
	a.$79 as PasswordExpired,
	a.$80 as PasswordLastSet,
	a.$81 as PasswordNeverExpires,
	a.$82 as PasswordNotRequired,
	a.$83 as POBox,
	a.$84 as PostalCode,
	a.$85 as PrimaryGroup,
	a.$86 as primaryGroupID,
	a.$87 as PrincipalsAllowedToDelegateToAccount,
	a.$88 as ProfilePath,
	a.$89 as ProtectedFromAccidentalDeletion,
	a.$90 as pwdLastSet,
	a.$91 as SamAccountName,
	a.$92 as sAMAccountType,
	a.$93 as ScriptPath,
	a.$94 as sDRightsEffective,
	a.$95 as ServicePrincipalNames,
	a.$96 as SID,
	a.$97 as SIDHistory,
	a.$98 as SmartcardLogonRequired,
	a.$99 as State,
	a.$100 as StreetAddress,
	a.$101 as Surname,
	a.$102 as Title,
	a.$103 as TrustedForDelegation,
	a.$104 as TrustedToAuthForDelegation,
	a.$105 as UseDESKeyOnly,
	a.$106 as userAccountControl,
	a.$107 as userCertificate,
	a.$108 as UserPrincipalName,
	a.$109 as uSNChanged,
	a.$110 as uSNCreated,
	a.$111 as whenChanged,
	a.$112 as whenCreated,
	-1 AS ETL_TASK_KEY,
	 -1 AS ETL_INSERTED_TASK_KEY,
	 convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	 CURRENT_USER as ETL_INSERTED_BY,
	 convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	 CURRENT_USER as ETL_LAST_UPDATED_BY,
	 0 as ETL_DELETED_FLAG
FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ActiveDirectory/ADusers (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT_TRIM_SPACE) a;

 EOT
}

