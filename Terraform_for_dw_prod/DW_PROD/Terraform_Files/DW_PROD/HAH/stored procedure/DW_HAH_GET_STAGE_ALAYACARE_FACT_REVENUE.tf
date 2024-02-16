resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_FACT_REVENUE" {
	name ="GET_STAGE_ALAYACARE_FACT_REVENUE"
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
-- NAME:  ALAYACARE_FACT_REVENUE
--
-- PURPOSE: Creates one row per Invoice_Item_ID according to AlayaCare 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/09/21		Mir Ali				Initial version
-- 15/03/21     Jashvant Patel      Removed GA filter and added join for Configuration table
-- 19/07/21     Deepen Gajjar       Modified Contract Key logic
-- 28/12/22     Deepen Gajjar       Modified logic for branch, client and employee key logic
-- 20/01/23		Pooja Shah			IMPROVED INVOICE LOGIC FOR GA - MARKET REPORT
-- 18/04/23		Mitul Panchal		Changed column for Outstading amount 2nd case from INVOICE_ITEM.INVOICE_ITEM_BALANCE to INVOICE_DETAIL.PROPERTIES_INVOICE_BALANCE
-- 03/04/23		Pinkal Panchal		Revenue and Payment Date corrections for RCM GA Report
-- 28/04/23		Pinkal Panchal		Changed Amount columns logic for RCM GA Report
-- 23/06/23 	Pinkal Panchal		Modified logic to resolve Orphan Invoice keys
-- 05/07/23 	Pinkal Panchal		Modified Contract key logic and added BILL_CODE table
-- 22/11/23     Pradeep Thippani    Modified supervisor_key and supervisor_code Logic 
-- 24/11/2023	Preeti Sharma		Added Bill_Unit_Type Column for RCM(Requested By Natalie)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALAYACARE_FACT_REVENUE
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
, CLIENT AS  --VISIT DATA
(
SELECT * FROM 
(
	SELECT CLIENT_ID,MASTER_ID,CLIENT_ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID
	FROM  DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MASTER_LIST 
) 
UNION
SELECT * FROM 
(
	SELECT DISTINCT ID,MASTER_ID,ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MATCH_LIST 
	WHERE ID NOT IN (SELECT CLIENT_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MASTER_LIST ) 
) 
)
SELECT DATA.* FROM ( 
SELECT DISTINCT	MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'' || ''-'' || INVOICE_ITEM.INVOICE_ITEM_ID || ''-'' || ''ALAYACARE'') AS REVENUE_KEY,
		COALESCE(VISITS.START_AT, MIN(INVOICE_ITEM.PROPERTIES_TBL_ACC_INVOICE_ITEM_ITEM_START_AT) OVER (PARTITION BY INVOICE_ITEM.INVOICE_ID)) AS REPORT_DATE,
		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'' || ''-'' || NVL(TRIM(GROUPS.GROUP_ID),''Unknown'') || ''-'' || ''ALAYACARE'') AS BRANCH_KEY,
		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'' || ''-'' || NVL(E.MASTER_ID::NUMBER, -1) || ''-'' || ''ALAYACARE'') AS EMPLOYEE_KEY,
		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'' || ''-'' || NVL(C.MASTER_ID::NUMBER,-1) || ''-'' || ''ALAYACARE'') AS CLIENT_KEY,
--		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')''|| ''-'' || NVL(TO_VARCHAR(SERVICES.SERVICE_FUNDER_ID), ''Unknown'') || ''-'' || NVL(TO_VARCHAR(SERVICES.SERVICE_CODE_ID), ''Unknown'') || ''-'' || COALESCE(VISITS.VISIT_COMPUTED_RATE_BILLITEM_ID::STRING, SERVICE_CODE_BILL_CODE.BILL_CODE_ID::STRING, ''Unknown'') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
--      MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')''|| ''-'' || NVL(TO_VARCHAR(SERVICES.SERVICE_FUNDER_ID), ''Unknown'') || ''-'' || NVL(TO_VARCHAR(SERVICES.SERVICE_CODE_ID), ''Unknown'') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
--		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')''|| ''-'' || NVL(NVL(TO_VARCHAR(SERVICES.SERVICE_FUNDER_ID),INVOICE_ITEM.FUNDER_ID::STRING), ''Unknown'') || ''-'' || COALESCE(SERVICES.SERVICE_CODE_ID::STRING, '''') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')''|| ''-'' || NVL(NVL(TO_VARCHAR(SERVICES.SERVICE_FUNDER_ID),INVOICE_ITEM.FUNDER_ID::STRING), ''Unknown'') || ''-'' || COALESCE(SERVICES.SERVICE_CODE_ID::STRING, '''') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
		MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'' || ''-'' || NVL(INVOICE_ITEM.INVOICE_ID,-1) || ''-'' || ''ALAYACARE'') AS INVOICE_KEY,
		9 AS SOURCE_SYSTEM_ID,
		MD5(UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'')) || '' ('' || NVL(B.BRANCH_ID,-1) || '')'' || ''-'' ||NVL(SUBSTRING(TRIM(CT.TAG_LIST),0,7),''Unknown'') || ''-'' || ''ALAYACARE'') AS SUPERVISOR_KEY,
--		MD5(UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'')) || '' ('' || NVL(B.BRANCH_ID,-1) || '')'' || ''-'' ||NVL(TRIM(EMP.PROFILE_SUPERVISOR_TAG),''Unknown'') || ''-'' || ''ALAYACARE'') AS SUPERVISOR_KEY,--CHANGES MADE ON 07/11/2023 FOR RCM
--		COALESCE(INVOICE_ITEM.PAYMENT_DATE, INVOICE_ITEM.PAYMENT_CREATION_DATE, INVOICE_ITEM.UPDATED_AT, INVOICE_ITEM.CREATED_AT) AS REVENUE_DATE,	--Changes made on 03/04/23 as per the discussion with Phil
		COALESCE(INVOICE_ITEM.UPDATED_AT, INVOICE_ITEM.CREATED_AT,INVOICE_ITEM.PAYMENT_DATE, INVOICE_ITEM.PAYMENT_CREATION_DATE) AS REVENUE_DATE,
--		COALESCE(INVOICE_ITEM.PAYMENT_DATE, INVOICE_ITEM.PAYMENT_CREATION_DATE, INVOICE_ITEM.UPDATED_AT, INVOICE_ITEM.CREATED_AT) AS PAYMENT_DATE,
		CASE WHEN (NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_TOTAL,0) - NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_BALANCE,0))/COUNT(1) OVER (PARTITION BY INVOICE_ITEM.INVOICE_ID  ORDER BY INVOICE_ITEM.INVOICE_ID) = 0
        	THEN NULL ELSE
        			COALESCE(INVOICE_ITEM.PAYMENT_DATE, INVOICE_ITEM.PAYMENT_CREATION_DATE,INVOICE_DETAIL.PROPERTIES_INVOICE_UPDATE_TIME)
        END AS PAYMENT_DATE,		--Changes made on 05/07/23 as per the discussion with Phil
		UPPER(TRIM(GROUPS.PROFILE_COMPANY))  AS BRANCH_NAME,
		--NVL(E.MASTER_ID,VISITS.EMPLOYEE_ID) AS EMPLOYEE_ID, 
		--NVL(C.MASTER_ID,VISITS.CLIENT_ID) AS CLIENT_NUMBER,
		VISITS.EMPLOYEE_ID AS EMPLOYEE_ID,--changed by harshala
		VISITS.CLIENT_ID AS CLIENT_NUMBER,--changed by harshala
		NVL(TO_VARCHAR(SERVICES.SERVICE_FUNDER_ID), ''Unknown'') AS CONTRACT_CODE,
		INVOICE_ITEM.INVOICE_ID AS INVOICE_NUMBER,
		''Regular'' AS INVOICE_TYPE,
		CASE WHEN VISITS.VISIT_COMPUTED_RATE_UNITS IS NULL THEN ''PREMIUM''
            WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''hours'' THEN ''HOURLY''
            WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''visits'' THEN ''VISIT''
            END AS BILL_UNIT_TYPE,
		1 AS NUMBER_OF_CLIENTS,
		UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID, -1) || '')'') AS SYSTEM_CODE,
--		EMP.PROFILE_SUPERVISOR_TAG AS SUPERVISOR_CODE,
		SUBSTRING(TRIM(CT.TAG_LIST),0,7) AS SUPERVISOR_CODE,--CHANGES MADE ON 07/11/2023 FOR RCM
--		NVL(TO_VARCHAR(SERVICES.SERVICE_CODE_ID), ''Unknown'') AS BILL_CODE,
		NVL(NVL(TO_VARCHAR(SERVICES.SERVICE_CODE_ID),TO_VARCHAR(BC.BILL_CODE_ID)), ''Unknown'') AS BILL_CODE,
		CASE LOWER(TRIM(INVOICE_ITEM.PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY_UNITS)) 
			WHEN ''hours'' THEN 
				COALESCE(
					TRY_CAST(INVOICE_ITEM.PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY AS DECIMAL(18, 3)),
					NULLIF(VISITS.VISIT_HOURS_APPROVED, 0),
					NULLIF(VISITS.VISIT_SCHEDULED_DURATION, 0))
			WHEN ''visits'' THEN 
				COALESCE(
					NULLIF(VISITS.VISIT_HOURS_APPROVED, 0),
					NULLIF(VISITS.VISIT_SCHEDULED_DURATION, 0),
					TRY_CAST(INVOICE_ITEM.PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY AS DECIMAL(18, 3)))
			ELSE INVOICE_ITEM.PROPERTIES_TBL_ACC_INVOICE_ITEM_QUANTITY END AS INVOICE_HOURS,
		IFF(NVL(INVOICE_HOURS, 0) = 0, NULL, INVOICE_ITEM.INVOICE_ITEM_AMOUNT / INVOICE_HOURS) AS INVOICE_RATE,
--		changes made for RCM on 04/01/2022
--		NVL(INVOICE_ITEM.INVOICE_ITEM_AMOUNT, 0) AS AMOUNT_BILLED,
--		NVL(INVOICE_ITEM.INVOICE_ITEM_AMOUNT, 0) - NVL(INVOICE_ITEM.INVOICE_ITEM_BALANCE, 0) AS AMOUNT_COLLECTED,
--		NVL(INVOICE_ITEM.INVOICE_ITEM_BALANCE, 0) AS AMOUNT_OUTSTANDING,
-- Changes made on 25/04/23 for RCM by Pinkal
	NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_TOTAL,0)/COUNT(1) OVER (PARTITION BY INVOICE_ITEM.INVOICE_ID  ORDER BY INVOICE_ITEM.INVOICE_ID) AS AMOUNT_BILLED,
	(NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_TOTAL,0) - NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_BALANCE,0))/COUNT(1) OVER (PARTITION BY INVOICE_ITEM.INVOICE_ID  ORDER BY INVOICE_ITEM.INVOICE_ID) AS AMOUNT_COLLECTED,
	NVL(INVOICE_DETAIL.PROPERTIES_INVOICE_BALANCE,0)/COUNT(1) OVER (PARTITION BY INVOICE_ITEM.INVOICE_ID  ORDER BY INVOICE_ITEM.INVOICE_ID) AS AMOUNT_OUTSTANDING,

		-- ETL Fields
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.INVOICE_ITEM AS INVOICE_ITEM
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.INVOICE_DETAILS AS INVOICE_DETAIL ON INVOICE_ITEM.INVOICE_ID = INVOICE_DETAIL.INVOICE_ID		-- Added on 20/01/23
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS ON VISITS.VISIT_ID = INVOICE_ITEM.VISIT_ID 
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE AS SERVICES ON SERVICES.SERVICE_ID = COALESCE(INVOICE_ITEM.SERVICE_ID,VISITS.SERVICE_ID)
    -- ON SERVICES.SERVICE_ID = INVOICE_ITEM.SERVICE_ID		--Changes made on 23/06/23 by Pinkal
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE_CODE_BILL_CODE AS SERVICE_CODE_BILL_CODE
        ON SERVICE_CODE_BILL_CODE.FUNDER_ID = COALESCE(SERVICES.SERVICE_FUNDER_ID, INVOICE_ITEM.FUNDER_ID)
            AND SERVICE_CODE_BILL_CODE.SERVICE_CODE_ID = SERVICES.SERVICE_CODE_ID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BILL_CODE BC ON INVOICE_ITEM.FUNDER_ID = BC.FUNDER_ID AND INVOICE_ITEM.ITEM_BILLITEM_ID = BC.BILL_CODE_ID
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.FUNDER AS FUNDERS ON FUNDERS.FUNDER_ID = INVOICE_DETAIL.INVOICE_FUNDER_ID 
	--INVOICE_ITEM.FUNDER_ID	--Changes made on 23/06/23 by Pinkal
--	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS ON VISITS.VISIT_ID = INVOICE_ITEM.VISIT_ID 
	LEFT JOIN EMPLOYEE E ON VISITS.EMPLOYEE_ID = E.EMPLOYEE_ID AND COALESCE(VISITS.BRANCH_ID, SERVICES.BRANCH_ID,FUNDERS.BRANCH_ID) = E.BRANCH_ID   
	LEFT JOIN  CLIENT C
	ON COALESCE(INVOICE_ITEM.CLIENT_ID, VISITS.CLIENT_ID) = C.CLIENT_ID AND COALESCE(VISITS.BRANCH_ID, SERVICES.BRANCH_ID,FUNDERS.BRANCH_ID) = C.BRANCH_ID 	
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_TAGS CT ON C.CLIENT_ID= CT.CLIENT_ID 
--	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.EMPLOYEE EMP ON SUBSTRING(TRIM(CT.TAG_LIST),0,7) = TRIM(EMP.PROFILE_SUPERVISOR_TAG)
--	AND SUBSTRING(TRIM(CT.TAG_LIST),0,7) <>'''' AND SUBSTRING(TRIM(CT.TAG_LIST),0,7) IS NOT NULL -- COMMENTED ON 22/11/2023 FOR RCM 	    
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_GUID_COST_CENTRE_TIER_4 COST_CENTRE_MAPPING
		ON COST_CENTRE_MAPPING.GUID_TO = C.GUID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_COST_CENTRES_TIER_4 AS COST_CENTRE
		ON COST_CENTRE.ID = COST_CENTRE_MAPPING.COST_CENTRE_ID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.GROUPS AS GROUPS
		ON GROUPS.BRANCH_ID = COST_CENTRE.PROPERTIES_BRANCH_ID
		AND GROUPS.PROFILE_COMPANY = COST_CENTRE.PROPERTIES_DESCRIPTION
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH B 
		ON B.BRANCH_ID = COALESCE(GROUPS.BRANCH_ID, SERVICES.BRANCH_ID, FUNDERS.BRANCH_ID)
	WHERE INVOICE_ITEM.INVOICE_ID IS NOT NULL
)  DATA
INNER JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.CONFIGURATION CONFIG 
	ON UPPER(CONFIG.SYSTEM_CODE) = UPPER(DATA.SYSTEM_CODE)
	AND CONFIG.CONFIGURATION_ACTIVE=TRUE
	AND CONFIG.SYSTEM_CODE IS NOT NULL;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

