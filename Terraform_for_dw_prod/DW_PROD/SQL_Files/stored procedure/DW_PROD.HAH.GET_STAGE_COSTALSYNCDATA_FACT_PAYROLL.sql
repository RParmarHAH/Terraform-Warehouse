CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_COSTALSYNCDATA_FACT_PAYROLL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
        --*****************************************************************************************************************************
-- NAME:  CostalSyncData_FACT_PAYROLL
--
-- PURPOSE: Creates one row per PAYROLL according to CoastalSnyc (combination of SHC_ALTRUS and SHC_SAVANNAH)
--
-- Note: Has duplicate Payroll Key -- currently Paycheck in coastal are broken down by client and month. 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 01/14/20     Greg Marsh           Initial development
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 04/02/20		Mohd Kamaludin		 Fixed Duplicate Payroll Key - sum hours, and added payrate to payroll key
-- 06/08/20		Arif Ansari			 Update the logic to get Payroll data from Raw table.
-- 11/24/20		Mir Ali				 Updated System_Code to be consistent with other structures (SHC_ALTRUS and SHC_SAVANNAH, instead of ALTRU and SHC)
-- 12/04/20		Mir Ali				 Updated to make use of new Discovery layer mapping table Stage.Coastal_Office_Mapping_Payroll
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CostalSyncData_FACT_PAYROLL
WITH ServicePayCode
AS 
(
	SELECT
		DB,PAY_CODE,PAY_CODE_CATEGORY
	FROM DISC_PROD.COSTALSYNCDATA.PAYCODE_CATEGORY
	WHERE PAY_CODE_CATEGORY =''SERVICE_CODE''
		
)
,OverTimePayCode
AS 
(
	SELECT
		DB,PAY_CODE,PAY_CODE_CATEGORY
	FROM DISC_PROD.COSTALSYNCDATA.PAYCODE_CATEGORY
	WHERE PAY_CODE_CATEGORY =''OVERTIME''

)
,REIMBURSEMENT_PAYCODE
AS 
(
	SELECT
		DB,PAY_CODE,PAY_CODE_CATEGORY
	FROM DISC_PROD.COSTALSYNCDATA.PAYCODE_CATEGORY
	WHERE PAY_CODE_CATEGORY = ''REIMBURSEMENT''

)
,CHANGED_DATA
AS
(
	SELECT DISTINCT
		DB
		,AUDITTRAILNUMBER 
		,CHECKNUMBER 
		,CHECKDATE
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE T
	WHERE T.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
						 
)
,srv 
AS 
(
	SELECT 
		cd.DB 
		,cd.CHECKNUMBER 
		,cd.AUDITTRAILNUMBER 
		,SUM(pcd.AMOUNT) AMOUNT
		,SUM(pcd.UNITS ) AS HOURS
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
	INNER JOIN CHANGED_DATA CD 
	ON cd.DB = pcd.DB 
	AND cd.CHECKNUMBER = pcd.CHECKNUMBER 
	AND cd.AUDITTRAILNUMBER = pcd.AUDITTRAILNUMBER
	INNER JOIN ServicePayCode sd
	ON pcd.PAYCODE =sd.PAY_CODE
	AND pcd.DB =sd.DB
	GROUP BY cd.DB , cd.CHECKNUMBER ,cd.AUDITTRAILNUMBER 
)
,overtimehours 
AS 
(
	SELECT 
		cd.DB 
		,cd.CHECKNUMBER 
		,cd.AUDITTRAILNUMBER 
		,SUM(pcd.AMOUNT) AMOUNT
		,SUM(pcd.UNITS ) AS HOURS
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
	INNER JOIN CHANGED_DATA CD 
	ON cd.DB = pcd.DB 
	AND cd.CHECKNUMBER = pcd.CHECKNUMBER 
	AND cd.AUDITTRAILNUMBER = pcd.AUDITTRAILNUMBER
	INNER JOIN OverTimePayCode sd
	ON pcd.PAYCODE =sd.PAY_CODE
	AND pcd.DB =sd.DB
	GROUP BY cd.DB , cd.CHECKNUMBER ,cd.AUDITTRAILNUMBER 
)
,REIMBURSEMENT_PAY
AS
(
	SELECT 
		cd.DB 
		,cd.CHECKNUMBER 
		,cd.AUDITTRAILNUMBER 
		,SUM(pcd.AMOUNT) AMOUNT
		,SUM(pcd.UNITS ) AS HOURS
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
	INNER JOIN CHANGED_DATA CD 
	ON cd.DB = pcd.DB 
	AND cd.CHECKNUMBER = pcd.CHECKNUMBER 
	AND cd.AUDITTRAILNUMBER = pcd.AUDITTRAILNUMBER
	INNER JOIN REIMBURSEMENT_PAYCODE sd
	ON pcd.PAYCODE =sd.PAY_CODE
	AND pcd.DB =sd.DB
	GROUP BY cd.DB , cd.CHECKNUMBER ,cd.AUDITTRAILNUMBER 
)
,nonsrvhours 
AS 
(
	SELECT 
		cd.DB 
		,cd.CHECKNUMBER 
		,cd.AUDITTRAILNUMBER 
		,SUM(pcd.AMOUNT) AMOUNT
		,SUM(pcd.UNITS ) AS HOURS
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
	INNER JOIN CHANGED_DATA CD 
	ON cd.DB = pcd.DB 
	AND cd.CHECKNUMBER = pcd.CHECKNUMBER 
	AND cd.AUDITTRAILNUMBER = pcd.AUDITTRAILNUMBER
	
	INNER JOIN DISC_PROD.COSTALSYNCDATA.GPALLPAYCODESBASE paycodes
	ON PAYCODES.PAY_CODE = pcd.PAYCODE
	AND PAYCODES.DB = pcd.DB
	
	LEFT JOIN ServicePayCode sd
	ON pcd.PAYCODE =sd.PAY_CODE
	AND pcd.DB =sd.DB
	
	LEFT JOIN OverTimePayCode ot
	ON pcd.PAYCODE =ot.PAY_CODE
	AND pcd.DB =ot.DB
	
	LEFT JOIN REIMBURSEMENT_PayCode rpc
	ON pcd.PAYCODE = rpc.PAY_CODE
	AND pcd.DB = rpc.DB
	
	WHERE sd.PAY_CODE IS NULL AND ot.PAY_CODE IS NULL AND rpc.PAY_CODE IS NULL
	GROUP BY cd.DB , cd.CHECKNUMBER ,cd.AUDITTRAILNUMBER 
)
, final_payroll
AS
(
	SELECT 
		pcb.DB 
		,CASE TRIM(pcb.DB) WHEN ''ALTRU'' THEN ''SHC_ALTRUS'' WHEN ''SHC'' THEN ''SHC_SAVANNAH'' END AS SYSTEM_CODE
		,pcb.AUDITTRAILNUMBER 
		,pcb.CHECKNUMBER 
		,pcb.EMPLOYEEID 
		,pcb.DEPARTMENT 
		,pcb.CHECKDATE AS PayDate
		,pcb.PAYPERIODBEGINDATE AS PeriodStart
		,pcb.PAYPERIODENDDATE 	AS PeriodEnd
		,pcb.GROSSPAY 
	--	,pcb.NETPAY + pcb.TOTALTAX
		,pcb.NETPAY 
		,pcb.TOTALTAX
		,COALESCE (srv.AMOUNT,0) AS Service_Amount
		,COALESCE(ot.AMOUNT,0) AS OverTime_Amount
		,COALESCE (ns.AMOUNT,0) AS NonSrv_Amount
		,COALESCE (rp.AMOUNT,0) AS Reim_Amount
		--	,COALESCE(srv.AMOUNT,0) + COALESCE(ot.AMOUNT,0)
	--	,COALESCE(srv.AMOUNT,0) + COALESCE(ot.AMOUNT,0)+ COALESCE(ns.AMOUNT,0)
		,COALESCE(srv.HOURS,0) AS Service_Hours
		,COALESCE(ot.HOURS,0) AS OverTime_Hours
		,COALESCE(ns.HOURS,0) AS NonSrv_Hours
		,COALESCE(rp.HOURS,0) AS Reim_Hours
		,COALESCE(srv.HOURS,0) + COALESCE(ot.HOURS,0) + COALESCE(ns.HOURS,0) AS TotalUnits
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKSBASE pcb
	INNER JOIN CHANGED_DATA AS cd 
	ON pcb.DB = cd.DB
	AND pcb.AUDITTRAILNUMBER  = cd.AUDITTRAILNUMBER
	AND pcb.CHECKNUMBER = cd.CHECKNUMBER
	LEFT JOIN srv 
	ON srv.DB = pcb.DB 
	AND srv.AUDITTRAILNUMBER = pcb.AUDITTRAILNUMBER 
	AND srv.CHECKNUMBER = cd.CHECKNUMBER
	LEFT JOIN overtimehours ot 
	ON ot.DB = pcb.DB 
	AND ot.AUDITTRAILNUMBER = pcb.AUDITTRAILNUMBER 
	AND ot.CHECKNUMBER = cd.CHECKNUMBER
	LEFT JOIN nonsrvhours ns 
	ON ns.DB = pcb.DB 
	AND ns.AUDITTRAILNUMBER = pcb.AUDITTRAILNUMBER 
	AND ns.CHECKNUMBER = cd.CHECKNUMBER
	LEFT JOIN REIMBURSEMENT_PAY rp
	ON rp.DB = pcb.DB 
	AND rp.AUDITTRAILNUMBER = pcb.AUDITTRAILNUMBER 
	AND rp.CHECKNUMBER = cd.CHECKNUMBER
	
)

SELECT 
	-- MD5( CAST( fp.PayDate AS VARCHAR) || CAST( fp.EmployeeID AS varchar) || fp.db || fp.CheckNumber) AS Payroll_Key
	MD5( CAST( fp.PayDate AS VARCHAR) || CAST( fp.EmployeeID AS varchar) || fp.SYSTEM_CODE || fp.CheckNumber) AS Payroll_Key
	,fp.PayDate AS Report_Date 
	,COALESCE(emp.Employee_Key, MD5(TRIM(fp.SYSTEM_CODE) || ''-'' || UPPER(TRIM(fp.EMPLOYEEID)) || ''-'' || ''COSTALSYNCDATA'')) AS EMPLOYEE_KEY
--	,emp.Primary_Branch_Key AS Branch_Key 
	,BRANCH.BRANCH_KEY
	,CAST(ss.Source_System_ID AS INTEGER) AS Source_System_ID 
	,fp.PayDate AS Payroll_Date 
	,TRIM(fp.EmployeeID) AS Employee_ID
--	,TRIM(emp.Primary_Branch_Name) AS Branch_Name
	,BRANCH.DETAILED_OFFICE_NAME AS BRANCH_NAME
	,fp.System_Code
	,fp.PeriodStart AS Pay_Period_Start_Date 
	,fp.PeriodEnd AS Pay_Period_End_Date  
	,fp.CheckNumber AS Check_Number
	,fp.TotalUnits AS Pay_Hours 
	,fp.Service_Hours 
	,fp.Overtime_Hours 
	,fp.NonSrv_Hours
	,NULL AS Sick_Hours
	,NULL AS Vacation_Hours
	,NULL AS Pay_Rate
	,NULL AS Overtime_Rate
	,fp.GROSSPAY AS Gross_Pay_Amount 
	,fp.Service_Amount AS Service_Pay_Amount 
	,fp.Overtime_Amount AS Overtime_Pay_Amount 
	,fp.NonSrv_Amount AS Non_Service_Pay_Amount  
	,fp.TOTALTAX AS Tax_Amount 
	,fp.NETPAY AS Net_Pay_Amount 
	,0 AS Other_Deductions_Amount
	,0 AS Union_Dues_Amount 
	,Reim_Amount AS Reimbursement_Amount,
	-- ETL Fields
   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
   convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
   CURRENT_USER as ETL_INSERTED_BY ,
   convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
   CURRENT_USER as ETL_LAST_UPDATED_BY,
   0 as ETL_DELETED_FLAG
FROM final_payroll fp
LEFT JOIN HAH.DIM_EMPLOYEE emp
ON trim(emp.SYSTEM_CODE) = trim(fp.SYSTEM_CODE)
AND trim(emp.employee_id) = trim(fp.EMPLOYEEID)
LEFT JOIN DISC_PROD."STAGE".COASTAL_OFFICE_MAPPING_PAYROLL AS BRANCH_MAPPING
	ON BRANCH_MAPPING.DB = TRIM(fp.DB) AND BRANCH_MAPPING.DEPARTMENT = TRIM(fp.DEPARTMENT)
LEFT JOIN HAH.DIM_BRANCH AS BRANCH
	ON BRANCH.SYSTEM_CODE = BRANCH_MAPPING.SYSTEM_CODE AND BRANCH.OFFICE_CODE = BRANCH_MAPPING.OFFICE_CODE
LEFT JOIN HAH.DIM_SOURCE_SYSTEM AS SS 
ON TRIM(CASE ss.SYSTEM_DESCRIPTION 
			WHEN ''Carevoyant (Altrus)'' THEN ''SHC_ALTRUS'' 
			WHEN ''Carevoyant (Coastal)'' THEN ''SHC_SAVANNAH'' 
			ELSE NULL END ) = fp.SYSTEM_CODE
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';