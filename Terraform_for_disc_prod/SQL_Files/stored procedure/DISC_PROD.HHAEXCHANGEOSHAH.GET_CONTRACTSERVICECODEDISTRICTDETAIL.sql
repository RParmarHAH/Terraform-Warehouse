CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CONTRACTSERVICECODEDISTRICTDETAIL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ContractServiceCodeDistrictDetail 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ContractServiceCodeDistrictDetail (SELECT t.$1 AS AgencyID, t.$2 AS ContractServiceCodeDistrictDetailID, t.$3 AS ContractServiceCodeDistrictID, t.$4 AS ServiceCodeID, t.$5 AS PayerID, t.$6 AS ContractDistrictID, t.$7 AS DistrictType, t.$8 AS CoverageDetail, t.$9 AS CreatedBy, t.$10 AS CreatedByUserName, t.$11 AS CreatedDate, t.$12 AS CreatedUTCDate, t.$13 AS UpdatedBy, t.$14 AS UpdatedByUserName, t.$15 AS UpdatedDate, t.$16 AS UpdatedUTCDate, t.$17 AS PayerServiceCodeAreaID, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ContractServiceCodeDistrictDetail.*[.]csv.gz'') T);

    return ''Success'';
END;
';