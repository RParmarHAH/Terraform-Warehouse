create or replace view DW_PROD.PUBLIC.VW_CURRENT_CCSI_FACT_VISIT(
	VISIT_KEY
) as
WITH RAWVRFP AS  --VISIT DATA
(
	SELECT DISTINCT RECORD_NUMBER
					,CLIENT_ID
					,SERVICE_TYPE
					,AREA_2
					,DAY_OF_SERVICE
					,PAY_PERIOD_ENDING_DATE
					,DATEADD(DAY,(IFNULL(DAY_OF_SERVICE,1) - 1),DATE_TRUNC('MONTH',TRY_TO_DATE(PERIOD_DATE, 'MMDDYY'))) AS "PERIOD_DATE" --CHANGE
					,EMPLOYEE_NUMBER
					,EMP_DESK
					,HOURS_WORKED
					,UPPER (TRIM (CONTRACT_NO)) AS "CONTRACT_NO" 
			FROM DISC_PROD.CCSI.RAWVRFP
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
SELECT CLIENT_NUMBER, AREA, CLIENT_NAME, MASTER_ID,RN,SHORT_DATE FROM 
(
SELECT *,ROW_NUMBER() OVER (PARTITION BY CLIENT_NUMBER,AREA ORDER BY SHORT_DATE DESC) AS DUP FROM 
(
	SELECT CLIENT_IDOA_NO AS "CLIENT_NUMBER"
			,USED_FOR_AREA AS "AREA"
			,FINAL_CLIENT_NAME AS "CLIENT_NAME"
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
					--,CLIENT_NAME
					,SUM(UNITS_PROVIDED) AS "UNITS"
					,SUM(BALANCE) AS "BALANCE"
					,TYPE_OF_SERVICE AS "SERVICE_TYPE"
				FROM DISC_PROD.CCSI.OTHERINV
				--WHERE CLIENT_ID  = 001641372
				GROUP BY CLIENT_ID,AREA,TYPE_OF_SERVICE				
				,TRY_TO_DATE(DATE_OF_SERVICE, 'MM/YYYY')
)
,MAXOTHERINV AS
(
	SELECT DISTINCT MAX(TRY_TO_DATE(DATE_OF_SERVICE, 'MM/YYYY')) AS "DATE_OF_SERVICE"
					,SUM(AMOUNT_BILLED) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,AREA 
					--,CLIENT_NAME
					,SUM(UNITS_PROVIDED) AS "UNITS"
					,SUM(BALANCE) AS "BALANCE"
					,TYPE_OF_SERVICE AS "SERVICE_TYPE"
				FROM DISC_PROD.CCSI.OTHERINV
				--WHERE CLIENT_ID  = 001641372
				GROUP BY CLIENT_ID,AREA
				,TYPE_OF_SERVICE
				,TRY_TO_DATE(DATE_OF_SERVICE, 'MM/YYYY')
)
, MCOINVOICE AS
(
	SELECT DISTINCT TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM') AS "DATE_OF_SERVICE"
					,SUM(DOLLAR_AMOUNT) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,UPPER(CCSI_OFFICE) AS "AREA"
					,SUM(BALANCE) AS "BALANCE"
					,SUM(UNITS) AS "UNITS"
					,SERVICE_TYPE
			FROM DISC_PROD.CCSI.MCOINV
			GROUP BY CLIENT_ID,UPPER(CCSI_OFFICE)
					,SERVICE_TYPE
					,TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM')
)	
, MAXMCOINVOICE AS
(
	SELECT DISTINCT MAX(TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM')) AS "DATE_OF_SERVICE"
					,SUM(DOLLAR_AMOUNT) AS "AMOUNT_BILLED"
					,CLIENT_ID
					,UPPER(CCSI_OFFICE) AS "AREA"
					,SUM(BALANCE) AS "BALANCE"
					,SUM(UNITS) AS "UNITS"
					,SERVICE_TYPE
			FROM DISC_PROD.CCSI.MCOINV
			GROUP BY CLIENT_ID,UPPER(CCSI_OFFICE)
			,SERVICE_TYPE
			,TRY_TO_DATE(SERVICE_MONTH, 'YYYY/MM')
)
, RAWVRFP_OTHERINV AS --DATA RELATED OTHER INVOICE
(
	SELECT * FROM RAWVRFP WHERE try_to_numeric(SERVICE_TYPE) IS NOT NULL --NUMERIC OTHER INV
)
, RAWVRFP_MCOINV AS --DATA RELATED MCO INVOICE
(
	SELECT * FROM RAWVRFP WHERE try_to_numeric(SERVICE_TYPE) IS NULL --NON NUMERIC FOR MCO INV
)
SELECT DISTINCT 
MD5(NVL(C.CLIENT_NAME,'E')::STRING || '-' || NVL(R.PERIOD_DATE::STRING,'E')::STRING || '-' || NVL(R.DAY_OF_SERVICE,'E')::STRING
			|| '-' || NVL(R.RECORD_NUMBER,'E')::STRING) AS VISIT_KEY
		FROM RAWVRFP_MCOINV R 
	LEFT JOIN MCOINVOICE O  
		ON R.CLIENT_ID = O.CLIENT_ID
		AND R.AREA_2 = O.AREA 
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE) AND YEAR(O.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE)) AND R.SERVICE_TYPE = O.SERVICE_TYPE
	LEFT JOIN MAXMCOINVOICE O1  
		ON R.CLIENT_ID = O1.CLIENT_ID
		AND R.AREA_2 = O1.AREA 
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE)) AND R.SERVICE_TYPE = O1.SERVICE_TYPE
	INNER JOIN DW_PROD.HAH.DIM_BRANCH B 
		ON R.AREA_2  = B.OFFICE_CODE AND B.SOURCE_SYSTEM_ID  = 8 
	INNER JOIN DIM_EMPLOYEE E		
		ON R.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER AND R.AREA_2 = E.AREA
	INNER JOIN DIM_CLIENT C --INNER JOIN DUE TO WE DON'T NEE TO TAKE BLAN CLIENT DATA
		ON R.CLIENT_ID = C.CLIENT_NUMBER AND R.AREA_2 = C.AREA
	INNER JOIN DW_PROD.HAH.DIM_CONTRACT CO ON R.CONTRACT_NO = CO.CONTRACT_CODE AND CO.SOURCE_SYSTEM_ID  = 8  
	INNER JOIN DISC_PROD.CCSI.DESKINFO D 
		ON R.EMP_DESK = D.DESK_DESIGNATOR AND R.AREA_2 = D.AREA
		--ON E.SUPERVISORY_DESK = D.DESK_DESIGNATOR AND E.AREA = D.AREA
		--WHERE R.CLIENT_ID  = 001641372
		UNION
SELECT DISTINCT
		MD5(NVL(C.CLIENT_NAME,'E')::STRING || '-' || NVL(R.PERIOD_DATE::STRING,'E')::STRING || '-' || NVL(R.DAY_OF_SERVICE,'E')::STRING
			|| '-' || NVL(R.RECORD_NUMBER,'E')::STRING) AS VISIT_KEY
	FROM RAWVRFP_OTHERINV R 
	LEFT JOIN OTHERINV O  
		ON R.CLIENT_ID = O.CLIENT_ID
		AND R.AREA_2 = O.AREA 
		AND  (MONTH(O.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE) AND YEAR(O.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE)) AND R.SERVICE_TYPE = O.SERVICE_TYPE
	LEFT JOIN MAXOTHERINV O1  
		ON R.CLIENT_ID = O1.CLIENT_ID
		AND R.AREA_2 = O1.AREA 
		AND  (MONTH(O1.DATE_OF_SERVICE) = MONTH(R.PERIOD_DATE)-1 AND YEAR(O1.DATE_OF_SERVICE) = YEAR(R.PERIOD_DATE)) AND R.SERVICE_TYPE = O1.SERVICE_TYPE
	INNER JOIN DW_PROD.HAH.DIM_BRANCH B 
		ON R.AREA_2  = B.OFFICE_CODE AND B.SOURCE_SYSTEM_ID  = 8
	INNER JOIN DIM_EMPLOYEE E		
		ON R.EMPLOYEE_NUMBER = E.EMPLOYEE_NUMBER AND R.AREA_2 = E.AREA 
	INNER JOIN DIM_CLIENT C --INNER JOIN DUE TO WE DON'T NEE TO TAKE BLAN CLIENT DATA
		ON R.CLIENT_ID = C.CLIENT_NUMBER AND R.AREA_2 = C.AREA 
	INNER JOIN DW_PROD.HAH.DIM_CONTRACT CO ON R.CONTRACT_NO = CO.CONTRACT_CODE AND CO.SOURCE_SYSTEM_ID  = 8 
	INNER JOIN DISC_PROD.CCSI.DESKINFO D 
		ON R.EMP_DESK = D.DESK_DESIGNATOR AND R.AREA_2 = D.AREA;