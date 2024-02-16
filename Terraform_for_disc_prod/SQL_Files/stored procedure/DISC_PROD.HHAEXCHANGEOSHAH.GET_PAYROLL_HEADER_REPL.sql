CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PAYROLL_HEADER_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Payroll_Header_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Payroll_Header_REPL (SELECT t.$1 AS AgencyID, t.$2 AS HeaderID, t.$3 AS BatchID, t.$4 AS CaregiverID, t.$5 AS WeekStart, t.$6 AS WeekEnd, t.$7 AS TotalHours, t.$8 AS TotalOTHours, t.$9 AS TotalAmount, t.$10 AS TotalOTAmount, t.$11 AS TotalHolidayHours, t.$12 AS TotalHolidayAmount, t.$13 AS PayrollSetupID, t.$14 AS OfficeID, t.$15 AS ExpenseAmount, t.$16 AS MileageAmount, t.$17 AS CreatedBy, t.$18 AS CreatedDate, t.$19 AS LastModifiedBy, t.$20 AS LastModifiedDate, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Payroll_Header_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';