CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS
        --
        -- DEVELOPMENT LOG:
        -- DATE         AUTHOR                 NOTES:
        -- --------     -------------------    -----------------------------------------------------------------------------------------------
        -- 03/11/23 	PINKAL PANCHAL 		   INITIAL DEVELOPMENT
        -- 20/11/23     MUHAMMAD ZOROB         CHANGED GRAIN OF INVPAY CTE TO MATCH FACT_REV
        -- 04/12/23     POONIT MISTRY (OLLION) CHANGED PERIOD FILTER TO INCLUDE ALL 2021 FORWARD, CHANGE TO DIM_DATE JOIN REMOVE NVL
        -- 20/12/23     POONIT MISTRY (OLLION) CHANGE LOGIC FOR TRANSACTION_KEY TO ACCOUNT FOR DIFFERENT REFERENCENO HAS IT RELATES TO REVENUE RECRODS
        -- *****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS

        WITH CLIENT_DATA AS (SELECT *
                             FROM (SELECT TRIM(DBNAME)                                    AS MASTER_DBNAME,
                                          TRIM(REGEXP_REPLACE(MASTER_ID, DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER,
                                          TRIM(DBNAME)                                    AS DBNAME,
                                          "NUMBER"                                        AS CLIENT_NUMBER,
                                          OFFICENUMBER                                    AS OFFICE_NUMBER
                                   FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST)
                             UNION
                             SELECT *
                             FROM (SELECT TRIM(MASTER.DBNAME)                                           AS MASTER_DBNAME,
                                          TRIM(REGEXP_REPLACE(MASTER.MASTER_ID, MASTER.DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER,
                                          TRIM(MATCH.DBNAME)                                            AS DBNAME,
                                          MATCH."NUMBER"                                                AS CLIENT_NUMBER,
                                          MATCH.OFFICENUMBER                                            AS OFFICE_NUMBER
                                   FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MATCH_LIST AS MATCH
                                            JOIN DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST AS MASTER
                                                 ON MASTER.MASTER_ID = MATCH.MASTER_ID
                                   WHERE MATCH.ID <> MATCH.MASTER_ID)),
             VIS1 AS (SELECT TH.REFERENCENO,
                             TH.DBNAME,
                             TH.WEEKENDDATE,
                             TH.SERVICEDATE,
                             (FLOOR(TH.Servicehours * 4)) / 4 as SERVICEHOURS,
                             --Used FLOOR logic to match TIMESHEETSHOURS hours with DFINVOICEDETAILS hours
                             TS1.CLIENTNUMBER,
                             TS1.BILLCODE,
                             TS1.EMPLOYEENUMBER,
                             TS1.SUPERVISORCODE,
                             TS1.contractcode,
                             ts1.offceno
                      FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS TH
                               LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 ON TH.DBNAME = TS1.DBNAME
                          AND TH.REFERENCENO = TS1.REFERENCENO
                          AND TH.WEEKENDDATE = TS1.WEEKENDDATE),
             VIS2 AS (SELECT MAX(TH.REFERENCENO)                   AS REFERENCENO,
                             TH.DBNAME,
                             TH.WEEKENDDATE,
                             TH.SERVICEDATE,
                             (FLOOR(sum(TH.Servicehours * 4))) / 4 as SERVICEHOURS,
                             TS1.CLIENTNUMBER,
                             TS1.BILLCODE,
                             TS1.EMPLOYEENUMBER,
                             TS1.SUPERVISORCODE,
                             TS1.contractcode,
                             ts1.offceno
                      FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS TH
                               LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 ON TH.DBNAME = TS1.DBNAME
                          AND TH.REFERENCENO = TS1.REFERENCENO
                          AND TH.WEEKENDDATE = TS1.WEEKENDDATE
                      group by
                          ALL),
             VIS_UNION AS (SELECT *
                           FROM VIS1
                           UNION
                           SELECT *
                           FROM VIS2),
             INVPAY AS (SELECT REFERENCENO,
                               DBNAME,
                               INVOICENO,
                               CONTRACTCODE,
                               CLIENTNUMBER,
                               WRITEOFFREASON,
                               PAIDAMOUNT            AS AMOUNT,
                               Date(CREATEDDATE)     AS TRANSACTION_CREATED,
                               Date(PAYMENTDATETIME) AS TRANSACTION_POSTED,
                               CHECKNUMBER           AS CHECK_NUMBER,
                               Date(PAYMENTDATETIME) AS POSTED_DATE
                        FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEPAYMENTS
                        WHERE PERIOD > ''202012''
                        UNION
                        SELECT PD.REFERENCENO,
                               P.DBNAME,
                               PD.INVOICENO,
                               P.CONTRACTCODE,
                               P.CLIENTNUMBER,
                               P.WRITEOFFREASON,
                               --P.AMOUNT            AS AMOUNT,
                               pd.amount           as amount,
                               DATE(P.CREATEDDATE) AS TRANSACTION_CREATED,
                               DATE(P.PAYDATE)     AS TRANSACTION_POSTED,
                               P.CHECKNUMBER       AS CHECK_NUMBER,
                               DATE(P.PAYDATE)     AS POSTED_DATE
                        FROM DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTS P
                                 JOIN DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTDETAILS PD ON P.CLIENTNUMBER = PD.CLIENTNUMBER
                            AND P.PAYMENTNO = PD.PAYMENTNO
                            AND PD.DBNAME = P.DBNAME
                        WHERE DATE(P.PAYDATE) > ''2020-12-31'')
        SELECT DISTINCT MD5(
                                    ''DATAFLEXSYNCDATA'' || ''-'' || nvl(INVPAY.REFERENCENO, -1) || ''-'' ||
                                    nvl(INVPAY.DBNAME, ''UNKNOWN'') ||
                                    ''-'' ||
                                    NVL(INVPAY.INVOICENO, -1) || ''-'' || COALESCE(INVPAY.CONTRACTCODE, ''UNKNOWN'') ||
                                    ''-'' ||
                                    NVL(INVPAY.CLIENTNUMBER, -1) || ''-'' ||
                                    COALESCE(VIS.ServiceDate, DET.DATEFROM, ''1900-01-01'') ||
                                    ''-'' || nvl(VIS.REFERENCENO, -1) || ''-'' || nvl(DET.REFERENCENO, ''UNKNOWN'') ||
                                    ''-'' ||
                                    NVL(TRIM(VIS.EMPLOYEENUMBER), '''') || ''-'' ||
                                    COALESCE(VIS.SUPERVISORCODE, ''UNKNOWN'') ||
                                    ''-'' || ''DATAFLEXSYNCDATA'')                                                   AS TRANSACTION_KEY,
                        CONCAT(nvl(INVPAY.REFERENCENO::STRING, ''UNKNOWN''), ''-'',
                               NVL(INVPAY.DBNAME, ''UNKNOWN''))                                                      AS TRANSACTION_NUMBER,
                        MD5(
                                    NVL(VIS.servicedate, ''1900-01-01'') || ''-'' ||
                                    COALESCE(oc.OFFICENUMBER, VIS.OFFCENO::string, ''-1'') || ''-'' ||
                                    UPPER(NVL(TRIM(VIS.EMPLOYEENUMBER), '''')) || ''-'' || NVL(det.CLIENTNUMBER, -1) ||
                                    ''-'' ||
                                    COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, ''-1'') || ''-'' ||
                                    nvl(det.INVOICENO, -1) ||
                                    ''-'' ||
                                    NVL(VIS.SUPERVISORCODE, ''Unknown-'' || NVL(det.DBNAME, ''UNKNOWN'')) || ''-'' ||
                                    COALESCE(VIS.BILLCODE, det.BILLCODE, ''Unknown'') || ''-'' ||
                                    NVL(det.REFERENCENO, ''UNKNOWN'') ||
                                    ''-'' ||
                                    NVL(VIS.REFERENCENO, ''-1'') || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                                                        AS REVENUE_KEY,
                        MD5(
                                    COALESCE(VIS.DBNAME, DET.DBNAME, ''UNKNOWN'') || ''-'' ||
                                    COALESCE(VIS.REFERENCENO, DET.REFERENCENO, ''UNKNOWN'') || ''-'' ||
                                    COALESCE(VIS.WEEKENDDATE, ''1900-01-01'') || ''-'' ||
                                    COALESCE(VIS.SERVICEDATE, ''1900-01-01'') ||
                                    ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                                                        AS VISIT_KEY,
                        MD5(
                                    ''DATAFLEXSYNCDATA'' || ''-'' || NVL(INVPAY.WRITEOFFREASON::STRING, ''UNKNOWN'') ||
                                    INVPAY.DBNAME || ''-'' || ''DATAFLEXSYNCDATA''
                            )                                                                                        AS TRANSACTION_TYPE_KEY,
                        INVPAY.AMOUNT / COUNT(1) OVER (
                            PARTITION BY INVPAY.INVOICENO,
                                INVPAY.DBNAME,
                                INVPAY.REFERENCENO
                            )                                                                                        AS AMOUNT,
                        DATE(INVPAY.TRANSACTION_CREATED)                                                             AS TRANSACTION_CREATED,
                        DATE(INVPAY.TRANSACTION_POSTED)                                                              AS TRANSACTION_POSTED,
                        NULL                                                                                         AS TRANSACTION_DATE,
                        NULL                                                                                         AS FINAL_TRANSACTION_DATE,
                        INVPAY.CHECK_NUMBER                                                                          AS CHECK_NUMBER,
                        NULL                                                                                         AS CHECK_DATE --NOT TRACKED IN DATAFLEX
                ,
                        NULL                                                                                         AS DEPOSIT_DATE,
                        DATE(INVPAY.POSTED_DATE)                                                                     AS POSTED_DATE,
                        INVPAY.DBNAME                                                                                AS SYSTEM_CODE,
                        3                                                                                            AS SOURCE_SYSTEM_ID,
                        :STR_ETL_TASK_KEY                                                                            AS ETL_TASK_KEY
                ,
                        :STR_ETL_TASK_KEY                                                                            AS ETL_INSERTED_TASK_KEY
                ,
                        CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                  AS ETL_INSERTED_DATE
                ,
                        CURRENT_USER                                                                                 AS ETL_INSERTED_BY
                ,
                        CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                  AS ETL_UPDATED_DATE
                ,
                        CURRENT_USER                                                                                 AS ETL_LAST_UPDATED_BY
                ,
                        0                                                                                            AS ETL_DELETED_FLAG
        FROM INVPAY --DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEPAYMENTS INVPAY
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFINVOICEDETAILS det ON det.DBNAME = INVPAY.DBNAME
            AND det.INVOICENO = INVPAY.INVOICENO
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv ON inv.DBNAME = det.DBNAME
            AND inv.INVOICENO = det.INVOICENO
            AND inv.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS con ON con.DBNAME = inv.DBNAME
            AND con.CONTRACTCODE = inv.CONTRACTCODE
            AND con.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN CLIENT_DATA cli ON cli.DBNAME = det.DBNAME
            AND det.CLIENTNUMBER = cli.Client_number
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES oc ON oc.DBNAME = cli.DBNAME
            AND cli.OFFICE_NUMBER = oc.OFFICENUMBER
            AND oc.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN VIS_UNION VIS ON VIS.CLIENTNUMBER = det.CLIENTNUMBER
            AND (
                                                        VIS.BILLCODE = det.BILLCODE
                                                    OR det.BILLCODE = ''''
                                                )
            AND det.DATEFROM <= VIS.SERVICEDATE
            and NVL(det.DATETO, det.DATEFROM) >= VIS.SERVICEDATE
            AND VIS.SERVICEHOURS = det.HOURS
            AND VIS.DBNAME = det.DBNAME;


        RETURN ''SUCCESS'';
    END ;
';