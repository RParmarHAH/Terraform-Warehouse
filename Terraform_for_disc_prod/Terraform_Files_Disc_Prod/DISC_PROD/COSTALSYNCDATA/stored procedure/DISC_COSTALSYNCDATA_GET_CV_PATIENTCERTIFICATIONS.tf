resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_PATIENTCERTIFICATIONS" {
	name ="GET_CV_PATIENTCERTIFICATIONS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_PatientCertifications 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_PatientCertifications FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Patient_Number, t.$5 AS Admission_Number, t.$6 AS Sequence_Number, t.$7 AS Certification_Code, t.$8 AS Certification_Number, t.$9 AS Certification_From, t.$10 AS Certification_Thru, t.$11 AS Facility_Code, t.$12 AS Billto_Status_Code, t.$13 AS Plan_Code, t.$14 AS Cert_Tran_Number, t.$15 AS Location_Code, t.$16 AS Department__Code, t.$17 AS Provider_Code, t.$18 AS Episode_Number, t.$19 AS DDL_Cert_Status_New, t.$20 AS DDL_Portal_Status, t.$21 AS Nurse_ID, t.$22 AS DDL_Cert_Form_Type, t.$23 AS DEX_ROW_ID, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientCertifications.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_PatientCertifications AS WITH curr_v AS (SELECT Db, Patient_Number, Admission_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientCertifications GROUP BY Db, Patient_Number, Admission_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_CV_PatientCertifications t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Admission_Number = v.Admission_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

