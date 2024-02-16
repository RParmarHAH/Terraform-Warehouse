resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_COSTALSYNCDATA_DIM_INVOICE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_COSTALSYNCDATA_DIM_INVOICE"
	statement = <<-SQL
	 WITH inv_list AS (
	SELECT DISTINCT db, bill_number
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_BILLINGDATA bil
	WHERE bil.ETL_LAST_UPDATED_DATE >= '1900-01-01')
SELECT --TOP 100
      md5(inv.db ||'-'|| inv.BILL_NUMBER ||'-'|| 'COSTALSYNCDATA') AS INVOICE_KEY --PK
FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.HIST_CV_BILLINGDATA inv
JOIN inv_list lis ON inv.db = lis.db AND inv.bill_number = lis.bill_number
WHERE inv.ETL_DELETED_FLAG = TRUE
    AND CAST(inv.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.HIST_CV_BILLINGDATA)
GROUP BY inv.DB, inv.BILL_NUMBER, inv.PATIENT_NUMBER, inv.LOCATION_CODE;
SQL
	or_replace = true 
	is_secure = false 
}

