CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_HOMEHEALTH_INSURANCEPAYERLIST("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_HOMEHEALTH_INSURANCEPAYERLIST 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_HomeHealth_InsurancePayerList (SELECT A.$1 AS Insurance_Id,A.$2 AS Insurance_Name,A.$3 AS Display_Name,A.$4 AS Payer_Class,A.$5 AS Type_Of_Bill,A.$6 AS Bill_Type,A.$7 Payer_Id,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG  FROM @DISC_PROD.stage.AWSAZSTAGEPROD/Axxess/SFTP_files/HomeHealth_InsurancePayerList(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;
';