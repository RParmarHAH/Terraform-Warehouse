resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_FACT_PARTNER_CONTRACT_SERVICE" {
	name ="GET_STAGE_MATRIXCARE_FACT_PARTNER_CONTRACT_SERVICE"
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
-- NAME:  MATRIXCARE FACT PARTNER CONTRACT SERVICE
--
-- PURPOSE: Populates Stage MATRIXCARE  FACT PARTNER CONTRACT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/30/23     RAJAT SAPKAL             Initial version
-- 07/03/23		Rajat Sapkal		 	 Type change - added 0 as visit
-- 12/25/23		Shraddha Sejpal			 Added State
--*****************************************************************************************************************************

	
INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_PARTNER_CONTRACT_SERVICE
WITH state AS (
SELECT DISTINCT  sc.svcc_id,COALESCE(MAPPING.OFFICE_STATE, BRANCH.BR_STATEORPROVINCE, ''IN'') AS ss
FROM  DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
left join DISC_${var.SF_ENVIRONMENT}.matrixcare.STVHC_T_SERVICECODE sc on sc.svcc_id = SCH_SERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES AS BRANCH ON BRANCH.BR_ID = SCH.SCH_BRANCHID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}."STAGE".MATRIXCARE_OFFICE_MAPPING AS MAPPING 
		ON MAPPING.BR_ID = BRANCH.BR_ID
)
,PAYER_SERVICES AS (
	SELECT DISTINCT FINAL_LIST.PAYERID, FINAL_LIST.SERVICECODEID, 
		IFF(MAX(FINAL_LIST.UNITFLAG_RANK) OVER (PARTITION BY FINAL_LIST.PAYERID, FINAL_LIST.SERVICECODEID) = 1, FIRST_VALUE(FINAL_LIST.UNITFLAG) OVER (PARTITION BY FINAL_LIST.PAYERID, FINAL_LIST.SERVICECODEID ORDER BY 1), NULL) AS UNITFLAG, -- Take the UnitFlag only if there is one unique value for all payer + service combinations
		IFF(MAX(FINAL_LIST.SERVICECODE_RANK) OVER (PARTITION BY FINAL_LIST.PAYERID) = 1, TRUE, FALSE) AS HAS_SINGLE_SERVICE_CODE,
		MAX(FINAL_LIST.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY FINAL_LIST.PAYERID, FINAL_LIST.SERVICECODEID) AS ETL_LAST_UPDATED_DATE
	FROM (
		SELECT DISTINCT LIST.PAYERID, LIST.SERVICECODEID, LIST.UNITFLAG,
			DENSE_RANK() OVER (PARTITION BY LIST.PAYERID, LIST.SERVICECODEID ORDER BY LIST.UNITFLAG) AS UNITFLAG_RANK,
			DENSE_RANK() OVER (PARTITION BY LIST.PAYERID ORDER BY LIST.SERVICECODEID) AS SERVICECODE_RANK, -- Used to determine if there are multiple services
			MAX(LIST.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY LIST.PAYERID, LIST.SERVICECODEID) AS ETL_LAST_UPDATED_DATE
		FROM (
			-- PayerServices setup
			SELECT PAYERSERVICES.PAYSVC_PAYERID AS PAYERID, 
				PAYERSERVICES.PAYSVC_SERVICECODEID AS SERVICECODEID,
				NULLIF(PAYERSERVICES.PAYSVC_DEFAULTBILLRATEUNITFLAG, 0) AS UNITFLAG,
				NVL(MAX(PAYERSERVICES.ETL_LAST_UPDATED_DATE), ''1/1/1900'') AS ETL_LAST_UPDATED_DATE
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERSERVICES AS PAYERSERVICES
			GROUP BY PAYERSERVICES.PAYSVC_PAYERID, PAYERSERVICES.PAYSVC_SERVICECODEID, NULLIF(PAYERSERVICES.PAYSVC_DEFAULTBILLRATEUNITFLAG, 0)
			UNION
			-- Schedules: This logic is coming from MatrixCare_Fact_Visit
			SELECT COALESCE(
					SCHEDULEPAYERS.SCHCP_PAYERID, 
					CLIENTPAYERS.CLIPAY_PAYERID, 
					INVOICEDETAILS.INVD_PAYERID,
					AUTHORIZATIONS.AUTH_PAYERID,
					PAYERBRANCHES.PAYBR_PAYERID) AS PAYERID,
				SCHEDULES.SCH_SERVICECODEID AS SERVICECODEID,
				NULLIF(SCHEDULES.SCH_BILLRATEUNITFLAG, 0) AS UNITFLAG,
				GREATEST(
					NVL(MAX(SCHEDULES.ETL_LAST_UPDATED_DATE), ''1/1/1900''), 
					NVL(MAX(CLIENTPAYERS.ETL_LAST_UPDATED_DATE), ''1/1/1900''),
					NVL(MAX(INVOICEDETAILS.ETL_LAST_UPDATED_DATE), ''1/1/1900''),
					NVL(MAX(AUTHORIZATIONS.ETL_LAST_UPDATED_DATE), ''1/1/1900''),
					NVL(MAX(PAYERBRANCHES.ETL_LAST_UPDATED_DATE), ''1/1/1900'')) AS ETL_LAST_UPDATED_DATE
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCHEDULES
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULEPAYERS AS SCHEDULEPAYERS
				ON SCHEDULEPAYERS.SCHCP_SCHEDULEID = SCHEDULES.SCH_ID
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPAYERS AS CLIENTPAYERS
				ON SCHEDULEPAYERS.SCHCP_ID IS NULL 
					AND CLIENTPAYERS.CLIPAY_CLIENTID = SCHEDULES.SCH_CLIENTID 
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICEDETAILS
				ON SCHEDULEPAYERS.SCHCP_ID IS NULL 
					AND CLIENTPAYERS.CLIPAY_ID IS NULL
					AND INVOICEDETAILS.INVD_SCHEDULEID = SCHEDULES.SCH_ID
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION AS AUTHORIZATIONS
				ON SCHEDULEPAYERS.SCHCP_ID IS NULL 
					AND CLIENTPAYERS.CLIPAY_ID IS NULL 
					AND INVOICEDETAILS.INVD_ID IS NULL
					AND AUTHORIZATIONS.AUTH_ADMISSIONID = SCHEDULES.SCH_ADMISSIONID 
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERBRANCHES AS PAYERBRANCHES
				ON SCHEDULEPAYERS.SCHCP_ID IS NULL 
					AND CLIENTPAYERS.CLIPAY_ID IS NULL 
					AND INVOICEDETAILS.INVD_ID IS NULL 
					AND AUTHORIZATIONS.AUTH_ID IS NULL
					AND PAYERBRANCHES.PAYBR_BRANCH_ID = SCHEDULES.SCH_BRANCHID 
			GROUP BY 1, 2, 3
			UNION
			-- Invoices
			SELECT INVOICEHEADER.INVH_PAYERID AS PAYERID, 
				INVOICEDETAILS.INVD_SERVICECODEID AS SERVICECODEID,
				NULLIF(INVOICEDETAILS.INVD_CHARGEUNITFLAG, 0) AS UNITFLAG,
				GREATEST(NVL(MAX(INVOICEHEADER.ETL_LAST_UPDATED_DATE), ''1/1/1900''), NVL(MAX(INVOICEDETAILS.ETL_LAST_UPDATED_DATE), ''1/1/1900'')) AS ETL_LAST_UPDATED_DATE		
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICEHEADER
			JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICEDETAILS
				ON INVOICEDETAILS.INVD_INVHID = INVOICEHEADER.INVH_ID
			GROUP BY INVOICEHEADER.INVH_PAYERID, INVOICEDETAILS.INVD_SERVICECODEID, NULLIF(INVOICEDETAILS.INVD_CHARGEUNITFLAG, 0)
			UNION 
			-- Authorizations
			SELECT AUTHORIZATIONS.AUTH_PAYERID AS PAYERID, 
				AUTHORIZATIONS.AUTH_SERVICECODEID AS SERVICECODEID,
				NULLIF(AUTHORIZATIONS.AUTH_UNITFLAG, 0) AS UNITFLAG,
				NVL(MAX(AUTHORIZATIONS.ETL_LAST_UPDATED_DATE), ''1/1/1900'') AS ETL_LAST_UPDATED_DATE				
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_AUTHORIZATION AS AUTHORIZATIONS
			GROUP BY AUTHORIZATIONS.AUTH_PAYERID, AUTHORIZATIONS.AUTH_SERVICECODEID, NULLIF(AUTHORIZATIONS.AUTH_UNITFLAG, 0)
		) AS LIST
	) AS FINAL_LIST
) 
SELECT DISTINCT
MD5(
        ''MATRIXCARE'' || ''-'' ||COALESCE(s.ss,b.BR_STATEORPROVINCE) || ''-'' ||
        NVL(P.PAY_ID,-1) || ''-'' ||
        NVL(PAYER_SERVICES.SERVICECODEID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                      as partner_contract_service_key,
  ''7''                                                                                                    AS SOURCE_SYSTEM_ID,
  ''MATRIXCARE''                                                                                           AS SYSTEM_CODE,
  COALESCE(s.ss,b.BR_STATEORPROVINCE) AS STATE, 
  MD5(
        ''MATRIXCARE'' || ''-'' || COALESCE(s.ss,b.BR_STATEORPROVINCE) || ''-'' ||
        NVL(P.PAY_ID,-1) || ''-'' ||
        ''MATRIXCARE''
    )                                                                                                       
    as partner_contract_key, 
 NVL(P.PAY_ID,-1) AS PARTNER_CODE,
 IFNULL(P.PAY_NAME,''UNKNOWN'') AS PARTNER_NAME,
 NVL(P.PAY_ID,-1) AS CONTRACT_CODE,
 IFNULL(P.PAY_NAME,''UNKNOWN'') AS CONTRACT_NAME,
 MD5(''MATRIXCARE'' || ''-'' || SC.SVCC_ID || ''-'' || ''MATRIXCARE'') AS SERVICE_KEY,
 PAYER_SERVICES.SERVICECODEID::varchar AS SERVICE_CODE,
 SC.SVCC_NAME AS SERVICE_NAME,
 MD5(''MATRIXCARE'' || ''-'' || SC.SVCC_id || ''-'' || ''MATRIXCARE'') AS BILLING_KEY,
 PAYER_SERVICES.SERVICECODEID::varchar AS BILL_CODE,
 SC.SVCC_NAME AS BILL_NAME,
CASE WHEN sc.SVCC_REVENUECODE IN (''0'',''1'',''2'') THEN TRUE 
		WHEN sc.SVCC_REVENUECODE = ''3'' THEN FALSE END AS BILLABLE_FLAG,
 CASE 
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (0,150) then ''Visit''		---- 0 means visit checked on UI
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (15,30,60) then ''Hourly''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1440 then ''Daily''
        --WHEN sc.SVCC_DEFAULTBILLUNITFLAG IS NOT NULL THEN ''Unknown''
        ELSE ''Unknown''
    END                                                                                                     AS BILL_TYPE,
CASE 
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = -1 then ''Medicare''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (0,150) then ''Visit''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1 then ''Minute''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 15 then ''15 Min''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 30 then ''30 Min''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 60 then ''Hourly''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1440 then ''Daily''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IS NOT NULL THEN ''Unknown''
        ELSE NULL
    END 																									AS BILL_UOM,
CASE 
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (0,150) then ''Visit''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (15,30,60) then ''Hourly''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1440 then ''Daily''
        --WHEN sc.SVCC_DEFAULTBILLUNITFLAG IS NOT NULL THEN ''Unknown''
        ELSE ''Unknown''
    END                                                                                                     AS schedule_type,
CASE 
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = -1 then ''Medicare''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IN (0,150) then ''Visit''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1 then ''Minute''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 15 then ''15 Min''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 30 then ''30 Min''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 60 then ''Hourly''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG = 1440 then ''Daily''
        WHEN sc.SVCC_DEFAULTBILLUNITFLAG IS NOT NULL THEN ''Unknown''
        ELSE NULL
    END 																									AS schedule_uom, 
TRUE 																										AS AUTHORIZATION_REQUIRED_FLAG,
  SERVICE_MAPPING.PAYABLE_FLAG AS PAYABLE_FLAG,
FALSE AS EXPENSE_FLAG, --Remaining
 SERVICE_MAPPING.MILEAGE_FLAG AS MILEAGE_FLAG
		,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
		,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
        ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
		,CURRENT_USER as ETL_INSERTED_BY 
		,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
		,CURRENT_USER as ETL_LAST_UPDATED_BY
		,0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERS p 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES b ON b.BR_ID = p.PAY_BRANCHID
LEFT JOIN PAYER_SERVICES AS PAYER_SERVICES
		ON PAYER_SERVICES.PAYERID = p.PAY_ID
LEFT JOIN state s ON PAYER_SERVICES.SERVICECODEID = s.svcc_id
--LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERSERVICES PS ON P.PAY_ID =PS.PAYSVC_PAYERID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE sc ON PAYER_SERVICES.SERVICECODEID=SC.SVCC_ID 
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}."STAGE".MATRIXCARE_SERVICE_REVENUE_CATEGORY_MAPPING AS SERVICE_MAPPING
		ON SERVICE_MAPPING.SVCC_ID = PAYER_SERVICES.SERVICECODEID;
	RETURN ''SUCCESS'';
end;

 EOT
}

