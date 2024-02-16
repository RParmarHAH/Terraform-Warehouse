resource "snowflake_procedure" "DISC_CCSI_GET_ACTIONTYPECHANGE" {
	name ="GET_ACTIONTYPECHANGE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_MCOINV 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.MCOINV select wm.$1,wm.$6,wm.$7,wm.$8,wm.$9,wm.$10,wm.$11,wm.$12,wm.$13,wm.$14,wm.$15,wm.$16,wm.$17,wm.$18,wm.$19,wm.$20,wm.$21,wm.$22,wm.$23,wm.$24,wm.$25,wm.$26,wm.$27,wm.$28,wm.$29,wm.$30,wm.$33,wm.$34,wm.$35,wm.$36,wm.$37,wm.$38,wm.$39,wm.$40,wm.$41,wm.$42,wm.$43,wm.$44,wm.$2,wm.$3,wm.$4,wm.$5,wm.$31,wm.$32,-1,-1,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),0 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/MCOinv/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format,PATTERN => ''.*.csv'')wm;


    return ''Success'';
END;

 EOT
}

