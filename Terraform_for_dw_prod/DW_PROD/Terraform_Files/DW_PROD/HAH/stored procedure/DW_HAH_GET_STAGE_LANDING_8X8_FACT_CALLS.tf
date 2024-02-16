resource "snowflake_procedure" "DW_HAH_GET_STAGE_LANDING_8X8_FACT_CALLS" {
	name ="GET_STAGE_LANDING_8X8_FACT_CALLS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --*****************************************************************************************************************************
-- NAME:  8X8_FACT_CALLS
--
-- PURPOSE: Creates one row per CALL according to 8X8 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/22/2024  MIRISHA               Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.LANDING_8X8_FACT_CALLS
WITH BRANCH AS
(
	SELECT DISTINCT  CALL_ID
		, REGEXP_REPLACE(BRANCHES , ''[]''''''''[]'', '''', 1, 0, ''i'') AS BRANCH
		, TRIM(SPLIT_PART(BRANCH, '','', 1)) AS  BRANCH1
		, CASE  WHEN BRANCH1 ILIKE ANY (''%ZENDESK%'' , ''Compucom Headquarters'') THEN ''''
				WHEN BRANCH1 NOT ILIKE ''%-%'' THEN TRIM(SPLIT_PART(BRANCH1, '' '', 1))
				ELSE TRIM(REPLACE(LEFT(BRANCH1, POSITION(''-'', BRANCH1)),''-'',''''))
				END AS STATE1 
		, CASE  WHEN BRANCH1 ILIKE ''%ZENDESK%'' THEN TRIM(SPLIT_PART(BRANCH1, ''-'', 1))
				WHEN BRANCH1 NOT ILIKE ''%-%'' THEN TRIM(SPLIT_PART(BRANCH1, '' '', 2))
				ELSE TRIM(SPLIT_PART(BRANCH1, ''-'', 2))
				END AS BRANCHNAME1
		, CASE  WHEN BRANCH1 ILIKE ''%Adaptive'' THEN TRIM(SPLIT_PART(BRANCH1,''-'',3))
				WHEN BRANCH1 ILIKE ''%ZENDESK%'' THEN  TRIM(RIGHT(BRANCH1, 3))
				WHEN BRANCH1 NOT ILIKE ''%-%'' THEN TRIM(RIGHT(BRANCH1, POSITION('' '', BRANCH1)))
				ELSE TRIM(RIGHT(BRANCH1, POSITION(''-'', BRANCH1)))
				END AS OFFICECODE1
		, SPLIT_PART(BRANCH, '','', 2) AS BRANCH2
		, SPLIT_PART(BRANCH, '','', 3) AS BRANCH3
		, SPLIT_PART(BRANCH, '','', 4) AS BRANCH4
		, SPLIT_PART(BRANCH, '','', 5) AS BRANCH5
	FROM DISC_${var.SF_ENVIRONMENT}.LANDING_8X8.TBL_INBOUND_CALLS  
), 
BRANCH_MAPPING AS
(
	SELECT DISTINCT CALL_ID,  BRANCH1, STATE1, BRANCHNAME1 , OFFICECODE1
					, PROD_B.OFFICE_STATE_CODE, PROD_B.OFFICE_NUMBER, PROD_B.BRANCH_NAME
					, PROD_B.BRANCH_KEY
	FROM BRANCH AS B
	LEFT JOIN INTEGRATION.DIM_BRANCH_MERGED  AS PROD_B
		ON TRIM(UPPER(PROD_B.OFFICE_STATE_CODE)) = TRIM(UPPER(B.STATE1))
		AND TRIM(UPPER(PROD_B.OFFICE_NUMBER)) = TRIM(UPPER(B.OFFICECODE1)) AND PROD_B.SOURCE_SYSTEM_TYPE =''AMS''
		AND TRIM(UPPER(PROD_B.OFFICE_STATE_CODE))!=''GA'' AND TRIM(UPPER(PROD_B.OFFICE_NUMBER))!=''908''
),
UNIFORM_DATE_TIME AS
(
		SELECT DISTINCT CALL_ID
						, TO_TIMESTAMP_TZ(START_TIME) AS START_TIME_TZ
						, TO_DATE(START_TIME_TZ) AS CALL_START_DATE
						, TO_TIME(START_TIME_TZ) AS CALL_START_TIME
						, TO_TIMESTAMP_TZ(DISCONNECTED_TIME) AS DISCONNECT_TIME_TZ
						, TO_DATE(DISCONNECT_TIME_TZ) AS CALL_DISCONNECTED_DATE
						, TO_TIME(DISCONNECT_TIME_TZ) AS CALL_DISCONNECTED_TIME
						, IFF(ANSWERED != ''Answered'', NULL, TO_TIMESTAMP_TZ("ANSWERED_TIME")) AS ANSWER
						, CONVERT_TIMEZONE(''America/Chicago'', ANSWER) AS ANS_TZ
						, TO_DATE(ANS_TZ) AS CALL_ANSWERED_DATE
						, TO_TIME(ANS_TZ) AS CALL_ANSWERED_TIME
						, DATEDIFF(''SECOND'',START_TIME_TZ, ANS_TZ) AS DIFF_START_ANSWTIME_IN_SEC
						, TALK_TIME_MS/1000 AS TALK_TIME_SEC
						, TO_TIME(TO_TIMESTAMP(TALK_TIME_SEC :: INT )) AS TALK_TIME
						, CALL_TIME/1000 AS CALL_TIME_SEC
						, TO_TIME(TO_TIMESTAMP(CALL_TIME_SEC :: INT )) AS CALL_TIME
						, "RING_DURATION"/1000 AS RING_DURATION_SEC
						, TO_TIME(TO_TIMESTAMP(RING_DURATION_SEC :: INT)) AS RING_DURATION
						, ABANDONED_TIME/1000 AS ABANDONED_TIME_SEC
						, TO_TIME(TO_TIMESTAMP(ABANDONED_TIME_SEC :: INT)) AS ABANDONED_TIME
						, "WAIT_TIME_MS"/1000 AS WAIT_TIME_SEC
						, TO_TIME(TO_TIMESTAMP(WAIT_TIME_SEC :: INT)) AS WAIT_TIME
						, "CALLEE_HOLD_DURATION_MS"/1000 AS CALLEE_HOLD_DURATION_SEC
						, TO_TIME(TO_TIMESTAMP(CALLEE_HOLD_DURATION_SEC :: INT)) AS CALLEE_HOLD_TIME
		FROM DISC_${var.SF_ENVIRONMENT}.LANDING_8X8.TBL_INBOUND_CALLS 
)
	SELECT  DISTINCT 
	        ''8X8'' AS SYSTEM_CODE
			,MD5(CL.CALL_ID|| ''-'' || NVL(CL.CALLER, ''-1'')|| NVL(CL.CALLEE,''-1'')) AS CALL_KEY
			,CASE WHEN TRY_CAST(CL.CALL_ID AS INTEGER) IS NULL THEN NULL
              ELSE TRY_CAST(CL.CALL_ID AS INTEGER) END AS CALL_ID
			,''37'' AS SOURCE_SYSTEM_ID
			,MD5(CL.CALLEE) AS AGENT_KEY
			,MD5(NVL(CL.CALLER, ''-1'')) AS CALLER_KEY
			,NULL AS TICKET_KEY
			,NULL AS TICKET_ID
			,CASE WHEN TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLEE, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER) IS NULL THEN NULL 
             ELSE TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLEE, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER)
             END AS AGENT_ID										--WHO RECEIVES A CALL
            ,CASE WHEN TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLER, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER) IS NULL THEN NULL 
             ELSE TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLER, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER) END AS CALLER_ID
			,NULL AS CALL_GROUP_ID
			,NULL AS GROUP_TITLE
			,NULL AS GROUP_DESCRIPTION
			,NULL AS ORGANIZATION_ID
			, BM.BRANCH_KEY
			, BM.OFFICE_STATE_CODE
			, NULL AS CALL_CHARGE
			, CL.LAST_LEG_DISPOSITION AS COMPLETION_STATUS
			,CL.DIRECTION
			,DT.CALL_TIME_SEC AS DURATION 
			,NULL AS EXCEEDED_QUEUE_WAIT_TIME
			,DT.CALLEE_HOLD_DURATION_SEC AS HOLD_TIME
			,NULL AS MINUTES_BILLED
			,NULL AS PHONE_NUMBER_ID
			,CASE WHEN TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLEE, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER) IS NULL THEN NULL 
             ELSE TRY_CAST(LPAD(REGEXP_REPLACE(CL.CALLEE, ''\\\\+1'', ''''), 10, ''0'') AS INTEGER)
             END AS PHONE_NUMBER
			,DT.DIFF_START_ANSWTIME_IN_SEC AS TIME_TO_ANSWER
			,IFF(UPPER(TRIM(CL.LAST_LEG_DISPOSITION))=''VOICEMAIL'',TRUE,FALSE) AS  VOICEMAIL
			,DT.WAIT_TIME_SEC AS WAIT_TIME
			,NULL AS WRAP_UP_TIME
			,DT.TALK_TIME_SEC AS TALK_TIME
			,NULL AS CONSULTATION_TIME
			,NULL AS OUTSIDE_BUSINESS_HOURS
			,NULL AS CALLBACK
			,NULL AS DEFAULT_GROUP
			,NULL AS LINE_ID
			,NULL AS LINE_TYPE
			,NULL AS CALL_CHANNEL
			,NULL AS QUALITY_ISSUES
			,CL.START_TIME AS CREATED_AT
			,CASE
                  WHEN EXTRACT(MINUTE, CL.START_TIME) < 30 THEN
                    TO_CHAR(DATE_TRUNC(''HOUR'', CL.START_TIME), ''HH24:MI'') || '' - '' || TO_CHAR(DATEADD(MINUTE, 30, DATE_TRUNC(''HOUR'', CL.START_TIME)), ''HH24:MI'')
                  ELSE
                    TO_CHAR(DATEADD(MINUTE, 30, DATE_TRUNC(''HOUR'', CL.START_TIME)), ''HH24:MI'') || '' - '' || TO_CHAR(DATEADD(MINUTE, 60, DATE_TRUNC(''HOUR'', CL.START_TIME)), ''HH24:MI'')
             END AS TIME_BRACKET
			,NULL AS UPDATED_AT
			, DNIS											--CALLER DIALED A FIRST NUMBER TO REACHOUT THE APPROPRIATE DEPARTMENT
			, AA_DESTINATION
			, DT.CALL_START_DATE AS CALL_START_DATE 
			, DT.CALL_START_TIME AS CALL_START_TIME 
			, DT.CALL_DISCONNECTED_DATE AS CALL_DISCONNECTED_DATE
			, DT.CALL_DISCONNECTED_TIME AS CALL_DISCONNECTED_TIME
			, CL.CALLEE_DISCONNECT_ON_HOLD
			, CL.CALLER_DISCONNECT_ON_HOLD
			--, DT.CALL_TIME AS CALL_TIME
            , DT.CALL_ANSWERED_DATE AS CALL_ANSWERED_DATE
			, DT.CALL_ANSWERED_TIME AS CALL_ANSWERED_TIME
			,CL.CALL_LEG_COUNT
			, DT.RING_DURATION AS RING_DURATION
			, DT.ABANDONED_TIME AS ABANDONED_TIME
            , CL.DEPARTMENTS
			, CL.BRANCHES
            ,CL.CALLER_NAME
            ,CL.CALLEE_NAME
			,NULL AS WH_EMPLOYEE_KEY
			---- ETL FIELDS ----
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
,CURRENT_USER AS ETL_INSERTED_BY
,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
,CURRENT_USER AS ETL_LAST_UPDATED_BY
,0 AS ETL_DELETED_FLAG	
	FROM DISC_${var.SF_ENVIRONMENT}.LANDING_8X8.TBL_INBOUND_CALLS  AS CL
	LEFT JOIN BRANCH_MAPPING AS BM
		ON BM.CALL_ID = CL.CALL_ID
	LEFT JOIN UNIFORM_DATE_TIME AS DT
		ON DT.CALL_ID = CL.CALL_ID;
	
	SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

