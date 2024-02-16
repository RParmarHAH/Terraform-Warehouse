create or replace view DW_PROD.STAGE.VW_CURRENT_CCSI_FACT_INTAKE(
	INTAKE_KEY
) as
WITH TMP_CLIENT_DATA AS 
(
SELECT DISTINCT 
	CLIENT_IDOA_NO,TRY_TO_DATE(DETERMINATION_DATE, 'YYYYMMDD') AS "START_DATE",SERVICE_TYPE
FROM DISC_PROD.CCSI.MASTERCLIENT  M
INNER JOIN DISC_PROD.CCSI.RAWVRFP R ON R.CLIENT_ID = M.CLIENT_IDOA_NO
)
, TMP_CLIENT_DATA_MAXLASTDATE AS
(
SELECT T.CLIENT_IDOA_NO,T.START_DATE ,LAST_DAY(MAX(TRY_TO_DATE(R.PERIOD_DATE, 'MMDDYY'))) AS "END_DATE",T.SERVICE_TYPE 
FROM TMP_CLIENT_DATA T
INNER JOIN DISC_PROD.CCSI.RAWVRFP R ON R.CLIENT_ID = T.CLIENT_IDOA_NO AND R.SERVICE_TYPE = T.SERVICE_TYPE
--WHERE T.CLIENT_IDOA_NO <> '000000000'
GROUP BY T.CLIENT_IDOA_NO,T.START_DATE,T.SERVICE_TYPE 
)
,TMP_CLIENT_DATA_VALIDATEDATE AS
(
SELECT CLIENT_IDOA_NO,START_DATE,CASE WHEN 
		END_DATE <= START_DATE THEN 
			CASE WHEN (MONTHS_BETWEEN(CURRENT_DATE(),START_DATE)) > 4 THEN LAST_DAY(DATEADD(YEAR,1,START_DATE)) ELSE LAST_DAY(DATEADD(MONTH,-1,CURRENT_DATE())) END
		ELSE END_DATE END AS "END_DATE"
,SERVICE_TYPE FROM TMP_CLIENT_DATA_MAXLASTDATE
)
,CLIENT_DATA AS 
(
		SELECT 
			CLIENT_IDOA_NO,SERVICE_TYPE 
		FROM TMP_CLIENT_DATA_VALIDATEDATE
		GROUP BY CLIENT_IDOA_NO,SERVICE_TYPE
		HAVING COUNT(*)>1
)
, UPDATE_CLIENT_ENDDATE AS 
(
		SELECT *,
			(LEAD(START_DATE-1) OVER (PARTITION BY CLIENT_IDOA_NO,SERVICE_TYPE ORDER BY CLIENT_IDOA_NO,SERVICE_TYPE,START_DATE)
			) AS TMP_CLIENT_DATA 
		FROM TMP_CLIENT_DATA_VALIDATEDATE T
		WHERE EXISTS  
		(SELECT 1 FROM CLIENT_DATA A WHERE A.CLIENT_IDOA_NO = T.CLIENT_IDOA_NO AND A.SERVICE_TYPE = T.SERVICE_TYPE)
		ORDER BY START_DATE
)
, TMP_CLIENT_MULTIPLEDATA AS
(
SELECT CLIENT_IDOA_NO,START_DATE,TMP_CLIENT_DATA AS "END_DATE",SERVICE_TYPE
	FROM UPDATE_CLIENT_ENDDATE
)
, RESULT_DATA AS
(
SELECT S.CLIENT_IDOA_NO,S.START_DATE,COALESCE(T.END_DATE,S.END_DATE) AS "END_DATE",S.SERVICE_TYPE
FROM TMP_CLIENT_DATA_VALIDATEDATE S
LEFT JOIN TMP_CLIENT_MULTIPLEDATA T ON
		S.CLIENT_IDOA_NO = T.CLIENT_IDOA_NO AND S.START_DATE = T.START_DATE
				AND S.SERVICE_TYPE = T.SERVICE_TYPE AND T.END_DATE IS NOT NULL
)
, RAWVRFP AS  --VISIT DATA
(
	SELECT DISTINCT RECORD_NUMBER
					,CLIENT_ID
					,AREA_2
					,DAY_OF_SERVICE
					,PAY_PERIOD_ENDING_DATE
					,DATEADD(DAY,(IFNULL(DAY_OF_SERVICE,1) - 1),DATE_TRUNC('MONTH',TRY_TO_DATE(PERIOD_DATE, 'MMDDYY'))) AS "PERIOD_DATE" --CHANGE
					,EMPLOYEE_NUMBER
					,EMP_DESK
					,HOURS_WORKED
					,UPPER (TRIM (CONTRACT_NO)) AS "CONTRACT_NO" 
					,SERVICE_TYPE
			FROM DISC_PROD.CCSI.RAWVRFP
			--WHERE CLIENT_ID  = 321303253
			WHERE PERIOD_DATE IS NOT NULL
				AND TRY_TO_DATE(PERIOD_DATE, 'MMDDYY') > '2015-12-31'
				AND DAY_OF_SERVICE  IS NOT NULL
				AND CLIENT_ID IS NOT NULL
)
,DIM_EMPLOYEE AS
(
SELECT EMPLOYEE_NUMBER, AREA, HIRE_DATE, TERMINATION_DATE,MASTER_ID,RN FROM 
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_NUMBER,AREA ORDER BY UPDATED_DATE, CREATED_DATE DESC) AS DUP FROM 
(
SELECT * FROM 
(
	SELECT DISTINCT DIM_EMPLOYEE_NUMBER AS "EMPLOYEE_NUMBER"
			,AREA
			,HIRE_DATE
			,TERMINATION_DATE
			,(RECORD_NUMBER::STRING || '-' || NVL(AREA,'C')::STRING || '-' || 'CCSI') AS MASTER_ID
			,ROW_NUMBER() OVER (PARTITION BY DIM_EMPLOYEE_NUMBER,AREA ORDER BY UPDATED_DATE, CREATED_DATE DESC) AS 			RN 
			,UPDATED_DATE, CREATED_DATE
	FROM  DISC_DEDUPE_PROD.CCSI.EMP_MASTER_LIST_CCSI	
) WHERE RN = 1
UNION 
SELECT * FROM 
(
	SELECT DISTINCT EMPLOYEE_NUMBER
			,AREA
			,HIRE_DATE
			,TERMINATION_DATE
			,MASTER_ID
			,ROW_NUMBER() OVER (PARTITION BY EMPLOYEE_NUMBER,AREA ORDER BY UPDATED_DATE,CREATED_DATE DESC) AS RN 
			,UPDATED_DATE, CREATED_DATE
	FROM DISC_DEDUPE_PROD.CCSI.EMP_MATCH_CCSI
		WHERE MASTER_ID NOT IN (SELECT MASTER_ID FROM DISC_DEDUPE_PROD.CCSI.EMP_MASTER_LIST_CCSI) 
) WHERE RN > 1 
) 
) WHERE DUP = 1
)
,DIM_CLIENT AS 
(
SELECT CLIENT_NUMBER, AREA, CLIENT_NAME, MASTER_ID,RN,SHORT_DATE,HOURS_AUTHORIZED FROM 
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY CLIENT_NUMBER,AREA ORDER BY SHORT_DATE DESC) AS DUP FROM 
(
	SELECT CLIENT_IDOA_NO AS "CLIENT_NUMBER"
			,USED_FOR_AREA AS "AREA"
			,FINAL_CLIENT_NAME AS "CLIENT_NAME"
			,SERVICE_1_UNITS AS "HOURS_AUTHORIZED"
			,CASE WHEN 
					UPDATED_DATE LIKE '%/OV%'  OR CREATED_DATE LIKE '%/OV%'  OR UPDATED_DATE IS NULL 
					THEN COALESCE(TRY_TO_DATE(CREATED_DATE ,'MM/DD/YY') , TRY_TO_DATE(ACTION_DATE ,'YYYYMMDD'))
				ELSE TO_DATE(UPDATED_DATE,'MM/DD/YY') END AS SHORT_DATE
			,(RECORD_NUMBER  || '-' ||  NVL(USED_FOR_AREA, 'CCSI') || '-' || 'CCSI') AS MASTER_ID
			,ROW_NUMBER() OVER (PARTITION BY (CLIENT_NUMBER  || '-' ||  NVL(USED_FOR_AREA, 'CCSI') || '-' || 'CCSI') ORDER BY 
				CASE WHEN 
					UPDATED_DATE LIKE '%/OV%'  OR CREATED_DATE LIKE '%/OV%'  OR UPDATED_DATE IS NULL 
					THEN COALESCE(TRY_TO_DATE(CREATED_DATE ,'MM/DD/YY') , TRY_TO_DATE(ACTION_DATE ,'YYYYMMDD'))
				ELSE TO_DATE(UPDATED_DATE,'MM/DD/YY') 
				END
			,RECORD_NUMBER DESC) AS RN FROM  DISC_DEDUPE_PROD.CCSI.CLIENT_MASTER_LIST_CCSI	
) WHERE RN = 1
UNION 
SELECT *,ROW_NUMBER() OVER (PARTITION BY CLIENT_NUMBER,AREA ORDER BY SHORT_DATE DESC) AS DUP FROM 
(
	SELECT CLIENT_IDOA_NO AS "CLIENT_NUMBER"
			,USED_FOR_AREA AS "AREA"
			,COMBINED_CLIENT_NAME AS "CLIENT_NAME"
			,SERVICE_1_UNITS AS "HOURS_AUTHORIZED"
			,CASE WHEN 
					UPDATED_DATE LIKE '%/OV%'  OR CREATED_DATE LIKE '%/OV%'  OR UPDATED_DATE IS NULL 
					THEN COALESCE(TRY_TO_DATE(CREATED_DATE ,'MM/DD/YY') , TRY_TO_DATE(ACTION_DATE ,'YYYYMMDD'))
				ELSE TO_DATE(UPDATED_DATE,'MM/DD/YY') END AS SHORT_DATE
			,MASTER_ID
			,ROW_NUMBER() OVER (PARTITION BY (CLIENT_NUMBER  || '-' ||  NVL(USED_FOR_AREA, 'CCSI') || '-' || 'CCSI') ORDER BY 
				CASE WHEN 
					UPDATED_DATE LIKE '%/OV%'  OR CREATED_DATE LIKE '%/OV%'  OR UPDATED_DATE IS NULL 
					THEN COALESCE(TRY_TO_DATE(CREATED_DATE ,'MM/DD/YY') , TRY_TO_DATE(ACTION_DATE ,'YYYYMMDD'))
				ELSE TO_DATE(UPDATED_DATE,'MM/DD/YY') 
				END
			,RECORD_NUMBER DESC) AS RN FROM DISC_DEDUPE_PROD.CCSI.CLIENT_MATCH_LIST_CCSI
						WHERE MASTER_ID NOT IN (SELECT MASTER_ID FROM DISC_DEDUPE_PROD.CCSI.CLIENT_MASTER_LIST_CCSI) 
) WHERE RN > 1
) WHERE DUP = 1
)
,OTHERINV AS
(
	SELECT DISTINCT TRY_TO_DATE(DATE_OF_SERVICE, 'MM/YYYY') AS "DATE_OF_SERVICE"
					,SUM(AMOUNT_BILLED) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,AREA 
					,SUM(UNITS_PROVIDED) AS "UNITS"
					,SUM(BALANCE) AS "BALANCE"
					,(SUM(NVL(AMOUNT1,0)) + SUM(NVL(AMOUNT2,0)) + SUM(NVL(AMOUNT3,0))) AS "AMOUNT_PAID"
					,MIN(TO_DATE(BILLING_DATE,'YYYYMMDD')) AS "BILLING_DATE"
					,SUM(RECORD_NUMBER) AS "RECORD_NUMBER"
					,TYPE_OF_SERVICE AS "SERVICE_TYPE"
				FROM DISC_PROD.CCSI.OTHERINV
				--WHERE CLIENT_ID  = 001641372
				GROUP BY DATE_OF_SERVICE
				,CLIENT_ID,AREA
				,TYPE_OF_SERVICE
				--,CLIENT_NAME
)
,MAXOTHERINV AS
(
	SELECT DISTINCT MAX(TRY_TO_DATE(DATE_OF_SERVICE, 'MM/YYYY')) AS "DATE_OF_SERVICE"
					,SUM(AMOUNT_BILLED) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,AREA 
					,SUM(UNITS_PROVIDED) AS "UNITS"
					,SUM(BALANCE) AS "BALANCE"
					,(SUM(NVL(AMOUNT1,0)) + SUM(NVL(AMOUNT2,0)) + SUM(NVL(AMOUNT3,0))) AS "AMOUNT_PAID"
					,MIN(TO_DATE(BILLING_DATE,'YYYYMMDD')) AS "BILLING_DATE"
					,SUM(RECORD_NUMBER) AS "RECORD_NUMBER"
					,TYPE_OF_SERVICE AS "SERVICE_TYPE"
				FROM DISC_PROD.CCSI.OTHERINV
				--WHERE CLIENT_ID  = 001641372
				GROUP BY CLIENT_ID,AREA
				,TYPE_OF_SERVICE
				--,CLIENT_NAME
)
, MCOINVOICE AS
(
	SELECT DISTINCT TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM') AS "DATE_OF_SERVICE"
					,SUM(DOLLAR_AMOUNT) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,UPPER(CCSI_OFFICE) AS "AREA"
					,SUM(BALANCE) AS "BALANCE"
					,SUM(UNITS) AS "UNITS"
					,(SUM(NVL(AMOUNT_1,0)) + SUM(NVL(AMOUNT_2,0)) + SUM(NVL(AMOUNT_3,0))) AS "AMOUNT_PAID"
					,MIN(TRY_TO_DATE(P_PAYMENT_DATE_1,'MM/DD/YYYY')) AS "BILLING_DATE"
					,SUM(RECORD_NUMBER) AS "RECORD_NUMBER"
					,SERVICE_TYPE
			FROM DISC_PROD.CCSI.MCOINV
			GROUP BY TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM')
					,CLIENT_ID,UPPER(CCSI_OFFICE)
					,SERVICE_TYPE
)	
, MAXMCOINVOICE AS
(
	SELECT DISTINCT MAX(TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM')) AS "DATE_OF_SERVICE"
					,SUM(DOLLAR_AMOUNT) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,UPPER(CCSI_OFFICE) AS "AREA"
					,SUM(BALANCE) AS "BALANCE"
					,SUM(UNITS) AS "UNITS"
					,(SUM(NVL(AMOUNT_1,0)) + SUM(NVL(AMOUNT_2,0)) + SUM(NVL(AMOUNT_3,0))) AS "AMOUNT_PAID"
					,MIN(TRY_TO_DATE(P_PAYMENT_DATE_1,'MM/DD/YYYY')) AS "BILLING_DATE"
					,SUM(RECORD_NUMBER) AS "RECORD_NUMBER"
					,SERVICE_TYPE
			FROM DISC_PROD.CCSI.MCOINV
			GROUP BY CLIENT_ID,UPPER(CCSI_OFFICE)
			,SERVICE_TYPE
)
,RAWVRFP_OTHERINV AS --DATA RELATED OTHER INVOICE
(
	SELECT * FROM RAWVRFP WHERE TRY_TO_NUMERIC(SERVICE_TYPE) IS NOT NULL --NUMERIC OTHER INV
)
, RAWVRFP_MCOINV AS --DATA RELATED MCO INVOICE
(
	SELECT * FROM RAWVRFP WHERE TRY_TO_NUMERIC(SERVICE_TYPE) IS NULL --NON NUMERIC FOR MCO INV
)
SELECT DISTINCT 
MD5(NVL(R.CLIENT_ID,'E')::STRING || '-' || NVL(COALESCE(O.AREA,O1.AREA),'E')::STRING 
			|| '-' || NVL(COALESCE(O.DATE_OF_SERVICE,O1.DATE_OF_SERVICE)::STRING,'E')::STRING 
			|| '-' || NVL(COALESCE(O.RECORD_NUMBER,O1.RECORD_NUMBER)::STRING,'E')::STRING
			|| '-' || 'CCSI') AS INTAKE_KEY
	FROM RAWVRFP_MCOINV R 
	INNER JOIN RESULT_DATA TMP 
		ON R.CLIENT_ID = TMP.CLIENT_IDOA_NO AND R.SERVICE_TYPE = TMP.SERVICE_TYPE
	JOIN DW_PROD.HAH.DIM_DATE AS DATES 
		ON DATES.CALENDAR_DATE BETWEEN TMP.START_DATE AND ADD_MONTHS(TMP.END_DATE,1)
	LEFT JOIN MCOINVOICE O  
		ON R.CLIENT_ID = O.CLIENT_ID
		AND R.AREA_2 = O.AREA AND R.SERVICE_TYPE = O.SERVICE_TYPE
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE) AND YEAR(O.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE))
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(DATES.FIRST_DAY_OF_MONTH) AND YEAR(O.DATE_OF_SERVICE) = YEAR(DATES.FIRST_DAY_OF_MONTH))
		AND  DATE_TRUNC('MONTH',O.DATE_OF_SERVICE) BETWEEN DATE_TRUNC('MONTH',TRY_TO_DATE(TMP.START_DATE)) AND END_DATE
		AND R.SERVICE_TYPE = O.SERVICE_TYPE
	LEFT JOIN MAXMCOINVOICE O1  
		ON R.CLIENT_ID = O1.CLIENT_ID
		AND R.AREA_2 = O1.AREA AND R.SERVICE_TYPE = O1.SERVICE_TYPE
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE))
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(DATES.FIRST_DAY_OF_MONTH)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(DATES.FIRST_DAY_OF_MONTH))
		AND  DATE_TRUNC('MONTH',O1.DATE_OF_SERVICE) BETWEEN DATE_TRUNC('MONTH',TRY_TO_DATE(TMP.START_DATE))-1 AND END_DATE
		AND R.SERVICE_TYPE = O1.SERVICE_TYPE
	INNER JOIN DW_PROD.HAH.DIM_BRANCH B 
		ON R.AREA_2  = B.OFFICE_CODE AND B.SOURCE_SYSTEM_ID  = 8 
	INNER JOIN DIM_CLIENT C
		ON R.CLIENT_ID = C.CLIENT_NUMBER AND R.AREA_2 = C.AREA
	INNER JOIN DW_PROD.HAH.DIM_CONTRACT CO ON R.CONTRACT_NO = CO.CONTRACT_CODE 	
	UNION
	SELECT DISTINCT
MD5(NVL(R.CLIENT_ID,'E')::STRING || '-' || NVL(COALESCE(O.AREA,O1.AREA),'E')::STRING 
			|| '-' || NVL(COALESCE(O.DATE_OF_SERVICE,O1.DATE_OF_SERVICE)::STRING,'E')::STRING 
			|| '-' || NVL(COALESCE(O.RECORD_NUMBER,O1.RECORD_NUMBER)::STRING,'E')::STRING
			|| '-' || 'CCSI') AS INTAKE_KEY
	FROM RAWVRFP_OTHERINV R 
	INNER JOIN RESULT_DATA TMP 
		ON R.CLIENT_ID = TMP.CLIENT_IDOA_NO AND R.SERVICE_TYPE = TMP.SERVICE_TYPE
	JOIN DW_PROD.HAH.DIM_DATE AS DATES 
		ON DATES.CALENDAR_DATE BETWEEN TMP.START_DATE AND ADD_MONTHS(TMP.END_DATE,1)
	LEFT JOIN OTHERINV O  
		ON R.CLIENT_ID = O.CLIENT_ID
		AND R.AREA_2 = O.AREA AND R.SERVICE_TYPE = O.SERVICE_TYPE
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE) AND YEAR(O.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE))
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(DATES.FIRST_DAY_OF_MONTH) AND YEAR(O.DATE_OF_SERVICE) = YEAR(DATES.FIRST_DAY_OF_MONTH))
		AND  DATE_TRUNC('MONTH',O.DATE_OF_SERVICE) BETWEEN DATE_TRUNC('MONTH',TRY_TO_DATE(TMP.START_DATE)) AND END_DATE
		AND R.SERVICE_TYPE = O.SERVICE_TYPE
	LEFT JOIN MAXOTHERINV O1  
		ON R.CLIENT_ID = O1.CLIENT_ID
		AND R.AREA_2 = O1.AREA AND R.SERVICE_TYPE = O1.SERVICE_TYPE
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE))
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(DATES.FIRST_DAY_OF_MONTH)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(DATES.FIRST_DAY_OF_MONTH))
		AND  DATE_TRUNC('MONTH',O1.DATE_OF_SERVICE) BETWEEN DATE_TRUNC('MONTH',TRY_TO_DATE(TMP.START_DATE))-1 AND END_DATE
		AND R.SERVICE_TYPE = O1.SERVICE_TYPE
	INNER JOIN DW_PROD.HAH.DIM_BRANCH B 
		ON R.AREA_2  = B.OFFICE_CODE AND B.SOURCE_SYSTEM_ID  = 8
	INNER JOIN DIM_CLIENT C
		ON R.CLIENT_ID = C.CLIENT_NUMBER AND R.AREA_2 = C.AREA
	INNER JOIN DW_PROD.HAH.DIM_CONTRACT CO ON R.CONTRACT_NO = CO.CONTRACT_CODE;