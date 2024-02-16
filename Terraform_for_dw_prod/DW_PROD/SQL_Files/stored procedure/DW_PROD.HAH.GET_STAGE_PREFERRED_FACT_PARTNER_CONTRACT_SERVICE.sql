CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_PREFERRED_FACT_PARTNER_CONTRACT_SERVICE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  PREFERRED FACT PARTNER CONTRACT SERVICE
--
-- PURPOSE: Populates Stage PREFERRED FACT FACT PARTNER CONTRACT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/21/23     Pankti Fadia          Initial version
-- 06/28/23     NUTAN JAGNADE         LOGIC CHANGE SERVICE_KEY
-- 12/25/23		Shraddha Sejpal		  Added State	
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_PARTNER_CONTRACT_SERVICE

WITH CLIENT AS(
	SELECT * FROM(SELECT PATIENTID,MASTER_ID,AGENCYID,LASTNAME,FIRSTNAME,OFFICEID--,ADMISSIONID --,OFFICEID
					FROM DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST)
	UNION
	SELECT * FROM(SELECT DISTINCT PATIENTID,MASTER_ID,AGENCYID,LASTNAME,FIRSTNAME,OFFICEID--,ADMISSIONID --,OFFICEID
					FROM DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MATCH_LIST WHERE PATIENTID NOT IN (
				  SELECT PATIENTID FROM	DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST) ))
	SELECT
		DISTINCT MD5(
		''PREFERRED'' || ''-'' || 
		ifnull(S.AGENCYID,-1) || ''-'' ||
		ifnull(PR.PAYERID, -1) || ''-'' ||
		IFNULL(S.CONTRACTID, -1) || ''-'' ||
		IFNULL(S.SERVICECODEID, -1) || ''-'' ||
		IFNULL(RS.REVENUE_SUBCATEGORY_CODE, ''1'') || ''-'' ||
		IFNULL(S.VISITTYPE, ''-1'') || ''-'' ||
		IFNULL(S.RATETYPETEXT, ''-1'') || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_SERVICE_KEY,
		''17'' AS SOURCE_SYSTEM_ID,
		''PREFERRED'' AS SYSTEM_CODE,
		''NY'' AS STATE,
        MD5(''PREFERRED'' || ''-'' ||  COALESCE(PR.PAYERID,S.CONTRACTID,-1) || ''-'' || COALESCE(PR.CONTRACTID,PR.PAYERID,S.CONTRACTID,-1) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_KEY,
		COALESCE(PR.PAYERID,PR.CONTRACTID,S.CONTRACTID,-1) AS PARTNER_CODE,
		COALESCE(PR.PAYERNAME,S.CONTRACTNAME,''UNKNOWN'') AS PARTNER_NAME,
		COALESCE(PR.CONTRACTID,S.CONTRACTID,-1) AS CONTRACT_CODE,
		COALESCE(PR.PAYERNAME,S.CONTRACTNAME,''UNKNOWN'') AS CONTRACT_NAME,
		--MD5(''PREFERRED'' || ''-'' || S.SERVICECODEID || ''-'' || ''HHAEXCHANGE'') AS SERVICE_KEY,
        MD5(''PREFERRED'' || ''-'' || S.SERVICECODEID || ''-'' ||NVL(RS.REVENUE_SUBCATEGORY_CODE,''-1'')|| ''-'' || ''HHAEXCHANGE'')  AS SERVICE_KEY,
		S.SERVICECODEID AS SERVICECODE,
		S.SERVICECODE AS SERVICENAME,
		MD5(''PREFERRED'' || ''-'' || S.SERVICECODEID || ''-'' || NULLIF(RS.REVENUE_SUBCATEGORY_CODE,''-1'') || ''-'' || ''HHAEXCHANGE'') AS BILLING_KEY,
		S.SERVICECODE AS BILLING_CODE,
		S.CONTRACTNAME AS BILL_NAME,
		IFF(UPPER(S.SERVICECODE) LIKE ''%BILLABLE%'',0,1) AS BILLABLE_FLAG,
		COALESCE(S.RATETYPETEXT,''Hourly'') AS BILL_TYPE,
		IFF(BILL_TYPE=''Hourly'',CASE
			WHEN CR.UNITS = 1 THEN ''Hourly''
			WHEN CR.UNITS = 2 THEN ''Half Hours''
			WHEN CR.UNITS = 4 THEN ''Quarter Hours''
			ELSE NULL
		END,NULL) AS BILL_UOM,
		COALESCE(S.RATETYPETEXT,''Hourly'') AS SCHEDULE_TYPE,
		S.RATETYPETEXT AS SCHEDULE_UOM,
		TRUE AS AUTHORIZATION_REQUIRED_FLAG,
		--Remaining
		TRUE AS PAYABLE_FLAG,                        --Remaining
		FALSE AS EXPENSE_FLAG,                      --Remaining
		IFF(UPPER(VI.INCLUDEMILEAGEEXPENSE :: BOOLEAN) IS NULL,UPPER(FALSE :: BOOLEAN),UPPER(VI.INCLUDEMILEAGEEXPENSE :: BOOLEAN)) AS MILEAGE_FLAG,                       --Remaining
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES S
--LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA 
--    ON S.CONTRACTID = PA.CONTRACTID
--	AND S.SERVICECODEID = PA.SERVICECODEID
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.CONTRACTS C 
	ON S.CONTRACTID = C.CONTRACTID
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PAYER_REPL PR 
	ON IFNULL(PR.CONTRACTID, PR.PAYERID) = S.CONTRACTID
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.CONTRACTRATES CR 
	ON s.SERVICECODEID = CR.SERVICECODEID
	AND CR.AGENCYID = S.AGENCYID
	AND CR.SERVICECODEID = S.SERVICECODEID
	AND CR.TODATE :: DATE > GETDATE()
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.VisitInfo_REPL VI 
	ON S.SERVICECODEID = VI.PRIMARYSERVICECODEID
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.VISITAUTHORIZATIONS_REPL VA 
	ON VA.VISITID = VI.VISITID 
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
	ON PA.AUTHORIZATIONID = VA.AUTHORIZATIONID 
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.REVENUE_MAPPING RS ON
	RS.SERVICECODEID = S.SERVICECODEID;

RETURN ''SUCCESS'';
end;
';