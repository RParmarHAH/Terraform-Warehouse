CREATE OR REPLACE PROCEDURE DISC_PROD.CCSI.GET_RAWVRFP("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CCSI.GET_RAWVRFP_LATEST 
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
    INSERT OVERWRITE INTO DISC_PROD.CCSI.RAWVRFP_Latest select wm.$1,wm.$6,wm.$7,wm.$8,wm.$9,wm.$10,wm.$11,wm.$12,wm.$13,wm.$14,wm.$15,wm.$16,wm.$17,wm.$18,wm.$19,wm.$20,wm.$21,wm.$22,wm.$23,wm.$24,wm.$25,wm.$26,wm.$27,wm.$28,wm.$29,wm.$30,wm.$31,wm.$32,wm.$33,wm.$34,wm.$3,wm.$2,wm.$37,wm.$50,wm.$51,wm.$52,wm.$53,wm.$54,wm.$55,wm.$56,wm.$36,wm.$35,wm.$4,wm.$5,wm.$38,wm.$39,wm.$40,wm.$41,wm.$42,wm.$43,wm.$44,wm.$45,wm.$46,wm.$47,wm.$48,wm.$49,-1,-1,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),0 FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/fjn/rawvrfp_1(file_format => DISC_PROD.STAGE.tab_format,PATTERN => ''.*.csv'')wm;


    return ''Success'';
END;
';