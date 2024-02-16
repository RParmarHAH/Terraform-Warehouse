resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_PATIENTDIAGNOSES" {
	name ="GET_AXXESS_PATIENTDIAGNOSES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_PATIENTDIAGNOSES 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_PATIENTDIAGNOSES (SELECT A.$1 AS Patient_Id, A.$2 AS Branch_Id, A.$3 AS Account, A.$4 AS Branch, A.$5 AS Mrn, A.$6 AS Patient_First_Name, A.$7 AS Patient_Last_Name, A.$8 AS Patient_Status, A.$9 AS Gender, A.$10 AS Patient_Age, A.$11 AS Payor_Type, A.$12 AS Primary_Insurance_Name, A.$13 AS Primary_Diagnosis, A.$14 AS Primary_Diagnosis_Description, A.$15 AS Primary_Diagnosis_Severity, A.$16 AS Diagnosis_2, A.$17 AS Diagnosis_2_Description, A.$18 AS Diagnosis_2_Severity, A.$19 AS Diagnosis_3, A.$20 AS Diagnosis_3_Description, A.$21 AS Diagnosis_3_Severity, A.$22 AS Diagnosis_4, A.$23 AS Diagnosis_4_Description, A.$24 AS Diagnosis_4_Severity, A.$25 AS Diagnosis_5, A.$26 AS Diagnosis_5_Description, A.$27 AS Diagnosis_5_Severity, A.$28 AS Diagnosis_6, A.$29 AS Diagnosis_6_Description, A.$30 AS Diagnosis_6_Severity, A.$31 AS Diagnosis_7, A.$32 AS Diagnosis_7_Description, A.$33 AS Diagnosis_7_Severity, A.$34 AS Diagnosis_8, A.$35 AS Diagnosis_8_Description, A.$36 AS Diagnosis_8_Severity, A.$37 AS INSURANCE_ID, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/PatientDiagnoses(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;

 EOT
}

