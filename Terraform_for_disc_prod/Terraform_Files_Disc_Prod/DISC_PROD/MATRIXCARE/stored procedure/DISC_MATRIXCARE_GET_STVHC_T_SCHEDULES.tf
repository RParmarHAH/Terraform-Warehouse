resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_SCHEDULES" {
	name ="GET_STVHC_T_SCHEDULES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Schedules 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Schedules FROM (SELECT t.$1 AS sch_ID, t.$2 AS sch_ClientID, t.$3 AS sch_CaregiverID, t.$4 AS sch_StartTime, t.$5 AS sch_EndTime, t.$6 AS sch_ScheduleStatusID, t.$7 AS sch_ServiceCodeID, t.$8 AS sch_AdmissionID, t.$9 AS sch_Description, t.$10 AS sch_ChargeRateOverrideAmt, t.$11 AS sch_ChargeRateOverrideModifiedUser, t.$12 AS sch_ChargeRateOverrideModifiedDate, t.$13 AS sch_PayRateOverrideAmt, t.$14 AS sch_PayRateOverrideModifiedUser, t.$15 AS sch_PayRateOverrideModifiedDate, t.$16 AS sch_ChargeRateID, t.$17 AS sch_ChargeRate, t.$18 AS sch_Units, t.$19 AS sch_BillRateUnitFlag, t.$20 AS sch_PayRateUnitFlag, t.$21 AS sch_PayUnits, t.$22 AS sch_OTUnits, t.$23 AS sch_NotesDate, t.$24 AS sch_PayReviewFlag, t.$25 AS sch_PayrollBatchID, t.$26 AS sch_PayNotes, t.$27 AS sch_PayDate, t.$28 AS sch_PayCode, t.$29 AS sch_RevenueCode, t.$30 AS sch_BillingStatus, t.$31 AS sch_AuthID, t.$32 AS sch_1500POS, t.$33 AS sch_1500TOS, t.$34 AS sch_1500Diag, t.$35 AS sch_1500EPSDT, t.$36 AS sch_1500EMG, t.$37 AS sch_1500COB, t.$38 AS sch_1500LocalUse, t.$39 AS sch_UserDefined1, t.$40 AS sch_RecurrenceId, t.$41 AS sch_IsRecurringAppointmentRoot, t.$42 AS sch_CreatedDate, t.$43 AS sch_CreatedUser, t.$44 AS sch_ModifiedDate, t.$45 AS sch_ModifiedUser, t.$46 AS sch_TS, t.$47 AS sch_IsRecurrenceUnique, t.$48 AS sch_TotalCharge, t.$49 AS sch_LegacyID, t.$50 AS sch_LegacyBranchID, t.$51 AS sch_tzID, t.$52 AS sch_TimeZoneID, t.$53 AS sch_StartOffset, t.$54 AS sch_EndOffset, t.$55 AS sch_OTMulti, t.$56 AS sch_SchedStartTime, t.$57 AS sch_SchedEndTime, t.$58 AS sch_SchedUnits, t.$59 AS sch_SchedUpdatedDate, t.$60 AS sch_SchedOverrideModifiedDate, t.$61 AS sch_SchedOverrideModifiedUser, t.$62 AS sch_TelUpdatedDate, t.$63 AS sch_OTExemptHours, t.$64 AS sch_OTExemptTypeID, t.$65 AS sch_1500BillingModifierID1, t.$66 AS sch_1500BillingModifierID2, t.$67 AS sch_1500BillingModifierID3, t.$68 AS sch_1500BillingModifierID4, t.$69 AS sch_BranchID, t.$70 AS sch_OriginalPayDate, t.$71 AS sch_TotalBillable, t.$72 AS sch_TotalBilled, t.$73 AS sch_TotalPaid, t.$74 AS sch_ArrivalCallID, t.$75 AS sch_DepartureCallID, t.$76 AS sch_TelephonyStatus, t.$77 AS sch_InvoiceDetailDescription, t.$78 AS sch_RegionID, t.$79 AS sch_BilledPaidRegion, t.$80 AS sch_QCode, t.$81 AS sch_PayNonWorkStartTime, t.$82 AS sch_PayNonWorkEndTime, t.$83 AS sch_BillNonWorkTypeID, t.$84 AS sch_BillNonWorkStartTime, t.$85 AS sch_BillNonWorkEndTime, t.$86 AS sch_BillNonWorkStartTimeOffset, t.$87 AS sch_BillNonWorkEndTimeOffset, t.$88 AS sch_PayNonWorkStartTimeOffset, t.$89 AS sch_PayNonWorkEndTimeOffset, t.$90 AS sch_NoteReceived, t.$91 AS sch_OTRate, t.$92 AS sch_BillOTOverrideModifiedDate, t.$93 AS sch_BillOTOverrideModifiedUser, t.$94 AS sch_BillingOTCalcType, t.$95 AS sch_ServicePlanHeaderId, t.$96 AS InsertDate, t.$97 AS UpdateDate, t.$98 AS DeletedFlag, t.$99 AS SYS_CHANGE_VERSION, CASE WHEN t.$98 = True THEN ''D'' WHEN t.$96 = t.$97 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$98, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Schedules.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Schedules AS WITH curr_v AS (SELECT sch_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Schedules GROUP BY sch_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT SCH_BRANCHID FROM MatrixCare.HIST_STVHC_T_Schedules  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.SCH_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Schedules t INNER JOIN curr_v v ON t.sch_ID = v.sch_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.SCH_BRANCHID NOT IN (SELECT SCH_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

