CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALAYACARE_DIM_ACTIVITIES("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
                BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALAYACARE_DIM_ACTIVITIES
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 12/08/2023   DEEPEN GAJJAR       INITIAL DEVELOPMENT
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_PROD.STAGE.ALAYACARE_DIM_ACTIVITIES
SELECT DISTINCT MD5(NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),
''Unknown'') || '' ('' || NVL(COMPANY.BRANCH_ID,
''-1'') || '')'' || ''-'' || NOTE_TIER_5.PROPERTIES_TYPE ::STRING || ''-'' || ''ALAYACARE'') AS ACTIVITY_KEY
,9 AS SOURCE_SYSTEM_ID
,UPPER(NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(COMPANY.BRANCH_ID,''-1'') || '')'') AS SYSTEM_CODE
,CASE WHEN TRIM(NOTE_TIER_5.PROPERTIES_TYPE) =''employee_1st_shift_call'' THEN ''1st Shift Follow Up''
WHEN TRIM(NOTE_TIER_5.PROPERTIES_TYPE) =''employee_1st_paycheck_call'' THEN ''1st Paycheck Follow Up''
WHEN TRIM(NOTE_TIER_5.PROPERTIES_TYPE) =''employee_30_day_pulse'' THEN ''30 Day Follow Up'' END ACTIVITY_NAME
,:STR_ETL_TASK_KEY  AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY  AS ETL_INSERTED_TASK_KEY                            
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
,0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.ALAYACARE.TBL_JOURNAL_ENTRIES_TIER_4 NOTE_TIER_5
JOIN DISC_PROD.ALAYACARE.BRANCH AS COMPANY ON COMPANY.BRANCH_ID = NOTE_TIER_5.BRANCH_ID
WHERE ((UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_1st_shift_call'')
	OR UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_1st_paycheck_call'')
		OR UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_30_day_pulse'')))
 ;
 RETURN ''SUCCESS'';
    END
';