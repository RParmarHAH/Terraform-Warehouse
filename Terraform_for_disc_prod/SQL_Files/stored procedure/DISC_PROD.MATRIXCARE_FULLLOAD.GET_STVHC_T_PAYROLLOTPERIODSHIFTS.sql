CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_PAYROLLOTPERIODSHIFTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_PayrollOTPeriodShifts 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollOTPeriodShifts FROM (SELECT t.$1 AS ots_ID, t.$2 AS ots_PeriodID, t.$3 AS ots_PayrollDetailsID, t.$4 AS ots_PeriodShiftStartTime, t.$5 AS ots_PeriodShiftEndTime, t.$6 AS ots_PeriodShiftEligiblePay, t.$7 AS ots_Seq, t.$8 AS ots_Duration, t.$9 AS ots_LegacyID, t.$10 AS ots_DraftID, t.$11 AS ots_AccumulatedDuration, t.$12 AS ots_OTEligibleMinutes, t.$13 AS InsertDate, t.$14 AS UpdateDate, t.$15 AS DeletedFlag, t.$16 AS SYS_CHANGE_VERSION, CASE WHEN t.$15 = True THEN ''D'' WHEN t.$13 = t.$14 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$15, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollOTPeriodShifts.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollOTPeriodShifts AS WITH curr_v AS (SELECT ots_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollOTPeriodShifts GROUP BY ots_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollOTPeriodShifts t INNER JOIN curr_v v ON t.ots_ID = v.ots_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';