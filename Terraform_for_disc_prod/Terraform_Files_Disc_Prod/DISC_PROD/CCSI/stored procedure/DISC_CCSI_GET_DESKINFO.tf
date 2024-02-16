resource "snowflake_procedure" "DISC_CCSI_GET_DESKINFO" {
	name ="GET_DESKINFO"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_DESKINFO 
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
    INSERT OVERWRITE  INTO DISC_${var.SF_ENVIRONMENT}.CCSI.DESKINFO select wm.$1,WM.$6,WM.$7,wm.$8,WM.$9,WM.$2,WM.$3,WM.$4,WM.$5,''-1'',''-1'',current_timestamp::TIMESTAMP_NTZ(9),current_user(),current_timestamp::TIMESTAMP_NTZ(9),current_user(),''FALSE'' from @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/DeskInfo(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format, pattern=>''.*csv'')wm;


    return ''Success'';
END;

 EOT
}

