CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_TRANSACTIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_TRANSACTIONS 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_TRANSACTIONS (SELECT A.$1 AS Branch_Id, A.$2 AS Episode_Id, A.$3 AS Patient_Id, A.$4 AS Fact_AR_Id, A.$5 AS Account, A.$6 AS Branch, A.$7 AS Mrn, A.$8 AS Patient_First_Name, A.$9 AS Patient_Last_Name, A.$10 AS Is_Remittance, A.$11 AS Is_Manual_Payment, A.$12 AS Is_Adjustment, A.$13 AS Payment_Amount, A.$14 AS Payment_Date, A.$15 AS Payment_Post_Date, A.$16 AS Adjustment_Amount, A.$17 AS Adjustment_Date, A.$18 AS Adjustment_Post_Date, A.$19 AS Check_RA, A.$20 AS EFT_Number, :TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/Transactions(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;
';