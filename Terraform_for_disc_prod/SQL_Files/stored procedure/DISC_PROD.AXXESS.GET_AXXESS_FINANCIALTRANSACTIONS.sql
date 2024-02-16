CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_FINANCIALTRANSACTIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_FinancialTransactions 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_FinancialTransactions (SELECT DISTINCT * FROM (SELECT A.$1 AS BRANCH_ID,  A.$2 AS Branch_Name,  A.$3 AS Account_Id,  A.$4 AS Account_Name,  A.$5 AS Client_Id,  A.$6 AS Client_First_Name,  A.$7 AS Client_Last_Name,  A.$8 AS Client_Middle_Initial,  A.$9 AS MRN,  A.$10 AS Admission_Status,  A.$11 AS Client_Status,  A.$12 AS Client_Dob,  A.$13 AS Client_Address1,  A.$14 AS Client_Address2,  A.$15 AS Client_State,  A.$16 AS Client_City,  A.$17 AS Client_Zip,  A.$18 AS Client_Referral_Source,  A.$19 AS Client_Diagnosis_Id,  A.$20 AS Client_Diagnosis_Name,  A.$21 AS Insurance_Name,  A.$22 AS Primary_Insurance_Id,  A.$23 AS Payor_Id,  A.$24 AS Payor_Name,  A.$25 AS   Payor_Type,  A.$26 AS Transaction_Id,  A.$27 AS Transaction_Type,  A.$28 AS Transaction_Date,  A.$29 AS Billed_Date,  A.$30 AS Adjustment_Date,  A.$31 AS Adjustment_Amount,  A.$32 AS Payment_Date,  A.$33 AS Payment_Amount,  A.$34 AS Claim_Id,  A.$35 AS Claim_StartDate,  A.$36 AS Claim_EndDate,  A.$37 AS Claim_Amount,  A.$38 AS Claim_Status,  A.$39 AS AdmissionIsDeprecated,  A.$40 AS Branch_State_Code,  A.$41 AS Branch_Zip_Code,  A.$42 AS ClientIsDeprecated ,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/FinancialTransactions(file_format => DISC_PROD.STAGE.PSV_FORMAT) A));

    return ''Success'';
END;
';