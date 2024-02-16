CREATE OR REPLACE PROCEDURE DISC_PROD.ZENDESK.GET_SLA_POLICIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ZENDESK.GET_SLA_POLICIES 
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
    INSERT INTO DISC_PROD.ZENDESK.HIST_SLA_POLICIES(SELECT DISTINCT ''AMS'' AS SOURCE, j2.value:id::int AS ID,     j2.value::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM     @DISC_PROD.STAGE.AWSAZSTAGEPROD/Zendesk/output/sla_policies.json(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT),     LATERAL FLATTEN(input => $1:sla_policies) j2     WHERE ID IS NOT NULL );

    --ViewSQL
    MERGE INTO DISC_PROD.ZENDESK.SLA_POLICIES TGT USING ( SELECT DISTINCT * FROM DISC_PROD.ZENDESK.HIST_SLA_POLICIES WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.ZENDESK.HIST_SLA_POLICIES)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.ID = STAGE.JSON_DATA:id, TGT.URL = STAGE.JSON_DATA:url , TGT.TITLE = STAGE.JSON_DATA:title , TGT.DESCRIPTION = STAGE.JSON_DATA:description , TGT.POSITION = STAGE.JSON_DATA:position , TGT.FILTER_ALL = STAGE.JSON_DATA:filter:all , TGT.FILTER_ANY = STAGE.JSON_DATA:filter:any , TGT.POLICY_METRICS = STAGE.JSON_DATA:policy_metrics , TGT.CREATED_AT = STAGE.JSON_DATA:created_at , TGT.UPDATED_AT = STAGE.JSON_DATA:updated_at , TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, ID, URL, TITLE, DESCRIPTION, POSITION, FILTER_ALL, FILTER_ANY, POLICY_METRICS, CREATED_AT, UPDATED_AT, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG) VALUES (   STAGE.SOURCE ,  STAGE.JSON_DATA:id,  STAGE.JSON_DATA:url ,  STAGE.JSON_DATA:title ,  STAGE.JSON_DATA:description ,  STAGE.JSON_DATA:position ,  STAGE.JSON_DATA:filter:all ,  STAGE.JSON_DATA:filter:any ,  STAGE.JSON_DATA:policy_metrics ,  STAGE.JSON_DATA:created_at ,  STAGE.JSON_DATA:updated_at ,  STAGE.ETL_TASK_KEY ,  STAGE.ETL_INSERTED_TASK_KEY ,  STAGE.ETL_INSERTED_DATE ,  STAGE.ETL_INSERTED_BY ,  STAGE.ETL_LAST_UPDATED_DATE ,  STAGE.ETL_LAST_UPDATED_BY ,  STAGE.ETL_DELETED_FLAG );

    return ''Success'';
END;
';