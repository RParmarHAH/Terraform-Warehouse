resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_INVOICE_STATUS_MAPPING" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_INVOICE_STATUS_MAPPING"
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
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 21/04/23    Pinkal Panchal        Initial Development
-- 03/10/23    Pradeep Thippani      Modified Invoice_status logic 
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.SANDATAIMPORT_DIM_INVOICE_STATUS_MAPPING
SELECT DISTINCT SOURCE_SYSTEM_ID,SYSTEM_CODE,DERIVED_INVOICE_STATUS,INVOICE_STATUS_KEY,	--Changes made on 27/07/23 by Pinkal
       -- ETL FIELDS
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                    
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY
FROM (
SELECT DISTINCT
	INV.INVOICENUMBER,
	4 AS SOURCE_SYSTEM_ID,
	CASE WHEN D.SERVICEID = ''CARECO'' THEN ''CC_''||INV.AGENCYID 
	ELSE INV.AGENCYID END AS SYSTEM_CODE,
	CASE INV.STATUSID 
		WHEN ''01'' THEN ''UNKNOWN''
		WHEN ''05'' THEN ''UNBILLED''
--		WHEN ''06'' THEN --''BILLED''
--                CASE WHEN SUM(D.PAIDAMOUNT)>0 AND sum(D.NETAMOUNT)>0 THEN ''PARTIAL PAY''
--                ELSE ''BILLED'' END
--		WHEN ''07'' THEN --''PAID''		--Changes made on 27/07/23 by Pinkal
--				CASE WHEN SUM(D.PAIDAMOUNT)>0 AND sum(D.NETAMOUNT)>0 THEN ''PARTIAL PAY''
--				ELSE ''PAID'' END
--Changes made on 03/10/23 for RCM
        WHEN ''06'' THEN   
        CASE 
            WHEN NVL(NVL(inv.ADJUSTEDAMOUNT,0)-NVL(inv.BALANCE,0),0)>0 AND NVL(inv.BALANCE,0)<=0 THEN ''PAID''
	        WHEN NVL(NVL(inv.ADJUSTEDAMOUNT,0)-NVL(inv.BALANCE,0),0)>0 AND NVL(inv.BALANCE,0)>0 THEN ''PARTIAL PAY''
	        ELSE ''BILLED''
         END
		WHEN ''07'' THEN
			    CASE WHEN NVL(NVL(inv.ADJUSTEDAMOUNT,0)-NVL(inv.BALANCE,0),0)>0 AND NVL(inv.BALANCE,0)>0 THEN ''PARTIAL PAY''  
				ELSE ''PAID'' END
		WHEN ''09'' THEN ''UNKNOWN''
		WHEN ''10'' THEN ''CANCELLED''
		WHEN ''11'' THEN ''UNKNOWN''
		ELSE ''UNKNOWN''
	END AS DERIVED_INVOICE_STATUS,
	MD5(SOURCE_SYSTEM_ID || ''-'' || DERIVED_INVOICE_STATUS || ''-'' || SYSTEM_CODE) AS INVOICE_STATUS_KEY
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEHEADER INV
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEDETAILS D ON D.AGENCYID = INV.AGENCYID AND D.INVOICENUMBER = INV.INVOICENUMBER 
WHERE INV.AGENCYID =''8485''
--GROUP BY INV.INVOICENUMBER,SYSTEM_CODE,INV.AGENCYID,INV.STATUSID
);
RETURN ''SUCCESS'';
END;

 EOT
}

