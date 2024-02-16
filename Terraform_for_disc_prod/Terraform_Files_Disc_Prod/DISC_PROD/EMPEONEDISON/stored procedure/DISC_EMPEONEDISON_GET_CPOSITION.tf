resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_CPOSITION" {
	name ="GET_CPOSITION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_CPosition 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.CPosition (SELECT t.$1 AS co, t.$2 AS positionCode, t.$3 AS description, t.$4 AS title, t.$5 AS cc1, t.$6 AS cc2, t.$7 AS cc3, t.$8 AS cc4, t.$9 AS cc5, t.$10 AS eeoClass, t.$11 AS wcc, t.$12 AS flsaOvertimeExempt, t.$13 AS payGrade, t.$14 AS jobDescription, t.$15 AS jobRequirements, t.$16 AS fte, t.$17 AS approvedDate, t.$18 AS effectiveDate, t.$19 AS closedDate, t.$20 AS supervisor, t.$21 AS supervisorID, t.$22 AS budgeted, t.$23 AS employeeID, t.$24 AS employeeName, t.$25 AS guidfield, t.$26 AS lastChange, t.$27 AS lastChangeUser, t.$28 AS cmsLaborJobCode, t.$29 AS SYS_CHANGE_VERSION, t.$30 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$30,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/EmpeonEdison_dbo_CPosition.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;

 EOT
}

