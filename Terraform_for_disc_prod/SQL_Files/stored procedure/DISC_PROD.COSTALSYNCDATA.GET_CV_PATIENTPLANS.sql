CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PATIENTPLANS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_PatientPlans 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_PatientPlans FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Sequence_Number, t.$9 AS Plan_Code, t.$10 AS Policy_Number, t.$11 AS Billto_Status_Code, t.$12 AS Group_Number, t.$13 AS Pre_Authorization_PatPln, t.$14 AS Pre_Authorization_Number, t.$15 AS RLNSHIP__CODE, t.$16 AS Guarantor_Number, t.$17 AS Effective_Date, t.$18 AS Expiration_Date, t.$19 AS Deductible, t.$20 AS Amount_Billed, t.$21 AS Amount_Paid, t.$22 AS Last_Bill_Date, t.$23 AS Last_Bill_Number, t.$24 AS Last_Bill_Amount, t.$25 AS Last_Payment_Date, t.$26 AS Last_Check_Number, t.$27 AS Last_Payment_Amount, t.$28 AS Last_Tracer_Date, t.$29 AS Electronic_Claim_PatPln, t.$30 AS Accept_Assignment_Patpln, t.$31 AS Insurance_Category_Code, t.$32 AS Capitation_Fee, t.$33 AS Co_Payment, t.$34 AS Payor_Code, t.$35 AS Group_Name, t.$36 AS CB_Claim_NOSV, t.$37 AS Coverage_Pay_Source, t.$38 AS Coverage_Plan, t.$39 AS DDL_Billing_Cycle, t.$40 AS DEX_ROW_ID, t.$41 AS SYS_CHANGE_VERSION, t.$42 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$42,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientPlans.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_PatientPlans AS WITH curr_v AS (SELECT Db, Patient_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientPlans GROUP BY Db, Patient_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_CV_PatientPlans t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';