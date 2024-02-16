resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_GPSYNCDATA_FACT_PAYROLL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_GPSYNCDATA_FACT_PAYROLL"
	statement = <<-SQL
	 WITH PayCodes_ServiceHours AS 
( SELECT Paycodes.COMPANY_CODE, Paycodes.PAY_CODE 
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYER_EDGE_PAYCODES Paycodes
  JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLPAYCODESBASE PaycodeDescription
  	ON TRIM(PaycodeDescription.DB) = TRIM(Paycodes.COMPANY_CODE) AND TRIM(PaycodeDescription.PAY_CODE) = TRIM(Paycodes.PAY_CODE) 
  WHERE Paycodes.IN_USE = 1 AND Paycodes.COUNT_HOURS = 1 AND Paycodes.TYPE_CODE = 'R'
  	AND NOT (
  		UPPER(Paycodes.PAY_CODE) IN ('OCP', 'TTI', 'QTRBON' )
  		OR UPPER(Paycodes.PAY_CODE) LIKE 'HOL%'
  		)
  	-- Exclude possible OTM codes
  	AND NOT (
  		(
  			UPPER(PaycodeDescription.DESCRIPTION) LIKE '%OTM%'
  			OR UPPER(PaycodeDescription.DESCRIPTION) LIKE '%OVERTIME%'
  		)
  		AND UPPER(PaycodeDescription.DESCRIPTION) NOT LIKE '%ADJ%'
  	)
), PayCodes_OvertimeHours AS 
( SELECT Paycodes.COMPANY_CODE, Paycodes.PAY_CODE
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYER_EDGE_PAYCODES Paycodes
  JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLPAYCODESBASE PaycodeDescription
  	ON TRIM(PaycodeDescription.DB) = TRIM(Paycodes.COMPANY_CODE) AND TRIM(PaycodeDescription.PAY_CODE) = TRIM(Paycodes.PAY_CODE) 
  WHERE
  	(
  		UPPER(PaycodeDescription.DESCRIPTION) LIKE '%OTM%'
  		OR UPPER(PaycodeDescription.DESCRIPTION) LIKE '%OVERTIME%'
  	)
  	AND UPPER(PaycodeDescription.DESCRIPTION) NOT LIKE '%ADJ%'
), srv AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Service_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Service_Hours
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  INNER JOIN PayCodes_ServiceHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code)
  WHERE dl1.IsWage = 'TRUE'
  	AND m1.ETL_LAST_UPDATED_DATE >= '1900-01-01'
  GROUP BY m1.CheckID),
nonsrv AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Non_Service_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Non_Service_Units
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  LEFT JOIN PayCodes_ServiceHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code)
  LEFT JOIN PayCodes_OvertimeHours AS pc2 ON TRIM(m1.DB) = TRIM(pc2.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc2.Pay_Code)
  WHERE dl1.IsWage = 'TRUE' AND pc1.COMPANY_CODE IS NULL AND pc2.COMPANY_CODE IS NULL
  	AND m1.ETL_LAST_UPDATED_DATE >= '1900-01-01'
  GROUP BY m1.CheckID),
ovtm AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Overtime_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Overtime_Hours
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  INNER JOIN PayCodes_OvertimeHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code) 
  WHERE dl1.IsWage = 'TRUE'
  	AND m1.ETL_LAST_UPDATED_DATE >= '1900-01-01'
  GROUP BY m1.CheckID),
tax AS
( SELECT CheckID, CAST( SUM( AMOUNT) AS DECIMAL( 12,2)) AS Taxes
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine 
  WHERE IsTax = 'TRUE'
  GROUP BY CheckID)
SELECT MD5( CAST( m1.PayDate AS VARCHAR) || CAST( m1.EmployeeID AS varchar) || m1.db || m1.CheckNumber) AS Payroll_Key
FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.HIST_Paystub_Master AS m1
LEFT OUTER JOIN srv ON srv.CheckID = m1.CheckID
LEFT OUTER JOIN nonsrv ON nonsrv.CheckID = m1.CheckID
LEFT OUTER JOIN ovtm ON ovtm.CheckID = m1.CheckID
LEFT OUTER JOIN tax ON tax.CheckID = m1.CheckID
LEFT OUTER JOIN HAH.DIM_EMPLOYEE AS emp ON emp.Employee_ID = m1.EmployeeID AND emp.System_Code = m1.db
WHERE emp.primary_branch_key IS NOT NULL and m1.AUDITTRAILNUMBER not like '%ABANDONED%'
AND CAST(m1.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT MAX(CAST(ETL_LAST_UPDATED_DATE AS DATE))
FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.HIST_PAYSTUB_MASTER)
	AND m1.ETL_DELETED_FLAG = TRUE;
SQL
	or_replace = true 
	is_secure = false 
}

