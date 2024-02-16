resource "snowflake_procedure" "DW_HAH_GET_STAGE_GPSYNCDATA_FACT_PAYROLL" {
	name ="GET_STAGE_GPSYNCDATA_FACT_PAYROLL"
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
-- NAME:  GPSyncData_FACT_PAYROLL
--
-- PURPOSE: Creates one row per PAYROLL according to Great Plains Payroll tables
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/19/20    Frank Noordover       Initial development
-- 03/18/20    Frank Noordover       Updated for Production rollout
-- 05/18/20	   Mir Ali				 Updated to use new paycodes table (GpSyncData..EMPLOYER_EDGE_PAYCODES)
-- 06/16/20	   Arif Ansari			 Update logic to generate EmployeeKEy		
--*****************************************************************************************************************************
  
INSERT OVERWRITE INTO STAGE.GPSYNCDATA_FACT_PAYROLL
WITH EMPLOYEE AS 
(
	SELECT DISTINCT 
		MASTER_ID, EMPLOYEE_ID, DB, OFFICE_NO, WORK_STATE,
		MD5(CAST(TRIM(MASTER_ID) AS VARCHAR)||''-''|| DB) AS EMPLOYEE_KEY
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYEE_MASTER_LIST
	UNION
	SELECT DISTINCT 
		MASTER_ID, EMPLOYEE_ID, DB, OFFICE_NO, WORK_STATE,
		MD5(CAST(TRIM(MASTER_ID) AS VARCHAR)||''-''|| DB) AS EMPLOYEE_KEY
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYEE_MATCH_LIST
	WHERE EMPLOYEE_ID NOT IN (SELECT DISTINCT EMPLOYEE_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYEE_MASTER_LIST)
),
PayCodes_ServiceHours AS 
( SELECT Paycodes.COMPANY_CODE, Paycodes.PAY_CODE 
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYER_EDGE_PAYCODES Paycodes
  JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLPAYCODESBASE PaycodeDescription
  	ON TRIM(PaycodeDescription.DB) = TRIM(Paycodes.COMPANY_CODE) AND TRIM(PaycodeDescription.PAY_CODE) = TRIM(Paycodes.PAY_CODE) 
  WHERE Paycodes.IN_USE = 1 AND Paycodes.COUNT_HOURS = 1 AND Paycodes.TYPE_CODE = ''R''
  	AND NOT (
  		UPPER(Paycodes.PAY_CODE) IN (''OCP'', ''TTI'', ''QTRBON'' )
  		OR UPPER(Paycodes.PAY_CODE) LIKE ''HOL%''
  		)
  	-- Exclude possible OTM codes
  	AND NOT (
  		(
  			UPPER(PaycodeDescription.DESCRIPTION) LIKE ''%OTM%''
  			OR UPPER(PaycodeDescription.DESCRIPTION) LIKE ''%OVERTIME%''
  		)
  		AND UPPER(PaycodeDescription.DESCRIPTION) NOT LIKE ''%ADJ%''
  	)
), PayCodes_OvertimeHours AS 
( SELECT Paycodes.COMPANY_CODE, Paycodes.PAY_CODE
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.EMPLOYER_EDGE_PAYCODES Paycodes
  JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.GPALLPAYCODESBASE PaycodeDescription
  	ON TRIM(PaycodeDescription.DB) = TRIM(Paycodes.COMPANY_CODE) AND TRIM(PaycodeDescription.PAY_CODE) = TRIM(Paycodes.PAY_CODE) 
  WHERE
  	(
  		UPPER(PaycodeDescription.DESCRIPTION) LIKE ''%OTM%''
  		OR UPPER(PaycodeDescription.DESCRIPTION) LIKE ''%OVERTIME%''
  	)
  	AND UPPER(PaycodeDescription.DESCRIPTION) NOT LIKE ''%ADJ%''
), srv AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Service_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Service_Hours, MAX(DL1.RATE) AS RATE
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  INNER JOIN PayCodes_ServiceHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code)
  WHERE dl1.IsWage = ''TRUE''
  	AND m1.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
  GROUP BY m1.CheckID),
nonsrv AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Non_Service_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Non_Service_Units
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  LEFT JOIN PayCodes_ServiceHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code)
  LEFT JOIN PayCodes_OvertimeHours AS pc2 ON TRIM(m1.DB) = TRIM(pc2.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc2.Pay_Code)
  WHERE dl1.IsWage = ''TRUE'' AND pc1.COMPANY_CODE IS NULL AND pc2.COMPANY_CODE IS NULL
  	AND m1.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
  GROUP BY m1.CheckID),
ovtm AS
( SELECT m1.CheckID, CAST( SUM( dl1.AMOUNT) AS DECIMAL( 12,2)) AS Overtime_Wages, CAST( SUM( dl1.UNITS) AS DECIMAL( 12,2)) AS Overtime_Hours
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
  INNER JOIN DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine dl1 ON m1.CheckID = dl1.CheckID
  INNER JOIN PayCodes_OvertimeHours AS pc1 ON TRIM(m1.DB) = TRIM(pc1.COMPANY_CODE) AND TRIM( PayCode) = TRIM( pc1.Pay_Code) 
  WHERE dl1.IsWage = ''TRUE''
  	AND m1.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
  GROUP BY m1.CheckID),
tax AS
( SELECT CheckID, CAST( SUM( AMOUNT) AS DECIMAL( 12,2)) AS Taxes
  FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_DetailLine 
  WHERE IsTax = ''TRUE''
  GROUP BY CheckID)
SELECT DISTINCT
	MD5( CAST( m1.PayDate AS VARCHAR) || CAST( coalesce(EMP.MASTER_ID, m1.EMPLOYEEID) AS varchar) || m1.db || m1.CheckNumber) AS Payroll_Key,
       m1.PayDate AS Report_Date, 
       MD5( CAST( TRIM(coalesce(EMP.MASTER_ID, m1.EMPLOYEEID)) AS VARCHAR)||''-''|| m1.db ) AS Employee_Key, 
      COALESCE(/*BRANCH2.BRANCH_KEY,*/BRANCH.BRANCH_KEY, CASE WHEN M1.COMPANYNAME ILIKE ''%HELP AT HOME%'' THEN MD5(5 || ''Help At Home, LLC'' || ''GPSYNCDATA'') ELSE NULL END, (''Unknown'' || ''-'' ||  m1.db)) AS Branch_Key,
       CAST( ''5'' AS INTEGER) AS Source_System_ID, 
       m1.PayDate AS Payroll_Date, 
       COALESCE(EMP.EMPLOYEE_ID, m1.EMPLOYEEID) AS Employee_ID,
        COALESCE(/*BRANCH2.Detailed_Office_Name,*/BRANCH.Detailed_Office_Name, CASE WHEN M1.COMPANYNAME ILIKE ''%HELP AT HOME%'' THEN ''Help At Home, LLC'' ELSE NULL END, ''Unknown'') AS Branch_Name,
       m1.db AS System_Code,
       m1.PeriodStart AS Pay_Period_Start_Date, 
       m1.PeriodEnd AS Pay_Period_End_Date,  
       m1.CheckNumber AS Check_Number,
       m1.TotalUnits AS Pay_Hours, 
       srv.Service_Hours, 
       ovtm.Overtime_Hours, 
       nonsrv.Non_Service_Units,
       NULL AS Sick_Hours,
       NULL AS Vacation_Hours,
       SRV.RATE AS Pay_Rate,
       NULL AS Overtime_Rate,
       m1.GrossWages AS Gross_Pay_Amount, 
       srv.Service_Wages AS Service_Pay_Amount, 
       ovtm.Overtime_Wages AS Overtime_Pay_Amount, 
       nonsrv.Non_Service_Wages AS Non_Service_Pay_Amount,  
       m1.TotalTaxes AS Tax_Amount, 
       m1.NetWages AS Net_Pay_Amount, 
       m1.OtherDeductions AS Other_Deductions_Amount,
       m1.UnionDues AS Union_Dues_Amount, 
       m1.Reimbursements AS Reimbursement_Amount, 
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.GPSYNCDATA.Paystub_Master AS m1
LEFT JOIN EMPLOYEE EMP
	ON TRIM(EMP.EMPLOYEE_ID) = TRIM(M1.EMPLOYEEID) AND UPPER(TRIM(EMP.DB)) = UPPER(TRIM(M1.DB))
LEFT OUTER JOIN srv ON srv.CheckID = m1.CheckID
LEFT OUTER JOIN nonsrv ON nonsrv.CheckID = m1.CheckID
LEFT OUTER JOIN ovtm ON ovtm.CheckID = m1.CheckID
LEFT OUTER JOIN tax ON tax.CheckID = m1.CheckID
--LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH BRANCH2 ON ( LPAD( CAST( BRANCH2.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( EMP.Office_NO), 3, ''0'') AND BRANCH2.Source_System_ID = 3 AND EMP.Office_No NOT IN (908, 950, 951, 17, 52, 53, 60, -1)) 
-- OR ( LPAD( CAST( BRANCH2.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( EMP.Office_NO), 3, ''0'') AND BRANCH2.Source_System_ID = 3 AND EMP.Office_No IN (908, 950, 951, 17, 52, 53, 60, -1) AND BRANCH2.Office_State_Code = UPPER( TRIM( EMP.Work_State)))
-- OR ( TRY_CAST(EMP.office_no AS INT) = BRANCH2.OFFICE_NUMBER  AND BRANCH2.source_system_id = 5)
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH BRANCH ON  TRIM(BRANCH.OFFICE_NUMBER) = TRIM(COALESCE(EMP.OFFICE_NO, M1.OFFICENUMBER))::INTEGER AND BRANCH.SOURCE_SYSTEM_ID = 3 AND TRIM(UPPER(BRANCH.OFFICE_STATE_CODE)) = UPPER(TRIM(COALESCE(CASE WHEN EMP.OFFICE_NO = 53 THEN ''IN'' ELSE EMP.WORK_STATE END, M1.WORKSTATE)))
 OR ( LPAD( CAST( BRANCH.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( EMP.Office_NO), 3, ''0'') AND BRANCH.Source_System_ID = 3 AND EMP.Office_No NOT IN (908, 950, 951, 17, 52, 53, 60, -1)) 
 OR ( LPAD( CAST( BRANCH.Office_Number AS VARCHAR), 3, ''0'') = LPAD( TRIM( EMP.Office_NO), 3, ''0'') AND BRANCH.Source_System_ID = 3 AND EMP.Office_No IN (908, 950, 951, 17, 52, 53, 60, -1) AND BRANCH.Office_State_Code = UPPER( TRIM( EMP.Work_State)))
 OR ( TRY_CAST(EMP.office_no AS INT) = BRANCH.OFFICE_NUMBER  AND BRANCH.source_system_id = 5)
 WHERE m1.AUDITTRAILNUMBER not like ''%ABANDONED%''
	AND m1.ETL_LAST_UPDATED_DATE >= :STR_CDC_START
;
    
	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;
    
 EOT
}

