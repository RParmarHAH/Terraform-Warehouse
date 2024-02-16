resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_VISIT_STATUS_MAPPING" {
	name ="GET_STAGE_CLEARCARE_DIM_VISIT_STATUS_MAPPING"
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
-- NAME:  		CLEARCARE_DIM_VISIT_STATUS_MAPPING
-- PURPOSE: 	Dim Visit Status Mapping for Clear Care
-- DATE        	AUTHOR              	NOTES:
-- --------------------------------------------------------------------------------------------------------------------------
-- 11/3/22    	Ayshwarya		     	Initial Development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_VISIT_STATUS_MAPPING
WITH DISCSTATUS AS
(SELECT DISTINCT 
 
CASE 
WHEN c.status = 30 AND s.status = 110 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = TRUE THEN ''Completed-OpenSchd''
WHEN c.status = 30 AND s.status = 110 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = FALSE THEN ''Complete-OpenSchd-Unpaid''
WHEN c.status = 30 AND s.status = 110 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = FALSE THEN ''Complete-OpenSchd-Unbilled''
WHEN c.status = 30 AND s.status = 110 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = TRUE THEN ''Complete-OpenSchd-Paid''
WHEN c.status = 30 AND s.status = 10 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = TRUE THEN ''Completed-Schd''
WHEN c.status = 30 AND s.status = 10 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = FALSE THEN ''Completed-Schd-Unpaid''
WHEN c.status = 30 AND s.status = 10 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = FALSE THEN ''Completed-Schd-Unbilled''
WHEN c.status = 30 AND s.status = 10 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = TRUE THEN ''Completed-Schd-Paid''
WHEN c.status IN (50,60,70,40,120,90) AND s.status IN ( 40,50,60,70,120,90,80,20) THEN ''Cancelled''
WHEN c.status IN (50,60,70,40,120,90) AND s.status NOT IN ( 40,50,60,70,120,90,80,20) THEN ''Schd-Cancelled''
WHEN c.status = 30 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = TRUE THEN ''Completed''
WHEN c.status = 30 AND BILL_INVOICED = TRUE AND PAY_FINALIZED = FALSE THEN ''Completed-Unpaid''
WHEN c.status = 30 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = FALSE THEN ''Completed-Unbilled''
WHEN c.status = 30 AND BILL_INVOICED = FALSE AND PAY_FINALIZED = TRUE THEN ''Completed-Paid''END AS Derived_Disc_Status,
CASE WHEN s.status = 10 AND c.status NOT IN ( 40,50,60,70,120,90) THEN ''Scheduled''
WHEN s.status = 110 AND c.status NOT IN ( 40,50,60,70,120,90) THEN ''Open Shift''
WHEN s.status IN ( 40,50,60,70,120,90,80,20)  AND c.status != 30 THEN ''Cancelled''
END AS Disc_Schedule_Status,
CASE WHEN c.status = 30 THEN ''Completed''
WHEN c.status IN ( 40,50,60,70,120,90) THEN ''Cancelled'' END AS Disc_Visit_Status,
CASE WHEN c.status = 30 AND bill_invoiced = TRUE THEN ''Billed'' 
WHEN c.status = 30 AND bill_invoiced = FALSE THEN ''Unbilled'' END AS Disc_Invoice_Status,
CASE WHEN c.status = 30 AND pay_finalized = TRUE THEN ''Paid'' 
WHEN c.status = 30 AND pay_finalized = FALSE THEN ''Unpaid'' END AS Disc_Payroll_Status,
c.id
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.CARELOGS_CARELOG c
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.SCHEDULES_SHIFT s ON s.id = c.SHIFT_ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.RECEIVABLES_INVOICE_CARELOGS  ric ON ric.CARELOG_ID = c.ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.INVOICE_TRANSACTION iv ON iv.id = ric.INVOICE_ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.SCHEDULES_SCHEDULE sc ON sc.id = s.SCHEDULE_ID )
SELECT  DISTINCT MD5(''16'' || ''-'' || ''CLEARCARE'' || ''-'' || NVL(DERIVED_DISC_STATUS,''No Schedule'')) AS VISIT_STATUS_KEY,
''16'',
''CLEARCARE'',
Derived_disc_status,
Disc_Schedule_status,
Disc_Visit_status,
Disc_Invoice_status,
Disc_Payroll_status,
CASE WHEN disc_schedule_status = ''Cancelled'' THEN ''s05''
WHEN disc_schedule_status = ''Open Shift'' THEN ''s02''
WHEN disc_schedule_status = ''Scheduled'' THEN ''s01''
END AS Schedule_Status_Code,
CASE 
WHEN disc_schedule_status = ''Open Shift'' THEN ''Scheduled-Open''
ELSE disc_schedule_status
END AS Schedule_Status_Name,
CASE 
WHEN disc_schedule_status = ''Open Shift'' THEN ''Scheduled-Open''
ELSE disc_schedule_status
END AS Schedule_Status_Description,
CASE WHEN disc_visit_status = ''Cancelled'' THEN ''v03''
ELSE ''v04''END AS Visit_Status_Code,
CASE WHEN disc_visit_status = ''Cancelled'' THEN ''Did not happen''
WHEN disc_visit_status = ''Completed'' THEN ''Completed'' END AS Visit_Status_Name,
CASE WHEN disc_visit_status = ''Cancelled'' THEN ''Did not happen''
WHEN disc_visit_status = ''Completed'' THEN ''Completed'' END AS Visit_Status_Description,
CASE WHEN Disc_Invoice_Status = ''Billed'' THEN ''i03''
WHEN Disc_Invoice_Status = ''UnBilled'' THEN ''i02'' END AS Invoice_Status_Code,
Disc_Invoice_Status AS Invoice_Status_Name,
Disc_Invoice_Status AS Invoice_Status_Description,
CASE WHEN Disc_Payroll_Status = ''Paid'' THEN ''p03''
WHEN Disc_Payroll_Status =  ''UnPaid'' THEN ''p02'' END AS Payroll_Status_Code,
Disc_Payroll_Status AS Payroll_Status_Name,
Disc_Payroll_Status AS Payroll_Status_Description,
CASE 
        WHEN DISC_VISIT_STATUS = ''Completed'' THEN ''YES''
		WHEN DISC_VISIT_STATUS = ''Cancelled''  THEN ''NO'' ELSE ''UNKNOWN''
    END AS CONFIRMED_FLAG,
        
NULL AS Consistent_Flag
FROM DISCSTATUS  d;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

