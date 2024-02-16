resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CLINICALORDERGOAL485" {
	name ="GET_CLINICALORDERGOAL485"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalOrderGoal485 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ClinicalOrderGoal485 (SELECT t.$1 AS AgencyID, t.$2 AS OrderGoal485ID, t.$3 AS Master485ID, t.$4 AS PatientID, t.$5 AS DisciplineID, t.$6 AS POCHeader485ID, t.$7 AS Frequency, t.$8 AS AdditionalOrder, t.$9 AS AdditionalGoal, t.$10 AS Other, t.$11 AS ClinicalDocumentOrders, t.$12 AS NonSkilledDisciplineID, t.$13 AS CreatedBy, t.$14 AS CreatedDate, t.$15 AS UpdatedBy, t.$16 AS UpdatedDate, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalOrderGoal485.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

