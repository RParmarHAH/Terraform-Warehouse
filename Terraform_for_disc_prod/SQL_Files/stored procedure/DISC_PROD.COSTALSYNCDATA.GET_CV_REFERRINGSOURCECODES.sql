CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_REFERRINGSOURCECODES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_ReferringSourceCodes 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_ReferringSourceCodes FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Referring_Source_Code, t.$8 AS Last_Name, t.$9 AS First_Name, t.$10 AS Middle_Initial, t.$11 AS Practice_Name, t.$12 AS Address, t.$13 AS City, t.$14 AS STATE_CODE, t.$15 AS Zipcode, t.$16 AS Phone, t.$17 AS Contact_Person, t.$18 AS Emergency_Phone, t.$19 AS Degree, t.$20 AS Specialty_Code, t.$21 AS REFSRC_CATG, t.$22 AS Social_Security_Number, t.$23 AS Tax_ID, t.$24 AS Employer_Id_Number, t.$25 AS Provider_Unique_ID, t.$26 AS Note_40, t.$27 AS Medicare_Number, t.$28 AS Medicaid_Number, t.$29 AS PTD_Charge, t.$30 AS PTD_Cash_Payment, t.$31 AS PTD_Check_Payment, t.$32 AS PTD_Credit_Payment, t.$33 AS PTD_Insurance_Payment, t.$34 AS PTD_Other_Payment, t.$35 AS PTD_Contractual, t.$36 AS PTD_Adjustment, t.$37 AS PTD_Visit, t.$38 AS PTD_Patient, t.$39 AS PTD_Procedure, t.$40 AS YTD_Charge, t.$41 AS YTD_Cash_Payment, t.$42 AS YTD_Check_Payment, t.$43 AS YTD_Credit_Payment, t.$44 AS YTD_Insurance_Payment, t.$45 AS YTD_Other_Payment, t.$46 AS YTD_Contractual, t.$47 AS YTD__Adjustment, t.$48 AS YTD_Visit, t.$49 AS YTD_Patient, t.$50 AS YTD_Procedure, t.$51 AS Blue_Cross_ID, t.$52 AS Other_Provider_ID, t.$53 AS Department__Code, t.$54 AS Taxonomy_Code, t.$55 AS Referring_Source_Email, t.$56 AS NPI, t.$57 AS Sales_Person_ID, t.$58 AS Facility_Code, t.$59 AS CB_NPI, t.$60 AS CB_PECOS, t.$61 AS NPI_Date, t.$62 AS PECOS_Date, t.$63 AS Last_Checked_Date, t.$64 AS DEX_ROW_ID, t.$65 AS SYS_CHANGE_VERSION, t.$66 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$66,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_ReferringSourceCodes.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_ReferringSourceCodes AS WITH curr_v AS (SELECT Db, Referring_Source_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_ReferringSourceCodes GROUP BY Db, Referring_Source_Code) SELECT t.* FROM CostalSyncData.HIST_CV_ReferringSourceCodes t INNER JOIN curr_v v ON t.Db = v.Db AND t.Referring_Source_Code = v.Referring_Source_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';