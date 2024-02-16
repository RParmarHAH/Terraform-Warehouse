resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_PHYSICIANS" {
	name ="GET_SANDATA_PHYSICIANS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_Physicians 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_Physicians FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS PhysicianID, t.$4 AS Person, t.$5 AS Title, t.$6 AS FirstName, t.$7 AS MiddleInitial, t.$8 AS LastName, t.$9 AS Suffix, t.$10 AS Sex, t.$11 AS SSN, t.$12 AS DOB, t.$13 AS DOD, t.$14 AS Address, t.$15 AS Address2, t.$16 AS AptNo, t.$17 AS County, t.$18 AS City, t.$19 AS State, t.$20 AS Zip, t.$21 AS HomePhone, t.$22 AS WorkPhone, t.$23 AS MobilePhone, t.$24 AS Fax, t.$25 AS Email, t.$26 AS Organization, t.$27 AS NPI, t.$28 AS API, t.$29 AS UPIN, t.$30 AS OtherID1, t.$31 AS OtherID2, t.$32 AS LicenseNumber, t.$33 AS LicenseExpires, t.$34 AS CreatedAt, t.$35 AS UpdatedAt, t.$36 AS HashedRowValues, t.$37 AS BatchId, t.$38 AS SYS_CHANGE_VERSION, t.$39 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$39,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_Physicians.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Physicians AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Physicians GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Physicians t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

