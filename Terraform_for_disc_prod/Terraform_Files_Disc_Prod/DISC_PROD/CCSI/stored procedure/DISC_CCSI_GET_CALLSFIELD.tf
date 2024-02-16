resource "snowflake_procedure" "DISC_CCSI_GET_CALLSFIELD" {
	name ="GET_CALLSFIELD"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_CALLSFIELD_LATEST 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.CALLSFIELD_LATEST SELECT WM.$1,WM.$6,WM.$7,WM.$8,WM.$9,WM.$10,WM.$11,WM.$12,WM.$13,WM.$14,WM.$15,WM.$16,WM.$17,WM.$2,WM.$3,WM.$4,WM.$5,NULL,NULL,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),0 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/CallsField(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format,PATTERN => ''.*.csv'')wm;


    return ''Success'';
END;

 EOT
}

