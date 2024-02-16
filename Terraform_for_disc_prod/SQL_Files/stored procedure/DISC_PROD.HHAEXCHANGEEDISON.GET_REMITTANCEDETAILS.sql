CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_REMITTANCEDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_RemittanceDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.RemittanceDetails  (SELECT t.$1 AS AgencyID, t.$2 AS RemittanceID, t.$3 AS CheckNumber, t.$4 AS CheckDate, t.$5 AS CheckAmount, t.$6 AS ContractName, t.$7 AS VisitID, t.$8 AS VisitDate, t.$9 AS BilledAmount, t.$10 AS PaidAmount, t.$11 AS ClaimStatus, t.$12 AS AdjustmentCode, t.$13 AS AdjustmentAmount, t.$14 AS PayerReferenceNumber, t.$15 AS PatientName, t.$16 AS InvoiceNumber, t.$17 AS ValidationStatus, t.$18 AS ModifiedDate, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_RemittanceDetails.*[.]csv.gz'')T);

    return ''Success'';
END;
';