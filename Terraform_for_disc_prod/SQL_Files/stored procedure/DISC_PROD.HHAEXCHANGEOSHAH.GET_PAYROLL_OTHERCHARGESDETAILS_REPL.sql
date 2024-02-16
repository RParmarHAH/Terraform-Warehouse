CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PAYROLL_OTHERCHARGESDETAILS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Payroll_OtherChargesDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Payroll_OtherChargesDetails_REPL (SELECT t.$1 AS AgencyID, t.$2 AS PayrollOtherChargesDetailID, t.$3 AS BatchID, t.$4 AS PatientID, t.$5 AS CaregiverExpenseID, t.$6 AS CaregiverID, t.$7 AS OtherChargeID, t.$8 AS VisitID, t.$9 AS ChargeType, t.$10 AS ChargeTypeName, t.$11 AS RegularHours, t.$12 AS PayAmount, t.$13 AS PayRateID, t.$14 AS PayRate, t.$15 AS PayRate2, t.$16 AS PayRateCode, t.$17 AS RateType, t.$18 AS PayrollWeekID, t.$19 AS PayerID, t.$20 AS WageParity, t.$21 AS TravelTimeDetailID, t.$22 AS OTHours, t.$23 AS OTAmount, t.$24 AS OTPayRateID, t.$25 AS OTPayRate, t.$26 AS OTPayRateCode, t.$27 AS OTPayRate2, t.$28 AS HolidayHours, t.$29 AS HolidayAmount, t.$30 AS HolidayPayRateID, t.$31 AS HolidayPayRate, t.$32 AS HolidayPayRateCode, t.$33 AS HolidayPayrate2, t.$34 AS MileageID, t.$35 AS CreatedBy, t.$36 AS CreatedDate, t.$37 AS CreatedUTCDate, t.$38 AS UpdatedBy, t.$39 AS UpdatedDate, t.$40 AS UpdatedUTCDate, t.$41 AS VisitDate, t.$42 AS SYS_CHANGE_VERSION, t.$43 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$43,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Payroll_OtherChargesDetails_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';