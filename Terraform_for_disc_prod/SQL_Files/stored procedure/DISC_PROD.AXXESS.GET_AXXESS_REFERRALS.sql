CREATE OR REPLACE PROCEDURE DISC_PROD.AXXESS.GET_AXXESS_REFERRALS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AXXESS.GET_AXXESS_REFERRALS 
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
    INSERT OVERWRITE INTO DISC_PROD.AXXESS.AXXESS_REFERRALS (SELECT A.$1 AS Referral_Id, A.$2 AS Branch_Id, A.$3 AS Account, A.$4 AS Branch, A.$5 AS Mrn, A.$6 AS Patient_First_Name, A.$7 AS Patient_Last_Name, A.$8 AS Is_Patient, A.$9 AS Referral_Status, A.$10 AS Patient_Status, A.$11 AS Date_Of_Birth, A.$12 AS Referral_Date, A.$13 AS Referral_Source, A.$14 AS Is_Referral, ''-1'' AS ETL_TASK_KEY,''-1'' AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/Referrals(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    return ''Success'';
END;
';