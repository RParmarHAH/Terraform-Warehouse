CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PAYROLL_VISITS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Payroll_Visits_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Payroll_Visits_REPL (SELECT t.$1 AS AgencyID, t.$2 AS PayrollVisitID, t.$3 AS OfficeID, t.$4 AS VisitID, t.$5 AS PayerID, t.$6 AS PatientID, t.$7 AS CaregiverID, t.$8 AS PayrollBilled, t.$9 AS PayrollDate, t.$10 AS PayrollBatchNumber, t.$11 AS Createdby, t.$12 AS CreatedDate, t.$13 AS CreatedUTCDate, t.$14 AS Updatedby, t.$15 AS UpdatedDate, t.$16 AS UpdatedUTCDate, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Payroll_Visits_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';