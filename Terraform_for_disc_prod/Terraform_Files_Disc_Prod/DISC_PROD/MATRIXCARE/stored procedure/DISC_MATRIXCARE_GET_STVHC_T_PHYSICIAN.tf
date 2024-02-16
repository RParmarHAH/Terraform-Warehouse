resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PHYSICIAN" {
	name ="GET_STVHC_T_PHYSICIAN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Physician 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Physician FROM (SELECT t.$1 AS phys_ID, t.$2 AS phys_FirstName, t.$3 AS phys_LastName, t.$4 AS phys_Active, t.$5 AS phys_BranchID, t.$6 AS phys_CompanyName, t.$7 AS phys_MiddleInitial, t.$8 AS phys_Title, t.$9 AS phys_Sex, t.$10 AS phys_Suffix, t.$11 AS phys_ContactName, t.$12 AS phys_Birthday, t.$13 AS phys_Address1, t.$14 AS phys_Address2, t.$15 AS phys_City, t.$16 AS phys_StateOrProvince, t.$17 AS phys_PostalCode, t.$18 AS phys_County, t.$19 AS phys_Country, t.$20 AS phys_Phone, t.$21 AS phys_PhoneType, t.$22 AS phys_Specialty, t.$23 AS phys_LicenseNum, t.$24 AS phys_UPIN, t.$25 AS phys_DEANumber, t.$26 AS phys_DEADate, t.$27 AS phys_ExpireDt, t.$28 AS phys_DataCurrent, t.$29 AS phys_ContactDate, t.$30 AS phys_Degree, t.$31 AS phys_LicenseStatus, t.$32 AS phys_ActivityStatus, t.$33 AS phys_TaxID, t.$34 AS phys_TaxType, t.$35 AS phys_NPI, t.$36 AS phys_EDIAdditionalID, t.$37 AS phys_EDIAdditionalIDType, t.$38 AS phys_Email, t.$39 AS phys_InfoRequested, t.$40 AS phys_Notes, t.$41 AS phys_RegionID, t.$42 AS phys_CreatedDate, t.$43 AS phys_CreatedUser, t.$44 AS phys_ModifiedDate, t.$45 AS phys_ModifiedUser, t.$46 AS phys_TS, t.$47 AS phys_StatusID, t.$48 AS phys_OasisInterfaceID, t.$49 AS phys_AllowMassEmail, t.$50 AS phys_Dear, t.$51 AS InsertDate, t.$52 AS UpdateDate, t.$53 AS DeletedFlag, t.$54 AS SYS_CHANGE_VERSION, CASE WHEN t.$53 = True THEN ''D'' WHEN t.$51 = t.$52 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$53, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Physician[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Physician AS WITH curr_v AS (SELECT phys_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Physician GROUP BY phys_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PHYS_BRANCHID FROM MatrixCare.HIST_STVHC_T_Physician  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PHYS_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Physician t INNER JOIN curr_v v ON t.phys_ID = v.phys_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PHYS_BRANCHID NOT IN (SELECT PHYS_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

