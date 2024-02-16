CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_STAGE_LINKEDCONTRACTRATES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_stage_LinkedContractRates 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.stage_LinkedContractRates (SELECT t.$1 AS AgencyID, t.$2 AS VendorRateID, t.$3 AS OfficeID, t.$4 AS PayerID, t.$5 AS FromDate, t.$6 AS ToDate, t.$7 AS Status, t.$8 AS ServiceCategory, t.$9 AS ServiceCode, t.$10 AS ServiceType, t.$11 AS RateAmount, t.$12 AS RateType, t.$13 AS AllowProviderEditBillingRates, t.$14 AS Units, t.$15 AS MinHr, t.$16 AS ServiceCodeID, t.$17 AS IsNonBillable, t.$18 AS IsExpandCollapsVisible, t.$19 AS CreatedDate, t.$20 AS LastModifiedDate, t.$21 AS AreaRatesDefined, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_stage_LinkedContractRates.*[.]csv.gz'') T);

    return ''Success'';
END;
';