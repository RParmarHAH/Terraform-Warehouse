resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_EAUTOPAY" {
	name ="GET_EAUTOPAY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_EAutoPay 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.EAutoPay (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS startDate, t.$4 AS endDate, t.$5 AS det, t.$6 AS detCode, t.$7 AS hours, t.$8 AS rate, t.$9 AS rateCode, t.$10 AS amount, t.$11 AS cc1, t.$12 AS cc2, t.$13 AS cc3, t.$14 AS cc4, t.$15 AS cc5, t.$16 AS jobCode, t.$17 AS otc1, t.$18 AS otc2, t.$19 AS otc3, t.$20 AS otc4, t.$21 AS goal, t.$22 AS paidTowardsGoal, t.$23 AS frequency, t.$24 AS lastDate, t.$25 AS guidfield, t.$26 AS lastChange, t.$27 AS lastChangeUser, t.$28 AS sequence, t.$29 AS defaultCheckAttributes, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EAutoPay.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

