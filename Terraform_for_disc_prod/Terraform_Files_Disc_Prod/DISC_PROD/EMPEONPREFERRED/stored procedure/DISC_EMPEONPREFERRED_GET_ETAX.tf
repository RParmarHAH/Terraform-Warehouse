resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_ETAX" {
	name ="GET_ETAX"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_ETax 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.ETax (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS tcode, t.$4 AS filingStatus, t.$5 AS exemptions, t.$6 AS exemptions2, t.$7 AS overrideTaxCalc, t.$8 AS defaultTax, t.$9 AS reciprocal, t.$10 AS additionalAmount, t.$11 AS additionalPercentage, t.$12 AS lowWageCredit, t.$13 AS specialCheckCalc, t.$14 AS priority, t.$15 AS startDate, t.$16 AS endDate, t.$17 AS percentofgross, t.$18 AS guidfield, t.$19 AS lastChange, t.$20 AS lastChangeUser, t.$21 AS addlTaxData1, t.$22 AS otherIncomeAmt, t.$23 AS otherDeductionAmt, t.$24 AS otherCreditAmt, t.$25 AS addlTaxOption1, t.$26 AS addlTaxOption2, t.$27 AS addlTaxOption3, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_ETax.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.ETax AS WITH curr_v AS (SELECT co, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.ETax GROUP BY co) SELECT t.* FROM EmpeonPreferred.ETax t INNER JOIN curr_v v ON t.co = v.co AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

