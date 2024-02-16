CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_MDPROCDE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_MDPROCDE 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_MDPROCDE FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS ProcCode, t.$8 AS ProDesc1, t.$9 AS ProcDesc2, t.$10 AS CPTCode, t.$11 AS Unit_Fee, t.$12 AS Proc_Cat, t.$13 AS Specialty_Code, t.$14 AS Place_of_Service, t.$15 AS Recall, t.$16 AS Recall_Days, t.$17 AS Type_of_Service, t.$18 AS Statement, t.$19 AS Charge_Entry, t.$20 AS Discontinued, t.$21 AS Discontinued_Date, t.$22 AS Taxable, t.$23 AS Standard_Units, t.$24 AS Claim, t.$25 AS Electronic_Claim, t.$26 AS Unit_Cost, t.$27 AS Duration, t.$28 AS Revenue_Code, t.$29 AS ICD9_CM_Code, t.$30 AS HCPCS_Code, t.$31 AS Prescription, t.$32 AS Conversion_Factor, t.$33 AS NDC, t.$34 AS NDC_NUmber, t.$35 AS CB_Time_Billing, t.$36 AS Base_Units, t.$37 AS Base_Unit_Time, t.$38 AS Break_Point, t.$39 AS Break_Unit_Time, t.$40 AS PTD_Charge, t.$41 AS PTD_Cash_Payment, t.$42 AS PTD_Check_Payment, t.$43 AS PTD_Credit_Payment, t.$44 AS PTD_Insurance_Payment, t.$45 AS PTD_Other_Payment, t.$46 AS PTD_Contractual, t.$47 AS PTD_Adjustment, t.$48 AS PTD_Procedure, t.$49 AS YTD_Charge, t.$50 AS YTD_Cash_Payment, t.$51 AS YTD_Check_Payment, t.$52 AS YTD_Credit_Payment, t.$53 AS YTD_Insurance_Payment, t.$54 AS YTD_Other_Payment, t.$55 AS YTD_Contractual, t.$56 AS YTD__Adjustment, t.$57 AS YTD_Procedure, t.$58 AS Previous_Balance, t.$59 AS CB_Expand_Panel_Code, t.$60 AS Tax_Code, t.$61 AS Work_RVU, t.$62 AS PE_RVU, t.$63 AS MP_RVU, t.$64 AS RBRVS_Units, t.$65 AS RBRVS_Value, t.$66 AS RECALLRESN_CODE, t.$67 AS Modifier_Code, t.$68 AS Unit_of_Measure, t.$69 AS Value_Code, t.$70 AS Discipline_Code, t.$71 AS Value_Code_Multi_Fac, t.$72 AS NDC_Qualifier, t.$73 AS Modifier2, t.$74 AS Modifier3, t.$75 AS Modifier4, t.$76 AS DEX_ROW_ID, t.$77 AS SYS_CHANGE_VERSION, t.$78 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$78,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_MDPROCDE.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_MDPROCDE AS WITH curr_v AS (SELECT Db, ProcCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_MDPROCDE GROUP BY Db, ProcCode) SELECT t.* FROM CostalSyncData.HIST_CV_MDPROCDE t INNER JOIN curr_v v ON t.Db = v.Db AND t.ProcCode = v.ProcCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';