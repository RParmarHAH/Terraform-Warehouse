CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_PAYROLLDETAILSOT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayrollDetailsOT 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollDetailsOT FROM (SELECT t.$1 AS prolldOT_ID, t.$2 AS prolldOT_PayrollBatchID, t.$3 AS prolldOT_BatchID, t.$4 AS prolldot_RecordID, t.$5 AS prolldOT_CaregiverID, t.$6 AS prolldOT_ScheduleID, t.$7 AS prolldOT_RatioOFHoursIncludedInWeek, t.$8 AS prolldOT_WeeklyTotalhoursForOT, t.$9 AS prolldOT_BlendedRate, t.$10 AS prolldOT_ProrateOTAmount, t.$11 AS prolldOT_ProrateOTHours, t.$12 AS prolldOT_PortionForBlendedRate, t.$13 AS prolldOT_WeeklyHoursLimit, t.$14 AS prolldOT_ProrateForOTExempt, t.$15 AS prolldOT_ActualHours, t.$16 AS prolldOT_PayAmount, t.$17 AS prolldOT_TotalWeekPayAmount, t.$18 AS prolldOT_WeeklyHours, t.$19 AS prolldOT_AccumWeeklyHours, t.$20 AS prolldOT_AccumDailyHours, t.$21 AS prolldOT_NotWorkingHrs, t.$22 AS prolldOT_StartTime, t.$23 AS prolldOT_EndTime, t.$24 AS prolldOT_ScheduleDuration, t.$25 AS prolldOT_WeekNum, t.$26 AS prolldOT_WeekStartTime, t.$27 AS prolldOT_WeekEndTime, t.$28 AS prolldOT_DayNo, t.$29 AS prolldOT_DayStartTime, t.$30 AS prolldOT_DayEndTime, t.$31 AS prolldOT_DailyTotalhours, t.$32 AS prolldOT_DailyOTUnits, t.$33 AS prolldOT_DailyOTLimit, t.$34 AS prolldOT_TotalDailyOTUnitsPerWeek, t.$35 AS prolldOT_WeeklyOTUnits, t.$36 AS prolldOT_OTMultiplier, t.$37 AS prolldOT_Rate, t.$38 AS prolldOT_Units, t.$39 AS prolldOT_IsWeekly, t.$40 AS prolldOT_HasSevenDayOT, t.$41 AS prolldOT_TotalPay, t.$42 AS prolldot_DailyOTOrder, t.$43 AS prolldot_Ranked, t.$44 AS prolldot_AdjustmentHrs, t.$45 AS prolldot_AdjustmentAmt, t.$46 AS prolldot_WeeklyHoursForOT, t.$47 AS prolldOT_dailyhoursForOT, t.$48 AS prolldOT_Description, t.$49 AS prolldOT_ClientID, t.$50 AS prolldOT_BatchTS, t.$51 AS prolldot_isexpense, t.$52 AS prolldOT_RecordTotalPayment, t.$53 AS prolldOT_OTPayment, t.$54 AS prolldOT_OTUnits, t.$55 AS prolldOT_RecordUnits, t.$56 AS prolldOT_PayrollTypeID, t.$57 AS prolldOT_PayrollAdjID, t.$58 AS InsertDate, t.$59 AS UpdateDate, t.$60 AS DeletedFlag, t.$61 AS SYS_CHANGE_VERSION, CASE WHEN t.$60 = True THEN ''D'' WHEN t.$58 = t.$59 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$60, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollDetailsOT.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollDetailsOT AS WITH curr_v AS (SELECT prolldOT_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollDetailsOT GROUP BY prolldOT_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollDetailsOT t INNER JOIN curr_v v ON t.prolldOT_ID = v.prolldOT_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';