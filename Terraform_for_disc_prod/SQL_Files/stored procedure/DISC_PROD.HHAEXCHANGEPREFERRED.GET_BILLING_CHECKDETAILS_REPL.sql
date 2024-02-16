CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_BILLING_CHECKDETAILS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_Billing_CheckDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.Billing_CheckDetails_REPL (SELECT t.$1 AS AgencyID, t.$2 AS CheckID, t.$3 AS PayerID, t.$4 AS CheckNumber, t.$5 AS CheckDate, t.$6 AS CheckAmount, t.$7 AS CheckMemo, t.$8 AS PaymentType, t.$9 AS CheckStatus, t.$10 AS PatientID, t.$11 AS DepositDate, t.$12 AS PostedDate, t.$13 AS PostedStatus, t.$14 AS RetentionAndRecruitment, t.$15 AS Type, t.$16 AS AppliedAmount, t.$17 AS RemianingAmount, t.$18 AS ApplyFromCreditAmount, t.$19 AS PayerName, t.$20 AS BankCodeID, t.$21 AS PaymentBatchID, t.$22 AS CreatedBy, t.$23 AS CreatedDate, t.$24 AS UpdatedBy, t.$25 AS UpdatedDate, t.$26 AS CreatedUTCDate, t.$27 AS UpdatedUTCDate, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_Billing_CheckDetails_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';