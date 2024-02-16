CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_PAYMENTSOURCES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_PAYMENTSOURCES 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_PAYMENTSOURCES ( SELECT BI.$1 AS Insurance_Id, BI.$2 AS Payor_Id, BI.$3 AS Agency_Id, BI.$4 AS Agency_Name,BI.$5 AS Insurance_Name, BI.$6 AS Payor_Name, BI.$7 AS Payor_Type_Name, BI.$8 AS Payer_Category_Name, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/PaymentSources(file_format => DISC_PROD.STAGE.PSV_FORMAT) BI );

    return ''Success'';
END;
';