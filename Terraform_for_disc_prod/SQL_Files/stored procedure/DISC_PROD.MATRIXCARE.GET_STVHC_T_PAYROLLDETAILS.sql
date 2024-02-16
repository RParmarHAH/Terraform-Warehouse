CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYROLLDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayrollDetails 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollDetails FROM (SELECT t.$1 AS prolld_ID, t.$2 AS prolld_PayrollBatchID, t.$3 AS prolld_CheckTransID, t.$4 AS prolld_CaregiverID, t.$5 AS prolld_PayrollCompanyEmployeeID, t.$6 AS prolld_ScheduleID, t.$7 AS prolld_ScheduleExpenseID, t.$8 AS prolld_ShiftNo, t.$9 AS prolld_BranchHolidayID, t.$10 AS prolld_HolidayMultiplier, t.$11 AS prolld_HolidayAddition, t.$12 AS prolld_ServiceEndTime, t.$13 AS prolld_ServiceDate, t.$14 AS prolld_ServiceCodeID, t.$15 AS prolld_Notes, t.$16 AS prolld_DeductionEarning, t.$17 AS prolld_Rate, t.$18 AS prolld_RateSource, t.$19 AS prolld_RateID, t.$20 AS prolld_Units, t.$21 AS prolld_PayUnitFlag, t.$22 AS prolld_OT_DayUnits, t.$23 AS prolld_OT_DayMultiplier, t.$24 AS prolld_OTDayRateType, t.$25 AS prolld_OT_WeekUnits, t.$26 AS prolld_OT_WeekMultiplier, t.$27 AS prolld_OTWeekRateType, t.$28 AS prolld_EarnCode, t.$29 AS prolld_OverrideDepartment, t.$30 AS prolld_OverrideDivision, t.$31 AS prolld_OverrideBranch, t.$32 AS prolld_OverrideState, t.$33 AS prolld_OverrideLocal, t.$34 AS prolld_Job, t.$35 AS prolld_Vacation, t.$36 AS prolld_Loan, t.$37 AS prolld_Fee, t.$38 AS prolld_Other, t.$39 AS prolld_Misc, t.$40 AS prolld_Holiday, t.$41 AS prolld_Advance, t.$42 AS prolld_Amount, t.$43 AS prolld_SourceTS, t.$44 AS prolld_CreatedDate, t.$45 AS prolld_CreatedUser, t.$46 AS prolld_ModifiedDate, t.$47 AS prolld_ModifiedUser, t.$48 AS prolld_TS, t.$49 AS prolld_OTWeeklyHours, t.$50 AS prolld_PayOT, t.$51 AS prolld_WeekStartTime, t.$52 AS prolld_WeekEndTime, t.$53 AS prolld_OTAdjustedUnits, t.$54 AS prolld_OTAdjustedRate, t.$55 AS prolld_TotalAmount, t.$56 AS prolld_PayrollAdjID, t.$57 AS prolld_TotalPayment, t.$58 AS prolld_PayerID, t.$59 AS prolld_AddOn, t.$60 AS prolld_PrimaryRate, t.$61 AS prolld_AddOnRateID, t.$62 AS prolld_TotalDetailAmount, t.$63 AS prolld_RegionID, t.$64 AS prolld_ClientID, t.$65 AS prolld_IsExpense, t.$66 AS prolld_CarExcludeOT, t.$67 AS prolld_BranchID, t.$68 AS InsertDate, t.$69 AS UpdateDate, t.$70 AS DeletedFlag, t.$71 AS SYS_CHANGE_VERSION, CASE WHEN t.$70 = True THEN ''D'' WHEN t.$68 = t.$69 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$70, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollDetails[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollDetails AS WITH curr_v AS (SELECT prolld_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollDetails GROUP BY prolld_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PROLLD_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayrollDetails  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PROLLD_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollDetails t INNER JOIN curr_v v ON t.prolld_ID = v.prolld_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PROLLD_BRANCHID NOT IN (SELECT PROLLD_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';