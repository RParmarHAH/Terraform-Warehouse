resource "snowflake_view" "DW_STAGE_VW_CURRENT_DATAFLEXSYNCDATA_DIM_EMPLOYEE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DATAFLEXSYNCDATA_DIM_EMPLOYEE"
	statement = <<-SQL
	 WITH employee_service_dates
AS
(
SELECT ts.DBName, ts.EmployeeNumber AS Employee_Number, CAST( MIN( tsh.ServiceDate) AS DATE) AS First_Service_Date, CAST( MAX( tsh.ServiceDate) AS DATE) AS Last_Service_Date
FROM DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.ALL_DFTIMESHEETS AS ts
INNER JOIN DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.ALL_TIMESHEETSHOURS AS tsh ON ts.DBName = tsh.DBName AND ts.ReferenceNo = tsh.ReferenceNo
GROUP BY ts.DBName, ts.EmployeeNumber
),
Find_Latest_Changes AS
(
SELECT LEAST( MAX( e.ETL_Last_Updated_Date), MAX( gp.ETL_Last_Updated_Date)) AS Date_to_Start_Processing
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DfEmployees e
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.GPSyncData.GPAllEmployeesBase AS gp ON TRIM( e.PayrollID) = TRIM( gp.Employee_ID) AND TRIM( e.DBName) = TRIM( gp.Office_State) AND TRIM( gp.DB) <> 'HAHIL'
), 
BULK_BILLING_EMPLOYEES AS (
    SELECT I.DBNAME, I.OFFICE, 
    	TRY_CAST(CONCAT(-100, I.OFFICE) AS INTEGER) AS DUMMY_EMPLOYEE_NUMBER,
    	COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, '-Unknown')) AS BRANCH_NAME, 
    	COALESCE(B.BRANCH_KEY, MD5(I.DBNAME || '-' || I.OFFICE || '-' || 'DATAFLEXSYNCDATA')) AS BRANCH_KEY,
    	COALESCE(B.DETAILED_OFFICE_NAME, BRANCH_NAME) AS DETAILED_OFFICE_NAME,
    	MAX(GREATEST(COALESCE(I.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(B.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES I
    LEFT JOIN HAH.DIM_BRANCH B ON B.SOURCE_SYSTEM_ID = 3 AND B.SYSTEM_CODE = I.DBNAME AND B.OFFICE_NUMBER = I.OFFICE 
	GROUP BY I.DBNAME, I.OFFICE, COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, '-Unknown')),
    	COALESCE(B.BRANCH_KEY, MD5(I.DBNAME || '-' || I.OFFICE || '-' || 'DATAFLEXSYNCDATA')),
    	COALESCE(B.DETAILED_OFFICE_NAME, BRANCH_NAME)
)
SELECT
    md5(COALESCE(e.DBNAME,'') || '-' || UPPER(NVL(TRIM(e.NUMBER), '')) || '-'  ||  '1900-01-01' || '-' || 'DATAFLEXSYNCDATA') AS EMPLOYEE_KEY
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DfEmployees e
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.GPSyncData.GPAllEmployeesBase AS gp ON TRIM( e.PayrollID) = TRIM( gp.Employee_ID) AND TRIM( e.DBName) = TRIM( gp.Office_State) AND TRIM( gp.DB) <> 'HAHIL'
LEFT OUTER JOIN HAH.DIM_Branch AS brnch ON UPPER( TRIM( e.DBName)) = brnch.System_Code AND 3 = brnch.Source_System_ID AND e.OfficeNumber = brnch.Office_Number
LEFT OUTER JOIN HAH.DIM_State AS st ON st.State_ISO_Code = UPPER( SUBSTRING( TRIM( e.State), 1, 2))
LEFT OUTER JOIN HAH.DIM_Zip_Code AS zip ON UPPER( zip.Zip_Code) = UPPER( e.Zip)
--LEFT OUTER JOIN employee_service_dates AS csd ON csd.DBName = e.DBName AND csd.Employee_Number = e.Number
WHERE UPPER( TRIM( e.DBName)) <> 'PA' 
--AND e.ETL_LAST_UPDATED_DATE >= '1900-01-01';
--AND e.ETL_LAST_UPDATED_DATE >= ( SELECT Date_to_Start_Processing FROM Find_Latest_Changes)
-- Bulk billing employees (for use with DfArInvoices)
UNION ALL
SELECT md5(COALESCE(e.DBNAME,'') || '-' || UPPER(NVL(TRIM(e.DUMMY_EMPLOYEE_NUMBER), '')) || '-'  ||  '1900-01-01' || '-' || 'DATAFLEXSYNCDATA-DUMMY') AS EMPLOYEE_KEY
FROM BULK_BILLING_EMPLOYEES E
WHERE E.ETL_LAST_UPDATED_DATE >= '1900-01-01';
SQL
	or_replace = true 
	is_secure = false 
}

