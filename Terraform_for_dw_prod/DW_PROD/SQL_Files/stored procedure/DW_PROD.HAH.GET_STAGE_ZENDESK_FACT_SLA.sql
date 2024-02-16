CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ZENDESK_FACT_SLA("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
 --*****************************************************************************************************************************
-- NAME:  ZENDESK_FACT_SLA
--
-- PURPOSE: Creates one row per TICKET according to ZENDESK 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 12-20-2023  MIRISHA               Initial development
-- 02-13-2024  MIRISHA               Removed duplicate records from source and removed next_reply_time records as per business confirmation
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ZENDESK_FACT_SLA
WITH POLICY_METRICS AS (
	  SELECT 
      T.id,
      f.value:business_hours::boolean AS  business_hours,
     CASE WHEN f.value:metric::STRING =''first_reply_time'' THEN ''reply_time''
          WHEN f.value:metric::STRING=''total_resolution_time'' THEN ''resolution_time''
     ELSE f.value:metric::STRING END  AS metric,
      f.value:priority::string AS priority,
      f.value:target::int AS target 
    FROM DISC_PROD.ZENDESK.SLA_POLICIES T,
    LATERAL FLATTEN(input => T.POLICY_METRICS) f
    ORDER BY ID,PRIORITY,METRIC  ASC ),
    TICKET_METRICS_EVENT AS (
    SELECT * FROM DISC_PROD.ZENDESK.TICKET_METRICS_EVENT WHERE TYPE = ''apply_sla'' AND INSTANCE_ID=''1''   -- taking instance id =1 to remove next reply time records and only take first reply time , all other metrics have instance id =1 , so it wont affect them
    QUALIFY ROW_NUMBER() OVER(PARTITION BY TICKET_ID,METRIC,INSTANCE_ID,TYPE,SLA_POLICY_ID,SLA_TARGET  ORDER BY TIME DESC) = 1 --to remove duplicate records
    )
SELECT DISTINCT 
      ''ZENDESK_AMS'' AS SYSTEM_CODE,
	   MD5(''ZENDESK'' || ''-'' || TME.ID  || ''-'' || TME.TICKET_ID || ''-'' || ''ZENDESK'' ) AS TICKET_SLA_KEY,
	   TME.ID,
       25 AS SOURCE_SYSTEM_ID,
	   FT.TICKET_KEY,
	   TME.TICKET_ID,
	   FT.WH_EMPLOYEE_KEY,
	   TKT.PRIORITY, 
	   INITCAP(REGEXP_REPLACE(TME.METRIC,''_'','' '')) AS METRIC,
	   TME.SLA_TARGET,
	   TME.SLA_POLICY_ID,
	   TME.SLA_POLICY_TITLE,
	   TME.SLA_POLICY_DESCRIPTION,
	   TM.REPLY_TIME_IN_MINUTES_BUSINESS AS REPLY_TIME,
	   TM.FULL_RESOLUTION_TIME_IN_MINUTES_BUSINESS AS FULL_RESOLUTION_TIME,
	   TM.REQUESTER_WAIT_TIME_IN_MINUTES_BUSINESS AS REQUESTER_WAIT_TIME,
	   TM.AGENT_WAIT_TIME_IN_MINUTES_BUSINESS AS AGENT_WAIT_TIME,
	   (FULL_RESOLUTION_TIME-AGENT_WAIT_TIME) AS AGENT_WORK_TIME,
	   CASE WHEN UPPER(TRIM(TME.METRIC))=''REPLY_TIME'' THEN IFF(REPLY_TIME<=TME.SLA_TARGET,TRUE,FALSE)
	        WHEN UPPER(TRIM(TME.METRIC))=''AGENT_WORK_TIME'' THEN IFF(AGENT_WORK_TIME<=TME.SLA_TARGET,TRUE,FALSE)
	        WHEN UPPER(TRIM(TME.METRIC))=''REQUESTER_WAIT_TIME'' THEN IFF(REQUESTER_WAIT_TIME<=TME.SLA_TARGET,TRUE,FALSE)
	   END AS SLA_TARGET_ACHIEVED,
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG,
		0 AS ETL_INFERRED_MEMBER_FLAG
FROM TICKET_METRICS_EVENT TME
JOIN DISC_PROD.ZENDESK.TICKET_METRICS TM 
	ON TM.TICKET_ID = TME.TICKET_ID
LEFT JOIN DISC_PROD.ZENDESK.TICKETS TKT
	ON TKT.ID = TME.TICKET_ID
	AND TKT.SOURCE = ''AMS''
LEFT JOIN POLICY_METRICS PM 
    ON PM.ID = TME.SLA_POLICY_ID AND TME.SLA_TARGET = PM.target AND TME.METRIC = PM.metric
LEFT JOIN HAH.FACT_TICKET FT
    ON FT.ID =TME.TICKET_ID AND FT.SYSTEM_CODE =''ZENDESK_AMS''
WHERE TKT.PRIORITY = PM.priority;
    SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';