create or replace view DW_PROD.REPORT.VW_INVOICE_DETAIL_EXTRACT_FOR_FINANCE(
	AMS_SOURCE_SYSTEM,
	PAYROLL_SOURCE_SYSTEM,
	STATE,
	OFFICE,
	OFFICE_NAME,
	PERIOD,
	INVOICE_CREATE_DATE,
	INVOICE_NUMBER,
	CLIENTNUMBER,
	CLIENTNAME,
	CLIENT_DATE_OF_BIRTH,
	CONTRACT_CODE,
	CONTRACT_NAME,
	BUSINESS_SEGMENT,
	SERVICE_CATEGORY,
	SERVICEAREA,
	REFERRAL_SOURCE,
	MOVED_TO,
	SHORT_DESC,
	"Billed_Hours-Header_Hours_Billed",
	"Gross_Charge-Header_Amount_Billed",
	"Payment_Amount-Header_Payment_Received",
	PAYMENT_DATE,
	PAYERCODE,
	"Credited_Amount-Header_Credited_Amount",
	"Balance-Header_Outstanding_Amount",
	EMPLOYEE_NUMBER,
	EMPLOYEE_NAME,
	START_OF_SERVICE,
	END_OF_SERVICE,
	EMPLOYEENO2_COUNT,
	EMPLOYEENO3_COUNT,
	EMPLOYEE_COUNT,
	HOURS,
	AMOUNT
) as
SELECT 'Dataflex' AS AMS_Source_System,
       'Great Plains' AS Payroll_Source_System,
       inv.DBNAME AS State, inv.OFFICE, off.OfficeName AS Office_Name,
       inv.Period AS Period,
       inv.INVOICECREATEDDATE AS Invoice_Create_Date, 
       inv.INVOICENO AS Invoice_Number, 
       inv.ClientNumber, 
       cl.FirstName||' '||cl.LastName AS ClientName,
       cl.DOB AS Client_Date_of_Birth,
       inv.CONTRACTCODE AS Contract_Code, 
       cntrct.ContractName AS Contract_Name, 
       cntrct.RevenueCategory AS Business_Segment,
       cntrct.RevenueSubCategory AS Service_Category, 
       inv.ServiceArea,
       srvc.GaurName AS Referral_Source,
       inv.MovedTo AS Moved_To,
       inv.ShortDesc AS Short_Desc,
       inv.HoursBilled AS "Billed_Hours-Header_Hours_Billed",
       inv.AMOUNTBILLED AS "Gross_Charge-Header_Amount_Billed", 
       inv.PAYMENTRECEIVED AS "Payment_Amount-Header_Payment_Received", 
       inv.LASTPAYDATE AS Payment_Date, inv.PAYERCODE, 
       inv.CREDITEDAMOUNT AS "Credited_Amount-Header_Credited_Amount", 
--       DATEDIFF( DAY, inv.InvoiceCreatedDate, pay.First_Pay_Date) AS Num_Days_to_First_Payment,
--       DATEDIFF( DAY, pay.Last_Pay_Date, inv.LastPayDate) AS Num_Days_to_Deposit,
--       NVL( pay.Number_of_Payments, 0) AS Number_of_Payments,
--       pay.Paid_Amount AS Total_Paid_Amount,
--       NVL( wrt.Number_of_WriteOffs, 0) AS Number_of_WriteOffs,
--       DATEDIFF( DAY, wrt.Last_WriteOff_Date, inv.LastPayDate) AS Num_Days_to_WriteOff,
--       wrt.WriteOff_Amount AS Total_WriteOff_Amount,
       inv.OUTSANDINGAMOUNT AS "Balance-Header_Outstanding_Amount",
--       CASE WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( wrt.WriteOff_Amount, 0) = 0 THEN 'Fully Paid'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( pay.Paid_Amount, 0) > 0 THEN 'Partially Paid, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount > 0 THEN 'Fully Written-Off, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT > 0 AND inv.OUTSANDINGAMOUNT < inv.AmountBilled AND  inv.PAYMENTRECEIVED > 0 THEN 'Partially Paid, Non-Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount = inv.AmountBilled THEN 'Fully Written-Off'
--            ELSE 'Billable' 
--       END AS INVOICE_STATUS,       inv.Status AS Status,
--       DATE_TRUNC( 'MONTH', ids.Start_Of_Service) AS Start_Service_Month,
       NULLIFZERO( invdtl.EmployeeNo1) AS Employee_Number,
       emp.FirstName||' '||cl.LastName AS Employee_Name,
       invdtl.DateFrom AS Start_Of_Service,
       invdtl.DateTo AS End_Of_Service,
       CASE WHEN invdtl.EmployeeNo2 IS NOT NULL AND invdtl.EmployeeNo2 <> 0 THEN 1 ELSE 0 END AS EmployeeNo2_Count,
       CASE WHEN invdtl.EmployeeNo3 IS NOT NULL AND invdtl.EmployeeNo3 <> 0 THEN 1 ELSE 0 END AS EmployeeNo3_Count,
       1 + EmployeeNo2_Count + EmployeeNo3_Count AS Employee_Count,
       invdtl.Hours / Employee_Count AS Hours,
       invdtl.Amount / Employee_Count AS Amount
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS inv
INNER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFContracts AS cntrct ON cntrct.DBNAME = inv.DBNAME AND cntrct.ContractCode = inv.ContractCode
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOffices AS off ON off.DBNAME = inv.DBNAME AND off.OfficeNumber = inv.Office
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFClients AS cl ON cl.DBName = inv.DBName AND cl.Number = inv.ClientNumber
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFServices AS srvc ON cl.DBName = srvc.DBName AND cl.ServiceArea = srvc.Area
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFEmployees AS emp ON invdtl.DBName = emp.DBName AND NULLIFZERO( invdtl.EmployeeNo1) = emp.Number
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE) 
--AND inv.DBName = 'TN'
--AND inv.InvoiceNo = 9656
--ORDER BY 1, 5, 6, 26, 25;
-- 31,448
UNION
SELECT 'Dataflex' AS AMS_Source_System,
       'Great Plains' AS Payroll_Source_System,
       inv.DBNAME AS State, inv.OFFICE, off.OfficeName AS Office_Name,
       inv.Period AS Period,
       inv.INVOICECREATEDDATE AS Invoice_Create_Date, 
       inv.INVOICENO AS Invoice_Number, 
       inv.ClientNumber, 
       cl.FirstName||' '||cl.LastName AS ClientName,
       cl.DOB AS Client_Date_of_Birth,
       inv.CONTRACTCODE AS Contract_Code, 
       cntrct.ContractName AS Contract_Name, 
       cntrct.RevenueCategory AS Business_Segment,
       cntrct.RevenueSubCategory AS Service_Category, 
       inv.ServiceArea,
       srvc.GaurName AS Referral_Source,
       inv.MovedTo AS Moved_To,
       inv.ShortDesc AS Short_Desc,
       inv.HoursBilled AS "Billed_Hours-Header_Hours_Billed",
       inv.AMOUNTBILLED AS "Gross_Charge-Header_Amount_Billed", 
       inv.PAYMENTRECEIVED AS "Payment_Amount-Header_Payment_Received", 
       inv.LASTPAYDATE AS Payment_Date, inv.PAYERCODE, 
       inv.CREDITEDAMOUNT AS "Credited_Amount-Header_Credited_Amount", 
--       DATEDIFF( DAY, inv.InvoiceCreatedDate, pay.First_Pay_Date) AS Num_Days_to_First_Payment,
--       DATEDIFF( DAY, pay.Last_Pay_Date, inv.LastPayDate) AS Num_Days_to_Deposit,
--       NVL( pay.Number_of_Payments, 0) AS Number_of_Payments,
--       pay.Paid_Amount AS Total_Paid_Amount,
--       NVL( wrt.Number_of_WriteOffs, 0) AS Number_of_WriteOffs,
--       DATEDIFF( DAY, wrt.Last_WriteOff_Date, inv.LastPayDate) AS Num_Days_to_WriteOff,
--       wrt.WriteOff_Amount AS Total_WriteOff_Amount,
       inv.OUTSANDINGAMOUNT AS "Balance-Header_Outstanding_Amount",
--       CASE WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( wrt.WriteOff_Amount, 0) = 0 THEN 'Fully Paid'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( pay.Paid_Amount, 0) > 0 THEN 'Partially Paid, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount > 0 THEN 'Fully Written-Off, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT > 0 AND inv.OUTSANDINGAMOUNT < inv.AmountBilled AND  inv.PAYMENTRECEIVED > 0 THEN 'Partially Paid, Non-Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount = inv.AmountBilled THEN 'Fully Written-Off'
--            ELSE 'Billable' 
--       END AS INVOICE_STATUS,       inv.Status AS Status,
--       DATE_TRUNC( 'MONTH', ids.Start_Of_Service) AS Start_Service_Month,
       NULLIFZERO( invdtl.EmployeeNo2) AS Employee_Number,
       emp.FirstName||' '||cl.LastName AS Employee_Name,
       invdtl.DateFrom AS Start_Of_Service,
       invdtl.DateTo AS End_Of_Service,
       CASE WHEN invdtl.EmployeeNo2 IS NOT NULL AND invdtl.EmployeeNo2 <> 0 THEN 1 ELSE 0 END AS EmployeeNo2_Count,
       CASE WHEN invdtl.EmployeeNo3 IS NOT NULL AND invdtl.EmployeeNo3 <> 0 THEN 1 ELSE 0 END AS EmployeeNo3_Count,
       1 + EmployeeNo2_Count + EmployeeNo3_Count AS Employee_Count,
       invdtl.Hours / Employee_Count AS Hours,
       invdtl.Amount / Employee_Count AS Amount
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS inv
INNER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFContracts AS cntrct ON cntrct.DBNAME = inv.DBNAME AND cntrct.ContractCode = inv.ContractCode
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOffices AS off ON off.DBNAME = inv.DBNAME AND off.OfficeNumber = inv.Office
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFClients AS cl ON cl.DBName = inv.DBName AND cl.Number = inv.ClientNumber
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFServices AS srvc ON cl.DBName = srvc.DBName AND cl.ServiceArea = srvc.Area
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFEmployees AS emp ON invdtl.DBName = emp.DBName AND NULLIFZERO( invdtl.EmployeeNo2) = emp.Number
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE) 
--AND inv.DBName = 'TN'
AND invdtl.EmployeeNo2 IS NOT NULL
AND invdtl.EmployeeNo2 <> 0 
--AND inv.InvoiceNo = 9656
UNION
SELECT 'Dataflex' AS AMS_Source_System,
       'Great Plains' AS Payroll_Source_System,
       inv.DBNAME AS State, inv.OFFICE, off.OfficeName AS Office_Name,
       inv.Period AS Period,
       inv.INVOICECREATEDDATE AS Invoice_Create_Date, 
       inv.INVOICENO AS Invoice_Number, 
       inv.ClientNumber, 
       cl.FirstName||' '||cl.LastName AS ClientName,
       cl.DOB AS Client_Date_of_Birth,
       inv.CONTRACTCODE AS Contract_Code, 
       cntrct.ContractName AS Contract_Name, 
       cntrct.RevenueCategory AS Business_Segment,
       cntrct.RevenueSubCategory AS Service_Category, 
       inv.ServiceArea,
       srvc.GaurName AS Referral_Source,
       inv.MovedTo AS Moved_To,
       inv.ShortDesc AS Short_Desc,
       inv.HoursBilled AS "Billed_Hours-Header_Hours_Billed",
       inv.AMOUNTBILLED AS "Gross_Charge-Header_Amount_Billed", 
       inv.PAYMENTRECEIVED AS "Payment_Amount-Header_Payment_Received", 
       inv.LASTPAYDATE AS Payment_Date, inv.PAYERCODE, 
       inv.CREDITEDAMOUNT AS "Credited_Amount-Header_Credited_Amount", 
--       DATEDIFF( DAY, inv.InvoiceCreatedDate, pay.First_Pay_Date) AS Num_Days_to_First_Payment,
--       DATEDIFF( DAY, pay.Last_Pay_Date, inv.LastPayDate) AS Num_Days_to_Deposit,
--       NVL( pay.Number_of_Payments, 0) AS Number_of_Payments,
--       pay.Paid_Amount AS Total_Paid_Amount,
--       NVL( wrt.Number_of_WriteOffs, 0) AS Number_of_WriteOffs,
--       DATEDIFF( DAY, wrt.Last_WriteOff_Date, inv.LastPayDate) AS Num_Days_to_WriteOff,
--       wrt.WriteOff_Amount AS Total_WriteOff_Amount,
       inv.OUTSANDINGAMOUNT AS "Balance-Header_Outstanding_Amount",
--       CASE WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( wrt.WriteOff_Amount, 0) = 0 THEN 'Fully Paid'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( pay.Paid_Amount, 0) > 0 THEN 'Partially Paid, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount > 0 THEN 'Fully Written-Off, Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT > 0 AND inv.OUTSANDINGAMOUNT < inv.AmountBilled AND  inv.PAYMENTRECEIVED > 0 THEN 'Partially Paid, Non-Zero Balance'
--            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount = inv.AmountBilled THEN 'Fully Written-Off'
--            ELSE 'Billable' 
--       END AS INVOICE_STATUS,       inv.Status AS Status,
--       DATE_TRUNC( 'MONTH', ids.Start_Of_Service) AS Start_Service_Month,
       NULLIFZERO( invdtl.EmployeeNo3) AS Employee_Number,
       emp.FirstName||' '||cl.LastName AS Employee_Name,
       invdtl.DateFrom AS Start_Of_Service,
       invdtl.DateTo AS End_Of_Service,
       CASE WHEN invdtl.EmployeeNo2 IS NOT NULL AND invdtl.EmployeeNo2 <> 0 THEN 1 ELSE 0 END AS EmployeeNo2_Count,
       CASE WHEN invdtl.EmployeeNo3 IS NOT NULL AND invdtl.EmployeeNo3 <> 0 THEN 1 ELSE 0 END AS EmployeeNo3_Count,
       1 + EmployeeNo2_Count + EmployeeNo3_Count AS Employee_Count,
       invdtl.Hours / Employee_Count AS Hours,
       invdtl.Amount / Employee_Count AS Amount
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS inv
INNER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFContracts AS cntrct ON cntrct.DBNAME = inv.DBNAME AND cntrct.ContractCode = inv.ContractCode
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOffices AS off ON off.DBNAME = inv.DBNAME AND off.OfficeNumber = inv.Office
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFClients AS cl ON cl.DBName = inv.DBName AND cl.Number = inv.ClientNumber
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFServices AS srvc ON cl.DBName = srvc.DBName AND cl.ServiceArea = srvc.Area
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFEmployees AS emp ON invdtl.DBName = emp.DBName AND NULLIFZERO( invdtl.EmployeeNo3) = emp.Number
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE) 
--AND inv.DBName = 'TN'
AND invdtl.EmployeeNo3 IS NOT NULL
AND invdtl.EmployeeNo3 <> 0 
--AND inv.InvoiceNo = 9656
ORDER BY 1, 5, 6, 26, 25;