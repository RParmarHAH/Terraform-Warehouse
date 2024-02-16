CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_PAYROLL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_PAYROLL 
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
    COPY INTO DISC_PROD.ASR.HIST_ASR_Payroll FROM (SELECT A.$1 AS Co_Code, A.$2 AS Batch_ID, A.$3 AS FILE, A.$4 AS Reg_Hours, A.$5 AS OT_Hours, A.$6 AS Temp_Dept, A.$7 AS Reg_Hours_Code, A.$8 AS Reg_Rate, A.$9 AS OT_Rate, A.$10 AS NAME, A.$11 AS Program, A.$12 AS Payer_Source, A.$13 AS Regular_Earnings, A.$14 AS OT_Earnings, A.$15 AS Total_Earnings, A.$16 AS Office_Location, A.$17 AS Combined_Rate, A.$18 AS Employee_ID, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_Payroll(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_PAYROLL AS WITH curr_v AS (SELECT EMPLOYEE_ID, PROGRAM, PAYER_SOURCE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.ASR.HIST_ASR_PAYROLL GROUP BY EMPLOYEE_ID, PROGRAM, PAYER_SOURCE) SELECT t.* FROM DISC_PROD.ASR.HIST_ASR_PAYROLL t INNER JOIN curr_v v ON t.EMPLOYEE_ID = v.EMPLOYEE_ID AND t.PROGRAM = v.PROGRAM AND t.PAYER_SOURCE = v.PAYER_SOURCE  AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';