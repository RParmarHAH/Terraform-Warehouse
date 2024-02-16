CREATE OR REPLACE PROCEDURE DISC_PROD.CCSI.GET_DESKINFO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CCSI.GET_DESKINFO 
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
    INSERT OVERWRITE  INTO DISC_PROD.CCSI.DESKINFO select wm.$1,WM.$6,WM.$7,wm.$8,WM.$9,WM.$2,WM.$3,WM.$4,WM.$5,''-1'',''-1'',current_timestamp::TIMESTAMP_NTZ(9),current_user(),current_timestamp::TIMESTAMP_NTZ(9),current_user(),''FALSE'' from @DISC_PROD.STAGE.AWSAZSTAGEPROD/fjn/DeskInfo(file_format => DISC_PROD.STAGE.tab_format, pattern=>''.*csv'')wm;


    return ''Success'';
END;
';