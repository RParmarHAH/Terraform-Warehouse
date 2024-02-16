CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PATIENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Patients 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Patients FROM (SELECT t.$1 AS Db, t.$2 AS DEX_ROW_ID, t.$3 AS Patient_Number, t.$4 AS Guarantor_Number, t.$5 AS Last_Name, t.$6 AS First_Name, t.$7 AS Middle_Initial, t.$8 AS Address, t.$9 AS Street_Name, t.$10 AS City, t.$11 AS STATE_CODE, t.$12 AS Zipcode, t.$13 AS Social_Security_Number, t.$14 AS Birth_Date, t.$15 AS Sex, t.$16 AS Phone, t.$17 AS RLNSHIP__CODE, t.$18 AS Provider_Code, t.$19 AS Referring_Source_Code, t.$20 AS Chart_Number, t.$21 AS First_Visit_Date, t.$22 AS Patient_Sign_on_file, t.$23 AS MARITALSTATS_CODE, t.$24 AS Patient_Status, t.$25 AS RESIDENCY_CODES, t.$26 AS RACE_CODE, t.$27 AS Total_Charge, t.$28 AS Total_Payment, t.$29 AS Total_Adjustment, t.$30 AS Last_Visit_Date, t.$31 AS Last_Charge_Date, t.$32 AS Last_Payment_Date, t.$33 AS Last_Adjustment_Date, t.$34 AS Last_Statement_Date, t.$35 AS Last_Claim_Date, t.$36 AS Last_BillTo_Date, t.$37 AS Co_Payment, t.$38 AS Facility_Code, t.$39 AS Sequence_Number, t.$40 AS Total_Contractual, t.$41 AS PTD_Charge, t.$42 AS PTD_Payment, t.$43 AS PTD_Adjustment, t.$44 AS YTD_Charge, t.$45 AS YTD_Payments, t.$46 AS YTD__Adjustment, t.$47 AS Location_Code, t.$48 AS Department__Code, t.$49 AS YTD_Visit, t.$50 AS YTD_Visit_Start_Date, t.$51 AS Billto_Status_Code, t.$52 AS Cell_Phone, t.$53 AS Email, t.$54 AS Fax_Number, t.$55 AS Priority_Code, t.$56 AS Schedule_Count, t.$57 AS Patient_Cancel_Count, t.$58 AS Patient_Reschedule_Count, t.$59 AS Patient_Missed_Visit_Cnt, t.$60 AS Entry_Date, t.$61 AS Update_Date, t.$62 AS SYS_CHANGE_VERSION, t.$63 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$63,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Patients.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Patients AS WITH curr_v AS (SELECT Db, Patient_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Patients GROUP BY Db, Patient_Number) SELECT t.* FROM CostalSyncData.HIST_CV_Patients t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';