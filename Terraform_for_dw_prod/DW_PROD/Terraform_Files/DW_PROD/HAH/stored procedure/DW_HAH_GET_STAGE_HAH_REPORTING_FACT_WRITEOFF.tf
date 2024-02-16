resource "snowflake_procedure" "DW_HAH_GET_STAGE_HAH_REPORTING_FACT_WRITEOFF" {
	name ="GET_STAGE_HAH_REPORTING_FACT_WRITEOFF"
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
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --*****************************************************************************************************************************
-- NAME:  HAH Reporting Fact Writeoff
--
-- PURPOSE: Creates one row per invoice detail by day according to SandataImport
--
-- NOTE: Still need to do Unit testing
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/25/20     Greg Marsh         	 Initial dev
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 04/16/20		Mohd Kamaludin		 Updated with a group by for amount and added additional fields for key
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.HAH_REPORTING_FACT_WRITEOFF
SELECT
    md5(NVL(f.PERIOD::string, '''') || ''-'' || NVL(off.OFFICENAME::string, ''Unknown'') || ''-'' || NVL(f.CLIENTNUMBER::string, '''') || ''-''
		|| NVL(f.CONTRACTCODE, ''Unknown'') || ''-'' || NVL(f.ADDITIONALITEM::string, ''Unknown'') || ''-''
		|| NVL(f.PAYDATE::string, '''')  || ''-'' || NVL(f.DFDB,'''')) AS WRITEOFF_KEY,
    f.PERIODDATE AS REPORT_DATE,  --BK
    COALESCE(b2.BRANCH_KEY,md5(F.DFDB || ''-'' || nvl(off.OFFICENAME,''Unknown'') || ''-'' ||  ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY,
    nvl(c2.CLIENT_KEY, md5(f.DFDB || ''-'' || nvl(f.CLIENTNUMBER,-1) || ''-''  ||  ''DATAFLEXSYNCDATA'' )) AS CLIENT_KEY,
    nvl(n2.CONTRACT_KEY, md5(f.DFDB || ''-'' || nvl(f.CONTRACTCODE,''Unknown'') || ''-''  ||  ''DATAFLEXSYNCDATA'')) AS CONTRACT_KEY,
    3 AS SOURCE_SYSTEM_ID, --treating as DF source
    f.PERIODDATE AS PERIOD_DATE,
    f.PAYDATE AS WRITEOFF_DATE,
    off.OFFICENAME AS BRANCH_NAME,
    f.CLIENTNUMBER AS CLIENT_NUMBER, --BK
	f.CONTRACTCODE AS CONTRACT_CODE,  --BK
    f.DFDB AS SYSTEM_CODE, --BK
    f.SERVICEAREA AS SERVICE_AREA,
    f.AMOUNTTYPE AS WRITEOFF_TYPE,
    f.WOREASON AS WRITEOFF_REASON_CODE,
    wo.REASON AS WRITEOFF_REASON_DESCIPTION,
    SUM(CASE WHEN AMOUNTTYPE = ''InvoiceWriteOff'' THEN f.PAIDAMOUNT ELSE 0 END) AS WRITEOFF_AMOUNT,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,  
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HAH_REPORTING.AGING_SUMMARY_AMOUNTDATA f
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HAH_REPORTING.AGING_SUMMARY_OFFICES off
    on f.OFFICENUMBER = off.OFFICENUMBER
    and f.DFDB = off.DFDB
LEFT JOIN (SELECT DISTINCT CODE, REASON FROM DISC_${var.SF_ENVIRONMENT}.HAH_REPORTING.AGING_SUMMARY_WRITEOFFCODES) wo
    on f.WOREASON = wo.CODE
LEFT JOIN (SELECT DISTINCT BRANCH_KEY, OFFICE_NUMBER, SYSTEM_CODE FROM HAH.DIM_BRANCH) b2
ON b2.OFFICE_NUMBER = f.OFFICENUMBER
    AND b2.SYSTEM_CODE = f.DFDB
LEFT JOIN HAH.DIM_CLIENT c2
ON TO_VARCHAR(c2.CLIENT_NUMBER) = TO_VARCHAR(f.CLIENTNUMBER)
    AND c2.SYSTEM_CODE = f.DFDB
LEFT JOIN HAH.DIM_CONTRACT n2
ON n2.CONTRACT_CODE = f.CONTRACTCODE
    AND n2.SYSTEM_CODE = f.DFDB
WHERE  AMOUNTTYPE LIKE ''%WriteOff%''-- limit 100
AND (f.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
	OR off.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16	;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

