resource "snowflake_procedure" "DISC_CCSI_GET_ACTION" {
	name ="GET_ACTION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_ACTION 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.ACTION select WM.$1,WM.$6,WM.$7,WM.$8,WM.$12,WM.$13,WM.$14,WM.$15,WM.$16,WM.$17,wm.$18,wm.$19,wm.$20,wm.$21,wm.$22,wm.$23,wm.$24,wm.$25,wm.$26,wm.$27,wm.$28,wm.$29,wm.$30,wm.$31,wm.$32,wm.$33,wm.$34,wm.$35,wm.$36,wm.$37,wm.$38,wm.$39,wm.$40,wm.$41,wm.$42,wm.$43,wm.$44,wm.$45,wm.$46,WM.$2,WM.$3,WM.$4,WM.$5,WM.$9,WM.$10,WM.$11,NULL,NULL,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),0 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/Action (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format,PATTERN => ''.*.csv'')wm;


    return ''Success'';
END;

 EOT
}

