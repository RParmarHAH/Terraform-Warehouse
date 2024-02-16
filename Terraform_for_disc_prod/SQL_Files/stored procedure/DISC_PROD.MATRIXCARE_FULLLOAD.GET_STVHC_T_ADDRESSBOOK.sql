CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_ADDRESSBOOK("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_AddressBook 
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
    COPY INTO MatrixCare.HIST_STVHC_T_AddressBook FROM (SELECT t.$1 AS addbk_ID, t.$2 AS addbk_BranchID, t.$3 AS addbk_FirstName, t.$4 AS addbk_LastName, t.$5 AS addbk_CompanyName, t.$6 AS addbk_Title, t.$7 AS addbk_ContactName, t.$8 AS addbk_Position, t.$9 AS addbk_BirthDate, t.$10 AS addbk_TypeID, t.$11 AS addbk_Notes, t.$12 AS addbk_Address1, t.$13 AS addbk_Address2, t.$14 AS addbk_City, t.$15 AS addbk_StateOrProvince, t.$16 AS addbk_PostalCode, t.$17 AS addbk_County, t.$18 AS addbk_Country, t.$19 AS addbk_Email, t.$20 AS addbk_Email2, t.$21 AS addbk_CreatedUser, t.$22 AS addbk_CreatedDate, t.$23 AS addbk_ModifiedDate, t.$24 AS addbk_ModifiedUser, t.$25 AS addbk_TS, t.$26 AS addbk_AllowMassEmail, t.$27 AS addbk_LegacyID, t.$28 AS addbk_LegacyBranchID, t.$29 AS addbk_SalutationID, t.$30 AS addbk_ContactTypeBitwise, t.$31 AS addbk_Hobbies, t.$32 AS addbk_TextMessage, t.$33 AS addbk_RegionID, t.$34 AS addbk_Website, t.$35 AS temp_ID, t.$36 AS temp_Table, t.$37 AS InsertDate, t.$38 AS UpdateDate, t.$39 AS DeletedFlag, t.$40 AS SYS_CHANGE_VERSION, CASE WHEN t.$39 = True THEN ''D'' WHEN t.$37 = t.$38 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$39, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_AddressBook[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_AddressBook AS WITH curr_v AS (SELECT addbk_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_AddressBook GROUP BY addbk_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT ADDBK_BRANCHID FROM MatrixCare.HIST_STVHC_T_AddressBook br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.ADDBK_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_AddressBook t INNER JOIN curr_v v ON t.addbk_ID = v.addbk_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ADDBK_BRANCHID NOT IN (SELECT ADDBK_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';