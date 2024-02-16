resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SERVICES" {
	name ="GET_SERVICES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_services 
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
    COPY INTO GENERATIONSALLIANCE.services FROM (SELECT t.$1 AS ServiceCode, t.$2 AS Description, t.$3 AS ShortDescription, t.$4 AS Cost, t.$5 AS ItemTypeId, t.$6 AS QuickBooksId, t.$7 AS flatRate, t.$8 AS AlternateServiceID1, t.$9 AS createdBy, t.$10 AS created, t.$11 AS updatedBy, t.$12 AS lastUpdated, t.$13 AS status, t.$14 AS region8ID, t.$15 AS modifier, t.$16 AS tos, t.$17 AS modifier2, t.$18 AS RevenueCode, t.$19 AS StateEVV, t.$20 AS SupplyInfo, t.$21 AS AccountNum, t.$22 AS Modifier3, t.$23 AS Modifier4, t.$24 AS IncludeInAdjustedDed, t.$25 AS OverrideServiceDescription, t.$26 AS ProcedureTaxonomyCode, t.$27 AS IsTellusEnabled, t.$28 AS CareProgramID, t.$29 AS AuthenticareEnabled, t.$30 AS ThirdPartyEVV, t.$31 AS SYS_CHANGE_VERSION, t.$32 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$32,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_services.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.services AS WITH curr_v AS (SELECT ServiceCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.services GROUP BY ServiceCode) SELECT t.* FROM GENERATIONSALLIANCE.services t INNER JOIN curr_v v ON t.ServiceCode = v.ServiceCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

