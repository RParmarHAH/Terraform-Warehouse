CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_VENDORS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_Vendors 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.Vendors (SELECT t.$1 AS VendorID, t.$2 AS VendorName, t.$3 AS VendorInitial, t.$4 AS VendorCode, t.$5 AS Starttm, t.$6 AS Endtm, t.$7 AS SYS_CHANGE_VERSION, t.$8 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$8,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_Vendors.*[.]csv.gz'') T);

    return ''Success'';
END;
';