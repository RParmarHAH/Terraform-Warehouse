resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_FACT_CAREGIVER_TOUCH_POINT" {
	name ="GET_STAGE_ALAYACARE_FACT_CAREGIVER_TOUCH_POINT"
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

                BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALAYACARE_FACT_CAREGIVER_TOUCH_POINT
--
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 12/01/2023   DEEPEN GAJJAR       INITIAL DEVELOPMENT
-- 12/15/2023   DEEPEN GAJJAR       ADDED EMPLOYEE FIRST NAME AND LAST NAME FIELDS
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.ALAYACARE_FACT_CAREGIVER_TOUCH_POINT
WITH EMPLOYEE AS 
(
SELECT * FROM 
(
    SELECT EMPLOYEE_ID,MASTER_ID,EMPLOYEE_ID AS ORIGINAL_RECORD_ID,BRANCH_ID
    FROM  DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST  
) 
UNION
SELECT * FROM 
(
    SELECT DISTINCT ID,MASTER_ID,ID AS ORIGINAL_RECORD_ID,BRANCH_ID
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MATCH_LIST 
    WHERE ID NOT IN (SELECT EMPLOYEE_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST ) 
) 
)
SELECT
MD5(NVL(TRIM(employee_branch.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(employee_branch.BRANCH_ID,''-1'') || '')'' || ''-'' || NVL(note_tier_5.ID ::INT,-1) || ''-'' || ''ALAYACARE'') AS INTERACTION_KEY
,9 AS SOURCE_SYSTEM_ID
,UPPER(NVL(TRIM(employee_branch.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(employee_branch.BRANCH_ID,''-1'') || '')'') AS SYSTEM_CODE
,TO_DATE(note_tier_5.create_time) AS ACTIVITY_DATE
,MD5(NVL(TRIM(employee_branch.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(EMPLOYEE_BRANCH.BRANCH_ID,''-1'') || '')'' || ''-'' || NVL(E.master_id::INT,-1) || ''-'' || ''ALAYACARE'') AS EMPLOYEE_KEY
,UPPER(EMP.profile_first_name) AS EMPLOYEE_FIRST_NAME
,UPPER(EMP.profile_last_name) AS EMPLOYEE_LAST_NAME
,MD5(NVL(TRIM(employee_branch.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(employee_branch.BRANCH_ID,''-1'') || '')'' || ''-'' || GROUPS.GROUP_ID || ''-'' || ''ALAYACARE'') AS BRANCH_KEY
,MD5(NVL(TRIM(employee_branch.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(employee_branch.BRANCH_ID,''-1'') || '')'' || ''-'' || NOTE_TIER_5.PROPERTIES_TYPE ::STRING  || ''-'' || ''ALAYACARE'') AS ACTIVITY_KEY,
CASE
            WHEN contains(note_tier_5.properties_content, ''li>'')
                THEN RTRIM(RTRIM(REGEXP_REPLACE((REGEXP_REPLACE(note_tier_5.properties_content, ''</[<(li)]+>'','' & '')), ''<[^<]+>'','''')), ''&'')::string
            ELSE REGEXP_REPLACE(note_tier_5.properties_content, ''<[^<]+>'','''')::string
         END  AS ACTIVITY_NOTES
,:STR_ETL_TASK_KEY  AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY  AS ETL_INSERTED_TASK_KEY                            
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
,0 as ETL_DELETED_FLAG
,0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE  AS employee_tier_5
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH  AS employee_branch ON (employee_tier_5."BRANCH_ID")=(employee_branch."BRANCH_ID")
LEFT JOIN EMPLOYEE E ON
employee_tier_5.EMPLOYEE_ID = E.EMPLOYEE_ID
AND employee_branch.BRANCH_ID = E.BRANCH_ID
LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE_MASTER_LIST EMP ON EMP.MASTER_ID = E.MASTER_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.PROFILE  AS employee_attributes_generic ON employee_tier_5.profile_id=employee_attributes_generic.profile_id
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.tbl_guid_cost_centre_tier_4  AS employee_cost_centre_tier_4 ON employee_tier_5.guid=employee_cost_centre_tier_4.guid_to
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.tbl_cost_centres_tier_4  AS cost_centre_tier_4 ON employee_cost_centre_tier_4.cost_centre_id=cost_centre_tier_4.id
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.tbl_journal_entries_tier_4  AS note_tier_5 ON employee_tier_5.guid=note_tier_5.guid_to
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.GROUPS AS GROUPS ON 
GROUPS.BRANCH_ID = cost_centre_tier_4.PROPERTIES_BRANCH_ID
AND GROUPS.PROFILE_COMPANY = cost_centre_tier_4.PROPERTIES_DESCRIPTION
WHERE ((UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_1st_shift_call'')
	OR UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_1st_paycheck_call'')
		OR UPPER(( note_tier_5.PROPERTIES_TYPE ::STRING )) = UPPER(''employee_30_day_pulse'')));
	
 RETURN ''SUCCESS'';
    END

 EOT
}

