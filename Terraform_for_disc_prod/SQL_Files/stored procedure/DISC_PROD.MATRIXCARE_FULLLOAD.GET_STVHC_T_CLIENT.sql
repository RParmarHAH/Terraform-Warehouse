CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_CLIENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_Client 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Client FROM (SELECT t.$1 AS cli_ID, t.$2 AS cli_TypeID, t.$3 AS cli_LastName, t.$4 AS cli_FirstName, t.$5 AS cli_BranchId, t.$6 AS cli_MiddleName, t.$7 AS cli_StatusID, t.$8 AS cli_PayerID, t.$9 AS cli_Address1, t.$10 AS cli_Address2, t.$11 AS cli_City, t.$12 AS cli_StateOrProvince, t.$13 AS cli_PostalCode, t.$14 AS cli_County, t.$15 AS cli_Country, t.$16 AS cli_Phone, t.$17 AS cli_PhoneTypeID, t.$18 AS cli_RaceID, t.$19 AS cli_MaritalStatus, t.$20 AS cli_Travel_Directions, t.$21 AS cli_Email, t.$22 AS cli_Email2, t.$23 AS cli_Notes, t.$24 AS cli_BirthDate, t.$25 AS cli_Sex, t.$26 AS cli_Suffix, t.$27 AS cli_DisasterPlanCode, t.$28 AS cli_DisasterPlanNotes, t.$29 AS cli_TelephonyID, t.$30 AS cli_AuthCheck, t.$31 AS cli_RegionID, t.$32 AS cli_DefaultServiceCode, t.$33 AS cli_MastSchedWeekCode, t.$34 AS cli_Mail_Date, t.$35 AS cli_NOKName, t.$36 AS cli_NOKPhone1, t.$37 AS cli_NOKPhone2, t.$38 AS cli_NOKRelation, t.$39 AS cli_HEPatientLivesWith, t.$40 AS cli_HEPetsInHome, t.$41 AS cli_HESmokersInHome, t.$42 AS cli_LPAdvanceDirectives, t.$43 AS cli_LPLocationOf, t.$44 AS cli_LPCopyRequested, t.$45 AS cli_LPLivingWill, t.$46 AS cli_LPCopyObtained, t.$47 AS cli_LPHCSurrogate, t.$48 AS cli_ACIHName, t.$49 AS cli_ACIHGreeting, t.$50 AS cli_ACIHRelation, t.$51 AS cli_ACIHBirthDate, t.$52 AS cli_RequiresOrientation, t.$53 AS cli_CreatedDate, t.$54 AS cli_CreatedUser, t.$55 AS cli_ModifiedDate, t.$56 AS cli_ModifiedUser, t.$57 AS cli_TS, t.$58 AS cli_LegacyID, t.$59 AS cli_LegacyBranchID, t.$60 AS cli_OasisInterfaceID, t.$61 AS cli_SSN, t.$62 AS cli_CalcUniqueSSN, t.$63 AS cli_UploadTelephony, t.$64 AS cli_AllowMassEmail, t.$65 AS cli_InquiryDate, t.$66 AS cli_Salut, t.$67 AS cli_POLST, t.$68 AS cli_TelephonyAllowCaregiverPhone, t.$69 AS cli_DisplayOnCaregiverPortal, t.$70 AS cli_HIC, t.$71 AS cli_InvcPrintLine, t.$72 AS cli_BillingOTCalcType, t.$73 AS InsertDate, t.$74 AS UpdateDate, t.$75 AS DeletedFlag, t.$76 AS cli_Nickname, t.$77 AS SYS_CHANGE_VERSION, CASE WHEN t.$75 = True THEN ''D'' WHEN t.$73 = t.$74 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$75, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Client[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Client AS SELECT * FROM MatrixCare.VW_CURRENT_STVHC_T_Client ;

    return ''Success'';
END;
';