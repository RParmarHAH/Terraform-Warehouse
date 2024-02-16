CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PATIENTPLANCOPAYS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_PatientPlanCopays 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_PatientPlanCopays FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Plan_Code, t.$9 AS Statrt_Date, t.$10 AS End__Date, t.$11 AS Co_Payment, t.$12 AS Date_Entered, t.$13 AS Previous_Copay_Amount, t.$14 AS DDL_Copay_Transfer, t.$15 AS DDL_Rate_Type, t.$16 AS CB_Pro_Rate, t.$17 AS DDL_Retro_Calculation_Me, t.$18 AS CB_Use_Detail_Procedure, t.$19 AS DDL_Change_Option, t.$20 AS CB_Retro_Billing, t.$21 AS CB_Retro_Change, t.$22 AS Retro_Completed_Date, t.$23 AS ProcCode, t.$24 AS Retro_Start_Date, t.$25 AS CB_Incl_MedA_Co_Ins_Days, t.$26 AS CB_Adjust_Copay_Daily, t.$27 AS PL_Pay_Source, t.$28 AS PL_Plan, t.$29 AS DEX_ROW_ID, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientPlanCopays.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_PatientPlanCopays AS WITH curr_v AS (SELECT Db, Patient_Number, Plan_Code, Statrt_Date, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientPlanCopays GROUP BY Db, Patient_Number, Plan_Code, Statrt_Date) SELECT t.* FROM CostalSyncData.HIST_CV_PatientPlanCopays t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Plan_Code = v.Plan_Code AND t.Statrt_Date = v.Statrt_Date AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';