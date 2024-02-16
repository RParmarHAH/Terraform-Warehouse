resource "snowflake_procedure" "DISC_CCSI_GET_MASTERCLIENT" {
	name ="GET_MASTERCLIENT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_MASTERCLIENT_LATEST 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.MASTERCLIENT_LATEST select wm.$1,wm.$6,wm.$7,wm.$8,wm.$9,wm.$10,wm.$11,wm.$12,wm.$13,wm.$14,wm.$15,wm.$16,wm.$17,wm.$18,wm.$19,wm.$20,wm.$21,wm.$22,wm.$23,wm.$24,wm.$25,wm.$26,wm.$27,wm.$28,wm.$29,wm.$30,wm.$31,wm.$32,wm.$33,wm.$34,wm.$35,wm.$36,wm.$37,wm.$38,wm.$39,wm.$40,wm.$41,wm.$42,wm.$43,wm.$44,wm.$45,wm.$46,wm.$47,wm.$48,wm.$49,wm.$50,wm.$51,wm.$52,wm.$53,wm.$54,wm.$55,wm.$56,wm.$57,wm.$58,wm.$59,wm.$60,wm.$65,wm.$66,wm.$67,wm.$68,wm.$69,wm.$70,wm.$71,wm.$72,wm.$73,wm.$74,wm.$75,wm.$76,wm.$77,wm.$78,wm.$79,wm.$80,wm.$81,wm.$82,wm.$83,wm.$84,wm.$85,wm.$86,wm.$87,wm.$88,wm.$89,wm.$90,wm.$91,wm.$2,wm.$3,wm.$4,wm.$5,wm.$61,wm.$62,wm.$63,wm.$64,NULL,NULL,CURRENT_DATE(),CURRENT_USER(),CURRENT_DATE(),CURRENT_USER(),0 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/masterclient(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format,PATTERN => ''.*.csv'')wm;


    return ''Success'';
END;

 EOT
}

