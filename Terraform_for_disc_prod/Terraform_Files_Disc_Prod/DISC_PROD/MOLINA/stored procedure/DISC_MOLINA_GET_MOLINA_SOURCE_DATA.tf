resource "snowflake_procedure" "DISC_MOLINA_GET_MOLINA_SOURCE_DATA" {
	name ="GET_MOLINA_SOURCE_DATA"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MOLINA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MOLINA.GET_MOLINA_SOURCE_DATA 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.MOLINA.HIST_MOLINA_SOURCE_DATA SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11,A.$12,A.$13,A.$14,A.$15,A.$16,$17,CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) as LOADDATE,SPLIT_PART(metadata$filename,''/'',3) AS FILENAME FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Program_Clients/MOLINA/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT,PATTERN =>''.*mol_roster.*[.]csv'') A;

    --ViewSQL
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.MOLINA.MOLINA_SOURCE_DATA SELECT * FROM DISC_${var.SF_ENVIRONMENT}.MOLINA.HIST_MOLINA_SOURCE_DATA WHERE LOADDATE IN (SELECT MAX(LOADDATE) FROM DISC_${var.SF_ENVIRONMENT}.MOLINA.HIST_MOLINA_SOURCE_DATA);

    return ''Success'';
END;

 EOT
}

