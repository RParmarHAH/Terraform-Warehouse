CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_BILLING_PAIDVISITS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_Billing_PaidVisits_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.Billing_PaidVisits_REPL (SELECT t.$1 AS AgencyID, t.$2 AS PaymentDetailID, t.$3 AS CheckID, t.$4 AS VisitID, t.$5 AS PaidAmount, t.$6 AS CreatedBy, t.$7 AS CreatedDate, t.$8 AS UpdatedBy, t.$9 AS UpdatedDate, t.$10 AS Adjustment, t.$11 AS TTAdjustment, t.$12 AS WriteOff, t.$13 AS PayerReferenceNumber, t.$14 AS OtherAdjustment, t.$15 AS Notes, t.$16 AS Credits, t.$17 AS PayerID, t.$18 AS PatientID, t.$19 AS OfficeID, t.$20 AS OtherChargeID, t.$21 AS PostedDate, t.$22 AS DepositDate, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Billing_PaidVisits_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';