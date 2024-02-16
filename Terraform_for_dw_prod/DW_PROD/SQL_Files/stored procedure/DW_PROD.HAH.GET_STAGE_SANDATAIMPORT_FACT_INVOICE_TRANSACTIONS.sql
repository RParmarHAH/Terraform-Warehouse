CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_FACT_INVOICE_TRANSACTIONS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    DECLARE
        return_result VARCHAR;
    BEGIN
        --*********************************************************************************************************************
        -- NAME: SANDATAIMPORT_FACT_INVOICE_TRANSACTIONS
        --
        -- DEVELOPMENT LOG:
        -- DATE         AUTHOR                 NOTES:
        -- --------     -------------------    -------------------------------------------------------------------
        -- 28/12/23     PINKAL PANCHAL         Initial development
        -- 14/11/23     Muhammad Zorob         Revised visits CTE and added second join to handle multiple client numbers.
        -- 13/12/23     Poonit Mistry (OLLION) revised visits and invoices cte
        --*********************************************************************************************************************

        INSERT OVERWRITE
        INTO STAGE.SANDATAIMPORT_FACT_INVOICE_TRANSACTIONS
        WITH all_visits AS (select agencyid,
                                   scheduleid,
                                   admissionid,
                                   serviceid,
                                   clientid,
                                   scheduledate,
                                   admissiontype                     as contract_code,
                                   scheduledduration                 as hours_served,
                                   try_cast(staffagencyid as bigint) as staffagencyid
                            from disc_PROD.bi_repository.sandatavisits
                            where STATus not in (''01'', ''09'', ''10'')

                            union

                            select agencyid,
                                   scheduleid,
                                   admissionid,
                                   serviceid,
                                   clientnumber                              as clientid,
                                   v.date                                    as scheduledate,
                                   clientadmittype                           as contract_code,
                                   NVL(v.ADJUSTEDDURATION, v.ACTUALDURATION) AS HOURS_SERVED,
                                   try_cast(staffagencyid as bigint)         as staffagencyid

                            from disc_PROD.sandataimport.sandata_visits v

                            where eventstatus not in (''01'', ''09'', ''10'')),

             visits as (select case
                                   WHEN VS.SERVICEID IN (''CARECO'', ''VBPCG'')
                                       THEN MD5(
                                               ''CC_'' || VS.AGENCYID || ''-'' || VS.SCHEDULEID || ''-'' ||
                                               ''SANDATAIMPORT''
                                       )

                                   ELSE MD5(
                                           VS.AGENCYID || ''-'' || VS.SCHEDULEID || ''-'' || ''SANDATAIMPORT''
                                       ) end                                                                             as visit_key,
                               clientid,
                               ADMISSIONID,
                               SERVICEID,
                               agencyid,
                               scheduleid,
                               scheduledate,
                               staffagencyid,

                               DIV0(VS.HOURS_SERVED,
                                    SUM(VS.HOURS_SERVED)
                                        OVER (PARTITION BY VS.agencyid, vs.CLIENTID, Vs.CONTRACT_CODE, Vs.scheduledate)) AS RATIO_DURATION

                        from all_visits vs

                        where clientid is not null
                          and vs.hours_served > ''0''),
             INVOICES AS (SELECT CASE
                                     WHEN D.SERVICEID IN (''CARECO'', ''VBPCG'')
                                         THEN ''CC_'' || H.AGENCYID
                                     ELSE H.AGENCYID END                              AS AGENCYID,

                                 H.INVOICENUMBER,
                                 H.INVOICEDATE,
                                 H.STATUSID,
                                 H.STATUSCHANGEDATE,
                                 H.BILLCODE,

                                 NVL(H.ADJUSTEDAMOUNT, 0)                             AS ADJUSTEDAMOUNT,
                                 NVL(H.BALANCE, 0)                                    AS BALANCE,
                                 NVL(NVL(H.ADJUSTEDAMOUNT, 0) - NVL(H.BALANCE, 0), 0) AS COLLECTED,

                                 D.INVOICELINEID,
                                 D.SERVICEID,
                                 D.HCPCS,
                                 D.UNITTYPEID,
                                 D.DURATION,
                                 D.DATEFROM,
                                 D.DATETHRU,

                                 CA.CLIENTID,
                                 H.ADMISSIONID,
                                 CA.ADMISSIONTYPE,
                                 DATE_TRUNC(MONTH, D.DATEFROM)                        AS REPORT_MONTH,

                                 D.RATE,
                                 D.BILLEDAMOUNT,
                                 D.PAIDAMOUNT,
                                 D.NETAMOUNT,
                                 PM.CREATEDAT, --Added ON 8/11/23

                                 COALESCE(H.ETL_LAST_UPDATED_DATE, ''1/1/1900'')      AS ETL_LAST_UPDATED_DATE

                          --Modified on 8/11/23 becuase SANDATA_INVOICEDETAILS_20231102_FULL table does not contain ETL_LAST_UPDATED_DATE column

                          FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER H

                                   LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS D
                                             ON D.AGENCYID = H.AGENCYID AND D.INVOICENUMBER = H.INVOICENUMBER

                                   LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CA
                                             ON CA.AGENCYID = H.AGENCYID AND CA.ADMISSIONID = H.ADMISSIONID

                                   LEFT JOIN (SELECT INVOICEDETAILID,
                                                     MAX(CREATEDAT) AS CREATEDAT
                                              FROM DISC_PROD.SANDATAIMPORT.SANDATA_PAYMENTDETAILS --Added on 31/07/23

                                              WHERE CREATEDAT IS NOT NULL
                                                AND PAYMENTAMOUNT != 0

                                              GROUP BY INVOICEDETAILID) PM
                                             ON D.INVOICELINEID = PM.INVOICEDETAILID --Added ON 8/11/23

                          WHERE H.AGENCYID = 8485
                            AND D.statusID not in (''09'', ''10'')
                            and h.statusid not in (''09'', ''10''))
        SELECT DISTINCT MD5(''SANDATAIMPORT'' || ''-'' ||
                            PAY_DET.ID::STRING ||
                            TO_VARCHAR(COALESCE(INV.INVOICEDATE, ''1/1/1900''), ''YYYYMMDD'') ||
                            COALESCE(VS.VISIT_KEY, ''-1'') ||
                            ''-SANDATAIMPORT'')                                                                                                                       AS TRANSACTION_KEY,
                        PAY_DET.ID                                                                                                                                    AS TRANSACTION_NUMBER,
                        MD5(COALESCE(inv.AGENCYID, ''Unknown'') || ''-'' ||
                            TO_VARCHAR(COALESCE(vs.scheduledate, inv.datefrom, ''1/1/1900''), ''YYYYMMDD'') || ''-'' ||
                            COALESCE(inv.INVOICELINEID, -1) || ''-'' || COALESCE(VISIT_KEY, ''-1'') || ''-'' ||
                            ''SANDATAIMPORT'')                                                                                                                        AS REVENUE_KEY,
                        COALESCE(VS.VISIT_KEY, ''Unknown'')                                                                                                           AS VISIT_KEY,
                        MD5(''SANDATAIMPORT'' || ''-'' ||
                            NVL(PAY_HED.CODE::STRING, ''Unknown'') ||
                            ''-SANDATAIMPORT'')                                                                                                                       AS TRANSACTION_TYPE_KEY,
                        DIV0(PAY_DET.PAYMENTAMOUNT, (COUNT(1)
                                                           OVER (PARTITION BY PAY_DET.INVOICEDETAILID || PAY_DET.ID ORDER BY PAY_DET.INVOICEDETAILID || PAY_DET.ID))) AS AMOUNT,
                        Date(PAY_DET.CREATEDAT)                                                                                                                       AS TRANSACTION_CREATED,
                        NULL                                                                                                                                          AS TRANSACTION_POSTED,
                        NULL                                                                                                                                          AS TRANSACTION_DATE,
                        NULL                                                                                                                                          AS FINAL_TRANSACTION_DATE,
                        PAY_HED.REFERENCENUMBER                                                                                                                       AS CHECK_NUMBER,
                        NULL                                                                                                                                          AS CHECK_DATE,
                        PAY_HED.RECEIPTDATE                                                                                                                           AS DEPOSIT_DATE,
                        NULL                                                                                                                                          AS POSTED_DATE,
                        CASE
                            WHEN INV.SERVICEID IN (''CARECO'', ''VBPCG'')
                                THEN ''CC_'' || PAY_DET.AGENCYID
                            ELSE PAY_DET.AGENCYID END                                                                                                                 AS SYSTEM_CODE,
                        4                                                                                                                                             AS SOURCE_SYSTEM_ID,
                        :STR_ETL_TASK_KEY                                                                                                                             AS ETL_TASK_KEY,
                        :STR_ETL_TASK_KEY                                                                                                                             AS ETL_INSERTED_TASK_KEY,
                        CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                                                                   AS ETL_INSERTED_DATE,
                        CURRENT_USER                                                                                                                                  AS ETL_INSERTED_BY,
                        CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ                                                                                   AS ETL_UPDATED_DATE,
                        CURRENT_USER                                                                                                                                  AS ETL_LAST_UPDATED_BY,
                        0                                                                                                                                             AS ETL_DELETED_FLAG
        FROM DISC_PROD.SANDATAIMPORT.SANDATA_PAYMENTDETAILS PAY_DET
                 LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_PAYMENTHEADER PAY_HED
                           ON PAY_DET.AGENCYID =
                              PAY_HED.AGENCYID AND
                              PAY_DET.PAYMENTID = PAY_HED.PAYMENTID
                 LEFT JOIN INVOICES INV
                           ON INV.INVOICENUMBER =
                              PAY_DET.INVOICEID AND
                              INV.INVOICELINEID =
                              PAY_DET.INVOICEDETAILID AND
                              CASE
                                  WHEN INV.SERVICEID IN (''CARECO'', ''VBPCG'')
                                      THEN INV.AGENCYID = ''CC_'' || PAY_DET.AGENCYID
                                  ELSE INV.AGENCYID = PAY_DET.AGENCYID END
                 LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CA
                           ON INV.ADMISSIONID = CA.ADMISSIONID AND
                              CASE
                                  WHEN INV.SERVICEID IN (''CARECO'', ''VBPCG'')
                                      THEN INV.AGENCYID = ''CC_'' || CA.AGENCYID
                                  ELSE INV.AGENCYID = CA.AGENCYID END
                 left join visits vs
                           on VS.CLIENTID = INV.CLIENTID AND
                              VS.ADMISSIONID =
                              INV.ADMISSIONID AND --VS.SCHEDULEDATE = DTE.CALENDAR_DATE
                              inv.DATEFROM <= vs.scheduledate AND
                              inv.DATETHRU >= vs.scheduledate

        WHERE PAY_DET.AGENCYID = ''8485'';

        SELECT CONCAT(''MESSAGE : '', "number of rows inserted", '' Rows Inserted.'') into :return_result
        FROM TABLE (RESULT_SCAN(LAST_QUERY_ID ()));

        return return_result;
    END ;
';