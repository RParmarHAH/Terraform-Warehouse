CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ASR_FACT_PARTNER_CONTRACT_SERVICE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  ASR FACT PARTNER CONTRACT SERVICE
--
-- PURPOSE: Populates Stage ASR FACT PARTNER CONTRACT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/08/23     Vijay Sharma          Initial version
-- 12/25/23		Shraddha Sejpal		  Added State
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ASR_FACT_PARTNER_CONTRACT_SERVICE
WITH ALL_CONTRACTS AS (
	SELECT SERVICE_TYPE_ID, SERVICE_TYPE_NAME, 
		CASE 
			WHEN SERVICE_TYPE_ID  IN (1,2,3,4,5,6,7,8) THEN ''400-100'' -- These ARE OLD home care contracts 
			ELSE TRIM(GLACCOUNTNUMBER)
		END AS SEGMENT
		,SERVICETYPEDESCR AS DESCRIPTION
	FROM DISC_PROD.ASR.ASR_SERVICETYPES S
	UNION
	SELECT ''0'' AS SERVICE_TYPE_ID, ''UNKNOWN'' AS SERVICE_TYPE_NAME, ''400-100'' AS SEGMENT
	,''UNKNOWN'' AS DESCRIPTION-- DUMMY CONTRACT to retrieve orphan visits AND considered AS HomeCare
)
SELECT DISTINCT
     -- MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,''-1'')|| ''-'' || IFNULL(AC.SERVICE_TYPE_ID,0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY
       -- MD5(''PRIME'' || ''-'' || IFNULL(TRIM(S.PAYERSOURCEID),''-1'')|| ''-'' || IFNULL(TRIM(S.SERVICETYPE),0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY
        MD5(''PRIME'' || ''-'' || IFNULL(TRIM(S.PAYERSOURCEID),''-1'') || ''-'' || IFNULL(TRIM(S.SERVICETYPE),0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY		
        ,''13'' AS SOURCE_SYSTEM_ID
		,''PRIME'' AS SYSTEM_CODE
		,''OH'' AS STATE
		,MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,-1)|| ''-'' || IFNULL(AC.SERVICE_TYPE_ID,-1) || ''-'' || ''ASR'') AS PARTNER_CONTRACT_KEY
		,IFNULL(P.PAYERSOURCEID,''-1'') AS PARTNER_CODE
		,IFNULL(P.PAYERSOURCENAME,''UNKNOWN'') AS PARTNER_NAME
		,IFNULL(AC.SERVICE_TYPE_ID,''-1'') AS CONTRACT_CODE
		,IFNULL(AC.SERVICE_TYPE_NAME,''UNKNOWN'') AS CONTRACT_NAME		
		,MD5(''PRIME'' || ''-'' || AC.SERVICE_TYPE_ID || ''-'' || ''ASR'') AS SERVICE_KEY
		,AC.SERVICE_TYPE_NAME AS SERVICE_CODE,
		AC.DESCRIPTION AS SERVICE_DESCRIPTION,
	     MD5(''PRIME'' || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || IFNULL(SM.SERVICE_TYPE_ID,''-1'') || ''-'' || ''ASR'') AS BILLING_KEY,
		IFNULL(BILL.BILLINGCODE,''-1'') AS BILL_CODE,
		IFNULL(BILL.BILLINGCODENAME,''UNKNOWN'') AS BILL_NAME,
		TRUE AS BILLABLE_FLAG,  --??    
		''Hourly'' AS BILL_TYPE, --??
		''Hourly'' AS BILL_UOM, --??
		''Hourly'' AS SCHEDULE_TYPE, --??
		NULL AS  SCHEDULE_UOM, --??
		TRUE::BOOLEAN AS AUTHORIZATION_REQUIRED_FLAG,  --??
		TRUE::BOOLEAN AS PAYABLE_FLAG,     --??                     
		FALSE::BOOLEAN AS EXPENSE_FLAG,     --??                  
		FALSE AS MILEAGE_FLAG,  --??
		--- ETL FIELDS ----
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	 FROM  DISC_PROD.ASR.ASR_PLANOFSERVICE AS S 
	LEFT JOIN DISC_PROD.ASR.ASR_PAYERSOURCES AS P ON S.PAYERSOURCEID = P.PAYERSOURCEID 
	LEFT JOIN DISC_PROD.ASR.ASR_BILLINGCODES BILL ON BILL.BILLINGCODEID = S.BILLINGCODEID
	LEFT JOIN ALL_CONTRACTS AC ON S.SERVICETYPE = AC.SERVICE_TYPE_ID
	LEFT JOIN DISC_PROD.ASR.ASR_SERVICE_TYPE_MAPPING SM ON AC.SERVICE_TYPE_ID = SM.SERVICE_TYPE_ID
	--
UNION 
--
SELECT DISTINCT
     -- MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,''-1'')|| ''-'' || IFNULL(AC.SERVICE_TYPE_ID,0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY
       -- MD5(''PRIME'' || ''-'' || IFNULL(TRIM(S.PAYERSOURCEID),''-1'')|| ''-'' || IFNULL(TRIM(S.SERVICETYPE),0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY
        MD5(''PRIME'' || ''-'' || IFNULL(TRIM(V.PAYERSOURCEID),''-1'') || ''-'' || IFNULL(TRIM(V.SERVICETYPE),0) || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || ''-'' || ''ASR'') AS PARTNER_CONTRACT_SERVICE_KEY		
        ,''13'' AS SOURCE_SYSTEM_ID
		,''PRIME'' AS SYSTEM_CODE
		,''OH'' AS STATE
		,MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,-1)|| ''-'' || IFNULL(AC.SERVICE_TYPE_ID,-1) || ''-'' || ''ASR'') AS PARTNER_CONTRACT_KEY
		,IFNULL(P.PAYERSOURCEID,''-1'') AS PARTNER_CODE
		,IFNULL(P.PAYERSOURCENAME,''UNKNOWN'') AS PARTNER_NAME
		,IFNULL(AC.SERVICE_TYPE_ID,''-1'') AS CONTRACT_CODE
		,IFNULL(AC.SERVICE_TYPE_NAME,''UNKNOWN'') AS CONTRACT_NAME		
		,MD5(''PRIME'' || ''-'' || AC.SERVICE_TYPE_ID || ''-'' || ''ASR'') AS SERVICE_KEY
		,AC.SERVICE_TYPE_NAME AS SERVICE_CODE,
		AC.DESCRIPTION AS SERVICE_DESCRIPTION,
	     MD5(''PRIME'' || ''-'' || IFNULL(BILL.BILLINGCODE,''-1'') || IFNULL(SM.SERVICE_TYPE_ID,''-1'') || ''-'' || ''ASR'') AS BILLING_KEY,
		IFNULL(BILL.BILLINGCODE,''-1'') AS BILL_CODE,
		IFNULL(BILL.BILLINGCODENAME,''UNKNOWN'') AS BILL_NAME,
		TRUE AS BILLABLE_FLAG,  --??    
		''Hourly'' AS BILL_TYPE, --??
		''Hourly'' AS BILL_UOM, --??
		''Hourly'' AS SCHEDULE_TYPE, --??
		NULL AS  SCHEDULE_UOM, --??
		TRUE::BOOLEAN AS AUTHORIZATION_REQUIRED_FLAG,  --??
		TRUE::BOOLEAN AS PAYABLE_FLAG,     --??                     
		FALSE::BOOLEAN AS EXPENSE_FLAG,     --??                  
		FALSE AS MILEAGE_FLAG,  --??
		--- ETL FIELDS ----
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	 FROM DISC_PROD.ASR.ASR_VISITS V
	 LEFT JOIN DISC_PROD.ASR.ASR_PLANOFSERVICE AS S ON V.SERVICEVISITID=S.SERVICEVISITID
	LEFT JOIN DISC_PROD.ASR.ASR_PAYERSOURCES AS P ON V.PAYERSOURCEID = P.PAYERSOURCEID 
	LEFT JOIN DISC_PROD.ASR.ASR_BILLINGCODES BILL ON BILL.BILLINGCODEID = V.BILLINGCODEID
	LEFT JOIN ALL_CONTRACTS AC ON V.SERVICETYPE = AC.SERVICE_TYPE_ID
	LEFT JOIN DISC_PROD.ASR.ASR_SERVICE_TYPE_MAPPING SM ON AC.SERVICE_TYPE_ID = SM.SERVICE_TYPE_ID;

	RETURN ''SUCCESS'';
end;
';