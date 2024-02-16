CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_EMPLOYEETRAININGLICENSESCERTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_EMPLOYEETRAININGLICENSESCERTS 
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
    COPY INTO DISC_PROD.ASR.HIST_ASR_EMPLOYEETRAININGLICENSESCERTS FROM (SELECT A.$1 AS EMPLOYEESPECIALTRAININGID, A.$2 AS EMPLOYEEID, A.$3 AS SPECIALTRAININGID, A.$4 AS ISSUEDATE, A.$5 AS EXPARATIONDATE, A.$6 AS TRAININGDONEBYTHECOMPANY, A.$7 AS NOTES, A.$8 AS PAYROLLDEDUCATION, A.$9 AS PAYROLLDEDUCATIONDATE, A.$10 AS LASTMODIFIEDON, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_EmployeeTrainingLicensesCerts(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_EMPLOYEETRAININGLICENSESCERTS AS WITH curr_v AS (SELECT EMPLOYEESPECIALTRAININGID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.ASR.HIST_ASR_EMPLOYEETRAININGLICENSESCERTS GROUP BY EMPLOYEESPECIALTRAININGID) SELECT t.* FROM DISC_PROD.ASR.HIST_ASR_EMPLOYEETRAININGLICENSESCERTS t INNER JOIN curr_v v ON t.EMPLOYEESPECIALTRAININGID = v.EMPLOYEESPECIALTRAININGID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';