resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_CDED" {
	name ="GET_CDED"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_CDed 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.CDed (SELECT t.$1 AS co, t.$2 AS dcode, t.$3 AS description, t.$4 AS shortDescription, t.$5 AS dedType, t.$6 AS priority, t.$7 AS w2Field, t.$8 AS printOnCheckStub, t.$9 AS maximum, t.$10 AS minimum, t.$11 AS annualMaximum, t.$12 AS rate, t.$13 AS units, t.$14 AS unitDescription, t.$15 AS autoDrop, t.$16 AS dropPartial, t.$17 AS autoMakeup, t.$18 AS frequency, t.$19 AS calculationCode, t.$20 AS amount, t.$21 AS agency, t.$22 AS taxExempt, t.$23 AS guidfield, t.$24 AS lastChange, t.$25 AS lastChangeUser, t.$26 AS grossCheck, t.$27 AS disallowOverrideCalcCode, t.$28 AS disallowOverrideRate, t.$29 AS disallowOverrideFrequency, t.$30 AS disallowOverrideAgency, t.$31 AS disallowOverrideMinimum, t.$32 AS disallowOverrideMaximum, t.$33 AS disallowOverrideAnnualMaximum, t.$34 AS blockMakeupPerAttributes, t.$35 AS allowEditforEmployeePortal, t.$36 AS Obsolete, t.$37 AS disallowOverrideGoal, t.$38 AS goal, t.$39 AS SYS_CHANGE_VERSION, t.$40 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$40,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_CDed.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

