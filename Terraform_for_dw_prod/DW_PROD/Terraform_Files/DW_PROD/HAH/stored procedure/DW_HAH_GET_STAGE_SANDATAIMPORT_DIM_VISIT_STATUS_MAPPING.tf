resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_VISIT_STATUS_MAPPING" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_VISIT_STATUS_MAPPING"
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
-- NAME:  SANDATAIMPORT_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per status
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/13/22     Shraddha Sejpal      Initial Development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.sandataimport_DIM_VISIT_STATUS_MAPPING
WITH CTE AS (
SELECT AGENCYID,SCHEDULEID, 
   CASE WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NULL AND SV.SCHEDULEDATE > CURRENT_DATE() THEN ''01OPENFUTURE'' 
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NOT NULL AND SV.SCHEDULEDATE > CURRENT_DATE() THEN ''01FUTURE''
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NULL AND SV.SCHEDULEDATE <= CURRENT_DATE() THEN ''01OPEN'' 
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NOT NULL AND SV.SCHEDULEDATE <= CURRENT_DATE() THEN ''01'' 
		ELSE SV.STATUS END
		AS DERIVED_DISC_STATUS FROM DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.SANDATAVISITS SV
		WHERE AGENCYID =''8485''
)
SELECT DISTINCT
	md5(4 ||''-''||''8485''||''-''||nvl(CTE.DERIVED_DISC_STATUS,''S'')) AS VISIT_STATUS_KEY,
	4 AS SOURCE_SYSTEM_ID,
	''8485'' AS SYSTEM_CODE,
	CTE.DERIVED_DISC_STATUS,
	NULL AS DISC_SCHEDULE_STATUS,
	SV.STATUS AS DISC_VISIT_STATUS,
	NULL AS DISC_INVOICE_STATUS,
	NULL AS DISC_PAYROLL_STATUS,
	CASE 
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NULL THEN ''s02'' 
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NOT NULL THEN ''s01''
		WHEN SV.STATUS =''10'' THEN ''s05'' END AS SCHEDULE_STATUS_CODE, 
	CASE  
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NULL THEN ''Scheduled-Open'' 
		WHEN SV.STATUS =''01'' AND SV.STAFFAGENCYID IS NOT NULL THEN ''Scheduled''
		WHEN SV.STATUS =''10'' THEN ''Cancelled'' END AS SCHEDULE_STATUS_NAME,
	CASE SV.STATUS 
		WHEN ''01'' THEN ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
		WHEN ''10'' THEN ''A visit has been cancelled and is no longer taking place (can be set back to confirmed, hold or pending)'' END AS SCHEDULE_STATUS_DESCRIPTION,
	CASE  
		WHEN SV.STATUS= ''01'' AND SV.SCHEDULEDATE > CURRENT_DATE() THEN ''v01''
        WHEN SV.STATUS= ''02'' THEN ''v04''
        WHEN SV.STATUS= ''03'' THEN ''v04''
        WHEN SV.STATUS= ''09'' THEN ''v02''
        WHEN SV.STATUS= ''10'' THEN ''v03''
        WHEN SV.STATUS= ''04'' THEN ''v04'' ELSE NULL
        END AS VISIT_STATUS_CODE, ---added generalized status codes FOR ALL SOURCE systems.
	CASE  
	    WHEN SV.STATUS= ''01'' AND SV.SCHEDULEDATE > CURRENT_DATE() THEN ''Future''
        WHEN SV.STATUS= ''02'' THEN ''Completed''
        WHEN SV.STATUS= ''03'' THEN ''Completed''
        WHEN SV.STATUS= ''09'' THEN ''In Review''
        WHEN SV.STATUS= ''10'' THEN ''Did not happen''
        WHEN SV.STATUS= ''04'' THEN ''Completed'' ELSE NULL
        END AS VISIT_STATUS_NAME,
	CASE 
	 	WHEN SV.STATUS= ''01'' AND SV.SCHEDULEDATE > CURRENT_DATE() THEN ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
        WHEN SV.STATUS= ''02'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)''
        WHEN SV.STATUS= ''03'' THEN ''The visit has been submitted for payroll (time keep extracted) and waiting to be billed''
        WHEN SV.STATUS= ''09'' THEN ''A visit has an exception or missing a call and needs to be manually confirmed (can go to confirmed, pending or cancelled) (once a exception is put on a visit via the system, it moves from pending to hold)''
        WHEN SV.STATUS= ''10'' THEN ''A visit has been cancelled and is no longer taking place (can be set back to confirmed, hold or pending)''
        WHEN SV.STATUS= ''04'' THEN ''The visit was confirmed that it happened and billed'' ELSE NULL
        END AS VISIT_STATUS_DESCRIPTION,
    CASE SV.STATUS
		WHEN ''02'' THEN ''i02'' 
		WHEN ''03'' THEN ''i02''
		WHEN ''04'' THEN ''i03'' ELSE NULL
		END AS INVOICE_STATUS_CODE,
	CASE SV.STATUS
		WHEN ''02'' THEN ''Unbilled''
		WHEN ''03'' THEN ''Unbilled''
		WHEN ''04'' THEN ''Billed'' ELSE NULL
		END AS INVOICE_STATUS_NAME,
	CASE SV.STATUS
		WHEN ''02'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)''
		WHEN ''03'' THEN ''The visit has been submitted for payroll (time keep extracted) and waiting to be billed''
		WHEN ''04'' THEN ''The visit was confirmed that it happened and billed'' ELSE NULL
		END AS INVOICE_STATUS_DESCRIPTION,
	CASE SV.STATUS
		WHEN ''02'' THEN ''p02'' ELSE NULL END
		 AS PAYROLL_STATUS_CODE,
	CASE SV.STATUS
		WHEN ''02'' THEN ''Unpaid'' ELSE NULL END
		 AS PAYROLL_STATUS_NAME,
	CASE SV.STATUS 
		WHEN ''02'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)'' ELSE NULL END AS PAYROLL_STATUS_DESCRIPTION,
	CASE WHEN SV.STATUS IN (''02'',''03'',''04'') THEN ''YES''
		 WHEN SV.STATUS IN (''01'',''09'',''10'')  OR SV.STATUS IS NULL THEN ''NO'' 
		 ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG,
	NULL AS CONSISTENT_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.SANDATAVISITS SV
	LEFT JOIN CTE ON SV.AGENCYID= CTE.AGENCYID AND SV.SCHEDULEID= CTE.SCHEDULEID
	WHERE SV.AGENCYID =''8485'';
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

