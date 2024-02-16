CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALLIANCE_DIM_PARTNER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALLIANCE_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to ALLIANCE 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/11/23     Shraddha Sejpal      Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_PARTNER
--WITH PRIVATE_PAY_PAYERS AS 
--(
--SELECT CASE WHEN (CONTAINS(UPPER(P.BADDRESS1), C.FIRSTNAME) AND CONTAINS(UPPER(P.BADDRESS1), C.LASTNAME)) 
--			OR ( CONTAINS(UPPER(C.LASTNAME), REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\\\\\\\\\S+$''))
--					OR CONTAINS(REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\\\\\\\\\S+$''), UPPER(C.LASTNAME))
--			   ) 
--			OR CT.NAME = ''Private Pay''
--			OR P.PAYORID IS NULL THEN TRUE ELSE FALSE END IS_PRIAVATE_PAY,P.PAYORID 
--FROM DISC_PROD.GENERATIONSALLIANCE.SCHEDULES SCH
--	INNER JOIN DISC_PROD.GENERATIONSALLIANCE.SERVICES SR
--	    ON SR.SERVICECODE  = SCH.SERVICECODE
--   	LEFT JOIN  DISC_PROD.GENERATIONSALLIANCE.CLIENT C 
--	    ON C.CLIENTID = SCH.CLIENTID 
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTPAYORS CPY
--	    ON SCH.CLIENTID = CPY.CLIENTID
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.PAYOR P
--	    ON P.PAYORID = CPY.PAYORID
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTTYPE CT 
--	    ON CT.CLIENTTYPEID = C.CLIENTTYPEID
--	WHERE C.CLIENTID NOT IN (SELECT CLIENT_NUMBER FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_CLIENT_NUMBER WHERE SOURCE_SYSTEM_ID = 19 AND SYSTEM_CODE = ''GENERATIONS'')
--			AND SCH."DATE"::DATE <= ''2022-09-30''::DATE
--UNION
--	SELECT DISTINCT CASE WHEN (CONTAINS(UPPER(P.BADDRESS1), C.FIRSTNAME) AND CONTAINS(UPPER(P.BADDRESS1), C.LASTNAME)) 
--							OR (
--									CONTAINS(UPPER(C.LASTNAME), REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\S+$''))
--									OR CONTAINS(REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\S+$''), UPPER(C.LASTNAME)
--									)
--							) OR CT.NAME = ''Private Pay''
--							  OR P.PAYORID IS NULL
--							THEN TRUE
--					 ELSE FALSE 
--				END IS_PRIAVATE_PAY,P.PAYORID 
--FROM DISC_PROD.GENERATIONSALLIANCE.SERVICEREQUEST SRE
--	INNER JOIN DISC_PROD.GENERATIONSALLIANCE.SERVICES SR
--	    ON SR.SERVICECODE  = SRE.SERVICECODE
--	INNER JOIN  DISC_PROD.GENERATIONSALLIANCE.CLIENT C 
--	    ON C.CLIENTID = SRE.CLIENTID 
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTPAYORS CPY
--		ON CPY.CLIENTID = SRE.CLIENTID
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.PAYOR P
--	    ON P.PAYORID = CPY.PAYORID
--	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTTYPE CT 
--	    ON CT.CLIENTTYPEID = C.CLIENTTYPEID
--	WHERE C.CLIENTID NOT IN (SELECT CLIENT_NUMBER FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_CLIENT_NUMBER WHERE SOURCE_SYSTEM_ID = 19 AND SYSTEM_CODE = ''GENERATIONS'')
--	QUALIFY DENSE_RANK() OVER(PARTITION BY SRE.SERVICEREQUESTID, CPY.CLIENTID 
--					  	 ORDER BY IFF(NVL(SRE.PAYORID, 0) = CPY.PAYORID, 2, NVL(CPY.ISPRIMARY, 0)::INT) DESC
--						  		, IFF(NVL(SRE.PAYORID, 0) = CPY.PAYORID, 2, NVL(CPY.CURRENTPAYOR, 0)::INT) DESC) = 1
--), PRIVATE_PAY_PAYERS_UNIQUE AS (
--	SELECT DISTINCT PAYORID ,IS_PRIAVATE_PAY FROM PRIVATE_PAY_PAYERS 
--	QUALIFY COUNT(DISTINCT IS_PRIAVATE_PAY) OVER (PARTITION BY PAYORID)=1
--)
SELECT DISTINCT --MD5(''ALLIANCE'' || ''-'' || CASE WHEN IS_PRIAVATE_PAY =TRUE THEN ''PRIVATE PAY'' ELSE P.PAYORID::VARCHAR END ||  ''-'' || ''ALLIANCE'') AS PARTNER_KEY
MD5(''ALLIANCE'' || ''-'' || P.PAYORID ||  ''-'' || ''GENERATIONS'') AS PARTNER_KEY
	, NULL AS PARENT_PARTNER_KEY
    , ''UNKNOWN'' AS PARENT_PARTNER_NAME
	, 19 AS SOURCE_SYSTEM_ID
	, ''ALLIANCE'' AS SYSTEM_CODE,
	-- P.PAYORID
	--, CASE WHEN IS_PRIAVATE_PAY =TRUE THEN ''PRIVATE PAY'' ELSE P.PAYORID::VARCHAR END AS PARTNER_CODE
	P.PAYORID AS PARTNER_CODE
	--, CASE WHEN IS_PRIAVATE_PAY =TRUE THEN ''PRIVATE PAY'' ELSE P.BADDRESS1 END AS PARTNER_NAME
	,P.BADDRESS1 AS PARTNER_NAME
	, NULL AS PARTNER_TYPE_CODE
	, NULL AS PARTNER_TYPE_NAME
	, TRUE AS ACTIVE_FLAG 
	, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE   
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.GENERATIONSALLIANCE.PAYOR P;
--LEFT JOIN PRIVATE_PAY_PAYERS_UNIQUE PU ON P.PAYORID= PU.PAYORID;
return ''SUCCESS'';
END;
';