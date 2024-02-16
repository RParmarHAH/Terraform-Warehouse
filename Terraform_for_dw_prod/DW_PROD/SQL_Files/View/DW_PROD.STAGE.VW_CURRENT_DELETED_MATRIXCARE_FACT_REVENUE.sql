create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_MATRIXCARE_FACT_REVENUE(
	REVENUE_KEY
) as
WITH EMPLOYEE AS (
  SELECT * FROM 
  (
    SELECT MASTER_ID,CAR_ID,CAR_SUPERVISOR,CAR_MANAGER,ETL_LAST_UPDATED_DATE
    FROM DISC_DEDUPE_PROD.MATRIXCARE.EMPLOYEE_MASTER_LIST  
  ) 
  UNION
  SELECT * FROM 
  (
    SELECT DISTINCT MASTER_ID,M.CAR_ID,C.CAR_SUPERVISOR,C.CAR_MANAGER,ETL_LAST_UPDATED_DATE
    FROM DISC_DEDUPE_PROD.MATRIXCARE.EMPLOYEE_MATCH_LIST M
    LEFT JOIN  DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVER C ON M.CAR_ID = C.CAR_ID
    WHERE M.CAR_ID NOT IN (SELECT DISTINCT CAR_ID FROM DISC_DEDUPE_PROD.MATRIXCARE.EMPLOYEE_MASTER_LIST)
  )
)
, CLIENT AS ( --VISIT DATA
  SELECT * FROM 
  (
    SELECT MASTER_ID,CLI_ID
    FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MASTER_LIST 
  ) 
  UNION
  SELECT * FROM 
  (
    SELECT DISTINCT MASTER_ID,ID
    FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MATCH_LIST 
    WHERE ID NOT IN (SELECT DISTINCT ID FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MASTER_LIST)
  ) 
)--added BY Diya Mistry
SELECT MD5('MATRIXCARE' || '-' || INVOICE_DETAILS.INVD_ID::STRING || '-' || 'MATRIXCARE') AS REVENUE_KEY
FROM DISC_PROD.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICE_DETAILS
LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICE_HEADER
	ON INVOICE_HEADER.INVH_ID = INVOICE_DETAILS.INVD_INVHID 
LEFT JOIN (
	SELECT POST_INVOICEDETAILID AS INVD_INVHID, 
		MAX(POST_POSTEDDATE) AS FINAL_PAYMENT_DATE,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.MATRIXCARE.STVHC_T_PAYMENTPOSTING 
	GROUP BY POST_INVOICEDETAILID
) AS INVOICE_PAYMENTS
	ON INVOICE_PAYMENTS.INVD_INVHID = INVOICE_DETAILS.INVD_INVHID
LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_SCHEDULES AS SCHEDULES 
	ON SCHEDULES.SCH_ID = INVOICE_DETAILS.INVD_SCHEDULEID 
--LEFT JOIN CLIENT AS CLIENT_MAPPING
--	ON CLIENT_MAPPING .CLIENT_NUMBER = INVOICE_DETAILS .INVD_CLIENTID
--LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_CLIENT_MAPPING_ALL AS CLIENT_MAPPING
--	ON CLIENT_MAPPING.CLIENT_NUMBER = INVOICE_DETAILS.INVD_CLIENTID
LEFT JOIN DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MASTER_LIST  AS CLIENT_MAPPING 
	ON CLIENT_MAPPING.CLI_ID = INVOICE_DETAILS.INVD_CLIENTID  
LEFT JOIN HAH.DIM_CLIENT AS MASTER_CLIENT
	ON MASTER_CLIENT.CLIENT_KEY = CLIENT_MAPPING.MASTER_ID
--LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_EMPLOYEE_MAPPING_ALL AS EMPLOYEE_MAPPING
--	ON EMPLOYEE_MAPPING.EMPLOYEE_NUMBER = SCHEDULES.SCH_CAREGIVERID
LEFT JOIN DISC_DEDUPE_PROD.MATRIXCARE.EMPLOYEE_MASTER_LIST AS EMPLOYEE_MAPPING
	ON EMPLOYEE_MAPPING.CAR_ID = SCHEDULES.SCH_CAREGIVERID 
LEFT JOIN HAH.DIM_EMPLOYEE AS MASTER_EMPLOYEE
	ON MASTER_EMPLOYEE.EMPLOYEE_KEY = EMPLOYEE_MAPPING.MASTER_ID  
LEFT JOIN EMPLOYEE AS CAREGIVER
	ON CAREGIVER.CAR_ID = COALESCE(MASTER_EMPLOYEE.EMPLOYEE_NUMBER, SCHEDULES.SCH_CAREGIVERID)
LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING AS BRANCH_MAPPING
	ON BRANCH_MAPPING.SOURCE_SYSTEM_ID = 7 AND BRANCH_MAPPING.SYSTEM_CODE = 'MATRIXCARE'
		AND BRANCH_MAPPING.OFFICE_CODE = INVOICE_DETAILS.INVD_BRANCHID::STRING
LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_BRANCHES AS BRANCHES
	ON BRANCHES.BR_ID::STRING = COALESCE(BRANCH_MAPPING.CONVERGED_OFFICE_CODE, INVOICE_DETAILS.INVD_BRANCHID::STRING)
WHERE (INVOICE_DETAILS.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR INVOICE_HEADER.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR INVOICE_PAYMENTS.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR SCHEDULES.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR CAREGIVER.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		-- OR BRANCHES.ETL_LAST_UPDATED_DATE >= '1900-01-01' -- Ignoring branches because only field is Branch_Name, which we don't want to change if there's an update
		OR CLIENT_MAPPING.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		-- OR MASTER_CLIENT.ETL_LAST_UPDATED_DATE >= '1900-01-01' -- Ignoring Master_Clients because only field is Client_Number which we are getting from Client_Mapping anyway
		OR EMPLOYEE_MAPPING.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		-- OR MASTER_EMPLYEE.ETL_LAST_UPDATED_DATE >= '1900-01-01' -- Ignoring Master_Employees because only field is Employee_Id which we are getting from Employee_Mapping anyway
		OR BRANCH_MAPPING.ETL_LAST_UPDATED_DATE >= '1900-01-01')
		AND INVOICE_DETAILS.ETL_DELETED_FLAG = TRUE
		AND CAST(INVOICE_DETAILS.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_INVOICEDETAILS);