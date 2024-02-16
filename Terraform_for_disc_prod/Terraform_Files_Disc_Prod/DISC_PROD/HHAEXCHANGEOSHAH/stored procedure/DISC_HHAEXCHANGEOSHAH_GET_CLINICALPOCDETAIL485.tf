resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_CLINICALPOCDETAIL485" {
	name ="GET_CLINICALPOCDETAIL485"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ClinicalPOCDetail485 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ClinicalPOCDetail485 (SELECT t.$1 AS AgencyID, t.$2 AS POCDetail485ID, t.$3 AS POCHeader485ID, t.$4 AS Master485ID, t.$5 AS PatientID, t.$6 AS POCTaskID, t.$7 AS POCPerRequired, t.$8 AS TimesPerWeek, t.$9 AS Minutes, t.$10 AS TimesPerWeekMin, t.$11 AS TimesPerWeekMax, t.$12 AS Createdby, t.$13 AS CreatedDate, t.$14 AS UpdatedDate, t.$15 AS UpdatedBy, t.$16 AS TaskName, t.$17 AS Sunday, t.$18 AS Monday, t.$19 AS Tuesday, t.$20 AS Wednesday, t.$21 AS Thursday, t.$22 AS Friday, t.$23 AS Saturday, t.$24 AS AsNeeded, t.$25 AS TaskInstruction, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalPOCDetail485.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

