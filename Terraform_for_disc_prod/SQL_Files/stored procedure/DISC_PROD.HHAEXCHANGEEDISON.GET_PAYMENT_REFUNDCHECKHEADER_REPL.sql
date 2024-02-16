CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_PAYMENT_REFUNDCHECKHEADER_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_Payment_RefundCheckHeader_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.Payment_RefundCheckHeader_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS RefundCheckHeaderID, t.$3 AS PayerID, t.$4 AS CheckNumber, t.$5 AS CheckDate, t.$6 AS CheckAmount, t.$7 AS CheckMemo, t.$8 AS RefundType, t.$9 AS CheckStatus, t.$10 AS SentDate, t.$11 AS PostedDate, t.$12 AS Type, t.$13 AS CreditUsedAmount, t.$14 AS PayerName, t.$15 AS PatientID, t.$16 AS CreatedBy, t.$17 AS CreatedDate, t.$18 AS UpdatedBy, t.$19 AS UpdatedDate, t.$20 AS CreatedUTCDate, t.$21 AS UpdatedUTCDate, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Payment_RefundCheckHeader_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';