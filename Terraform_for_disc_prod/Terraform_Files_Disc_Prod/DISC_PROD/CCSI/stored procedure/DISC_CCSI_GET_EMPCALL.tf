resource "snowflake_procedure" "DISC_CCSI_GET_EMPCALL" {
	name ="GET_EMPCALL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CCSI.GET_EMPCALL 
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
    INSERT  OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.CCSI.EMPCALL select wm.$1,WM.$6,WM.$7 ,wm.$8,WM.$9,WM.$10,WM.$11,WM.$12,wm.$13,WM.$14,WM.$15,WM.$16,WM.$17  ,WM.$18 ,WM.$19 ,WM.$20 , WM.$21,WM.$22 ,WM.$23 ,WM.$24  ,WM.$25  ,WM.$26 ,WM.$27,WM.$28,WM.$29  ,  WM.$30,  WM.$31,WM.$32  ,WM.$2  ,WM.$3  ,WM.$4 ,WM.$5  ,-1,-1,current_timestamp::TIMESTAMP_NTZ(9),current_user(),current_timestamp::TIMESTAMP_NTZ(9),current_user(),''FALSE'' from @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/fjn/empcall(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.tab_format, pattern =>''.*csv'')wm;


    return ''Success'';
END;

 EOT
}

