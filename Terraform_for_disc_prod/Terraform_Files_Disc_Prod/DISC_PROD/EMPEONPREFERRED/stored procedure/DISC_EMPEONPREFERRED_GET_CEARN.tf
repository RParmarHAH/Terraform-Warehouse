resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_CEARN" {
	name ="GET_CEARN"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_CEarn 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.CEarn (SELECT t.$1 AS co, t.$2 AS ecode, t.$3 AS description, t.$4 AS shortDescription, t.$5 AS earnType, t.$6 AS w2Field, t.$7 AS printOnCheckStub, t.$8 AS minimum, t.$9 AS maximum, t.$10 AS annualMaximum, t.$11 AS overrideRate, t.$12 AS addToRate, t.$13 AS rateMultiplier, t.$14 AS overrideShift, t.$15 AS unitDescription, t.$16 AS autoDrop, t.$17 AS calculationCode, t.$18 AS rateCode, t.$19 AS amount, t.$20 AS frequency, t.$21 AS units, t.$22 AS rate, t.$23 AS agency, t.$24 AS dcode, t.$25 AS reduceAutoPay, t.$26 AS taxExempt, t.$27 AS guidfield, t.$28 AS lastChange, t.$29 AS lastChangeUser, t.$30 AS worked, t.$31 AS Obsolete, t.$32 AS blockWithholdingTax, t.$33 AS hppdType, t.$34 AS acaMeasurement, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_CEarn.*[.]csv.gz'')T);

    
    return ''Success'';
END;

 EOT
}

