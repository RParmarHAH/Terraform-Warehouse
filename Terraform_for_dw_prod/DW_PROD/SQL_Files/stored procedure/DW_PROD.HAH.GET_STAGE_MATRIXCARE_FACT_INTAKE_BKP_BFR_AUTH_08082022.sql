CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_MATRIXCARE_FACT_INTAKE_BKP_BFR_AUTH_08082022("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
                BEGIN
    INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_INTAKE
WITH ADMISSIONS 
AS (
	SELECT ADM_ID ADMISSIONID,ADM_BRANCHID BRANCHID,ADM_CLIENTID CLIENTID,ADM_VERBALSOCDATE VERBALSOCDATE,
	ADM_ACTUALSOCDATE ACTUALSOCDATE,ADM_DISCHARGEDATE DISCHARGEDATE,ADM_DISCHARGERECORDEDDATE DISCHARGERECORDEDDATE,ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_ADMISSIONS
),
AUTHDETAIL AS 
(
	SELECT 
	AUTH.AUTH_ADMISSIONID ADMISSIONID,AUTH.AUTH_PAYERID PAYERID,AUTH.AUTH_SERVICECODEID SERVICECODEID,AUTH.AUTH_UNITFLAG UNITFLAG,
	AUTH.AUTH_BEGINDATE BEGINDATE,AUTH.AUTH_ENDDATE ENDDATE,AUTHDTL.AUTHDTL_FREQTYPE FREQTYPE,AUTHDTL.AUTHDTL_FREQINTERVAL FREQINTERVAL,
	AUTHDTL.AUTHDTL_FREQCOUNT FREQCOUNT,
	CASE WHEN AUTH_UNITFLAG = 15 THEN AUTHDTL_MAXUNITS/ 4
		WHEN AUTH_UNITFLAG = 30 THEN AUTHDTL_MAXUNITS / 2
		WHEN AUTH_UNITFLAG = 60 THEN AUTHDTL_MAXUNITS 
		ELSE 0 END AUTHDTL_UNITS,
	DIV0((AUTHDTL_UNITS*AUTHDTL.AUTHDTL_FREQCOUNT),
	CASE WHEN AUTHDTL.AUTHDTL_FREQINTERVAL = 1 THEN 2 ELSE 1 END) AUTHDTL_HOURS,
	GREATEST(AUTH.ETL_LAST_UPDATED_DATE,AUTHDTL.ETL_LAST_UPDATED_DATE) ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_AUTHORIZATION AUTH
	LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_AUTHORIZATIONDETAIL AUTHDTL ON AUTH.AUTH_ID=AUTHDTL.AUTHDTL_AUTHORIZATIONID
),
DATES AS 
(
	SELECT 
	DISTINCT FIRST_DAY_OF_MONTH , LAST_DAY_OF_MONTH
	FROM HAH.DIM_DATE 
),
AUTHDETAILBYMONTH AS 
(
	SELECT DISTINCT ADMISSIONID,PAYERID,SERVICECODEID,
	CASE WHEN DATE_TRUNC(''MONTH'',BEGINDATE)=FIRST_DAY_OF_MONTH THEN BEGINDATE ELSE NVL(FIRST_DAY_OF_MONTH,BEGINDATE) END BEGIN_DATE,
	CASE WHEN DATE_TRUNC(''MONTH'',ENDDATE)=FIRST_DAY_OF_MONTH THEN ENDDATE ELSE NVL(FIRST_DAY_OF_MONTH,ENDDATE) END END_DATE,
	AUTHDTL_HOURS TOTAL_AUTH_HOURS,
	AUTHDTL_HOURS/ CASE WHEN DATEDIFF(''DAY'',BEGINDATE,ENDDATE)=0 THEN 1 ELSE DATEDIFF(''DAY'',BEGINDATE,ENDDATE) END AUTH_HOURS_PER_DAY,
	DATEDIFF(''DAY'',BEGINDATE,ENDDATE),
	ROW_NUMBER() OVER (PARTITION BY ADMISSIONID,PAYERID,SERVICECODEID ORDER BY BEGINDATE,FIRST_DAY_OF_MONTH) ENTRYNUMBER,
	ROUND(AUTH_HOURS_PER_DAY *
	CASE WHEN DATE_TRUNC(''MONTH'',BEGINDATE)=FIRST_DAY_OF_MONTH THEN DATEDIFF(''DAY'',BEGINDATE,LAST_DAY_OF_MONTH) 
		WHEN DATE_TRUNC(''MONTH'',ENDDATE)=FIRST_DAY_OF_MONTH THEN 
			CASE WHEN DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,ENDDATE) = 0 THEN 1 ELSE DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,ENDDATE) END
		ELSE DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,LAST_DAY_OF_MONTH) END) HOURS_AUTHORIZED_ADJUSTED,
	ROUND(TOTAL_AUTH_HOURS / CASE WHEN DATEDIFF(''MONTH'',BEGINDATE,ENDDATE)=0 THEN 1 ELSE DATEDIFF(''MONTH'',BEGINDATE,ENDDATE) END) HOURS_AUTHORIZED_NON_ADJUSTED,
	AUTHDTL.FREQTYPE,
	ETL_LAST_UPDATED_DATE 
	FROM AUTHDETAIL AUTHDTL
	LEFT JOIN DATES D ON D.FIRST_DAY_OF_MONTH >= DATE_TRUNC(''MONTH'',AUTHDTL.BEGINDATE) 
		AND D.FIRST_DAY_OF_MONTH <= AUTHDTL.ENDDATE
),
CLIENTAUTH AS 
(
	SELECT DISTINCT CLIENTID,BRANCHID,SERVICECODEID,PAYERID,BEGIN_DATE,	--END_DATE,
	SUM(HOURS_AUTHORIZED_ADJUSTED) HOURS_AUTHORIZED_ADJUSTED,
	SUM(HOURS_AUTHORIZED_NON_ADJUSTED) HOURS_AUTHORIZED_NON_ADJUSTED,
	COALESCE(GREATEST(MAX(ADM.ETL_LAST_UPDATED_DATE),MAX(ADLBM.ETL_LAST_UPDATED_DATE)),''1900-01-01'') ETL_LAST_UPDATED_DATE 
	FROM ADMISSIONS ADM
	JOIN AUTHDETAILBYMONTH ADLBM ON ADM.ADMISSIONID=ADLBM.ADMISSIONID
	GROUP BY CLIENTID,BRANCHID,SERVICECODEID,PAYERID,BEGIN_DATE
),
OLD_DATA AS
(
	SELECT MD5(''MATRIXCARE'' || ''-'' || NVL(BEGIN_DATE,''1900-01-01'') || ''-'' || CLIENTID || ''-'' || PAYERID || ''-'' || SERVICECODEID || ''-'' || BRANCHID) INTAKE_KEY,
	DATE_TRUNC(''MONTH'',BEGIN_DATE) REPORT_DATE, MD5(''MATRIXCARE'' || ''-'' || BRANCHID || ''-'' || ''MATRIXCARE'') AS BRANCH_KEY,
	MD5(''MATRIXCARE'' || ''-'' || CLIENTID::STRING || ''-'' || ''MATRIXCARE'') AS CLIENT_KEY,
	MD5(''MATRIXCARE'' || ''-'' || PAYERID || ''-'' || SERVICECODEID || ''-'' || ''MATRIXCARE'') CONTRACT_KEY,
	7 SOURCE_SYSTEM_ID,BEGIN_DATE AS REAUTHORIZED_DATE,B.BR_NAME BRANCH_NAME,CLIENTID CLIENT_NUMBER,PAYERID CONTRACT_CODE,
	NULL BILL_RATE,''MATRIXCARE'' SYSTEM_CODE,NULL CASE_MANAGER,HOURS_AUTHORIZED_ADJUSTED HOURS_AUTHORIZED,HOURS_AUTHORIZED_NON_ADJUSTED,CA.ETL_LAST_UPDATED_DATE
	FROM CLIENTAUTH CA
	LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_BRANCHES B ON CA.BRANCHID=B.BR_ID
	WHERE CA.ETL_LAST_UPDATED_DATE >=  
:STR_CDC_START::timestamp_ntz
)
--, BRANCH_MAPPING AS 
--(
--SELECT * , MD5(SYSTEM_CODE || ''''-'''' || OFFICE_CODE || ''''-'''' || ''''MATRIXCARE'''') AS BRANCH_KEY  
--FROM MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING
--)
,ALL_DATA AS 
(
	SELECT DISTINCT O.INTAKE_KEY,O.REPORT_DATE, COALESCE (B.CONVERGED_BRANCH_KEY,O.BRANCH_KEY) AS BRANCH_KEY ,
	CASE WHEN MCM.MASTER_CLIENT_KEY IS NOT NULL THEN 
	MD5(''MATRIXCARE'' || ''-'' || MCM.MASTER_CLIENT_NUMBER::STRING || ''-'' || ''MATRIXCARE'') ELSE O.CLIENT_KEY END AS CLIENT_KEY
	--COALESCE(MCM.MASTER_CLIENT_KEY,O.CLIENT_KEY) AS CLIENT_KEY
	, O.CONTRACT_KEY,
	O.SOURCE_SYSTEM_ID,O.REAUTHORIZED_DATE, COALESCE (B.CONVERGED_OFFICE_NAME, O.BRANCH_NAME) AS BRANCH_NAME,
	COALESCE (MCM.MASTER_CLIENT_NUMBER ,O.CLIENT_NUMBER) AS CLIENT_NUMBER,
	O.CONTRACT_CODE, O.BILL_RATE, O.SYSTEM_CODE,O.CASE_MANAGER,O.HOURS_AUTHORIZED,
	O.HOURS_AUTHORIZED_NON_ADJUSTED,
	
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,0 as ETL_DELETED_FLAG
	FROM OLD_DATA O 
	LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_CLIENT_MAPPING_ALL MCM ON MCM.CLIENT_KEY = O.CLIENT_KEY
	--LEFT JOIN BRANCH_MAPPING B ON B.BRANCH_KEY=O.BRANCH_KEY
	LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING B ON B.BRANCH_KEY=O.BRANCH_KEY
	WHERE O.ETL_LAST_UPDATED_DATE >=  
:STR_CDC_START::timestamp_ntz
)
SELECT * FROM ALL_DATA;
    RETURN ''SUCCESS'';
    END;
    ';