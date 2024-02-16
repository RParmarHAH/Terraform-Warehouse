create or replace view DW_PROD.HAH.VW_DIM_CLIENT_MERGED(
	ORIGINAL_CLIENT_KEY,
	ORIGINAL_SOURCE_SYSTEM_ID,
	ORIGINAL_SYSTEM_CODE,
	ORIGINAL_CLIENT_NUMBER,
	CLIENT_KEY,
	CLIENT_NUMBER,
	SYSTEM_CODE,
	SOURCE_SYSTEM_ID,
	CLIENT_PID,
	CLIENT_DOB,
	CLIENT_DATE_OF_DEATH,
	CLIENT_GENDER,
	CLIENT_ETHNICITY,
	CLIENT_MARITAL_STATUS,
	CLIENT_SALUTATION,
	CLIENT_FIRST_NAME,
	CLIENT_MIDDLE_NAME,
	CLIENT_LAST_NAME,
	CLIENT_NAME,
	CLIENT_ADDRESS1,
	CLIENT_ADDRESS2,
	CLIENT_CITY,
	CLIENT_STATE_CODE,
	CLIENT_ZIP,
	CLIENT_CLN_ADDRESS1,
	CLIENT_CLN_ADDRESS2,
	CLIENT_CLN_CITY,
	CLIENT_CLN_STATE_CODE,
	CLIENT_CLN_ZIP,
	CLIENT_STD_ADDRESS1,
	CLIENT_STD_ADDRESS2,
	CLIENT_STD_CITY,
	CLIENT_STD_STATE_CODE,
	CLIENT_STD_ZIP,
	CLIENT_HOME_PHONE,
	CLIENT_CELL_PHONE,
	CLIENT_WORK_PHONE,
	CLIENT_FAX_NUMBER,
	CLIENT_PERSONAL_EMAIL,
	REFERRAL_DATE,
	DAYS_TO_SERVICE,
	CONTRACT_BEGIN_DATE,
	CONTRACT_END_DATE,
	FIRST_SERVICE_DATE,
	LAST_SERVICE_DATE,
	BEGIN_DATE,
	END_DATE,
	ACTIVE_CLIENT_FLAG,
	ON_HOLD_FLAG,
	ON_HOLD_START_DATE,
	ON_HOLD_END_DATE,
	ACQUIRED_FROM_COMPANY_KEY,
	ACQUIRED_FROM_COMPANY_ID,
	ACQUIRED_FROM_COMPANY_FULL_NAME,
	ACQUISITION_DATE,
	ACQUISITION_FLAG,
	ADMISSION_DATE,
	ADMISSION_FLAG,
	CLIENT_CONVERTED_FLAG,
	PRIMARY_SUPERVISOR_KEY,
	PRIMARY_SUPERVISOR_CODE,
	PRIMARY_SUPERVISOR_NAME,
	SECONDARY_SUPERVISOR_KEY,
	SECONDARY_SUPERVISOR_CODE,
	SECONDARY_SUPERVISOR_NAME,
	PRIMARY_BRANCH_KEY,
	PRIMARY_BRANCH_NAME,
	PRIMARY_BRANCH_STATE,
	GUARANTOR_NAME,
	NOTES,
	EFFECTIVE_FROM_DATE,
	EFFECTIVE_TO_DATE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	ETL_INFERRED_MEMBER_FLAG
) as
WITH DATAFLEX_CLIENTS AS (
	SELECT CLIENT.CLIENT_KEY, LIST.SYSTEM_CODE, CLIENT.CLIENT_PID 
	FROM (
		SELECT SOURCE_SYSTEM_ID, IFF(SYSTEM_CODE IN ('GA', 'SC'), 'GA', SYSTEM_CODE) AS SYSTEM_CODE, CLIENT_PID 
		FROM HAH.DIM_CLIENT
		WHERE SOURCE_SYSTEM_ID = 3
		GROUP BY SOURCE_SYSTEM_ID, IFF(SYSTEM_CODE IN ('GA', 'SC'), 'GA', SYSTEM_CODE), CLIENT_PID
		HAVING COUNT(*) = 1
	) LIST
	JOIN HAH.DIM_CLIENT AS CLIENT
		ON CLIENT.SOURCE_SYSTEM_ID = LIST.SOURCE_SYSTEM_ID AND IFF(CLIENT.SYSTEM_CODE IN ('GA', 'SC'), 'GA', CLIENT.SYSTEM_CODE) = LIST.SYSTEM_CODE AND CLIENT.CLIENT_PID = LIST.CLIENT_PID
), COASTAL_CLIENTS AS (
	SELECT CLIENT.CLIENT_KEY, CLIENT.CLIENT_PID
	FROM (
		SELECT CLIENT_PID
		FROM HAH.DIM_CLIENT
		WHERE SOURCE_SYSTEM_ID IN (1, 2)
		GROUP BY CLIENT_PID
		HAVING COUNT(*) = 1
	) LIST
	JOIN HAH.DIM_CLIENT AS CLIENT
		ON CLIENT.SOURCE_SYSTEM_ID IN (1, 2) AND CLIENT.CLIENT_PID = LIST.CLIENT_PID
), EXCEL_CLIENTS AS (
	SELECT CLIENT.CLIENT_KEY, CLIENT.CLIENT_PID
	FROM (
		SELECT SOURCE_SYSTEM_ID, CLIENT_PID
		FROM HAH.DIM_CLIENT
		WHERE SOURCE_SYSTEM_ID = 4
		GROUP BY SOURCE_SYSTEM_ID, CLIENT_PID
		HAVING COUNT(*) = 1
	) LIST
	JOIN HAH.DIM_CLIENT AS CLIENT
		ON CLIENT.SOURCE_SYSTEM_ID = LIST.SOURCE_SYSTEM_ID AND CLIENT.CLIENT_PID = LIST.CLIENT_PID
), MERGED_CLIENTS AS (
	-- Coastal
	SELECT DATAFLEX.CLIENT_PID,
		DATAFLEX.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY, 
		COASTAL.CLIENT_KEY AS NEW_SYSTEM_CLIENT_KEY
	FROM DATAFLEX_CLIENTS AS DATAFLEX
	JOIN COASTAL_CLIENTS AS COASTAL
		ON COASTAL.CLIENT_PID = DATAFLEX.CLIENT_PID
	WHERE DATAFLEX.SYSTEM_CODE = 'GA'
	-- Excel
	UNION ALL
	SELECT DATAFLEX.CLIENT_PID,
		DATAFLEX.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY, 
		EXCEL.CLIENT_KEY AS NEW_SYSTEM_CLIENT_KEY
	FROM DATAFLEX_CLIENTS AS DATAFLEX
	JOIN EXCEL_CLIENTS AS EXCEL
		ON EXCEL.CLIENT_PID = DATAFLEX.CLIENT_PID
	WHERE DATAFLEX.SYSTEM_CODE = 'PA'
)
	SELECT CLIENT.CLIENT_KEY AS ORIGINAL_CLIENT_KEY,
		CLIENT.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
		CLIENT.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE,
		CLIENT.CLIENT_NUMBER AS ORIGINAL_CLIENT_NUMBER,
		NEW_CLIENT.*
	FROM HAH.DIM_CLIENT AS CLIENT
	LEFT JOIN MERGED_CLIENTS AS MERGED_CLIENTS
		ON MERGED_CLIENTS.OLD_SYSTEM_CLIENT_KEY = CLIENT.CLIENT_KEY
	JOIN HAH.DIM_CLIENT AS NEW_CLIENT
		ON NEW_CLIENT.CLIENT_KEY = COALESCE(MERGED_CLIENTS.NEW_SYSTEM_CLIENT_KEY, CLIENT.CLIENT_KEY);