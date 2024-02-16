resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CAREGIVER" {
	name ="GET_STVHC_T_CAREGIVER"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Caregiver 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Caregiver FROM (SELECT t.$1 AS car_ID, t.$2 AS car_LastName, t.$3 AS car_FirstName, t.$4 AS car_MiddleName, t.$5 AS car_StatusID, t.$6 AS car_BranchID, t.$7 AS car_RegionID, t.$8 AS car_InternalID, t.$9 AS car_Phone, t.$10 AS car_PhoneType, t.$11 AS car_Title, t.$12 AS car_SkillCd, t.$13 AS car_Address1, t.$14 AS car_Address2, t.$15 AS car_City, t.$16 AS car_StateOrProvince, t.$17 AS car_PostalCode, t.$18 AS car_County, t.$19 AS car_Country, t.$20 AS car_Email1, t.$21 AS car_Email2, t.$22 AS car_TextMessage, t.$23 AS car_Birthdate, t.$24 AS car_SpouseName, t.$25 AS car_Notes, t.$26 AS car_ADPFileNum, t.$27 AS car_NPI, t.$28 AS car_EmpSubCod_UD, t.$29 AS car_Group, t.$30 AS car_EmpOTFlag, t.$31 AS car_TelephonyID, t.$32 AS car_Supervisor, t.$33 AS car_Manager, t.$34 AS car_InternalCaseMgr, t.$35 AS car_ShiftDiffFlag, t.$36 AS car_PayType, t.$37 AS car_WageChartID, t.$38 AS car_PayRate, t.$39 AS car_NumAllowances, t.$40 AS car_WithHold, t.$41 AS car_PayPreference, t.$42 AS car_VacationHours, t.$43 AS car_DDBankAcctType, t.$44 AS car_ExcludeHoliday, t.$45 AS car_CreatedDate, t.$46 AS car_CreatedUser, t.$47 AS car_ModifiedDate, t.$48 AS car_ModifiedUser, t.$49 AS car_TS, t.$50 AS car_Role, t.$51 AS car_LegacyID, t.$52 AS car_LegacyBranchID, t.$53 AS car_EmpSSN, t.$54 AS car_DDBankRoutingNum, t.$55 AS car_DDBankAcctNum, t.$56 AS car_CalcUniqueSSN, t.$57 AS car_BonusPointsThershold, t.$58 AS car_EmpSexID, t.$59 AS car_MaritalStatID, t.$60 AS car_EmpSalutID, t.$61 AS car_Nickname, t.$62 AS car_AllowMassEmail, t.$63 AS car_ReferralTerritoryID, t.$64 AS car_UploadTelephony, t.$65 AS car_WSNumAllowances, t.$66 AS car_WSWithHold, t.$67 AS car_SUISDI_TaxJurisdiction, t.$68 AS car_FedFilingStatus, t.$69 AS car_WSFilingStatus, t.$70 AS car_WorkState, t.$71 AS car_RSNumAllowances, t.$72 AS car_RSWithHold, t.$73 AS car_RSFilingStatus, t.$74 AS car_TelephonyAllowCaregiverPhone, t.$75 AS car_EDIAdditionalID, t.$76 AS car_EDIAdditionalIDType, t.$77 AS car_RaceID, t.$78 AS car_EmpMHFlag, t.$79 AS InsertDate, t.$80 AS UpdateDate, t.$81 AS DeletedFlag, t.$82 AS SYS_CHANGE_VERSION, CASE WHEN t.$81 = True THEN ''D'' WHEN t.$79 = t.$80 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$81, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Caregiver[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Caregiver AS SELECT * FROM MatrixCare.VW_CURRENT_STVHC_T_Caregiver;

    return ''Success'';
END;

 EOT
}

