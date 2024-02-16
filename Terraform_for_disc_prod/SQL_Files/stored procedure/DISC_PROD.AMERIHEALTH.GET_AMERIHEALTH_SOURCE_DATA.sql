CREATE OR REPLACE PROCEDURE DISC_PROD.AMERIHEALTH.GET_AMERIHEALTH_SOURCE_DATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AMERIHEALTH.GET_AMERIHEALTH_SOURCE_DATA 
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
    INSERT INTO DISC_PROD.AMERIHEALTH.HIST_AMERIHEALTH_SOURCE_DATA SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11,A.$12,A.$13,A.$14,A.$15,A.$16,A.$17,CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) as LOADDATE,SPLIT_PART(metadata$filename,''/'',3) AS FILENAME FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Program_Clients/AMERIHEALTH/(file_format => DISC_PROD.STAGE.PSV_FORMAT,PATTERN =>''.*AHC_Monthly_Roster_.*[.]csv'') A;

    --ViewSQL
    INSERT OVERWRITE INTO DISC_PROD.AMERIHEALTH.AMERIHEALTH_SOURCE_DATA SELECT * FROM DISC_PROD.AMERIHEALTH.HIST_AMERIHEALTH_SOURCE_DATA WHERE LOADDATE IN (SELECT MAX(LOADDATE) FROM DISC_PROD.AMERIHEALTH.HIST_AMERIHEALTH_SOURCE_DATA);

    return ''Success'';
END;
';