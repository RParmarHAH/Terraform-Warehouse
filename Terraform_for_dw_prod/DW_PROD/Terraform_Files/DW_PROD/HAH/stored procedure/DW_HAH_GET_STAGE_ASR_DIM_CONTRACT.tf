resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_DIM_CONTRACT" {
	name ="GET_STAGE_ASR_DIM_CONTRACT"
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
-- NAME:  ASR_DIM_CONTRACT
--
-- PURPOSE: Creates one row per contract according to ASR
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/29/2021	Jay Prajapati			Initial Development
-- 04/04/2022	Abhishek Sunil			Revised logic
-- 05/03/2022	Abhishek Sunil			Changed contract logic to point to ServiceTypes instead of Programs
-- 06/07/2022   Parag Gajjar            Resolved SP execution issue 
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.ASR_DIM_CONTRACT 
WITH ALL_CONTRACTS AS (
	SELECT SERVICE_TYPE_ID, SERVICE_TYPE_NAME, 
		CASE 
			WHEN SERVICE_TYPE_ID  IN (1,2,3,4,5,6,7,8) THEN ''400-100'' -- These ARE OLD home care contracts 
			ELSE TRIM(GLACCOUNTNUMBER)
		END AS SEGMENT
	FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SERVICETYPES S
	UNION
	SELECT ''0'' AS SERVICE_TYPE_ID, ''UNKNOWN'' AS SERVICE_TYPE_NAME, ''400-100'' -- DUMMY CONTRACT to retrieve orphan visits AND considered AS HomeCare
)
SELECT 
 	MD5(''PRIME'' || ''-'' || S.SERVICE_TYPE_ID || ''-'' || ''ASR'') AS CONTRACT_KEY ,
    S.SERVICE_TYPE_ID AS CONTRACT_CODE,  
	''PRIME'' AS SYSTEM_CODE,
	13 AS SOURCE_SYSTEM_ID,
	S.SERVICE_TYPE_NAME AS CONTRACT_NAME,
	NULL AS SERVICE_CODE_ID,
	NULL AS SERVICE_KEY,
	NULL AS DEFAULT_BILL_CODE,
	NULL AS PAYROLL_CODE,
	CASE 
		WHEN SEGMENT = ''400-300'' THEN ''HH''
		WHEN SEGMENT = ''400-100'' THEN ''HC''
	END AS REVENUE_CATEGORY,  
	CASE 
		WHEN REVENUE_CATEGORY = ''HH'' THEN ''HHA''
		WHEN REVENUE_CATEGORY = ''HC'' THEN ''HC''
	END AS REVENUE_SUBCATEGORY_CODE,  
	CASE
		WHEN REVENUE_CATEGORY = ''HH'' THEN ''HOME HEALTH AIDE''
		WHEN REVENUE_CATEGORY = ''HC'' THEN ''HOME CARE''
	END AS REVENUE_SUBCATEGORY_NAME,   
	NULL AS PAYOR_CODE,
	NULL AS PAYOR_DESCRIPTION, 
	REVENUE_CATEGORY AS SERVICE_LINE_CODE, -- Confirm this
	REVENUE_CATEGORY AS SERVICE_LINE_DESCRIPTION, -- Confirm this
	''OH'' AS CONTRACT_STATE_CODE,   
	''1HR'' AS TIME_TRANSLATION_CODE, 
	''1'' AS TIME_TRANSLATION_DIVIDER, 
	NULL AS PAY_TRAVELS_CODE,
	FALSE AS MILEAGE_FLAG,
	TRUE AS PAYABLE_FLAG,
	TRUE AS BILLABLE_FLAG,
	TRUE AS BILLED_BY_QUARTER_HOURS,   --Confirmed by Frank,Galit
	TRUE AS BILLED_BY_HALF_HOURS,      --Confirmed by Frank,Galit
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	,CURRENT_USER AS ETL_INSERTED_BY
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	,CURRENT_USER AS ETL_LAST_UPDATED_BY
	,FALSE AS ETL_DELETED_FLAG
	,FALSE as ETL_INFERRED_MEMBER_FLAG
FROM ALL_CONTRACTS S;
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

