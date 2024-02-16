create or replace view DW_PROD.INTEGRATION.VW_DIM_CLIENT_MERGED(
	ORIGINAL_CLIENT_KEY,
	ORIGINAL_SOURCE_SYSTEM_ID,
	ORIGINAL_SYSTEM_CODE,
	ORIGINAL_CLIENT_NUMBER,
	ORIGINAL_AGENCY,
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
	LINKED_ID,
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
	AGENCY,
	MEDICAID_ID,
	EFFECTIVE_FROM_DATE,
	EFFECTIVE_TO_DATE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	ETL_INFERRED_MEMBER_FLAG,
	DERIVED_REFERRAL_DATE,
	DERIVED_CONTRACT_BEGIN_DATE,
	DERIVED_CONTRACT_END_DATE,
	DERIVED_FIRST_SERVICE_DATE,
	DERIVED_LAST_SERVICE_DATE,
	DERIVED_BEGIN_DATE,
	DERIVED_END_DATE,
	DERIVED_DAYS_TO_SERVICE
) as
WITH DATAFLEX_CLIENTS AS
(
SELECT CLIENT.CLIENT_KEY, LIST.SYSTEM_CODE, CLIENT.CLIENT_PID ,CLIENT.CLIENT_FIRST_NAME,CLIENT.CLIENT_LAST_NAME,CLIENT.CLIENT_DOB
FROM (
SELECT SOURCE_SYSTEM_ID, IFF(SYSTEM_CODE IN ('GA', 'SC'), 'GA', SYSTEM_CODE) AS SYSTEM_CODE, CLIENT_PID
FROM HAH.DIM_CLIENT
WHERE SOURCE_SYSTEM_ID = 3
GROUP BY SOURCE_SYSTEM_ID, IFF(SYSTEM_CODE IN ('GA', 'SC'), 'GA', SYSTEM_CODE), CLIENT_PID
HAVING COUNT(*) = 1
) LIST
JOIN HAH.DIM_CLIENT AS CLIENT
ON CLIENT.SOURCE_SYSTEM_ID = LIST.SOURCE_SYSTEM_ID AND IFF(CLIENT.SYSTEM_CODE IN ('GA', 'SC'), 'GA', CLIENT.SYSTEM_CODE) = LIST.SYSTEM_CODE AND CLIENT.CLIENT_PID = LIST.CLIENT_PID
)
, COASTAL_CLIENTS AS
(
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
)
, EXCEL_CLIENTS AS
(
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
),
CCSI_CLIENTS AS
(
SELECT CLIENT.CLIENT_KEY, CLIENT.CLIENT_PID,CLIENT.CLIENT_FIRST_NAME,CLIENT.CLIENT_LAST_NAME,CLIENT.CLIENT_DOB
FROM (
SELECT CLIENT_PID,CLIENT_FIRST_NAME,CLIENT_LAST_NAME,CLIENT_DOB
FROM HAH.DIM_CLIENT
WHERE SOURCE_SYSTEM_ID IN (8)
--GROUP BY CLIENT_PID,CLIENT_FIRST_NAME,CLIENT_LAST_NAME,CLIENT_DOB
--HAVING COUNT(*) = 1 --Removing having clause as duplicate pid filter out and not getting captured in merged ccsi logic
) LIST
JOIN HAH.DIM_CLIENT AS CLIENT
ON CLIENT.SOURCE_SYSTEM_ID IN (8) AND CLIENT.CLIENT_PID = LIST.CLIENT_PID
)
, MERGED_CLIENTS AS
(
-- Coastal
SELECT DATAFLEX.CLIENT_PID,
DATAFLEX.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY,
COASTAL.CLIENT_KEY AS NEW_SYSTEM_CLIENT_KEY
FROM DATAFLEX_CLIENTS AS DATAFLEX
JOIN COASTAL_CLIENTS AS COASTAL
ON COASTAL.CLIENT_PID = DATAFLEX.CLIENT_PID
WHERE DATAFLEX.SYSTEM_CODE = 'GA'
-- Excel
UNION
SELECT DATAFLEX.CLIENT_PID,
DATAFLEX.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY,
EXCEL.CLIENT_KEY AS NEW_SYSTEM_CLIENT_KEY
FROM DATAFLEX_CLIENTS AS DATAFLEX
JOIN EXCEL_CLIENTS AS EXCEL
ON EXCEL.CLIENT_PID = DATAFLEX.CLIENT_PID
WHERE DATAFLEX.SYSTEM_CODE = 'PA'
-- MatrixCare
--UNION
--SELECT DISTINCT NULL AS CLIENT_PID,
--DATAFLEX.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY,
--FIRST_VALUE(MATRIXCARE.CLIENT_KEY) OVER (PARTITION BY DATAFLEX.CLIENT_KEY ORDER BY MATRIXCARE.CLIENT_NUMBER) AS NEW_SYSTEM_CLIENT_KEY
--FROM INTEGRATION.DATAFLEX_MATRIXCARE_CLIENT_MAPPING_IN_MI AS DATAFLEX
--JOIN INTEGRATION.DATAFLEX_MATRIXCARE_CLIENT_MAPPING_IN_MI AS MATRIXCARE
--ON MATRIXCARE.MASTER_CLIENT_KEY = DATAFLEX.MASTER_CLIENT_KEY
--AND MATRIXCARE.CLIENT_KEY <> DATAFLEX.CLIENT_KEY
--AND MATRIXCARE.SYSTEM_CODE <> DATAFLEX.SYSTEM_CODE
--AND MATRIXCARE.SOURCE_SYSTEM_ID <> DATAFLEX.SOURCE_SYSTEM_ID
--WHERE DATAFLEX.SOURCE_SYSTEM_ID = 3
)
,MERGED_CCSI AS
(
SELECT DATAFLEX.CLIENT_KEY AS NEW_SYSTEM_CLIENT_KEY, CCSI.CLIENT_KEY AS OLD_SYSTEM_CLIENT_KEY
,CCSI.CLIENT_FIRST_NAME,CCSI.CLIENT_LAST_NAME,CCSI.CLIENT_DOB
,DATAFLEX.CLIENT_FIRST_NAME,DATAFLEX.CLIENT_LAST_NAME,DATAFLEX.CLIENT_DOB
FROM CCSI_CLIENTS AS CCSI
JOIN DATAFLEX_CLIENTS AS DATAFLEX ON TRIM(CCSI.CLIENT_PID) = TRIM(DATAFLEX.CLIENT_PID)
WHERE DATAFLEX.SYSTEM_CODE = 'IL'
)
SELECT DISTINCT CLIENT.CLIENT_KEY AS ORIGINAL_CLIENT_KEY,
CLIENT.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
CLIENT.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE,
CLIENT.CLIENT_NUMBER AS ORIGINAL_CLIENT_NUMBER,
CLIENT.AGENCY AS ORIGINAL_AGENCY,
--NEW_CLIENT.* EXCLUDE (REFERRER_KEY,CLIENT_MEDICARE_ID,MEDICAID_ID,CLIENT_GENDER_IDENTITY,CLIENT_SEXUAL_ORIENTATION,CLIENT_RACE,
--						EFFECTIVE_FROM_DATE,
--						EFFECTIVE_TO_DATE,ETL_TASK_KEY,ETL_INSERTED_TASK_KEY,ETL_INSERTED_DATE,ETL_INSERTED_BY,
--						ETL_LAST_UPDATED_DATE,ETL_LAST_UPDATED_BY,ETL_DELETED_FLAG,ETL_INFERRED_MEMBER_FLAG),
NEW_CLIENT.CLIENT_KEY,
NEW_CLIENT.CLIENT_NUMBER,
NEW_CLIENT.SYSTEM_CODE,
NEW_CLIENT.SOURCE_SYSTEM_ID,
NEW_CLIENT.CLIENT_PID,
NEW_CLIENT.CLIENT_DOB,
NEW_CLIENT.CLIENT_DATE_OF_DEATH,
NEW_CLIENT.CLIENT_GENDER,
NEW_CLIENT.CLIENT_ETHNICITY,
NEW_CLIENT.CLIENT_MARITAL_STATUS,
NEW_CLIENT.CLIENT_SALUTATION,
NEW_CLIENT.CLIENT_FIRST_NAME,
NEW_CLIENT.CLIENT_MIDDLE_NAME,
NEW_CLIENT.CLIENT_LAST_NAME,
NEW_CLIENT.CLIENT_NAME,
NEW_CLIENT.CLIENT_ADDRESS1,
NEW_CLIENT.CLIENT_ADDRESS2,
NEW_CLIENT.CLIENT_CITY,
NEW_CLIENT.CLIENT_STATE_CODE,
NEW_CLIENT.CLIENT_ZIP,
NEW_CLIENT.CLIENT_CLN_ADDRESS1,
NEW_CLIENT.CLIENT_CLN_ADDRESS2,
NEW_CLIENT.CLIENT_CLN_CITY,
NEW_CLIENT.CLIENT_CLN_STATE_CODE,
NEW_CLIENT.CLIENT_CLN_ZIP,
NEW_CLIENT.CLIENT_STD_ADDRESS1,
NEW_CLIENT.CLIENT_STD_ADDRESS2,
NEW_CLIENT.CLIENT_STD_CITY,
NEW_CLIENT.CLIENT_STD_STATE_CODE,
NEW_CLIENT.CLIENT_STD_ZIP,
NEW_CLIENT.CLIENT_HOME_PHONE,
NEW_CLIENT.CLIENT_CELL_PHONE,
NEW_CLIENT.CLIENT_WORK_PHONE,
NEW_CLIENT.CLIENT_FAX_NUMBER,
NEW_CLIENT.CLIENT_PERSONAL_EMAIL,
NEW_CLIENT.REFERRAL_DATE,
NEW_CLIENT.DAYS_TO_SERVICE,
NEW_CLIENT.CONTRACT_BEGIN_DATE,
NEW_CLIENT.CONTRACT_END_DATE,
NEW_CLIENT.FIRST_SERVICE_DATE,
NEW_CLIENT.LAST_SERVICE_DATE,
NEW_CLIENT.BEGIN_DATE,
NEW_CLIENT.END_DATE,
NEW_CLIENT.ACTIVE_CLIENT_FLAG,
NEW_CLIENT.ON_HOLD_FLAG,
NEW_CLIENT.ON_HOLD_START_DATE,
NEW_CLIENT.ON_HOLD_END_DATE,
NEW_CLIENT.LINKED_ID,
NEW_CLIENT.ACQUIRED_FROM_COMPANY_KEY,
NEW_CLIENT.ACQUIRED_FROM_COMPANY_ID,
NEW_CLIENT.ACQUIRED_FROM_COMPANY_FULL_NAME,
NEW_CLIENT.ACQUISITION_DATE,
NEW_CLIENT.ACQUISITION_FLAG,
NEW_CLIENT.ADMISSION_DATE,
NEW_CLIENT.ADMISSION_FLAG,
NEW_CLIENT.CLIENT_CONVERTED_FLAG,
NEW_CLIENT.PRIMARY_SUPERVISOR_KEY,
NEW_CLIENT.PRIMARY_SUPERVISOR_CODE,
NEW_CLIENT.PRIMARY_SUPERVISOR_NAME,
NEW_CLIENT.SECONDARY_SUPERVISOR_KEY,
NEW_CLIENT.SECONDARY_SUPERVISOR_CODE,
NEW_CLIENT.SECONDARY_SUPERVISOR_NAME,
NEW_CLIENT.PRIMARY_BRANCH_KEY,
NEW_CLIENT.PRIMARY_BRANCH_NAME,
NEW_CLIENT.PRIMARY_BRANCH_STATE,
NEW_CLIENT.GUARANTOR_NAME,
NEW_CLIENT.NOTES,
NEW_CLIENT.AGENCY,
NEW_CLIENT.MEDICAID_ID ,
NEW_CLIENT.EFFECTIVE_FROM_DATE,
NEW_CLIENT.EFFECTIVE_TO_DATE,
NEW_CLIENT.ETL_TASK_KEY,
NEW_CLIENT.ETL_INSERTED_TASK_KEY,
NEW_CLIENT.ETL_INSERTED_DATE,
NEW_CLIENT.ETL_INSERTED_BY,
NEW_CLIENT.ETL_LAST_UPDATED_DATE,
NEW_CLIENT.ETL_LAST_UPDATED_BY,
NEW_CLIENT.ETL_DELETED_FLAG,
NEW_CLIENT.ETL_INFERRED_MEMBER_FLAG,
MIN(CLIENT.REFERRAL_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_REFERRAL_DATE,
MIN(CLIENT.CONTRACT_BEGIN_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_CONTRACT_BEGIN_DATE,
MAX(CLIENT.CONTRACT_END_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_CONTRACT_END_DATE,
MIN(CLIENT.FIRST_SERVICE_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_FIRST_SERVICE_DATE,
MAX(CLIENT.LAST_SERVICE_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_LAST_SERVICE_DATE,
MIN(CLIENT.BEGIN_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_BEGIN_DATE,
MAX(CLIENT.END_DATE) OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY) AS DERIVED_END_DATE,
DATEDIFF(DAY,
MIN(IFF(NEW_CLIENT.SOURCE_SYSTEM_ID = 3 AND NEW_CLIENT.REFERRAL_DATE < '2013-01-01', NULL, NEW_CLIENT.REFERRAL_DATE))
OVER (PARTITION BY NEW_CLIENT.CLIENT_KEY),
DERIVED_FIRST_SERVICE_DATE) AS DERIVED_DAYS_TO_SERVICE
FROM HAH.DIM_CLIENT AS CLIENT
LEFT JOIN MERGED_CLIENTS AS MERGED_CLIENTS
ON MERGED_CLIENTS.OLD_SYSTEM_CLIENT_KEY = CLIENT.CLIENT_KEY
LEFT JOIN MERGED_CCSI AS MERGED_CCSI
ON MERGED_CCSI.OLD_SYSTEM_CLIENT_KEY = CLIENT.CLIENT_KEY
JOIN HAH.DIM_CLIENT AS NEW_CLIENT
ON NEW_CLIENT.CLIENT_KEY = COALESCE(MERGED_CLIENTS.NEW_SYSTEM_CLIENT_KEY, MERGED_CCSI.NEW_SYSTEM_CLIENT_KEY,CLIENT.CLIENT_KEY);