resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_FACT_CLIENT_SERVICE" {
	name ="GET_STAGE_MATRIXCARE_FACT_CLIENT_SERVICE"
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
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  MATRIXCARE_FACT_CLIENT_SERVICE
--12/07/2022     SAM HUFF                Initial development
--03/13/2021	 Rajat Sapkal			 Modified Initial Logic
--07/03/23		Rajat Sapkal		 	 Type change - added 0 as visit
--07/14/23		Rajat Sapkal			 Removed 24_hr cap
--10/13/2023	RAJAT SAPKAL			 Modified Authorization max units adjusted and Authorization max units logic-for month UOM																	  
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_CLIENT_SERVICE

WITH CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT ID AS CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MATCH_LIST
		WHERE CLI_ID NOT IN (SELECT CLI_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST)
	)),
DATES AS 
(
    SELECT 
    DISTINCT FIRST_DAY_OF_MONTH , LAST_DAY_OF_MONTH
    FROM HAH.DIM_DATE 
),
DATA AS(
SELECT DISTINCT
MD5(
		NVL(au.AUTH_ADMISSIONID,-1) || ''-'' || 
        NVL(sc.SVCC_ID,-1) || ''-'' ||
        NVL(au.AUTH_ID,-1) || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       
																											as CLIENT_SERVICE_KEY,
''7'' 																										as source_system_id,
''MATRIXCARE'' 																								as system_code,
MD5(
        ''MATRIXCARE'' || ''-'' || COALESCE(MAPPING.OFFICE_STATE, b.BR_STATEORPROVINCE, ''IN'') || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        NVL(sc.svcc_id,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                      
																										   as partner_contract_service_key,
    MD5(
        NVL(au.AUTH_ADMISSIONID,-1) || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '' '') || ''-'' || 
        NVL(sc.svcc_id,-1) || ''-'' ||
        NVL(au.AUTH_PAYERID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                      as CLIENT_ADMISSION_KEY,
    MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(COALESCE(CLI.MASTER_ID::STRING,CLI.CLI_ID::STRING), '''') || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       AS CLIENT_KEY,
    CASE WHEN sc.svcc_id IS NOT NULL  
	THEN MD5(
        ''MATRIXCARE'' || ''-'' || 
        NVL(sc.svcc_id,-1) || ''-'' ||
        ''MATRIXCARE''
    )  ELSE ''-1'' END                                                                                     	AS SERVICE_KEY,   
sc.svcc_id                                                                                    				AS BILL_CODE,
    CASE 
        WHEN AUTH_UNITFLAG in (0,150) then ''Visit''		-- 0 means visit checked on UI
        WHEN AUTH_UNITFLAG IN (1,15,30,60) then ''Hourly''
        WHEN AUTH_UNITFLAG = 1440 then ''Daily''
        WHEN AUTH_UNITFLAG IS NOT NULL THEN ''UNKNOWN''
        ELSE NULL
    END                                                                                                     AS BILL_TYPE,--values taken from matrixcare documentation
    CASE 
        WHEN AUTHDTL_FREQTYPE = 0 then ''Day''
        WHEN AUTHDTL_FREQTYPE IN (1,2,7) then ''Week''
        WHEN AUTHDTL_FREQTYPE IN (3,4,8) then ''Month''
        WHEN AUTHDTL_FREQTYPE = 5 then ''Year''
        WHEN AUTHDTL_FREQTYPE = 6 then ''Entire Period''
        ELSE NULL 
    END                                                                                                     AS BILL_UOM,--values taken from matrixcare documentation
    CASE 
        WHEN AUTH_UNITFLAG in (0,150) then ''Visit''		-- 0 means visit checked on UI
        WHEN AUTH_UNITFLAG IN (1,15,30,60) then ''Hourly''
        WHEN AUTH_UNITFLAG = 1440 then ''Daily''
        WHEN AUTH_UNITFLAG IS NOT NULL THEN ''UNKNOWN''
        ELSE NULL
    END                                                                                                      AS SCHEDULE_TYPE,--values taken from matrixcare documentation
    CASE 
        WHEN AUTHDTL_FREQTYPE = 0 then ''Day''
        WHEN AUTHDTL_FREQTYPE IN (1,2,7) then ''Week''
        WHEN AUTHDTL_FREQTYPE IN (3,4,8) then ''Month''
        WHEN AUTHDTL_FREQTYPE = 5 then ''Year''
        WHEN AUTHDTL_FREQTYPE = 6 then ''Entire Period''
        ELSE NULL 
    END                                                                                                      AS SCHEDULE_UOM,--values taken from matrixcare documentation	
svcc_name													                                       			AS AUTHORIZATION_DISCIPLINE,
TIMESTAMPDIFF(''hour'', CONVERT_TIMEZONE(''America/New_York'', AU.AUTH_ENDDATE)::datetime ,AU.AUTH_ENDDATE::datetime)  AS hours_diff,
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', AU.auth_begindate)))					as authorization_date,
TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', AU.auth_begindate)))					as authorization_period_start_date,
--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', AU.auth_enddate)))						as AUTHORIZATION_PERIOD_END_DATE,
TO_DATE(DATEADD (MINUTE , 0, iff((hours_diff in (''4'') or hour(AU.auth_enddate)=''5'') and day(AU.auth_enddate)=''1'',dateadd(HOUR,-1,CONVERT_TIMEZONE(''America/New_York'', AU.auth_enddate)::datetime),CONVERT_TIMEZONE(''America/New_York'', AU.auth_enddate)))) as AUTHORIZATION_PERIOD_END_DATE,
IFNULL((DATEDIFF(''DAY'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1),0) 				AS EFFECTIVE_DAYS,
CASE
        WHEN AUTH_UNITFLAG in (0,150) then ''Visit Authorization''		-- 0 means visit checked on UI
        WHEN AUTH_UNITFLAG IN (1,15,30,60) then ''Hourly Authorization''
        WHEN AUTH_UNITFLAG = 1440 then ''Daily Authorization''
        WHEN AUTH_UNITFLAG IS NOT NULL THEN ''UNKNOWN''
        ELSE NULL
    END                                                                                                      AS AUTHORIZAITON_TYPE,--values taken from matrixcare documentation
    CASE 
        WHEN AUTHDTL_FREQTYPE = 0 then ''Day''
        WHEN AUTHDTL_FREQTYPE IN (1,2,7) then ''Weekly''
        WHEN AUTHDTL_FREQTYPE IN (3,4,8) then ''Monthly''
        WHEN AUTHDTL_FREQTYPE = 5 then ''Yearly''
        WHEN AUTHDTL_FREQTYPE = 6 then ''Entire Period''
        ELSE NULL 
    END                                                                                                     AS AUTHORIZATION_UOM,--values taken from matrixcare documentation
    NULL                                                                                                   AS AUTH_INFO,
    CASE WHEN AUTH_UNITFLAG = 15 THEN AUTHDTL_MAXUNITS/ 4
        WHEN AUTH_UNITFLAG = 30 THEN AUTHDTL_MAXUNITS / 2
        WHEN AUTH_UNITFLAG = 60 THEN AUTHDTL_MAXUNITS 
        ELSE AUTHDTL_MAXUNITS END                                                                           AS authorization_max_units_by_uom,  
        --
    /*CASE WHEN AUTHDTL_FREQTYPE = 0 AND authorization_max_units_by_uom > 24 THEN 24
         WHEN AUTHDTL_FREQTYPE IN (1,2,7) AND authorization_max_units_by_uom > 168 THEN 168
         WHEN AUTHDTL_FREQTYPE IN (3,4,8) AND authorization_max_units_by_uom > 744 THEN 744
         WHEN AUTHDTL_FREQTYPE = 5 AND authorization_max_units_by_uom > 8784 THEN 8784
         WHEN AUTHDTL_FREQTYPE = 6 THEN IFF(DIV0(authorization_max_units_by_uom,DATEDIFF(''DAY'',authorization_period_start_date,AUTHORIZATION_PERIOD_END_DATE))>24,24*DATEDIFF(''DAY'',authorization_period_start_date,AUTHORIZATION_PERIOD_END_DATE),authorization_max_units_by_uom)
        ELSE authorization_max_units_by_uom END AS authorization_max_units_by_uom_adjusted,--24 hours cap if max units are exceeding beyond 24hrs per day*/
        --
        authorization_max_units_by_uom 																		AS authorization_max_units_by_uom_adjusted,
        --
    --DIV0(authorization_max_units_by_uom * AUTHDTL_FREQCOUNT, CASE WHEN AUTHDTL_FREQINTERVAL = 1 THEN 2 ELSE 1 END) AS authorization_max_units,
       -- 
        CAST(CASE WHEN AUTHDTL_FREQTYPE IN (1,2,7) THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/ 7))     
         WHEN AUTHDTL_FREQTYPE=0 THEN authorization_max_units_by_uom*EFFECTIVE_DAYS 
         WHEN AUTHDTL_FREQTYPE=3 THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/30))
         WHEN AUTHDTL_FREQTYPE IN(4,8) THEN (authorization_max_units_by_uom*(DATEDIFF(''MONTH'',authorization_period_start_date,AUTHORIZATION_PERIOD_END_DATE)+1))
         WHEN AUTHDTL_FREQTYPE=5 THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/365))
         WHEN AUTHDTL_FREQTYPE=6 THEN  authorization_max_units_by_uom
         END AS NUMBER(38,3)) 																								AS AUTHORIZATION_MAX_UNITS,
        CAST(CASE WHEN AUTHDTL_FREQTYPE IN (1,2,7) THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/ 7))  
         WHEN AUTHDTL_FREQTYPE=0 THEN authorization_max_units_by_uom*EFFECTIVE_DAYS 
         WHEN AUTHDTL_FREQTYPE=3 THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/30))
         WHEN AUTHDTL_FREQTYPE IN(4,8) THEN
        	CASE WHEN AUTHORIZATION_PERIOD_END_DATE=LAST_DAY(AUTHORIZATION_PERIOD_END_DATE)
        	AND AUTHORIZATION_PERIOD_START_DATE=DATE_TRUNC(month, AUTHORIZATION_PERIOD_START_DATE)
         	THEN 
        		(authorization_max_units_by_uom*(DATEDIFF(''MONTH'',authorization_period_start_date,AUTHORIZATION_PERIOD_END_DATE)+1)) 
        	ELSE (authorization_max_units_by_uom*MONTHS_BETWEEN(AUTHORIZATION_PERIOD_END_DATE,AUTHORIZATION_PERIOD_START_DATE))
        	END
         WHEN AUTHDTL_FREQTYPE=5 THEN (authorization_max_units_by_uom*(EFFECTIVE_DAYS/365))
         WHEN AUTHDTL_FREQTYPE=6 THEN  authorization_max_units_by_uom
         END AS NUMBER(38,3)) 																								AS AUTHORIZATION_MAX_UNITS_ADJUSTED,
    iff(current_date() between authorization_period_start_date and AUTHORIZATION_PERIOD_END_DATE, true, false) as active_flag,
    FALSE AS CANCELLED_FLAG,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
      :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER                                              as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER                                              as ETL_LAST_UPDATED_BY,
     0                                                          AS ETL_DELETED_FLAG   
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION AU
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATIONDETAIL AD
	ON AU.AUTH_ID =AD.AUTHDTL_AUTHORIZATIONID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE SC
	ON AU.AUTH_SERVICECODEID =SC.SVCC_ID 
left join disc_${var.SF_ENVIRONMENT}.matrixcare.stvhc_t_admissions adm 
	on adm.adm_id = au.AUTH_ADMISSIONID
LEFT JOIN disc_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERS p 
	ON p.pay_id = au.AUTH_PAYERID
LEFT JOIN disc_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES b ON b.BR_ID = p.PAY_BRANCHID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}."STAGE".MATRIXCARE_OFFICE_MAPPING AS MAPPING 
		ON MAPPING.BR_ID = b.BR_ID									   
LEFT JOIN client cli
	ON cli.cli_id=adm.ADM_CLIENTID											 
LEFT JOIN DATES D ON D.FIRST_DAY_OF_MONTH >= DATE_TRUNC(''MONTH'',AU.auth_begindate) 
		AND D.FIRST_DAY_OF_MONTH <= DATE_TRUNC(''MONTH'',AU.auth_enddate)
qualify row_number() over (partition by CLIENT_SERVICE_KEY order by authdtl_modifieddate,AUTHDTL_FREQCOUNT desc) = 1)
SELECT CLIENT_SERVICE_KEY,SOURCE_SYSTEM_ID,SYSTEM_CODE,PARTNER_CONTRACT_SERVICE_KEY,CLIENT_ADMISSION_KEY,CLIENT_KEY,SERVICE_KEY,
BILL_CODE,BILL_TYPE,BILL_UOM,SCHEDULE_TYPE,SCHEDULE_UOM,AUTHORIZATION_DISCIPLINE,AUTHORIZATION_DATE,
AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE,EFFECTIVE_DAYS,AUTHORIZAITON_TYPE,AUTHORIZATION_UOM,AUTH_INFO,AUTHORIZATION_MAX_UNITS_BY_UOM,AUTHORIZATION_MAX_UNITS,authorization_max_units_by_uom_adjusted,
AUTHORIZATION_MAX_UNITS_ADJUSTED,ACTIVE_FLAG,CANCELLED_FLAG,ETL_TASK_KEY,ETL_INSERTED_TASK_KEY,
ETL_INSERTED_DATE,ETL_INSERTED_BY,ETL_LAST_UPDATED_DATE,ETL_LAST_UPDATED_BY,ETL_DELETED_FLAG FROM DATA;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;


 EOT
}

