resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_FACT_INTAKE" {
	name ="GET_STAGE_MATRIXCARE_FACT_INTAKE"
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
-- NAME:  MATRIXCARE_FACT_INTAKE
--
-- PURPOSE: 
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/19/22     Pooja Shah      	 Enhancement to include Auth Dates & PreAuthNo. 
-- 02/03/2023   Mirisha              Updated logic for Auth hours	
-- 04/04/2023   Jashvant Patel	     Updated Time format as per American time
-- 04/10/2023	Mohit Vaghadiya		 Made changes on time zone convesion to fix an issue where auth hours are not showing up properly on PBI Dash
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_INTAKE
WITH CLIENT AS (
  SELECT * FROM 
  (
    SELECT MASTER_ID,CLI_ID
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST 
  ) 
  UNION
  SELECT * FROM 
  (
    SELECT DISTINCT MASTER_ID,ID
    FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MATCH_LIST 
    WHERE ID NOT IN (SELECT DISTINCT CLI_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST)
  ) 
),
 ADMISSIONS 
AS (
    SELECT ADM_ID ADMISSIONID,ADM_BRANCHID BRANCHID,ADM_CLIENTID CLIENTID,ADM_VERBALSOCDATE VERBALSOCDATE,
    ADM_ACTUALSOCDATE ACTUALSOCDATE,ADM_DISCHARGEDATE DISCHARGEDATE,ADM_DISCHARGERECORDEDDATE DISCHARGERECORDEDDATE,ETL_LAST_UPDATED_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS
),
AUTHDETAIL AS 
(
    SELECT -- distinct  -- MODIFIIED BY PJSHAH ON 07/21
    AUTH.AUTH_ADMISSIONID ADMISSIONID,AUTH.AUTH_PAYERID PAYERID,AUTH.AUTH_SERVICECODEID SERVICECODEID,AUTH.AUTH_UNITFLAG UNITFLAG,
    --MAX (AUTH.AUTH_BEGINDATE ) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) BEGINDATE, -- Modified by PJShah on 03052022
    --MAX(AUTH.AUTH_ENDDATE ) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) ENDDATE, -- Modified by PJShah on 03052022
	--AUTH.AUTH_BEGINDATE BEGINDATE,AUTH.AUTH_ENDDATE ENDDATE,  -- CORRECTION BY PJSHAH ON 07/22
 	AUTH.AUTH_BEGINDATE_EST BEGINDATE,
	AUTH.AUTH_ENDDATE_EST ENDDATE,
    AUTHDTL.AUTHDTL_FREQTYPE FREQTYPE,AUTHDTL.AUTHDTL_FREQINTERVAL FREQINTERVAL,
    AUTHDTL.AUTHDTL_FREQCOUNT FREQCOUNT,
    CASE WHEN AUTH_UNITFLAG = 15 THEN AUTHDTL_MAXUNITS/ 4
        WHEN AUTH_UNITFLAG = 30 THEN AUTHDTL_MAXUNITS / 2
        WHEN AUTH_UNITFLAG = 60 THEN AUTHDTL_MAXUNITS 
        ELSE 0 END AUTHDTL_UNITS,
    DIV0((AUTHDTL_UNITS*AUTHDTL.AUTHDTL_FREQCOUNT),
    CASE WHEN AUTHDTL.AUTHDTL_FREQINTERVAL = 1 THEN 2 ELSE 1 END) AUTHDTL_HOURS,
    GREATEST(AUTH.ETL_LAST_UPDATED_DATE,AUTHDTL.ETL_LAST_UPDATED_DATE) ETL_LAST_UPDATED_DATE
    --,AUTH.AUTH_BEGINDATE AS LATEST_AUTH_BEGIN_DATE -- Added by PJShah on 19042022
    --,AUTH.AUTH_ENDDATE AS LATEST_AUTH_END_DATE -- Added by PJShah on 19042022
	--,MAX (AUTH.AUTH_BEGINDATE ) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) as LATEST_AUTH_BEGIN_DATE  -- Added by PJShah on 19042022
    --,MAX(AUTH.AUTH_ENDDATE ) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) AS LATEST_AUTH_END_DATE
	,MAX(AUTH.AUTH_BEGINDATE_EST) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) as LATEST_AUTH_BEGIN_DATE  -- Added by PJShah on 19042022
    ,MAX(AUTH.AUTH_ENDDATE_EST) OVER (Partition by AUTH.AUTH_ADMISSIONID,AUTH.AUTH_PAYERID ) AS LATEST_AUTH_END_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.VW_STVHC_T_AUTHORIZATION AUTH
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATIONDETAIL AUTHDTL ON AUTH.AUTH_ID=AUTHDTL.AUTHDTL_AUTHORIZATIONID
    --where auth.AUTH_ADMISSIONID=22639
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
	CASE WHEN FREQTYPE IN (1,2,7) THEN AUTHDTL_UNITS/ 7
	     WHEN FREQTYPE=0 THEN AUTHDTL_UNITS
	     WHEN FREQTYPE=3 THEN AUTHDTL_UNITS/30
	     WHEN FREQTYPE IN(4,8) THEN AUTHDTL_UNITS/(DATEDIFF(''DAY'',D.FIRST_DAY_OF_MONTH,D.LAST_DAY_OF_MONTH)+1)
	     WHEN FREQTYPE=5 THEN AUTHDTL_UNITS/(DATEDIFF(''DAY'',BEGINDATE,ENDDATE)+1)
	     WHEN FREQTYPE=6 THEN AUTHDTL_UNITS/(DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH ,LAST_DAY_OF_MONTH)+1)/IFF(DATEDIFF(''MONTH'',BEGINDATE,ENDDATE)=0,1,DATEDIFF(''MONTH'',BEGINDATE,ENDDATE))
	    END AS AUTH_HOURS_PER_DAY,
	DATEDIFF(''DAY'',BEGINDATE,ENDDATE),
	--ROW_NUMBER() OVER (PARTITION BY ADMISSIONID,PAYERID,SERVICECODEID ORDER BY BEGINDATE,FIRST_DAY_OF_MONTH) ENTRYNUMBER,
	ROUND(AUTH_HOURS_PER_DAY* 
				CASE 
	 WHEN BEGINDATE>=FIRST_DAY_OF_MONTH THEN DATEDIFF(''DAY'',BEGINDATE,LAST_DAY_OF_MONTH)+1
     WHEN ENDDATE<LAST_DAY_OF_MONTH THEN DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,ENDDATE)
     WHEN ENDDATE=FIRST_DAY_OF_MONTH THEN
      CASE WHEN DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,ENDDATE) = 0 THEN 1 ELSE DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,ENDDATE) END
     ELSE DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,LAST_DAY_OF_MONTH)+1 END) HOURS_AUTHORIZED_ADJUSTED,
	ROUND(TOTAL_AUTH_HOURS / CASE WHEN DATEDIFF(''MONTH'',BEGINDATE,ENDDATE)=0 THEN 1 ELSE DATEDIFF(''MONTH'',BEGINDATE,ENDDATE) END) HOURS_AUTHORIZED_NON_ADJUSTED,
	AUTHDTL.FREQTYPE,
	ETL_LAST_UPDATED_DATE 
	,MAX (LATEST_AUTH_BEGIN_DATE ) OVER (Partition by ADMISSIONID,PAYERID ) as LATEST_AUTH_BEGIN_DATE 	-- Added by PJShah on 19042022
	,MAX(LATEST_AUTH_END_DATE ) OVER (Partition by ADMISSIONID,PAYERID ) AS LATEST_AUTH_END_DATE		-- Added by PJShah on 19042022
	FROM AUTHDETAIL AUTHDTL
	LEFT JOIN DATES D ON D.FIRST_DAY_OF_MONTH >= DATE_TRUNC(''MONTH'',AUTHDTL.BEGINDATE) 
		AND D.FIRST_DAY_OF_MONTH <= DATE_TRUNC(''MONTH'',AUTHDTL.ENDDATE)-- AND D.LAST_DAY_OF_MONTH<=AUTHDTL.ENDDATE
),
CLIENTAUTH AS -- Modified by PJShah on 03052022
(select 
 CLIENT_ID,BRANCHID,SERVICECODEID,PAYERID, --MAX(BEGIN_DATE) as 
    BEGIN_DATE, 
    SUM(HOURS_AUTHORIZED_ADJUSTED) HOURS_AUTHORIZED_ADJUSTED,  -- MODIFIED BY PJSHAH ON 07/21
    SUM(HOURS_AUTHORIZED_NON_ADJUSTED) HOURS_AUTHORIZED_NON_ADJUSTED, -- MODIFIED BY PJSHAH ON 07/21
     MAX(ETL_LAST_UPDATED_DATE ) ETL_LAST_UPDATED_DATE 
    , LATEST_AUTH_BEGIN_DATE    -- Added by PJShah on 19042022
    , LATEST_AUTH_END_DATE
from 
( SELECT -- DISTINCT  -- COMMENTED DISTINCT AS CREATES ISSUE IN GROUPING DUE TO AUTH DATES INCLUDED BY PJSHAH ON 07/26
    COALESCE (C.MASTER_ID,ADM.CLIENTID) AS CLIENT_ID,BRANCHID,SERVICECODEID,PAYERID, BEGIN_DATE,    --END_DATE,
    SUM(HOURS_AUTHORIZED_ADJUSTED) HOURS_AUTHORIZED_ADJUSTED,
    SUM(HOURS_AUTHORIZED_NON_ADJUSTED) HOURS_AUTHORIZED_NON_ADJUSTED,
    COALESCE(GREATEST(MAX(ADM.ETL_LAST_UPDATED_DATE),MAX(ADLBM.ETL_LAST_UPDATED_DATE)),''1900-01-01'') ETL_LAST_UPDATED_DATE 
    ,MAX(LATEST_AUTH_BEGIN_DATE) OVER (Partition by  COALESCE (C.MASTER_ID,ADM.CLIENTID),PAYERID ) as LATEST_AUTH_BEGIN_DATE    -- Added by PJShah on 19042022
    ,MAX(LATEST_AUTH_END_DATE) OVER (Partition by  COALESCE (C.MASTER_ID,ADM.CLIENTID),PAYERID ) as LATEST_AUTH_END_DATE        -- Added by PJShah on 19042022  
FROM ADMISSIONS ADM
    LEFT JOIN CLIENT C ON C.CLI_ID = ADM.CLIENTID
    JOIN AUTHDETAILBYMONTH ADLBM ON ADM.ADMISSIONID=ADLBM.ADMISSIONID
    GROUP BY COALESCE (C.MASTER_ID,ADM.CLIENTID),BRANCHID,SERVICECODEID,PAYERID,BEGIN_DATE
    ,LATEST_AUTH_BEGIN_DATE     -- Added by PJShah on 19042022
    ,LATEST_AUTH_END_DATE       -- Added by PJShah on 19042022  
)t
group by 
  CLIENT_ID,BRANCHID,SERVICECODEID,PAYERID,BEGIN_DATE   --END_DATE, -- MODIFIED BY PJSHAH ON 07/19
    --SUM(HOURS_AUTHORIZED_ADJUSTED) HOURS_AUTHORIZED_ADJUSTED,
--  SUM(HOURS_AUTHORIZED_NON_ADJUSTED) HOURS_AUTHORIZED_NON_ADJUSTED
    --, ETL_LAST_UPDATED_DATE 
    , LATEST_AUTH_BEGIN_DATE    -- Added by PJShah on 19042022
    , LATEST_AUTH_END_DATE
),
--select SUM(HOURS_AUTHORIZED_ADJUSTED) from CLIENTAUTH;--30833283,
CLIENT_SERVICE_DATES -- ADDED BY PJSHAH ON 19042022
AS
(SELECT DISTINCT C.MASTER_ID AS ID
        , CP.CLIPAY_PAYERID
        , CP.CLIPAY_EFFECTIVEDATE
        , CP.CLIPAY_EXPIRATIONDATE
        , CP.CLIPAY_POLICYNUMBER
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPAYERS CP
INNER JOIN client c ON CP.CLIPAY_CLIENTID = c.CLI_ID
JOIN 
(
    SELECT C.MASTER_ID AS MID
            , CLIPAY_PAYERID
            , MAX(CLIPAY_EFFECTIVEDATE) AS BEGIN_SERVICE_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPAYERS p
    INNER JOIN CLIENT C ON p.CLIPAY_CLIENTID = c.CLI_ID
    --WHERE CLIPAY_CLIENTID=9022
    GROUP BY MID, CLIPAY_PAYERID
--HAVING COUNT(1)>1
)T 
    ON C.MASTER_ID = T.MID 
        AND CP.CLIPAY_PAYERID=T.CLIPAY_PAYERID
        AND CP.CLIPAY_EFFECTIVEDATE= T.BEGIN_SERVICE_DATE
QUALIFY ROW_NUMBER() OVER(PARTITION BY C.MASTER_ID, CP.CLIPAY_PAYERID, CP.CLIPAY_EFFECTIVEDATE
                            ORDER BY CP.CLIPAY_EXPIRATIONDATE DESC) = 1
),
OLD_DATA AS
(
    SELECT MD5(''MATRIXCARE'' || ''-'' || NVL(BEGIN_DATE,''1900-01-01'') || ''-'' || CA.CLIENT_ID || ''-'' || PAYERID || ''-'' || SERVICECODEID || ''-'' || BRANCHID) INTAKE_KEY,
    DATE_TRUNC(''MONTH'',BEGIN_DATE) REPORT_DATE, MD5(''MATRIXCARE'' || ''-'' || BRANCHID || ''-'' || ''MATRIXCARE'') AS BRANCH_KEY,
    C.MASTER_ID,
--  MD5(''MATRIXCARE'' || ''-'' || CA.CLIENT_ID::STRING || ''-'' || ''MATRIXCARE'') AS CLIENT_KEY,
    MD5(''MATRIXCARE'' || ''-'' || PAYERID || ''-'' || SERVICECODEID || ''-'' || ''MATRIXCARE'') CONTRACT_KEY,
    7 SOURCE_SYSTEM_ID,BEGIN_DATE AS REAUTHORIZED_DATE,B.BR_NAME BRANCH_NAME,CA.CLIENT_ID CLIENT_NUMBER,PAYERID CONTRACT_CODE,
    NULL BILL_RATE,''MATRIXCARE'' SYSTEM_CODE,NULL CASE_MANAGER,
    HOURS_AUTHORIZED_ADJUSTED HOURS_AUTHORIZED,
    HOURS_AUTHORIZED_NON_ADJUSTED,
    CA.ETL_LAST_UPDATED_DATE
    ,DT.CLIPAY_POLICYNUMBER AS PRE_AUTH_NUMBER -- Added by PJShah on 19042022   
    ,DT.CLIPAY_EFFECTIVEDATE AS BEGIN_SERVICE_DATE-- Added by PJShah on 19042022    
    ,DT.CLIPAY_EXPIRATIONDATE  AS END_SERVICE_DATE -- Added by PJShah on 19042022   
    ,CA.LATEST_AUTH_BEGIN_DATE -- Added by PJShah on 19042022   
    ,CA.LATEST_AUTH_END_DATE -- Added by PJShah on 19042022 
FROM CLIENTAUTH CA
LEFT JOIN CLIENT C ON C.CLI_ID = CA.CLIENT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES B ON CA.BRANCHID=B.BR_ID
LEFT JOIN CLIENT_SERVICE_DATES DT ON DT.ID= CA.CLIENT_ID
    AND DT.CLIPAY_PAYERID=CA.PAYERID -- ADDED BY PJSHAH ON 19042022
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
    SELECT DISTINCT O.INTAKE_KEY,
O.REPORT_DATE, 
--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', O.REPORT_DATE))) as REPORT_DATE,
COALESCE (B.CONVERGED_BRANCH_KEY,O.BRANCH_KEY) AS BRANCH_KEY ,
    --CASE WHEN MCM.MASTER_CLIENT_KEY IS NOT NULL THEN 
--  MD5(''MATRIXCARE'' || ''-'' || MCM.MASTER_ID::STRING || ''-'' || ''MATRIXCARE'') ELSE O.CLIENT_KEY END AS CLIENT_KEY
    --COALESCE(MCM.MASTER_CLIENT_KEY,O.CLIENT_KEY) AS CLIENT_KEY
    --MD5(''MATRIXCARE'' || ''-'' || MCM.MASTER_ID::STRING || ''-'' || ''MATRIXCARE'') AS CLIENT_KEY
    MD5(''MATRIXCARE'' || ''-'' || COALESCE (MCM.MASTER_ID::STRING,O.CLIENT_NUMBER::STRING) || ''-'' || ''MATRIXCARE'') AS CLIENT_KEY
    , O.CONTRACT_KEY,
    O.SOURCE_SYSTEM_ID,
    O.PRE_AUTH_NUMBER,  -- Added by PJShah on 19042022
    --O.BEGIN_SERVICE_DATE,  -- Added by PJShah on 19042022                         
    --O.END_SERVICE_DATE,    -- Added by PJShah on 19042022
    --O.LATEST_AUTH_BEGIN_DATE, -- Added by PJShah on 19042022 
    --O.LATEST_AUTH_END_DATE,   -- Added by PJShah on 19042022
   -- O.LATEST_AUTH_BEGIN_DATE AS BEGIN_SERVICE_DATE,  -- Interchanged by PJShah as per call with Mir on 21042022  
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', O.LATEST_AUTH_BEGIN_DATE))) AS BEGIN_SERVICE_DATE,         
    --O.LATEST_AUTH_END_DATE AS END_SERVICE_DATE,  -- Interchanged by PJShah as per call with Mir on 21042022            
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', O.LATEST_AUTH_END_DATE))) AS END_SERVICE_DATE,
    --O.BEGIN_SERVICE_DATE AS LATEST_AUTH_BEGIN_DATE,    -- Interchanged by PJShah as per call with Mir on 21042022                                 
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'',O.BEGIN_SERVICE_DATE))) AS LATEST_AUTH_BEGIN_DATE,
   --O.END_SERVICE_DATE AS LATEST_AUTH_BEGIN_DATE, -- Interchanged by PJShah as per call with Mir on 21042022            
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', O.END_SERVICE_DATE))) AS LATEST_AUTH_BEGIN_DATE,
    --O.REAUTHORIZED_DATE, 
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', O.REAUTHORIZED_DATE))) as REAUTHORIZED_DATE,
COALESCE (B.CONVERGED_OFFICE_NAME, O.BRANCH_NAME) AS BRANCH_NAME,
    O.MASTER_ID  AS CLIENT_NUMBER,
    O.CONTRACT_CODE, O.BILL_RATE, O.SYSTEM_CODE,O.CASE_MANAGER,O.HOURS_AUTHORIZED,
    O.HOURS_AUTHORIZED_NON_ADJUSTED,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                       
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,0 as ETL_DELETED_FLAG
    FROM OLD_DATA O 
    LEFT JOIN CLIENT MCM ON MCM.MASTER_ID = O.MASTER_ID 
    --LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_CLIENT_MAPPING_ALL MCM ON MCM.CLIENT_KEY = O.CLIENT_KEY
    --LEFT JOIN BRANCH_MAPPING B ON B.BRANCH_KEY=O.BRANCH_KEY
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING B ON B.BRANCH_KEY=O.BRANCH_KEY
		WHERE O.ETL_LAST_UPDATED_DATE >=  
:STR_CDC_START::timestamp_ntz
)
SELECT * FROM ALL_DATA;;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

