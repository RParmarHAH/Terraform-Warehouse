resource "snowflake_procedure" "DW_HAH_FACT_VISIT_CONTRACT_UPDATE_POSTPROCESSING" {
	name ="FACT_VISIT_CONTRACT_UPDATE_POSTPROCESSING"
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
	RETURN_RESULT VARCHAR (1000);
	MAX_DATE date;
BEGIN

--*****************************************************************************************************************************
-- NAME:  FACT_VISIT_CONTRACT_UPDATE_POSTPROCESSING
--
-- PURPOSE: Update SandataImport CONTRACT_KEY, PARTNER_CONTRACT_SERVICE_KEY, CONTRACT_CODE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR						NOTES:
-- ----------	-------------------			---------------------------------------------------------------------------------------
-- 26/09/2023	Deepen Gajjar				Initial Development
--*****************************************************************************************************************************

SELECT MAX(CDC_MIN_DATE)::date into MAX_DATE FROM ETL_MANAGEMENT_${var.SF_ENVIRONMENT}.AUDIT.ETL_TASK_DETAILS WHERE PRIMARY_SOURCE_TABLE_NAME=''SANDATAIMPORT_FACT_VISIT'';

UPDATE DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT A
SET A.CONTRACT_KEY = B.CONTRACT_KEY, A.PARTNER_CONTRACT_SERVICE_KEY = B.PARTNER_CONTRACT_SERVICE_KEY, A.CONTRACT_CODE = B.CONTRACT_CODE
FROM (
	WITH UNIT_TYPE AS (
		SELECT * FROM (SELECT row_number() OVER (PARTITION BY SCHEDULEID ORDER BY rate desc) rn,AGENCYID ,SCHEDULEID, 
		CASE UNITTYPE WHEN ''01'' THEN ''Hourly'' WHEN ''02'' THEN ''Visit'' WHEN ''05'' THEN ''Hourly'' WHEN ''06'' THEN ''Per Diem'' 
			else NULL END AS UNITTYPE  
		from DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_SCHEDULESCLIENTS 
		WHERE AGENCYID =''8485'' AND RATE NOT IN (0.00, 0.01) AND (UNITTYPE IS NOT NULL OR UNITTYPE <>'''')) WHERE rn=1 
		)
		SELECT 
		DISTINCT CASE WHEN  SV.SERVICEID IN (''CARECO'',''VBPCG'')	
				THEN MD5(''CC_''||SV.AGENCYID || ''-'' || SV.SCHEDULEID || ''-'' || ''SANDATAIMPORT'') 
				ELSE MD5(SV.AGENCYID || ''-'' || SV.SCHEDULEID || ''-'' || ''SANDATAIMPORT'') 
				END AS VISIT_KEY,
		CASE WHEN  SV.SERVICEID IN (''CARECO'',''VBPCG'')
				THEN MD5(NVL(''CC_''||SV.AGENCYID, ''S'') || ''-'' || SV.ADMISSIONTYPE || ''-'' || ''SANDATAIMPORT'')
			ELSE MD5(NVL(SV.AGENCYID, ''S'') || ''-'' || SV.ADMISSIONTYPE || ''-'' || ''SANDATAIMPORT'') END AS CONTRACT_KEY,
		CASE WHEN  SV.SERVICEID IN (''CARECO'',''VBPCG'')
			THEN MD5(
		            ''CC_''||IFNULL(SV.AGENCYID,-1) || ''-'' ||
		            IFNULL(P.PAYORID,-1) || ''-'' ||
		            IFNULL(SV.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' ||
		            IFNULL(NULLIF(SV.SERVICEID,'''') , ''UNKNOWN'') || ''-'' ||
				  COALESCE(U.UNITTYPE, ''UNKNOWN'') || ''-'' ||
		            ''SANDATAIMPORT''
			)
			ELSE MD5(
		            IFNULL(SV.AGENCYID,-1) || ''-'' ||
		            IFNULL(P.PAYORID,-1) || ''-'' ||
		            IFNULL(SV.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' ||
		            IFNULL(NULLIF(SV.SERVICEID,'''') , ''UNKNOWN'') || ''-'' ||
				  COALESCE(U.UNITTYPE, ''UNKNOWN'') || ''-'' ||
		            ''SANDATAIMPORT''
			) END AS PARTNER_CONTRACT_SERVICE_KEY,
		SV.ADMISSIONTYPE AS CONTRACT_CODE
		FROM DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.SANDATAVISITS SV
		JOIN DW_${var.SF_ENVIRONMENT}."STAGE".SANDATAIMPORT_FACT_VISIT SFV ON VISIT_KEY = SFV.VISIT_KEY
		LEFT JOIN UNIT_TYPE U ON SV.AGENCYID= U.AGENCYID AND SV.SCHEDULEID = U.SCHEDULEID
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_PAYORS P ON P."NAME" = SV.PAYORNAME AND P.AGENCYID =8485
		WHERE SV.AGENCYID = ''8485'' AND
		 NVL(SV.STAFFAGENCYID,'''') <> '''' AND SV.CLIENTID IS NOT NULL
			AND NVL(SV.ADMISSIONTYPE, '''') <> '''' AND LEN(NVL(SV.STATUS,'''')) <= 2 -- Exclude (7) bad data records
			AND SV.ETL_LAST_UPDATED_DATE >= :MAX_DATE::timestamp_ntz
) B 
WHERE A.VISIT_KEY = B.VISIT_KEY ;

SELECT CONCAT (''MESSAGE : '',"number of rows updated",'' Rows Updated. '',''START_DATE : '',:MAX_DATE::timestamp_ntz) into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

	RETURN return_result;
END ;

 EOT
}

