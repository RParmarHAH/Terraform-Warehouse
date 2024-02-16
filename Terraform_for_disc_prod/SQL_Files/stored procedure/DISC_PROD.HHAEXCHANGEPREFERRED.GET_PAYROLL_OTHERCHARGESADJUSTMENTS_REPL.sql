CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_PAYROLL_OTHERCHARGESADJUSTMENTS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_Payroll_OtherChargesAdjustments_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.Payroll_OtherChargesAdjustments_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS PayrollOtherChargesAdjustmentID, t.$3 AS PayrollOtherChargesDetailID, t.$4 AS BatchID, t.$5 AS PatientID, t.$6 AS CaregiverExpenseID, t.$7 AS CaregiverID, t.$8 AS OtherChargeID, t.$9 AS VisitID, t.$10 AS RegularHours, t.$11 AS PayRateID, t.$12 AS PayRate, t.$13 AS PayRate2, t.$14 AS PayRateCode, t.$15 AS PayAmount, t.$16 AS PayerID, t.$17 AS RateType, t.$18 AS PayrollWeekID, t.$19 AS ChargeType, t.$20 AS ChargeTypeName, t.$21 AS OtherChargesAdjustmentID, t.$22 AS WageParity, t.$23 AS BatchNumber, t.$24 AS TravelTimeDetailID, t.$25 AS OTHours, t.$26 AS OTAmount, t.$27 AS OTPayRateID, t.$28 AS OTPayRate, t.$29 AS OTPayRateCode, t.$30 AS OTPayRate2, t.$31 AS HolidayHours, t.$32 AS HolidayAmount, t.$33 AS HolidayPayRateID, t.$34 AS HolidayPayRate, t.$35 AS HolidayPayRateCode, t.$36 AS HolidayPayrate2, t.$37 AS MileageID, t.$38 AS CreatedBy, t.$39 AS CreatedDate, t.$40 AS CreatedUTCDate, t.$41 AS UpdatedBy, t.$42 AS UpdatedDate, t.$43 AS UpdatedUTCDate, t.$44 AS VisitDate, t.$45 AS SYS_CHANGE_VERSION, t.$46 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$46,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_Payroll_OtherChargesAdjustments_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';