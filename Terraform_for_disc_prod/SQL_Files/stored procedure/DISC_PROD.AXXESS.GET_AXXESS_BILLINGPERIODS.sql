CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_BILLINGPERIODS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_BILLINGPERIODS 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_BILLINGPERIODS (SELECT A.$1 AS Branch_Id, A.$2 AS Episode_Id, A.$3 AS Patient_Id, A.$4 AS Account, A.$5 AS Branch, A.$6 AS Patient_First_Name, A.$7 AS Patient_Last_Name, A.$8 AS Mrn, A.$9 AS Patient_Status, A.$10 AS Is_Patient_Deleted, A.$11 AS Admission_Id, A.$12 AS Admission_Status, A.$13 AS Billing_Period_Type, A.$14 AS CaseMix_Weight, A.$15 AS Hhrg_Code, A.$16 AS Lupa_Threshold, A.$17 AS Clinical_Grouping, A.$18 AS CoMorbidity_Level, A.$19 AS CoMorbidity, A.$20 AS Functional_Score_Level, A.$21 AS Functional_Score, A.$22 AS Payor_Class, A.$23 AS Completed_Sn_Visit_Count, A.$24 AS Completed_Pt_Visit_Count, A.$25 AS Completed_Ot_Visit_Count, A.$26 AS Completed_St_Visit_Count, A.$27 AS Completed_Pta_Visit_Count, A.$28 AS Completed_Dietician_Visit_Count, A.$29 AS Completed_Hha_Visit_Count, A.$30 AS Completed_Cota_Visit_Count, A.$31 AS Completed_Msw_Visit_Count, A.$32 AS Completed_Lpn_Visit_Count, A.$33 AS Admission_Source, A.$34 AS Episode_Timing, A.$35 AS Final_Claim_Cash_Received, A.$36 AS Managed_Claim_Cash_Received, A.$37 AS Rap_Cash_Received, A.$38 AS Final_Claim_Amount, A.$39 AS Managed_Claim_Amount, A.$40 AS Rap_Amount, A.$41 AS End_Date, A.$42 AS Start_Date, A.$43 AS Is_Admission_Period_Discharged, A.$44 AS Is_Admit, A.$45 AS Is_Recert, A.$46 AS Is_Episode_Active, A.$47 AS Start_Of_Care_Date, A.$48 AS Actual_Hipps_Code, A.$49 AS Actual_Prospective_Pay, A.$50 AS Expected_Billing_Period_Amount, A.$51 AS Expected_Lupa_Amount, A.$52 AS Hipps_Code, A.$53 AS Medicare_Number, A.$54 AS Original_Prospective_Pay, A.$55 AS Schedule_Frequency, A.$56 AS CaseMix_Expected_Amount, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/BillingPeriods(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;
';