CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_NURSES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Nurses 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Nurses FROM (SELECT t.$1 AS DB, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Nurse_ID, t.$8 AS Last_Name, t.$9 AS First_Name, t.$10 AS Middle_Initial, t.$11 AS Address, t.$12 AS Street_Name, t.$13 AS City, t.$14 AS STATE_CODE, t.$15 AS Zipcode, t.$16 AS Nurse_Secondary_ID, t.$17 AS Social_Security_Number, t.$18 AS Birth_Date, t.$19 AS Sex, t.$20 AS Salute, t.$21 AS MARITALSTATS_CODE, t.$22 AS Phone, t.$23 AS Emergency_Phone, t.$24 AS Contact_Person, t.$25 AS Car_Phone, t.$26 AS Beeper_Number, t.$27 AS Beeper_Code, t.$28 AS Specialty_Code, t.$29 AS DDL_Nurse_Status, t.$30 AS Nurse_Status_Date, t.$31 AS Degree, t.$32 AS Resource_Category_Code, t.$33 AS Service_Category_Code, t.$34 AS Hire_Date, t.$35 AS Hire_Commemt, t.$36 AS Termination_Date, t.$37 AS Termination_Comment, t.$38 AS Review_Date, t.$39 AS Review_Comment, t.$40 AS Referring_Source_Code, t.$41 AS CB_Referral_Check, t.$42 AS CB_Inservice, t.$43 AS CB_Medical_Test, t.$44 AS CB_Job_Description, t.$45 AS Addl_Category_Array4_1, t.$46 AS Addl_Category_Array4_2, t.$47 AS Addl_Category_Array4_3, t.$48 AS Addl_Category_Array4_4, t.$49 AS Preferrence_Level, t.$50 AS Prefer_Level_Note40_Arr2_1, t.$51 AS Prefer_Level_Note40_Arr2_2, t.$52 AS General_Note40_Array2_1, t.$53 AS General_Note40_Array2_2, t.$54 AS Location_Code, t.$55 AS Work_Phone, t.$56 AS Primary_Department, t.$57 AS Secondary_Department, t.$58 AS Provider_Code, t.$59 AS Pay_Rate, t.$60 AS Zone_Code, t.$61 AS CB_Hide_Payrate, t.$62 AS DDL_OT_Calc_Method, t.$63 AS DDL_Employee_Type, t.$64 AS Federal_Tax_Filing_St, t.$65 AS Federal_Tax_Exemptions, t.$66 AS State_Tax_Filing_Status, t.$67 AS State_Tax_Exemptions, t.$68 AS Worked_State_Tax_Code, t.$69 AS SUISDI_Tax_Jurisdiction, t.$70 AS Workstation_Name, t.$71 AS Discipline_Code, t.$72 AS CB_Oncall, t.$73 AS Email, t.$74 AS Employee_Profile_Code, t.$75 AS Employee_Manager, t.$76 AS Facility_Code, t.$77 AS Interface_Unique_ID, t.$78 AS First_Payment_Date, t.$79 AS Last_Payment_Date, t.$80 AS First_Charge_Date, t.$81 AS Last_Charge_Date, t.$82 AS CB_Check_Over_Time, t.$83 AS Overtime_Criteria_Code, t.$84 AS Employee_Rating, t.$85 AS PTO_Balance, t.$86 AS Billed_Visits_For_Visit, t.$87 AS Billed_Hours_For_Visit, t.$88 AS Billed_Visits_For_Hourly, t.$89 AS Billed_Hours_For_Hourly, t.$90 AS Paid_Visits_For_Visit, t.$91 AS Paid_Hours_For_Visit, t.$92 AS Paid_Visits_For_Hourly, t.$93 AS Paid_Hours_For_Hourly, t.$94 AS Employee_Status_Code, t.$95 AS Employee_Type_Code, t.$96 AS Total_Billed_Hours, t.$97 AS Total_Billed_Units, t.$98 AS Total_Paid_Hours, t.$99 AS Total_Paid_Units, t.$100 AS Prev_Name, t.$101 AS Ethnicity_Level1, t.$102 AS Ethnicity_Level2, t.$103 AS DEX_ROW_ID, t.$104 AS SYS_CHANGE_VERSION, t.$105 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$105,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Nurses.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Nurses AS WITH curr_v AS (SELECT DB, Nurse_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Nurses GROUP BY DB, Nurse_ID) SELECT t.* FROM CostalSyncData.HIST_CV_Nurses t INNER JOIN curr_v v ON t.DB = v.DB AND t.Nurse_ID = v.Nurse_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';