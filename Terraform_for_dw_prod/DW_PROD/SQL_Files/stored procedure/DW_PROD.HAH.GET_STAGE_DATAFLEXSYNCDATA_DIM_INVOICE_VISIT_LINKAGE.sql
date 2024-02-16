CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_DIM_INVOICE_VISIT_LINKAGE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  DATAFLEXSYNCDATA_DIM_INVOICE_VISIT_LINKAGE
        --
        -- DEVELOPMENT LOG:A
        -- DATE         AUTHOR              NOTES:
        -- --------     ------------------- -----------------------------------------------------------------------------------------------
        -- 06/12/23		Pinkal Panchal 		Initial Development

        --*****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_DIM_INVOICE_VISIT_LINKAGE
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
                             ts1.employeenumber,
                             ts1.supervisorcode,
                             ts1.offceno,
                             ts1.contractcode
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
                             ts1.employeenumber,
                             ts1.supervisorcode,
                             ts1.offceno,
                             ts1.contractcode
                      FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS TH
                               LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 ON TH.DBNAME = TS1.DBNAME
                          AND TH.REFERENCENO = TS1.REFERENCENO
                          AND TH.WEEKENDDATE = TS1.WEEKENDDATE
                      group by
                          ALL),
             VIS_UNION AS (SELECT
                               *
                           FROM VIS1
                           UNION
                           SELECT *
                           FROM VIS2)
        SELECT DISTINCT MD5(
                    NVL(vis.servicedate, ''1900-01-01'') || ''-'' ||
                    COALESCE(oc.OFFICENUMBER, VIS.OFFCENO::string, ''-1'') || ''-'' ||
                    UPPER(NVL(TRIM(VIS.EMPLOYEENUMBER), '''')) || ''-'' || NVL(det.CLIENTNUMBER, -1) || ''-'' ||
                    COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, ''-1'') || ''-'' || det.INVOICENO || ''-'' ||
                    NVL(VIS.SUPERVISORCODE, ''Unknown-'' || det.DBNAME) || ''-'' ||
                    COALESCE(VIS.BILLCODE, det.BILLCODE, ''Unknown'') || ''-'' || det.REFERENCENO || ''-'' ||
                    NVL(VIS.REFERENCENO, ''-1'') || ''-'' || ''DATAFLEXSYNCDATA''
            )                                                                       AS REVENUE_KEY
                      , MD5(
                    COALESCE(VIS.DBNAME, det.DBNAME, ''Unknown'') || ''-'' ||
                    COALESCE(VIS.REFERENCENO, det.REFERENCENO, ''Unknown'') || ''-'' ||
                    COALESCE(VIS.WEEKENDDATE, ''1900-01-01'') ||
                    ''-'' || COALESCE(VIS.SERVICEDATE, ''1900-01-01'') || ''-'' || ''DATAFLEXSYNCDATA''
            )                                                                       AS VISIT_KEY
                      , COALESCE(CAST(VIS.REFERENCENO AS VARCHAR), ''Unknown'')     AS VISIT_ID
                      , COALESCE(VIS.SERVICEDATE::DATE, det.DATEFROM)               as SERVICE_DATE
                      , det.DBNAME                                                  AS SYSTEM_CODE
                      , 3                                                           AS SOURCE_SYSTEM_ID
                      , :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
                      , :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
                      , CURRENT_USER                                                as ETL_INSERTED_BY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
                      , CURRENT_USER                                                as ETL_LAST_UPDATED_BY
                      , 0                                                           as ETL_DELETED_FLAG
        FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_DFINVOICEDETAILS det
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv ON det.DBNAME = inv.DBNAME
            AND det.INVOICENO = inv.INVOICENO
            AND inv.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS con ON inv.DBNAME = con.DBNAME
            AND inv.CONTRACTCODE = con.CONTRACTCODE
            AND con.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN CLIENT_DATA cli ON det.DBNAME = cli.DBNAME
            AND det.CLIENTNUMBER = cli.Client_number
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES oc ON cli.DBNAME = oc.DBNAME
            AND cli.OFFICE_NUMBER = oc.OFFICENUMBER
            AND oc.ETL_DELETED_FLAG = FALSE
                 LEFT JOIN VIS_UNION VIS ON VIS.CLIENTNUMBER = det.CLIENTNUMBER
            AND (
                                                        VIS.BILLCODE = det.BILLCODE
                                                    OR det.BILLCODE = ''''
                                                )
            AND det.DATEFROM <= VIS.SERVICEDATE
            AND NVL(det.DATETO, det.DATEFROM) >= VIS.SERVICEDATE
            AND VIS.SERVICEHOURS = det.HOURS
            AND VIS.DBNAME = det.DBNAME
        WHERE con.PAYMENTMETHOD != ''3''
          AND inv.movedto = '''';
        --AR INVOICES
        INSERT INTO STAGE.DATAFLEXSYNCDATA_DIM_INVOICE_VISIT_LINKAGE
          with AR_DIM_INVOICE_CHANGED_DATA AS (SELECT DISTINCT I.DBNAME,
                                                               I.INVOICENUMBER,
                                                               I.OFFICE,
                                                               I.PERIOD,
                                                               I.CONTRACTCODE,
                                                               MD5(
                                                                           I.DBNAME || ''-'' || I.INVOICENUMBER ||
                                                                           ''-'' || I.OFFICE || ''-'' || I.PERIOD ||
                                                                           ''-'' || I.CONTRACTCODE || ''-'' ||
                                                                           ''DATAFLEXSYNCDATA-DFARINVOICES''
                                                                   ) AS INVOICE_KEY
                                               FROM DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES I),
              AR_DIM_INVOICE AS (SELECT INV.DBNAME,
                               INV.INVOICENUMBER,
                               INV.SUPPLEMENTNO,
                               DATEFROMPARTS(LEFT (TRIM(INV.PERIOD), 4),
            RIGHT (TRIM(INV.PERIOD), 2),
            1
            ) AS PERIOD_DATE,
            INV.PERIOD,
            INV.CONTRACTCODE AS CONTRACT_CODE,
            INV.OFFICE,
            INV.SERVICEAREA,
            CHANGED_DATA.INVOICE_KEY,
            COALESCE(BRANCH.BRANCH_KEY,
                     MD5(INV.DBNAME || ''-'' || INV.OFFICE || ''-'' || ''DATAFLEXSYNCDATA'')
            ) AS BRANCH_KEY,
            COALESCE(BRANCH.BRANCH_NAME,
                     CONCAT(INV.DBNAME, ''-Unknown'')
            ) AS BRANCH_NAME,
            TRY_CAST(CONCAT(- 100, INV.OFFICE) AS INTEGER) AS DUMMY_CLIENT_NUMBER,
            TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER) AS DUMMY_EMPLOYEE_NUMBER,
            TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)::STRING AS DUMMY_SUPERVISOR_CODE
            FROM AR_DIM_INVOICE_CHANGED_DATA AS CHANGED_DATA
            JOIN DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES INV
            ON INV.DBNAME = CHANGED_DATA.DBNAME
            AND INV.INVOICENUMBER = CHANGED_DATA.INVOICENUMBER
            AND INV.OFFICE = CHANGED_DATA.OFFICE
            AND INV.PERIOD = CHANGED_DATA.PERIOD
            AND INV.CONTRACTCODE = CHANGED_DATA.CONTRACTCODE
            LEFT JOIN dw_PROD.HAH.DIM_BRANCH AS BRANCH ON BRANCH.SOURCE_SYSTEM_ID = 3
            AND BRANCH.SYSTEM_CODE = INV.DBNAME
            AND BRANCH.OFFICE_CODE = INV.OFFICE::STRING)
        SELECT DISTINCT MD5(
                    INV.DBNAME || ''-'' || INV.PERIOD || ''-'' || INV.OFFICE || ''-'' || INV.DUMMY_EMPLOYEE_NUMBER ||
                    ''-'' ||
                    INV.DUMMY_CLIENT_NUMBER || ''-'' || INV.CONTRACT_CODE || ''-'' || INV.INVOICENUMBER || ''-'' ||
                    INV.DUMMY_SUPERVISOR_CODE || ''-'' || INV.SERVICEAREA || ''-'' || INV.SUPPLEMENTNO || ''-'' ||
                    ''DATAFLEXSYNCDATA-DFARINVOICES''
            )                                                                       AS REVENUE_KEY
                      , ''UNKNOWN''                                                 AS VISIT_KEY
                      , ''UNKNOWN''                                                 AS VISIT_ID
                      , PERIOD_DATE                                                 AS SERVICE_DATE
                      , INV.DBNAME                                                  AS SYSTEM_CODE
                      , 3                                                           AS SOURCE_SYSTEM_ID
                      , :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
                      , :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
                      , CURRENT_USER                                                as ETL_INSERTED_BY
                      , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
                      , CURRENT_USER                                                as ETL_LAST_UPDATED_BY
                      , 0                                                           as ETL_DELETED_FLAG
        FROM AR_DIM_INVOICE AS INV
                 LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS con ON inv.CONTRACT_CODE = con.CONTRACTCODE
            AND inv.DBNAME = con.DBNAME
        WHERE con.PAYMENTMETHOD = ''3'';

        RETURN ''SUCCESS'';
    END ;
';