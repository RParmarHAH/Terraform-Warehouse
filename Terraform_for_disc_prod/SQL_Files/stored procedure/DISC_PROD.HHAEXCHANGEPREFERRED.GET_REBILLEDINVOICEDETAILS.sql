CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_REBILLEDINVOICEDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_RebilledInvoiceDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.RebilledInvoiceDetails (SELECT t.$1 AS AgencyID, t.$2 AS RebilledinvoicedetailID, t.$3 AS InvoiceHeaderID, t.$4 AS PrevInvoiceNumber, t.$5 AS InvoiceNumber, t.$6 AS InvoiceDate, t.$7 AS BatchID, t.$8 AS BatchNumber, t.$9 AS VisitDuration, t.$10 AS PatientID, t.$11 AS AdmissionID, t.$12 AS PatientName, t.$13 AS Address, t.$14 AS TotalHours, t.$15 AS BilledUnits, t.$16 AS ThrdPartyAmount, t.$17 AS TotalAmount, t.$18 AS Contract, t.$19 AS PaidAmount, t.$20 AS Discount, t.$21 AS PaymentStatus, t.$22 AS DeletedBy, t.$23 AS DeletedDate, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_RebilledInvoiceDetails.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';