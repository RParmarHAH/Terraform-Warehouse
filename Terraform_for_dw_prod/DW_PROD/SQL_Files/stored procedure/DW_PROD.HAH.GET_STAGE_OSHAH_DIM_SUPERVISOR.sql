CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_OSHAH_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  OSHAH_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to OPENSYSTEM 
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 12/08/2022   Pankti Fadia		    Initial development
-- 07/12/2023   Sandesh Gosavi         update code to use config flag
-- 08/25/2023   Mirisha                updated SYSTEM_CODE and SUPERVISOR_STATE_CODE
--***************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.OSHAH_DIM_SUPERVISOR
WITH DISTINCT_SUP AS (SELECT sup.COORDINATORID ,sup.COORDINATORNAME,O.STATE,
	 ROW_NUMBER() OVER(PARTITION BY sup.COORDINATORID ORDER BY O.STATE DESC) RN
	 FROM DISC_PROD.HHAEXCHANGEOSHAH.TBLCOORDINATOR_REPL SUP
LEFT join DISC_PROD.HHAEXCHANGEOSHAH.office_COORDINATORS oc
	 	on sup.coordinatorid = OC.CoordinatorID
	 JOIN DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL O
	 ON O.OFFICEID = OC.OFFICEID
	 QUALIFY RN=1)
SELECT MD5(''OSHAH'' || ''-'' ||SUP.COORDINATORID|| ''-'' || ''HHAEXCHANGE'') AS SUPERVISOR_KEY
	 , SUP.COORDINATORID AS SUPERVISOR_CODE
	 , CONCAT(''OSHAH - '',DS.state) AS SYSTEM_CODE
	 , 17 AS SOURCE_SYSTEM_ID
	 , UPPER(SUP.COORDINATORNAME) AS SUPERVISOR_NAME
	 , DS.state AS SUPERVISOR_STATE_CODE
	 , NULL SUPERVISOR_JOB_CODE
	 , NULL SUPERVISOR_JOB_TITLE
	 , TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
	 , TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
	 , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	 , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	 , CURRENT_USER AS ETL_INSERTED_BY
	 , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	 , CURRENT_USER AS ETL_LAST_UPDATED_BY
	 , SUP.DELETED AS ETL_DELETED_FLAG
	 , 0::BOOLEAN AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.HHAEXCHANGEOSHAH.TBLCOORDINATOR_REPL SUP
	LEFT JOIN DISTINCT_SUP DS ON DS.COORDINATORID = SUP.COORDINATORID
	WHERE DS.STATE IN (SELECT STATE FROM DISC_PROD.HHAEXCHANGEOSHAH.CONFIGURATION WHERE CONFIG = TRUE)	
UNION ALL 	
SELECT MD5(''OSHAH'' || ''-'' || -1 || ''-'' || ''HHAEXCHANGE'') AS SUPERVISOR_KEY
	 , -1 AS SUPERVISOR_CODE
	 , CONCAT(''OSHAH - PA'') AS SYSTEM_CODE
	 , 17 AS SOURCE_SYSTEM_ID
	 , ''UNKNOWN'' AS SUPERVISOR_NAME
	 , ''PA'' AS SUPERVISOR_STATE_CODE
	 , NULL SUPERVISOR_JOB_CODE
	 , NULL SUPERVISOR_JOB_TITLE
	 , TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
	 , TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
     , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	 , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	 , CURRENT_USER AS ETL_INSERTED_BY
	 , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	 , CURRENT_USER AS ETL_LAST_UPDATED_BY
	 , 0::BOOLEAN AS ETL_1DELETED_FLAG
	 , 0::BOOLEAN AS ETL_INFERRED_MEMBER_FLAG;
RETURN ''SUCCESS'';
end;
';