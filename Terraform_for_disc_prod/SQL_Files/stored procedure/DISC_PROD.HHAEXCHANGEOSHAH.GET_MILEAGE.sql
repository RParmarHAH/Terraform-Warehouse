CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_MILEAGE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Mileage 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Mileage (SELECT t.$1 AS AgencyID, t.$2 AS MileageID, t.$3 AS MileageDate, t.$4 AS CaregiverID, t.$5 AS CaregiverName, t.$6 AS VisitID, t.$7 AS Miles, t.$8 AS PatientID, t.$9 AS PatientName, t.$10 AS Notes, t.$11 AS Shift, t.$12 AS ServiceCodeID, t.$13 AS ServiceCode, t.$14 AS PayRateID, t.$15 AS PayRateText, t.$16 AS PayRate, t.$17 AS ContractID, t.$18 AS Contract, t.$19 AS PayerID, t.$20 AS BillRate, t.$21 AS BillRateAfterBilled, t.$22 AS PayRateAfterPayRoll, t.$23 AS PayRollBatchID, t.$24 AS PayRollBatchNumber, t.$25 AS InvoiceNumber, t.$26 AS InvoiceHeaderID, t.$27 AS BatchID, t.$28 AS AuthorizationID, t.$29 AS AuthorizationNumber, t.$30 AS PayRollOtherChargesDetailID, t.$31 AS PayRollOtherChargesAdjustmentID, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_Mileage.*[.]csv.gz'') T);

    return ''Success'';
END;
';