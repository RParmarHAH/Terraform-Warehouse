resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_PHYSICIAN" {
	name ="GET_PHYSICIAN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_physician 
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
    COPY INTO GENERATIONSALLIANCE.physician FROM (SELECT t.$1 AS PhysicianName, t.$2 AS Address1, t.$3 AS Address2, t.$4 AS City, t.$5 AS State, t.$6 AS Zip, t.$7 AS Phone, t.$8 AS Fax, t.$9 AS AltPhone, t.$10 AS Notes, t.$11 AS createdBy, t.$12 AS created, t.$13 AS updatedBy, t.$14 AS lastUpdated, t.$15 AS Email, t.$16 AS NPI_NUMBER, t.$17 AS Id, t.$18 AS PhysicianLastName, t.$19 AS PhysicianFirstName, t.$20 AS TaxonomyNumber, t.$21 AS TaxonomyCode, t.$22 AS QualifierID, t.$23 AS Qualifier, t.$24 AS ProviderAssignedID, t.$25 AS Specialty, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_physician.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.physician AS WITH curr_v AS (SELECT PhysicianName, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.physician GROUP BY PhysicianName) SELECT t.* FROM GENERATIONSALLIANCE.physician t INNER JOIN curr_v v ON t.PhysicianName = v.PhysicianName AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

