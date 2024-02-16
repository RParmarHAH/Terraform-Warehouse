resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_CAREGIVERCOMPLIANCEEXPITEMS_REPL" {
	name ="GET_CAREGIVERCOMPLIANCEEXPITEMS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_CaregiverComplianceExpItems_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.CaregiverComplianceExpItems_REPL (SELECT t.$1 AS CaregiverComplianceExpItemID, t.$2 AS CaregiverID, t.$3 AS AgencyID, t.$4 AS ExpirationItemID, t.$5 AS ExpirationItem, t.$6 AS ExpirationItemType, t.$7 AS ComplianceExpItemResultID, t.$8 AS Result, t.$9 AS DateCompleted, t.$10 AS Status, t.$11 AS Compliant, t.$12 AS DueDate, t.$13 AS Notes, t.$14 AS ScanGUID, t.$15 AS ScanFileName, t.$16 AS CreatedDate, t.$17 AS CreatedBy, t.$18 AS CreatedByUser, t.$19 AS CreatedUTCDate, t.$20 AS UpdatedDate, t.$21 AS UpdatedBy, t.$22 AS UpdatedByUser, t.$23 AS UpdatedUTCDate, t.$24 AS ActionDate, t.$25 AS Score, t.$26 AS ParentExpirationItemID, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/HHAEXCHANGEOSHAH_dbo_CaregiverComplianceExpItems_REPL.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}

