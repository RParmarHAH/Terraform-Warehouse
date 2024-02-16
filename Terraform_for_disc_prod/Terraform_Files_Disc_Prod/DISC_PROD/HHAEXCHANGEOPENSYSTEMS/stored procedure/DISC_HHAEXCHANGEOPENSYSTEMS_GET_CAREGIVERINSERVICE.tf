resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CAREGIVERINSERVICE" {
	name ="GET_CAREGIVERINSERVICE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverInservice 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.CaregiverInservice (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverInServiceID, t.$3 AS InServiceID, t.$4 AS CaregiverID, t.$5 AS InServiceDate, t.$6 AS FromTime, t.$7 AS EndTime, t.$8 AS FromEndTime, t.$9 AS Topic, t.$10 AS Location, t.$11 AS Instructor, t.$12 AS Description, t.$13 AS Type, t.$14 AS Hours, t.$15 AS PayrollBilled, t.$16 AS NoShow, t.$17 AS NoShowText, t.$18 AS IsStatus, t.$19 AS IsStatusText, t.$20 AS Reason, t.$21 AS BatchNumber, t.$22 AS CreatedByUser, t.$23 AS CreatedbyUserID, t.$24 AS CreatedDate, t.$25 AS ModifiedDate, t.$26 AS PayRateID, t.$27 AS PayRateCode, t.$28 AS PayRateID2, t.$29 AS PayRateCode2, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverInservice.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

