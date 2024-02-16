resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_ELABORDIST" {
	name ="GET_ELABORDIST"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_ELaborDist 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.ELaborDist (SELECT t.$1 AS Trans, t.$2 AS TransType, t.$3 AS det, t.$4 AS detCode, t.$5 AS hours, t.$6 AS rate, t.$7 AS amount, t.$8 AS rateCode, t.$9 AS tcode1, t.$10 AS tcode2, t.$11 AS tcode3, t.$12 AS tcode4, t.$13 AS beginDate, t.$14 AS endDate, t.$15 AS shift, t.$16 AS wcc, t.$17 AS cc1, t.$18 AS cc2, t.$19 AS cc3, t.$20 AS cc4, t.$21 AS cc5, t.$22 AS jobCode, t.$23 AS gl1, t.$24 AS gl2, t.$25 AS gl3, t.$26 AS gl4, t.$27 AS gl5, t.$28 AS gl6, t.$29 AS cd, t.$30 AS xgl1, t.$31 AS xgl2, t.$32 AS xgl3, t.$33 AS xgl4, t.$34 AS xgl5, t.$35 AS xgl6, t.$36 AS guidfield, t.$37 AS lastChange, t.$38 AS calendarId, t.$39 AS lastChangeUser, t.$40 AS co, t.$41 AS comment, t.$42 AS voidReason, t.$43 AS account, t.$44 AS SYS_CHANGE_VERSION, t.$45 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$45,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_ELaborDist.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

