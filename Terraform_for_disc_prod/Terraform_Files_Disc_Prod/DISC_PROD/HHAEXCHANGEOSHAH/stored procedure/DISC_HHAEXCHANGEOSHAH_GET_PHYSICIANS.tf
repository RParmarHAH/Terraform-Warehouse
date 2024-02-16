resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PHYSICIANS" {
	name ="GET_PHYSICIANS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Physicians 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Physicians (SELECT t.$1 AS AgencyID, t.$2 AS PhysicianID, t.$3 AS PhysicianName, t.$4 AS Address, t.$5 AS Phone, t.$6 AS Fax, t.$7 AS LicenseNo, t.$8 AS LicenseExpirationDate, t.$9 AS SuspensionDate, t.$10 AS RevokeDate, t.$11 AS Note, t.$12 AS Status, t.$13 AS PhysicianNPI, t.$14 AS PhysicianType, t.$15 AS OfficeNames, t.$16 AS CreatedBy, t.$17 AS CreatedDate, t.$18 AS UpdatedBy, t.$19 AS UpdatedDate, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_Physicians.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

