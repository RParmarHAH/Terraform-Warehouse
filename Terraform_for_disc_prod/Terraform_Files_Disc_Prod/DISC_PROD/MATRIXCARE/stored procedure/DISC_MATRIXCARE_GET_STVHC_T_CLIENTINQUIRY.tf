resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CLIENTINQUIRY" {
	name ="GET_STVHC_T_CLIENTINQUIRY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientInquiry 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO MatrixCare.HIST_STVHC_T_ClientInquiry FROM (SELECT t.$1 AS cliinq_ID, t.$2 AS cliinq_BranchID, t.$3 AS cliinq_Date, t.$4 AS cliinq_CallerRelatonID, t.$5 AS cliinq_CallerAddress1, t.$6 AS cliinq_CallerAddress2, t.$7 AS cliinq_CallerCity, t.$8 AS cliinq_CallerStateOrProvince, t.$9 AS cliinq_CallerPostalCode, t.$10 AS cliinq_CallerCounty, t.$11 AS cliinq_CallerCountry, t.$12 AS cliinq_CallerPhone1, t.$13 AS cliinq_CallerPhone2, t.$14 AS cliinq_ClientLastName, t.$15 AS cliinq_ClientFirstName, t.$16 AS cliinq_ClientAddress1, t.$17 AS cliinq_ClientAddress2, t.$18 AS cliinq_ClientCity, t.$19 AS cliinq_ClientStateOrProvince, t.$20 AS cliinq_ClientPostalCode, t.$21 AS cliinq_ClientCounty, t.$22 AS cliinq_ClientCountry, t.$23 AS cliinq_ClientBirthDate, t.$24 AS cliinq_SecondClientName, t.$25 AS cliinq_SecondClientRelation, t.$26 AS cliinq_SecondClientBirthDate, t.$27 AS cliinq_ReferralDate, t.$28 AS cliinq_ReferralTypeID, t.$29 AS cliinq_LocationIsClient, t.$30 AS cliinq_ServiceCallAddress1, t.$31 AS cliinq_ServiceCallAddress2, t.$32 AS cliinq_ServiceCallCity, t.$33 AS cliinq_ServiceCallStateOrProvince, t.$34 AS cliinq_ServiceCallPostalCode, t.$35 AS cliinq_ServiceCallCounty, t.$36 AS cliinq_ServiceCallCountry, t.$37 AS cliinq_ServiceCallPhone1, t.$38 AS cliinq_ServiceCallPhone2, t.$39 AS cliinq_Notes, t.$40 AS cliinq_NonAdmissionReasonID, t.$41 AS cliinq_ActualSOCDate, t.$42 AS cliinq_BillTo, t.$43 AS cliinq_PayerID, t.$44 AS cliinq_ConvertedClientID, t.$45 AS cliinq_ConvertedClientDate, t.$46 AS cliinq_ConvertedClientUser, t.$47 AS cliinq_CreatedDate, t.$48 AS cliinq_CreatedUser, t.$49 AS cliinq_ModifiedDate, t.$50 AS cliinq_ModifiedUser, t.$51 AS cliinq_TS, t.$52 AS cliinq_LegacyID, t.$53 AS cliinq_CallerFirstName, t.$54 AS cliinq_CallerLastName, t.$55 AS cliinq_CaregiverID, t.$56 AS cliinq_AmbulatoryFlag, t.$57 AS cliinq_AmbulatoryNotes, t.$58 AS cliinq_MedicationsFlag, t.$59 AS cliinq_MedicationsNotes, t.$60 AS cliinq_IncontinentFlag, t.$61 AS cliinq_IncontinentNotes, t.$62 AS cliinq_AllowMassEmail, t.$63 AS cliinq_CallerEmail, t.$64 AS cliinq_LocationIsServiceCall, t.$65 AS cliinq_CallerBrochureSent, t.$66 AS cliinq_ClientBrochureSent, t.$67 AS cliinq_ServiceCallBrochureSent, t.$68 AS cliinq_ReferralEntityTypeID, t.$69 AS cliinq_ReferralEntityID, t.$70 AS cliinq_ReferralContactJoinID, t.$71 AS cliinq_StaffID, t.$72 AS cliinq_OasisPhysicianID, t.$73 AS cliinq_ReferralNotes, t.$74 AS cliinq_ReferralCampaignID, t.$75 AS cliinq_ReferralTakenBy, t.$76 AS cliinq_ServiceCall_ActivityID, t.$77 AS cliinq_ClientAddressFrom, t.$78 AS cliinq_ServiceCallAddressFrom, t.$79 AS cliinq_ClientSalutationID, t.$80 AS cliinq_CallerSalutationID, t.$81 AS cliinq_NonAdmissionNotes, t.$82 AS cliinq_ReferralTakenByID, t.$83 AS cliinq_ClientEmail, t.$84 AS cliinq_ClientAllowMassEmail, t.$85 AS cliinq_ServiceCallScheduledByID, t.$86 AS cliinq_RegionID, t.$87 AS cliinq_ClientInquiryRatingID, t.$88 AS InsertDate, t.$89 AS UpdateDate, t.$90 AS DeletedFlag, t.$91 AS SYS_CHANGE_VERSION, CASE WHEN t.$90 = True THEN ''D'' WHEN t.$88 = t.$89 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$90, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientInquiry[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientInquiry AS WITH curr_v AS (SELECT cliinq_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientInquiry GROUP BY cliinq_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIINQ_BRANCHID FROM MatrixCare.HIST_STVHC_T_ClientInquiry br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIINQ_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientInquiry t INNER JOIN curr_v v ON t.cliinq_ID = v.cliinq_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CLIINQ_BRANCHID NOT IN (SELECT CLIINQ_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

