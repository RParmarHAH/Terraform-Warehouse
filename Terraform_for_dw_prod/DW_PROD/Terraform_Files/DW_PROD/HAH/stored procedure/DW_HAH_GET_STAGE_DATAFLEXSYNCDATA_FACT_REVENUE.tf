resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_FACT_REVENUE" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_FACT_REVENUE"
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
-- NAME:  DataFlexSyncData_FACT_REVENUE
--
-- PURPOSE: Creates one row per invoice detail by day according to Dataflexsync
--
-- NOTE: Branch, Office, Supervisor mapping have not been included
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/04/20     Greg Marsh           Initial Development
-- 02/10/20		Mohd Kamaludin		 Changed Fact Revenue from based on timesheets to invoice details
-- 02/17/20     Mohd Kamaludin       Moved timesheet from CTE to main query, and updated amount and rate logic
-- 02/18/20     Mohd Kamaludin       Added BillCode as part of Revenue Key to remove duplicate keys
-- 02/21/20     Mohd Kamaludin       Added ratio from timesheets. Amount now matches invoice detail to the penny
-- 02/27/20     Mohd Kamaludin       Switched Revenue date to InvoiceCreateDate from DFInvoice master table
-- 03/05/20     Greg Marsh           Synced the invoice header with detail to make sure the Fact reflects
-- 12/24/20     Mir Ali              Changed keys to use OfficeNumber instead of OfficeName 
-- 02/04/21		Mir Ali				Added numbers from DfArInvoice (bulk billing/aging)
-- 02/28/22     Deven Kapasi         Leveraged dataflex dedupe tables
-- 08/26/22     Jashvant Patel       Leaveraged History tables to display deleted data
-- 05/11/23		Pinkal Panchal		Payment Date logic changes for RCM
-- 15/06/23     Deepen Gajjar        Modifed logic for Branch key
-- 14/07/23 	Pinkal Panchal		Modified logic of Amount_Billed. Amount_Collected and Amount_Outstanding for RCM
-- 15/06/23		PINKAL PANCHAL		Added PAYMENTMETHOD condition for Aging invoices for RCM
-- 18/07/23 	PINKAL PANCHAL		Updated the payments table to exclude the Payment_date if the CODE is ''WO''
-- 09/08/23     Mirisha             Dedupe change for Client_key(MASTER_CLIENT_NUMBER), Employee_key(MASTER_EMPLOYEE_NUMBER)
-- 25/11/23     Pradeep Thippani    Added bill_unit_type column for RCM(Requested By Natalie)
-- 28/12/23     Pooonit Mistry (OLLION) Acccount for removal or revenue records that have MOVEDTO flag associated with them
-- 12/02/24     Pradeep Thippani    Taking PAYMENTDATETIME instead of CREATEDDATE from DFINVOICEPAYMENTS Table for PAYMENT_DATE.
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.DataFlexSyncData_FACT_REVENUE
      WITH CLIENT_DATA AS (SELECT *
                             FROM (SELECT TRIM(DBNAME)                                    AS MASTER_DBNAME,
                                          TRIM(REGEXP_REPLACE(MASTER_ID, DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER,
                                          TRIM(DBNAME)                                    AS DBNAME,
                                          "NUMBER"                                        AS CLIENT_NUMBER,
                                          OFFICENUMBER                                    AS OFFICE_NUMBER
                                   FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST)
                             UNION
                             SELECT *
                             FROM (SELECT TRIM(MASTER.DBNAME)                                           AS MASTER_DBNAME,
                                          TRIM(REGEXP_REPLACE(MASTER.MASTER_ID, MASTER.DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER,
                                          TRIM(MATCH.DBNAME)                                            AS DBNAME,
                                          MATCH."NUMBER"                                                AS CLIENT_NUMBER,
                                          MATCH.OFFICENUMBER                                            AS OFFICE_NUMBER
                                   FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MATCH_LIST AS MATCH
                                            JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST AS MASTER
                                                 ON MASTER.MASTER_ID = MATCH.MASTER_ID
                                   WHERE MATCH.ID <> MATCH.MASTER_ID)),
             EMPLOYEES AS (SELECT *,
                                  TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
                                  TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
                           FROM (SELECT TRIM(DBNAME)                                    AS MASTER_DBNAME,
                                        TRIM(REGEXP_REPLACE(MASTER_ID, DBNAME))::NUMBER AS MASTER_EMPLOYEE_NUMBER,
                                        TRIM(DBNAME)                                    AS DBNAME,
                                        "NUMBER"                                        AS EMPLOYEE_NUMBER
                                 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST)
                           UNION
                           SELECT *,
                                  TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
                                  TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
                           FROM (SELECT TRIM(MASTER.DBNAME)                                           AS MASTER_DBNAME,
                                        TRIM(REGEXP_REPLACE(MASTER.MASTER_ID, MASTER.DBNAME))::NUMBER AS MASTER_EMPLOYEE_NUMBER,
                                        TRIM(MATCH.DBNAME)                                            AS DBNAME,
                                        MATCH."NUMBER"                                                AS EMPLOYEE_NUMBER
                                 FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MATCH_LIST AS MATCH
                                          JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST AS MASTER
                                               ON MASTER.MASTER_ID = MATCH.MASTER_ID
                                 WHERE MATCH.ID <> MATCH.MASTER_ID)),
             VIS1 AS (SELECT TH.REFERENCENO,
                             TH.DBNAME,
                             TH.WEEKENDDATE,
                             TH.SERVICEDATE,
                             (FLOOR(TH.Servicehours * 4)) / 4 as SERVICEHOURS,
                             ts1.employeenumber,
                             --Used FLOOR logic to match TIMESHEETSHOURS hours with DFINVOICEDETAILS hours
                             TS1.CLIENTNUMBER,
                             TS1.BILLCODE,
                             ts1.supervisorcode,
                             ts1.offceno,
                             ts1.contractcode--,
                      -- SUM(TH.SERVICEHOURS) OVER (
                      --     PARTITION BY TH.SERVICEDATE,
                      --     ts1.EMPLOYEENUMBER,
                      --     CLIENTNUMBER,
                      --     BILLCODE,
                      --     TH.DBNAME,
                      --     CONTRACTCODE
                      -- ) as SRVHOURS,
                      -- IFF(
                      --     TH.SERVICEHOURS > 0,
                      --     SRVHOURS / SUM(TH.SERVICEHOURS) OVER (
                      --         PARTITION BY TH.SERVICEDATE,
                      --         CLIENTNUMBER,
                      --         BILLCODE,
                      --         TH.DBNAME,
                      --         CONTRACTCODE
                      --     ),
                      --     0
                      -- ) as RATIO
                      FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS TH
                               LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 ON TH.DBNAME = TS1.DBNAME
                          AND TH.REFERENCENO = TS1.REFERENCENO
                          AND TH.WEEKENDDATE = TS1.WEEKENDDATE),
             VIS2 AS (SELECT MAX(TH.REFERENCENO)                   AS REFERENCENO,
                             TH.DBNAME,
                             TH.WEEKENDDATE,
                             TH.SERVICEDATE,
                             (FLOOR(sum(TH.Servicehours * 4))) / 4 as SERVICEHOURS,
                             ts1.employeenumber,
                             TS1.CLIENTNUMBER,
                             TS1.BILLCODE,
                             ts1.supervisorcode,
                             ts1.offceno,
                             ts1.contractcode--,  SUM(TH.SERVICEHOURS) as SRVHOURS, ''1'' as RATIO
                      FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS TH
                               LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1
                                         ON TH.DBNAME = TS1.DBNAME AND TH.REFERENCENO = TS1.REFERENCENO
                                             AND TH.WEEKENDDATE = TS1.WEEKENDDATE
                      group by ALL),
             VIS_UNION AS (SELECT *
                           FROM VIS1
                           UNION
                           SELECT *
                           FROM VIS2),
             VIS as (select *,
                            SUM(V.SERVICEHOURS) OVER (
                                PARTITION BY SERVICEDATE,
                                    EMPLOYEENUMBER,
                                    CLIENTNUMBER,
                                    BILLCODE,
                                    DBNAME,
                                    CONTRACTCODE
                                ) as SRVHOURS,
                            IFF(
                                        SERVICEHOURS > 0,
                                        SRVHOURS / SUM(SERVICEHOURS) OVER (
                                            PARTITION BY SERVICEDATE,
                                                CLIENTNUMBER,
                                                BILLCODE,
                                                DBNAME,
                                                CONTRACTCODE
                                            ),
                                        0
                                ) as RATIO
                     from VIS_UNION V)
        SELECT DISTINCT MD5(
                                    NVL(VIS.servicedate, ''1900-01-01'') || ''-'' ||
                                    COALESCE(oc.OFFICENUMBER, VIS.OFFCENO::string, ''-1'') || ''-'' ||
                                    UPPER(NVL(TRIM(VIS.EMPLOYEENUMBER), '''')) || ''-'' ||
                                    NVL(det.CLIENTNUMBER, -1) || ''-'' ||
                                    COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, ''-1'') ||
                                    ''-'' || NVL(det.INVOICENO, -1) || ''-'' ||
                                    NVL(VIS.SUPERVISORCODE, ''Unknown-'' || det.DBNAME) || ''-'' ||
                                    COALESCE(VIS.BILLCODE, det.BILLCODE, ''Unknown'') || ''-'' ||
                                    nvl(det.REFERENCENO, ''UNKNOWN'') || ''-'' ||
                                    NVL(VIS.REFERENCENO, ''-1'') || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                       AS REVENUE_KEY,
                        COALESCE(VIS.SERVICEDATE::DATE, det.DATEFROM, inv.INVOICECREATEDDATE, det.CREATEDDATE,
                                 ''1900-01-01'')                                    AS REPORT_DATE,
                        MD5(
                                    det.DBNAME || ''-'' || COALESCE(
                                        oc.OFFICENUMBER::NUMBER,
                                        VIS.OFFCENO::NUMBER,
                                        INV.OFFICE::NUMBER,
                                        ''-1''
                                    ) || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                       AS BRANCH_KEY,
                        MD5(
                                    NVL(EMP.MASTER_DBNAME, det.DBNAME) || ''-'' || UPPER(
                                        NVL(
                                                TRIM(
                                                        NVL(EMP.MASTER_EMPLOYEE_NUMBER, VIS.EMPLOYEENUMBER)
                                                    ),
                                                ''''
                                            )
                                    ) || ''-'' || ''1900-01-01'' || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                       AS EMPLOYEE_KEY,
                        MD5(
                                    NVL(cli.MASTER_DBNAME, det.DBNAME) || ''-'' || NVL(
                                        NVL(cli.MASTER_CLIENT_NUMBER, det.CLIENTNUMBER),
                                        -1
                                    ) || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                       AS CLIENT_KEY,
                        MD5(
                                    det.DBNAME || ''-'' || COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, ''-1'') ||
                                    ''-'' ||
                                    ''DATAFLEXSYNCDATA''
                            )                                                       AS CONTRACT_KEY,
                        MD5(
                                det.DBNAME || ''-'' || det.INVOICENO || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                       AS INVOICE_KEY,
                        3                                                           AS SOURCE_SYSTEM_ID,
                        MD5(
                                    det.DBNAME || ''-'' || NVL(VIS.SUPERVISORCODE, ''Unknown-'' || det.DBNAME) ||
                                    ''-'' ||
                                    ''DATAFLEXSYNCDATA''
                            )                                                       AS SUPERVISOR_KEY,
                        COALESCE(
                                inv.INVOICECREATEDDATE,
                                det.CREATEDDATE,
                                ''1900-01-01''
                            )                                                       AS REVENUE_DATE,
                        COALESCE(pay.CREATEDDATE, invpay.PAYMENTDATE)               AS PAYMENT_DATE, -- Modified on 12/02/24 by Pradeep Thippani for RCM.
                        NVL(oc.OFFICENAME, ''Unknown'')                             AS BRANCH_NAME,
                        NVL(EMP.EMPLOYEE_NUMBER, VIS.EMPLOYEENUMBER)                AS EMPLOYEE_ID,
                        NVL(cli.CLIENT_NUMBER, det.CLIENTNUMBER)                    AS CLIENT_NUMBER,
                        COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, ''-1'')        AS CONTRACT_CODE,
                        det.INVOICENO::STRING                                       AS INVOICE_NUMBER,
                        ''Regular''                                                 AS INVOICE_TYPE,
                        ''HOURLY''                                                  AS BILL_UNIT_TYPE,
                        1                                                           AS NUMBER_OF_CLIENTS,
                        det.DBNAME                                                  AS SYSTEM_CODE,
                        -1                                                          AS SUPERVISOR_CODE,
                        COALESCE(VIS.BILLCODE, det.BILLCODE, ''Unknown'')           AS BILL_CODE,
                        det.hours * NVL(VIS.RATIO, 1) /
                        (datediff(day, DATEFROM, NVL(DATETO, DATEFROM)) + 1)        as INVOICE_HOURS,
                        IFF(det.HOURS > 0, det.AMOUNT / det.HOURS, -1)              AS INVOICE_RATE,
                        (
                                inv.AmountBilled / (
                                COUNT(1) OVER (PARTITION BY det.INVOICENO, det.DBNAME)
                                )
                            )                                                       AS AMOUNT_BILLED,
                        (
                                inv.PAYMENTRECEIVED / (
                                COUNT(1) OVER (PARTITION BY det.INVOICENO, det.DBNAME)
                                )
                            )                                                       AS AMOUNT_COLLECTED,
                        (
                                (inv.AmountBilled - inv.PAYMENTRECEIVED) / (
                                COUNT(1) OVER (PARTITION BY det.INVOICENO, det.DBNAME)
                                )
                            )                                                       AS AMOUNT_OUTSTANDING,
                        ---- ETL FIELDS ___
                        :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY,
                        :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY,
                        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
                        CURRENT_USER                                                as ETL_INSERTED_BY,
                        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
                        CURRENT_USER                                                as ETL_LAST_UPDATED_BY,
                        0                                                           as ETL_DELETED_FLAG
        FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_DFINVOICEDETAILS det
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFINVOICES inv ON det.DBNAME = inv.DBNAME
            AND det.INVOICENO = inv.INVOICENO
            AND inv.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN (SELECT SUM(DFPD.AMOUNT)      AS AMOUNT,
                                   DFPD.INVOICENO,
                                   DFPD.DBNAME,
                                   MAX(DFPD.CREATEDDATE) AS CREATEDDATE
                            FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFPAYMENTDETAILS DFPD
                                     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFPAYMENTS AS DFP
                                               ON DFPD.CLIENTNUMBER = DFP.CLIENTNUMBER
                                                   AND DFPD.PAYMENTNO = DFP.PAYMENTNO
                            WHERE DFP.CODE <> ''WO''
                            GROUP BY DFPD.INVOICENO,
                                     DFPD.DBNAME) pay ON det.DBNAME = pay.DBNAME
            AND det.INVOICENO = pay.INVOICENO
                 LEFT JOIN (SELECT DFIP.INVOICENO,
                                   DFIP.DBNAME,
                                   MAX(DFIP.PAYMENTDATETIME) AS PAYMENTDATE  -- changed on 12/02/2024 by Pradeep thippani for RCM
                            FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFINVOICEPAYMENTS DFIP
                            WHERE DFIP.CODE <> ''WO''
                            GROUP BY DFIP.INVOICENO,
                                     DFIP.DBNAME) invpay ON det.DBNAME = invpay.DBNAME
            AND det.INVOICENO =
                invpay.INVOICENO --Modified on 17/07/23 by Pinkal updated the procedure to not grab the date if the record in DFPayments has field Code = WO
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS con ON inv.DBNAME = con.DBNAME
            AND inv.CONTRACTCODE = con.CONTRACTCODE
            AND con.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS spr ON det.DBNAME = spr.DBNAME
            AND det.CLIENTNUMBER = spr.CLIENTNUMBER
            AND con.PAYORCODE = spr.BUSINESSLINE
            AND spr.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN CLIENT_DATA cli ON det.DBNAME = cli.DBNAME
            AND det.CLIENTNUMBER = cli.Client_number
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES oc ON cli.DBNAME = oc.DBNAME
            AND cli.OFFICE_NUMBER = oc.OFFICENUMBER
            AND oc.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN VIS ON VIS.CLIENTNUMBER = det.CLIENTNUMBER
            AND (
                                              VIS.BILLCODE = det.BILLCODE
                                          OR det.BILLCODE = ''''
                                      )
            AND Det.datefrom <= VIS.SERVICEDATE
            and NVL(det.DATETO, det.DATEFROM) >= VIS.SERVICEDATE --det.DATEFROM
            AND VIS.SERVICEHOURS = det.HOURS
            AND VIS.DBNAME = det.DBNAME
                 left join EMPLOYEES EMP on VIS.EMPLOYEENUMBER = EMP.EMPLOYEE_number
            and VIS.DBNAME = EMP.DBNAME
        WHERE con.PAYMENTMETHOD != ''3''
          AND --Added on 14/06/23 for RCM by Pinkal
            inv.movedto = '''';

        -- Bulk billing invoices (from DfArInvoices -- unique key for details is INV.DBNAME, INV.INVOICENUMBER, INV.OFFICE, INV.PERIOD, INV.CONTRACTCODE, INV.SERVICEAREA, INV.SUPPLEMENTNO)
        INSERT INTO DW_${var.SF_ENVIRONMENT}.STAGE.DATAFLEXSYNCDATA_FACT_REVENUE
        WITH AR_DIM_INVOICE_CHANGED_DATA AS (SELECT DISTINCT I.DBNAME,
                                                             I.INVOICENUMBER,
                                                             I.OFFICE,
                                                             I.PERIOD,
                                                             I.CONTRACTCODE,
                                                             MD5(
                                                                         I.DBNAME || ''-'' || I.INVOICENUMBER ||
                                                                         ''-'' ||
                                                                         I.OFFICE || ''-'' || I.PERIOD || ''-'' ||
                                                                         I.CONTRACTCODE ||
                                                                         ''-'' || ''DATAFLEXSYNCDATA-DFARINVOICES''
                                                                 ) AS INVOICE_KEY
                                             FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES I),
             AR_DIM_INVOICE AS (SELECT INV.DBNAME,
                                       INV.INVOICENUMBER,
                                       INV.SUPPLEMENTNO,
                                       DATEFROMPARTS(
                                               LEFT(TRIM(INV.PERIOD), 4),
                                               RIGHT(TRIM(INV.PERIOD), 2),
                                               1
                                           )                                                 AS PERIOD_DATE,
                                       INV.PERIOD,
                                       INV.CONTRACTCODE                                      AS CONTRACT_CODE,
                                       INV.OFFICE,
                                       INV.SERVICEAREA,
                                       CHANGED_DATA.INVOICE_KEY,
                                       COALESCE(
                                               BRANCH.BRANCH_KEY,
                                               MD5(
                                                       INV.DBNAME || ''-'' || INV.OFFICE || ''-'' || ''DATAFLEXSYNCDATA''
                                                   )
                                           )                                                 AS BRANCH_KEY,
                                       COALESCE(
                                               BRANCH.BRANCH_NAME,
                                               CONCAT(INV.DBNAME, ''-Unknown'')
                                           )                                                 AS BRANCH_NAME,
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)         AS DUMMY_CLIENT_NUMBER,
                                       -- Dummy clients/employees are in Dim_Client with -100 appended to office number
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)         AS DUMMY_EMPLOYEE_NUMBER,
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)::STRING AS DUMMY_SUPERVISOR_CODE,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_CLIENT_NUMBER || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_CLIENT_KEY,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_EMPLOYEE_NUMBER || ''-'' ||
                                                   ''1900-01-01'' || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_EMPLOYEE_KEY,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_SUPERVISOR_CODE || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_SUPERVISOR_KEY,
                                       MD5(
                                               INV.DBNAME || ''-'' || INV.CONTRACTCODE || ''-'' || ''DATAFLEXSYNCDATA''
                                           )                                                 AS CONTRACT_KEY,
                                       INV.DATECREATED,
                                       INV.HOURSBILLED                                       AS HOURS_BILLED,
                                       INV.AMOUNTBILLED                                      AS AMOUNT_BILLED,
                                       INV.CLIENTBILLED                                      AS NUMBER_OF_CLIENTS,
                                       INV.OUTSTANDING                                       AS AMOUNT_OUTSTANDING,
                                       INV.GROSSPAID                                         AS AMOUNT_COLLECTED,
                                       INV.LASTPAYDATE
                                FROM AR_DIM_INVOICE_CHANGED_DATA AS CHANGED_DATA
                                         JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES INV
                                              ON INV.DBNAME = CHANGED_DATA.DBNAME
                                                  AND INV.INVOICENUMBER = CHANGED_DATA.INVOICENUMBER
                                                  AND INV.OFFICE = CHANGED_DATA.OFFICE
                                                  AND INV.PERIOD = CHANGED_DATA.PERIOD
                                                  AND INV.CONTRACTCODE = CHANGED_DATA.CONTRACTCODE
                                         LEFT JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SOURCE_SYSTEM_ID = 3
                                    AND BRANCH.SYSTEM_CODE = INV.DBNAME
                                    AND BRANCH.OFFICE_CODE = INV.OFFICE::STRING)
        SELECT MD5(
                           INV.DBNAME || ''-'' || INV.PERIOD || ''-'' || INV.OFFICE || ''-'' ||
                           INV.DUMMY_EMPLOYEE_NUMBER || ''-'' ||
                           INV.DUMMY_CLIENT_NUMBER || ''-'' || INV.CONTRACT_CODE || ''-'' || INV.INVOICENUMBER ||
                           ''-'' ||
                           INV.DUMMY_SUPERVISOR_CODE || ''-'' || INV.SERVICEAREA || ''-'' || INV.SUPPLEMENTNO ||
                           ''-'' ||
                           ''DATAFLEXSYNCDATA-DFARINVOICES''
                   )                                                       AS REVENUE_KEY,
               INV.PERIOD_DATE                                             AS REPORT_DATE,
               INV.BRANCH_KEY                                              AS BRANCH_KEY,
               INV.DUMMY_EMPLOYEE_KEY                                      AS EMPLOYEE_KEY,
               INV.DUMMY_CLIENT_KEY                                        AS CLIENT_KEY,
               INV.CONTRACT_KEY,
               INV.INVOICE_KEY,
               3                                                           AS SOURCE_SYSTEM_ID,
               INV.DUMMY_SUPERVISOR_KEY                                    AS SUPERVISOR_KEY,
               COALESCE(INV.DATECREATED, ''1900-01-01'')                   AS REVENUE_DATE,
               INV.LASTPAYDATE                                             AS PAYMENT_DATE,
               INV.BRANCH_NAME,
               INV.DUMMY_EMPLOYEE_NUMBER                                   AS EMPLOYEE_ID,
               INV.DUMMY_CLIENT_NUMBER                                     AS CLIENT_NUMBER,
               INV.CONTRACT_CODE,
               INV.INVOICENUMBER::STRING                                   AS INVOICE_NUMBER,
               ''Lump Sum''                                                AS INVOICE_TYPE,
               ''HOURLY''                                                  AS BILL_UNIT_TYPE,
               SUM(INV.NUMBER_OF_CLIENTS)                                  AS NUMBER_OF_CLIENTS,
               INV.DBNAME                                                  AS SYSTEM_CODE,
               INV.DUMMY_SUPERVISOR_CODE                                   AS SUPERVISOR_CODE,
               NULL                                                        AS BILL_CODE,
               SUM(INV.HOURS_BILLED)                                       AS INVOICE_HOURS,
               IFF(
                           NVL(SUM(INV.HOURS_BILLED), 0) = 0,
                           NULL,
                           NVL(SUM(INV.AMOUNT_BILLED), 0) / SUM(INV.HOURS_BILLED)
                   )                                                       AS INVOICE_RATE,
               SUM(INV.AMOUNT_BILLED)                                      AS AMOUNT_BILLED,
               SUM(INV.AMOUNT_COLLECTED)                                   AS AMOUNT_COLLECTED,
               SUM(INV.AMOUNT_OUTSTANDING)                                 AS AMOUNT_OUTSTANDING,
               ---- ETL FIELDS ___
               :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY,
               :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
               CURRENT_USER                                                as ETL_INSERTED_BY,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
               CURRENT_USER                                                as ETL_LAST_UPDATED_BY,
               0                                                           as ETL_DELETED_FLAG
        FROM AR_DIM_INVOICE AS INV
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS con --Added on 14/06/23 for RCM by Pinkal
                           ON inv.CONTRACT_CODE = con.CONTRACTCODE
                               AND inv.DBNAME = con.DBNAME
        WHERE con.PAYMENTMETHOD = ''3''
        GROUP BY REVENUE_KEY,
                 INV.PERIOD_DATE,
                 INV.BRANCH_KEY,
                 INV.DUMMY_EMPLOYEE_KEY,
                 INV.DUMMY_CLIENT_KEY,
                 INV.CONTRACT_KEY,
                 INV.INVOICE_KEY,
                 INV.DUMMY_SUPERVISOR_KEY,
                 REVENUE_DATE,
                 INV.LASTPAYDATE,
                 INV.BRANCH_NAME,
                 INV.DUMMY_EMPLOYEE_NUMBER,
                 INV.DUMMY_CLIENT_NUMBER,
                 INV.CONTRACT_CODE,
                 INV.INVOICENUMBER::STRING,
                 INV.DBNAME,
                 INV.DUMMY_SUPERVISOR_CODE;
        WITH AR_DIM_INVOICE_CHANGED_DATA AS (SELECT DISTINCT I.DBNAME,
                                                             I.INVOICENUMBER,
                                                             I.OFFICE,
                                                             I.PERIOD,
                                                             I.CONTRACTCODE,
                                                             MD5(
                                                                         I.DBNAME || ''-'' || I.INVOICENUMBER ||
                                                                         ''-'' ||
                                                                         I.OFFICE || ''-'' || I.PERIOD || ''-'' ||
                                                                         I.CONTRACTCODE ||
                                                                         ''-'' || ''DATAFLEXSYNCDATA-DFARINVOICES''
                                                                 ) AS INVOICE_KEY
                                             FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES I),
             AR_DIM_INVOICE AS (SELECT INV.DBNAME,
                                       INV.INVOICENUMBER,
                                       INV.SUPPLEMENTNO,
                                       DATEFROMPARTS(
                                               LEFT(TRIM(INV.PERIOD), 4),
                                               RIGHT(TRIM(INV.PERIOD), 2),
                                               1
                                           )                                                 AS PERIOD_DATE,
                                       INV.PERIOD,
                                       INV.CONTRACTCODE                                      AS CONTRACT_CODE,
                                       INV.OFFICE,
                                       INV.SERVICEAREA,
                                       CHANGED_DATA.INVOICE_KEY,
                                       COALESCE(
                                               BRANCH.BRANCH_KEY,
                                               MD5(
                                                       INV.DBNAME || ''-'' || INV.OFFICE || ''-'' || ''DATAFLEXSYNCDATA''
                                                   )
                                           )                                                 AS BRANCH_KEY,
                                       COALESCE(
                                               BRANCH.BRANCH_NAME,
                                               CONCAT(INV.DBNAME, ''-Unknown'')
                                           )                                                 AS BRANCH_NAME,
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)         AS DUMMY_CLIENT_NUMBER,
                                       -- Dummy clients/employees are in Dim_Client with -100 appended to office number
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)         AS DUMMY_EMPLOYEE_NUMBER,
                                       TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)::STRING AS DUMMY_SUPERVISOR_CODE,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_CLIENT_NUMBER || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_CLIENT_KEY,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_EMPLOYEE_NUMBER || ''-'' ||
                                                   ''1900-01-01'' || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_EMPLOYEE_KEY,
                                       MD5(
                                                   INV.DBNAME || ''-'' || DUMMY_SUPERVISOR_CODE || ''-'' ||
                                                   ''DATAFLEXSYNCDATA-DUMMY''
                                           )                                                 AS DUMMY_SUPERVISOR_KEY,
                                       MD5(
                                               INV.DBNAME || ''-'' || INV.CONTRACTCODE || ''-'' || ''DATAFLEXSYNCDATA''
                                           )                                                 AS CONTRACT_KEY,
                                       INV.DATECREATED,
                                       INV.HOURSBILLED                                       AS HOURS_BILLED,
                                       INV.AMOUNTBILLED                                      AS AMOUNT_BILLED,
                                       INV.CLIENTBILLED                                      AS NUMBER_OF_CLIENTS,
                                       INV.OUTSTANDING                                       AS AMOUNT_OUTSTANDING,
                                       INV.GROSSPAID                                         AS AMOUNT_COLLECTED,
                                       INV.LASTPAYDATE
                                FROM AR_DIM_INVOICE_CHANGED_DATA AS CHANGED_DATA
                                         JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFARINVOICES INV
                                              ON INV.DBNAME = CHANGED_DATA.DBNAME
                                                  AND INV.INVOICENUMBER = CHANGED_DATA.INVOICENUMBER
                                                  AND INV.OFFICE = CHANGED_DATA.OFFICE
                                                  AND INV.PERIOD = CHANGED_DATA.PERIOD
                                                  AND INV.CONTRACTCODE = CHANGED_DATA.CONTRACTCODE
                                         LEFT JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SOURCE_SYSTEM_ID = 3
                                    AND BRANCH.SYSTEM_CODE = INV.DBNAME
                                    AND BRANCH.OFFICE_CODE = INV.OFFICE::STRING)
        SELECT MD5(
                           INV.DBNAME || ''-'' || INV.PERIOD || ''-'' || INV.OFFICE || ''-'' ||
                           INV.DUMMY_EMPLOYEE_NUMBER || ''-'' ||
                           INV.DUMMY_CLIENT_NUMBER || ''-'' || INV.CONTRACT_CODE || ''-'' || INV.INVOICENUMBER ||
                           ''-'' ||
                           INV.DUMMY_SUPERVISOR_CODE || ''-'' || INV.SERVICEAREA || ''-'' || INV.SUPPLEMENTNO ||
                           ''-'' ||
                           ''DATAFLEXSYNCDATA-DFARINVOICES''
                   )                                                       AS REVENUE_KEY,
               INV.PERIOD_DATE                                             AS REPORT_DATE,
               INV.BRANCH_KEY                                              AS BRANCH_KEY,
               INV.DUMMY_EMPLOYEE_KEY                                      AS EMPLOYEE_KEY,
               INV.DUMMY_CLIENT_KEY                                        AS CLIENT_KEY,
               INV.CONTRACT_KEY,
               INV.INVOICE_KEY,
               3                                                           AS SOURCE_SYSTEM_ID,
               INV.DUMMY_SUPERVISOR_KEY                                    AS SUPERVISOR_KEY,
               COALESCE(INV.DATECREATED, ''1900-01-01'')                   AS REVENUE_DATE,
               INV.LASTPAYDATE                                             AS PAYMENT_DATE,
               INV.BRANCH_NAME,
               INV.DUMMY_EMPLOYEE_NUMBER                                   AS EMPLOYEE_ID,
               INV.DUMMY_CLIENT_NUMBER                                     AS CLIENT_NUMBER,
               INV.CONTRACT_CODE,
               INV.INVOICENUMBER::STRING                                   AS INVOICE_NUMBER,
               ''Lump Sum''                                                AS INVOICE_TYPE,
               ''HOURLY''                                                  AS BILL_UNIT_TYPE,
               SUM(INV.NUMBER_OF_CLIENTS)                                  AS NUMBER_OF_CLIENTS,
               INV.DBNAME                                                  AS SYSTEM_CODE,
               INV.DUMMY_SUPERVISOR_CODE                                   AS SUPERVISOR_CODE,
               NULL                                                        AS BILL_CODE,
               SUM(INV.HOURS_BILLED)                                       AS INVOICE_HOURS,
               IFF(
                           NVL(SUM(INV.HOURS_BILLED), 0) = 0,
                           NULL,
                           NVL(SUM(INV.AMOUNT_BILLED), 0) / SUM(INV.HOURS_BILLED)
                   )                                                       AS INVOICE_RATE,
               SUM(INV.AMOUNT_BILLED)                                      AS AMOUNT_BILLED,
               SUM(INV.AMOUNT_COLLECTED)                                   AS AMOUNT_COLLECTED,
               SUM(INV.AMOUNT_OUTSTANDING)                                 AS AMOUNT_OUTSTANDING,
               ---- ETL FIELDS ___
               :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY,
               :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
               CURRENT_USER                                                as ETL_INSERTED_BY,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
               CURRENT_USER                                                as ETL_LAST_UPDATED_BY,
               0                                                           as ETL_DELETED_FLAG
        FROM AR_DIM_INVOICE AS INV
                 LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS con --Added on 14/06/23 for RCM by Pinkal
                           ON inv.CONTRACT_CODE = con.CONTRACTCODE
                               AND inv.DBNAME = con.DBNAME
        WHERE con.PAYMENTMETHOD = ''3''
        GROUP BY REVENUE_KEY,
                 INV.PERIOD_DATE,
                 INV.BRANCH_KEY,
                 INV.DUMMY_EMPLOYEE_KEY,
                 INV.DUMMY_CLIENT_KEY,
                 INV.CONTRACT_KEY,
                 INV.INVOICE_KEY,
                 INV.DUMMY_SUPERVISOR_KEY,
                 REVENUE_DATE,
                 INV.LASTPAYDATE,
                 INV.BRANCH_NAME,
                 INV.DUMMY_EMPLOYEE_NUMBER,
                 INV.DUMMY_CLIENT_NUMBER,
                 INV.CONTRACT_CODE,
                 INV.INVOICENUMBER::STRING,
                 INV.DBNAME,
                 INV.DUMMY_SUPERVISOR_CODE;
        RETURN ''SUCCESS'';
    END ;

 EOT
}

