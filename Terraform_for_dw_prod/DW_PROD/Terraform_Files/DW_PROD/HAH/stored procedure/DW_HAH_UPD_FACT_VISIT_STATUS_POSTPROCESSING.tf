resource "snowflake_procedure" "DW_HAH_UPD_FACT_VISIT_STATUS_POSTPROCESSING" {
	name ="UPD_FACT_VISIT_STATUS_POSTPROCESSING"
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
-- NAME:  UPDATE_VISIT STATUS RELATED ALL 
--
-- PURPOSE: Update FUTURE VISIT STATUS WHICH REPORT DATE IS PAST
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/11/2023	Darshan 			Initial development
--*****************************************************************************************************************************


------Update for Coastalsync

UPDATE  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT 
FROM (
SELECT 
VISIT.VISIT_KEY ,
VISIT_MPNG.SCHEDULE_STATUS_CODE,
VISIT_MPNG.SCHEDULE_STATUS_NAME,
VISIT_MPNG.SCHEDULE_STATUS_DESCRIPTION,
VISIT_MPNG.VISIT_STATUS_CODE,
VISIT_MPNG.VISIT_STATUS_NAME,
VISIT_MPNG.VISIT_STATUS_DESCRIPTION,
VISIT_MPNG.INVOICE_STATUS_CODE,
VISIT_MPNG.INVOICE_STATUS_NAME,
VISIT_MPNG.INVOICE_STATUS_DESCRIPTION,
VISIT_MPNG.PAYROLL_STATUS_CODE,
VISIT_MPNG.PAYROLL_STATUS_NAME,
VISIT_MPNG.PAYROLL_STATUS_DESCRIPTION,
VISIT_MPNG .CONFIRMED_FLAG
FROM 
(SELECT  *  FROM  DW_${var.SF_ENVIRONMENT}.STAGE.VW_UPD_VISIT_STATUS WHERE source_system_id IN (1,2))INTR_MEDT_V
JOIN  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT  VISIT 
ON INTR_MEDT_V.VISIT_KEY  = VISIT .VISIT_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT.SOURCE_SYSTEM_ID 
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_STATUS_MAPPING VISIT_MPNG 
ON INTR_MEDT_V .VISIT_STATUS_KEY  = VISIT_MPNG.VISIT_STATUS_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT_MPNG.SOURCE_SYSTEM_ID 
WHERE 
NVL(VISIT.VISIT_STATUS_CODE,''A'') <> NVL(VISIT_MPNG.VISIT_STATUS_CODE,''A'') 
AND upper(trim(VISIT.VISIT_STATUS_NAME)) LIKE ''%FUTURE%'' 
AND VISIT."REPORT_DATE" < CURRENT_DATE )X
SET 
SCHEDULE_STATUS_CODE = X.SCHEDULE_STATUS_CODE,
SCHEDULE_STATUS_NAME = X.SCHEDULE_STATUS_NAME,
SCHEDULE_STATUS_DESCRIPTION = X.SCHEDULE_STATUS_DESCRIPTION,
VISIT_STATUS_CODE = X.VISIT_STATUS_CODE,
VISIT_STATUS_NAME = X.VISIT_STATUS_NAME,
VISIT_STATUS_DESCRIPTION = X.VISIT_STATUS_DESCRIPTION,
INVOICE_STATUS_CODE = X.INVOICE_STATUS_CODE,
INVOICE_STATUS_NAME = X.INVOICE_STATUS_NAME,
INVOICE_STATUS_DESCRIPTION = X.INVOICE_STATUS_DESCRIPTION,
PAYROLL_STATUS_CODE = X.PAYROLL_STATUS_CODE,
PAYROLL_STATUS_NAME = X.PAYROLL_STATUS_NAME,
PAYROLL_STATUS_DESCRIPTION = X.PAYROLL_STATUS_DESCRIPTION,
CONFIRMED_FLAG = X.CONFIRMED_FLAG
WHERE 
DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT.VISIT_KEY =  X.VISIT_KEY ;




------Update for Dataflex 

UPDATE  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT 
FROM (
SELECT 
VISIT.VISIT_KEY ,
VISIT_MPNG.SCHEDULE_STATUS_CODE,
VISIT_MPNG.SCHEDULE_STATUS_NAME,
VISIT_MPNG.SCHEDULE_STATUS_DESCRIPTION,
VISIT_MPNG.VISIT_STATUS_CODE,
VISIT_MPNG.VISIT_STATUS_NAME,
VISIT_MPNG.VISIT_STATUS_DESCRIPTION,
VISIT_MPNG.INVOICE_STATUS_CODE,
VISIT_MPNG.INVOICE_STATUS_NAME,
VISIT_MPNG.INVOICE_STATUS_DESCRIPTION,
VISIT_MPNG.PAYROLL_STATUS_CODE,
VISIT_MPNG.PAYROLL_STATUS_NAME,
VISIT_MPNG.PAYROLL_STATUS_DESCRIPTION,
VISIT_MPNG .CONFIRMED_FLAG
FROM 
(SELECT  *  FROM  DW_${var.SF_ENVIRONMENT}.STAGE.VW_UPD_VISIT_STATUS WHERE source_system_id IN (3))INTR_MEDT_V
JOIN  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT  VISIT 
ON INTR_MEDT_V.VISIT_KEY  = VISIT .VISIT_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT.SOURCE_SYSTEM_ID 
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_STATUS_MAPPING VISIT_MPNG 
ON INTR_MEDT_V .VISIT_STATUS_KEY  = VISIT_MPNG.VISIT_STATUS_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT_MPNG.SOURCE_SYSTEM_ID 
WHERE 
NVL(VISIT.VISIT_STATUS_CODE,''A'') <> NVL(VISIT_MPNG.VISIT_STATUS_CODE,''A'') 
AND upper(trim(VISIT.VISIT_STATUS_NAME)) LIKE ''%FUTURE%'' 
AND VISIT."REPORT_DATE" < CURRENT_DATE )X
SET 
SCHEDULE_STATUS_CODE = X.SCHEDULE_STATUS_CODE,
SCHEDULE_STATUS_NAME = X.SCHEDULE_STATUS_NAME,
SCHEDULE_STATUS_DESCRIPTION = X.SCHEDULE_STATUS_DESCRIPTION,
VISIT_STATUS_CODE = X.VISIT_STATUS_CODE,
VISIT_STATUS_NAME = X.VISIT_STATUS_NAME,
VISIT_STATUS_DESCRIPTION = X.VISIT_STATUS_DESCRIPTION,
INVOICE_STATUS_CODE = X.INVOICE_STATUS_CODE,
INVOICE_STATUS_NAME = X.INVOICE_STATUS_NAME,
INVOICE_STATUS_DESCRIPTION = X.INVOICE_STATUS_DESCRIPTION,
PAYROLL_STATUS_CODE = X.PAYROLL_STATUS_CODE,
PAYROLL_STATUS_NAME = X.PAYROLL_STATUS_NAME,
PAYROLL_STATUS_DESCRIPTION = X.PAYROLL_STATUS_DESCRIPTION,
CONFIRMED_FLAG = X.CONFIRMED_FLAG
WHERE 
DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT.VISIT_KEY =  X.VISIT_KEY  ;



---Update for Sandata


UPDATE  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT 
FROM (
SELECT 
VISIT.VISIT_KEY ,
VISIT_MPNG.SCHEDULE_STATUS_CODE,
VISIT_MPNG.SCHEDULE_STATUS_NAME,
VISIT_MPNG.SCHEDULE_STATUS_DESCRIPTION,
VISIT_MPNG.VISIT_STATUS_CODE,
VISIT_MPNG.VISIT_STATUS_NAME,
VISIT_MPNG.VISIT_STATUS_DESCRIPTION,
VISIT_MPNG.INVOICE_STATUS_CODE,
VISIT_MPNG.INVOICE_STATUS_NAME,
VISIT_MPNG.INVOICE_STATUS_DESCRIPTION,
VISIT_MPNG.PAYROLL_STATUS_CODE,
VISIT_MPNG.PAYROLL_STATUS_NAME,
VISIT_MPNG.PAYROLL_STATUS_DESCRIPTION,
VISIT_MPNG .CONFIRMED_FLAG
FROM 
(SELECT  *  FROM  DW_${var.SF_ENVIRONMENT}.STAGE.VW_UPD_VISIT_STATUS WHERE source_system_id IN (4))INTR_MEDT_V
JOIN  DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT  VISIT 
ON INTR_MEDT_V.VISIT_KEY  = VISIT .VISIT_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT.SOURCE_SYSTEM_ID 
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_VISIT_STATUS_MAPPING VISIT_MPNG 
ON INTR_MEDT_V .VISIT_STATUS_KEY  = VISIT_MPNG.VISIT_STATUS_KEY 
AND INTR_MEDT_V.SOURCE_SYSTEM_ID = VISIT_MPNG.SOURCE_SYSTEM_ID 
WHERE 
NVL(VISIT.VISIT_STATUS_CODE,''A'') <> NVL(VISIT_MPNG.VISIT_STATUS_CODE,''A'') 
AND upper(trim(VISIT.VISIT_STATUS_NAME)) LIKE ''%FUTURE%''
AND VISIT."REPORT_DATE" < CURRENT_DATE  )X
SET 
SCHEDULE_STATUS_CODE = X.SCHEDULE_STATUS_CODE,
SCHEDULE_STATUS_NAME = X.SCHEDULE_STATUS_NAME,
SCHEDULE_STATUS_DESCRIPTION = X.SCHEDULE_STATUS_DESCRIPTION,
VISIT_STATUS_CODE = X.VISIT_STATUS_CODE,
VISIT_STATUS_NAME = X.VISIT_STATUS_NAME,
VISIT_STATUS_DESCRIPTION = X.VISIT_STATUS_DESCRIPTION,
INVOICE_STATUS_CODE = X.INVOICE_STATUS_CODE,
INVOICE_STATUS_NAME = X.INVOICE_STATUS_NAME,
INVOICE_STATUS_DESCRIPTION = X.INVOICE_STATUS_DESCRIPTION,
PAYROLL_STATUS_CODE = X.PAYROLL_STATUS_CODE,
PAYROLL_STATUS_NAME = X.PAYROLL_STATUS_NAME,
PAYROLL_STATUS_DESCRIPTION = X.PAYROLL_STATUS_DESCRIPTION,
CONFIRMED_FLAG = X.CONFIRMED_FLAG
WHERE 
DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT.VISIT_KEY =  X.VISIT_KEY  ;



RETURN ''SUCCESS'';
    END;

 EOT
}

