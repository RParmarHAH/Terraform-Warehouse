resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_OFFICE_BRANCH_REPL" {
	name ="GET_OFFICE_BRANCH_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Office_Branch_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Office_Branch_REPL (SELECT t.$1 AS AgencyID, t.$2 AS BranchID, t.$3 AS BranchName, t.$4 AS Description, t.$5 AS Active, t.$6 AS OfficeID, t.$7 AS AgencyBranchID, t.$8 AS MDOrderBranchAddress, t.$9 AS Street1, t.$10 AS Street2, t.$11 AS City, t.$12 AS State, t.$13 AS ZipCode, t.$14 AS Phone, t.$15 AS Fax, t.$16 AS CreatedBy, t.$17 AS CreatedDate, t.$18 AS CreatedUTCDate, t.$19 AS UpdatedBy, t.$20 AS UpdatedDate, t.$21 AS UpdatedUTCDate, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Office_Branch_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

