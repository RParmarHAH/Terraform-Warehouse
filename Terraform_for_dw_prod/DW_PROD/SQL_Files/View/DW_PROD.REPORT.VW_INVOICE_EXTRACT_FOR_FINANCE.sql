create or replace view DW_PROD.REPORT.VW_INVOICE_EXTRACT_FOR_FINANCE(
	STATE,
	OFFICE,
	OFFICE_NAME,
	PERIOD,
	INVOICE_CREATE_DATE,
	INVOICE_NUMBER,
	CLIENTNUMBER,
	CLIENTNAME,
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
	NUM_DAYS_TO_FIRST_PAYMENT,
	NUM_DAYS_TO_DEPOSIT,
	NUMBER_OF_PAYMENTS,
	TOTAL_PAID_AMOUNT,
	NUMBER_OF_WRITEOFFS,
	NUM_DAYS_TO_WRITEOFF,
	TOTAL_WRITEOFF_AMOUNT,
	"Balance-Header_Outstanding_Amount",
	INVOICE_STATUS,
	STATUS,
	START_SERVICE_MONTH,
	START_OF_SERVICE,
	END_OF_SERVICE,
	NUMBER_OF_VISITS,
	DETAIL_SUM_INVOICE_HOURS,
	DETAIL_SUM_INVOICE_AMOUNT,
	DETAIL_SUM_AMOUNT_PAID
) as
WITH invoice_detail_summary
AS
(
SELECT inv.DBName, inv.InvoiceNo, inv.InvoiceCreatedDate AS InvoiceDate, inv.Period, inv.Movedto, -- invdtl.BillCode, invdtl.ContractCode,
       inv.ClientNumber, cl.FirstName||' '||cl.LastName AS ClientName,
       MAX( NVL( invdtl.EmployeeNo1, NVL( invdtl.EmployeeNo2, invdtl.EmployeeNo3))) AS EmployeeID, -- emp.FirstName||' '||emp.LastName AS EmployeeName,
       MIN( invdtl.DateFrom) AS Start_Of_Service, MAX( invdtl.DateTo) AS End_Of_Service,
       inv.HoursBilled AS Header_Hours_Billed, inv.AmountBilled AS Header_Amount_Billed, inv.PaymentReceived AS Header_Payment_Received, inv.CreditedAmount AS Header_Credited_Amount, inv.OutsandingAmount AS Header_Outstanding_Amount,
       COUNT( invdtl.ReferenceNo) AS Detail_Record_Count,
       SUM( invdtl.Hours) AS Detail_Sum_Invoice_Hours,
       SUM( invdtl.Amount) AS Detail_Sum_Invoice_Amount,
       SUM( invdtl.AmountPaid) AS Detail_Sum_Amount_Paid
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv 
LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFInvoiceDetails AS invdtl ON invdtl.DBNAME = inv.DBNAME AND invdtl.INVOICENO = inv.INVOICENO
LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFClients AS cl ON inv.DBNAME = cl.DBNAME AND inv.ClientNumber = cl.Number
-- LEFT OUTER JOIN DISC_Prod.DataFlexSyncData.DFEmployees AS emp ON invdtl.DBNAME = emp.DBNAME AND NVL( invdtl.EmployeeNo1, NVL( invdtl.EmployeeNo2, invdtl.EmployeeNo3)) = emp.Number
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE)
--AND TRIM( inv.DBName) = 'TN'
--AND inv.Period BETWEEN 201801 and 202006
--AND invdtl.InvoiceNo = 52472
GROUP BY inv.DBName, inv.InvoiceNo, inv.Period, inv.Movedto, inv.InvoiceCreatedDate, inv.HoursBilled, inv.AmountBilled, inv.PaymentReceived, inv.CreditedAmount, inv.OutsandingAmount, inv.ClientNUmber, cl.FirstName||' '||cl.LastName --, emp.FirstName||' '||emp.LastName --, invdtl.EmployeeNo1 --, invdtl.BillCode, invdtl.ContractCode
ORDER BY inv.DBName, inv.InvoiceCreatedDate, inv.InvoiceNo, inv.ClientNUmber  
-- 1,212,029 records
),
invoice_payment_summary
AS
(
SELECT pay.DBName, pay.InvoiceNo, 
       MIN( pay.ReferenceNo) AS First_Reference_Number,
       MAX( pay.ReferenceNo) AS Last_Reference_Number,
       CAST( MIN( pay.PaymentDateTime) AS DATE) AS First_Pay_Date,
       CAST( MAX( pay.PaymentDateTime) AS DATE) AS Last_Pay_Date,
       CAST( MIN( pay.AddedDate) AS DATE) AS First_Payment_Record_Date,
       CAST( MAX( pay.AddedDate) AS DATE) AS Last_Payment_Record_Date,
       CAST( MIN( pay.ChangedDate) AS DATE) AS First_Payment_Change_Date,
       CAST( MAX( pay.ChangedDate) AS DATE) AS Last_Payment_Change_Date,
       MIN( pay.AuditNo) AS Payment_Min_Audit_Number,
       MAX( pay.AuditNo) AS Payment_Max_Audit_Number,
       COUNT( pay.PaidAmount) AS Number_Of_Payments,
       SUM( pay.PaidAmount) AS Paid_Amount
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv 
LEFT OUTER JOIN DISC_PROD.DataFlexSyncData.DFInvoicePayments AS pay ON pay.DBNAME = inv.DBNAME AND pay.INVOICENO = inv.INVOICENO AND pay.PaidAmount <> 0
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE)
--AND TRIM( inv.DBName) = 'TN'
--AND inv.invoiceno = 53320
GROUP BY 1, 2
),
invoice_writeoff_summary
AS
(
SELECT pay.DBName, pay.InvoiceNo, 
       MIN( pay.ReferenceNo) AS First_Reference_Number,
       MAX( pay.ReferenceNo) AS Last_Reference_Number,
       CAST( MIN( pay.PaymentDateTime) AS DATE) AS First_WriteOff_Date,
       CAST( MAX( pay.PaymentDateTime) AS DATE) AS Last_WriteOff_Date,
       CAST( MIN( pay.AddedDate) AS DATE) AS First_WriteOff_Record_Date,
       CAST( MAX( pay.AddedDate) AS DATE) AS Last_WriteOff_Record_Date,
       CAST( MIN( pay.ChangedDate) AS DATE) AS First_WriteOff_Change_Date,
       CAST( MAX( pay.ChangedDate) AS DATE) AS Last_WriteOff_Change_Date,
       MIN( pay.AuditNo) AS WriteOff_Min_Audit_Number,
       MAX( pay.AuditNo) AS WriteOff_Max_Audit_Number,
       COUNT( pay.WriteOffAmount) AS Number_Of_WriteOffs,
       SUM( pay.WriteOffAmount) AS WriteOff_Amount
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv 
LEFT OUTER JOIN DISC_PROD.DataFlexSyncData.DFInvoicePayments AS pay ON pay.DBNAME = inv.DBNAME AND pay.INVOICENO = inv.INVOICENO AND pay.WriteOffAmount <> 0
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE)
--AND TRIM( inv.DBName) = 'TN'
--AND inv.invoiceno = 53320
GROUP BY 1, 2
)
SELECT inv.DBNAME AS State, inv.OFFICE, off.OfficeName AS Office_Name,
       inv.Period AS Period,
       inv.INVOICECREATEDDATE AS Invoice_Create_Date, 
       inv.INVOICENO AS Invoice_Number, 
       inv.ClientNumber, 
       cl.FirstName||' '||cl.LastName AS ClientName,
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
       DATEDIFF( DAY, inv.InvoiceCreatedDate, pay.First_Pay_Date) AS Num_Days_to_First_Payment,
       DATEDIFF( DAY, pay.Last_Pay_Date, inv.LastPayDate) AS Num_Days_to_Deposit,
       NVL( pay.Number_of_Payments, 0) AS Number_of_Payments,
       pay.Paid_Amount AS Total_Paid_Amount,
       NVL( wrt.Number_of_WriteOffs, 0) AS Number_of_WriteOffs,
       DATEDIFF( DAY, wrt.Last_WriteOff_Date, inv.LastPayDate) AS Num_Days_to_WriteOff,
       wrt.WriteOff_Amount AS Total_WriteOff_Amount,
       inv.OUTSANDINGAMOUNT AS "Balance-Header_Outstanding_Amount",
       CASE WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( wrt.WriteOff_Amount, 0) = 0 THEN 'Fully Paid'
            WHEN inv.OUTSANDINGAMOUNT = 0 AND NVL( pay.Paid_Amount, 0) > 0 THEN 'Partially Paid, Zero Balance'
            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount > 0 THEN 'Fully Written-Off, Zero Balance'
            WHEN inv.OUTSANDINGAMOUNT > 0 AND inv.OUTSANDINGAMOUNT < inv.AmountBilled AND  inv.PAYMENTRECEIVED > 0 THEN 'Partially Paid, Non-Zero Balance'
            WHEN inv.OUTSANDINGAMOUNT = 0 AND wrt.WriteOff_Amount = inv.AmountBilled THEN 'Fully Written-Off'
            ELSE 'Billable' 
       END AS INVOICE_STATUS,       inv.Status AS Status,
       DATE_TRUNC( 'MONTH', ids.Start_Of_Service) AS Start_Service_Month,
       ids.Start_Of_Service,
       ids.End_Of_Service,
       ids.Detail_Record_Count AS Number_Of_Visits,
       ids.Detail_Sum_Invoice_Hours,
       ids.Detail_Sum_Invoice_Amount,
       ids.Detail_Sum_Amount_Paid
FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS inv
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFContracts AS cntrct ON cntrct.DBNAME = inv.DBNAME AND cntrct.ContractCode = inv.ContractCode
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOffices AS off ON off.DBNAME = inv.DBNAME AND off.OfficeNumber = inv.Office
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFClients AS cl ON cl.DBName = inv.DBName AND cl.Number = inv.ClientNumber
LEFT OUTER JOIN DISC_PROD.DATAFLEXSYNCDATA.DFServices AS srvc ON cl.DBName = srvc.DBName AND cl.ServiceArea = srvc.Area
LEFT OUTER JOIN invoice_detail_summary AS ids ON ids.DBName = inv.DBName AND ids.InvoiceNo = inv.InvoiceNo
LEFT OUTER JOIN invoice_payment_summary AS pay ON pay.DBName = inv.DBName AND pay.InvoiceNo = inv.InvoiceNo
LEFT OUTER JOIN invoice_writeoff_summary AS wrt ON wrt.DBName = inv.DBName AND wrt.InvoiceNo = inv.InvoiceNo
WHERE inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE) 
--AND inv.DBName = 'TN'
--AND  inv.Period >= '201601'
--AND inv.INVOICECREATEDDATE BETWEEN CAST( '2021-01-01' AS DATE) AND CAST( CURRENT_DATE AS DATE)
--AND inv.INVOICECREATEDDATE BETWEEN CAST( '2020-01-01' AS DATE) AND CAST( '2020-12-31' AS DATE)
--AND inv.INVOICECREATEDDATE BETWEEN CAST( '2019-01-01' AS DATE) AND CAST( '2019-12-31' AS DATE)
--AND inv.INVOICECREATEDDATE BETWEEN CAST( '2018-01-01' AS DATE) AND CAST( '2018-12-31' AS DATE)
--AND inv.INVOICECREATEDDATE BETWEEN CAST( '2017-01-01' AS DATE) AND CAST( '2017-12-31' AS DATE)
--AND inv.invoiceno = 53320
ORDER BY inv.DBNAME, inv.INVOICECREATEDDATE, inv.InvoiceNo;