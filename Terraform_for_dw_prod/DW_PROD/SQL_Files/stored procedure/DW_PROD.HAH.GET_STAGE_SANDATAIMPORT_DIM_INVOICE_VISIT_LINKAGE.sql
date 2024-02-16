CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_DIM_INVOICE_VISIT_LINKAGE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
    BEGIN
        --*****************************************************************************************************************************
        -- NAME:  SANDATAIMPORT_DIM_INVOICE_VISIT_LINKAGE
        --
        -- DEVELOPMENT LOG:A
        -- DATE         AUTHOR              NOTES:
        -- --------     ------------------- -----------------------------------------------------------------------------------------------
        -- 06/12/23		Pinkal Panchal		Initial Development
        -- 06/12/23     Muhammad Zorob		Revised to use same method as fact_revenue, pending updates for visit id
        --*****************************************************************************************************************************
        --
        INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_DIM_INVOICE_VISIT_LINKAGE
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
                                   WHEN VS.SERVICEID IN (''CARECO'', ''VBPCG'') THEN MD5(
                                               ''CC_'' || VS.AGENCYID || ''-'' || VS.SCHEDULEID || ''-'' ||
                                               ''SANDATAIMPORT''
                                       )
                                   ELSE MD5(
                                           VS.AGENCYID || ''-'' || VS.SCHEDULEID || ''-'' || ''SANDATAIMPORT''
                                       ) end                                                                                              as visit_key,
                               clientid,
                               ADMISSIONID,
                               SERVICEID,
                               agencyid,
                               scheduleid,
                               scheduledate,
                               staffagencyid,
                               DIV0(VS.HOURS_SERVED, SUM(VS.HOURS_SERVED)
                                                         OVER (PARTITION BY VS.agencyid, vs.CLIENTID, Vs.CONTRACT_CODE, Vs.scheduledate)) AS RATIO_DURATION
                        from all_visits vs
                        where clientid is not null
                          and vs.hours_served > ''0'')
                ,
             INVOICES AS (SELECT CASE
                                     WHEN D.SERVICEID IN (''CARECO'', ''VBPCG'') THEN ''CC_'' || H.AGENCYID
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
                                 D.NETAMOUNT, --Added ON 8/11/23
                                 COALESCE(H.ETL_LAST_UPDATED_DATE, ''1/1/1900'')      AS ETL_LAST_UPDATED_DATE
                          --Modified on 8/11/23 becuase SANDATA_INVOICEDETAILS_20231102_FULL table does not contain ETL_LAST_UPDATED_DATE column
                          FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER H
                                   LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS D
                                             ON D.AGENCYID = H.AGENCYID AND D.INVOICENUMBER = H.INVOICENUMBER
                                   LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CA
                                             ON CA.AGENCYID = H.AGENCYID AND CA.ADMISSIONID = H.ADMISSIONID --Added ON 8/11/23
                          WHERE H.AGENCYID = 8485
                            AND D.statusID not in (''09'', ''10'')
                            and h.statusid not in (''09'', ''10'')),
             CLIENT AS --Added on 20/01/23
                 (SELECT *
                  FROM (SELECT CLIENTID,
                               MASTER_ID,
                               AGENCYID
                        FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST
                        WHERE AGENCYID = 8485)
                  UNION
                  SELECT *
                  FROM (SELECT DISTINCT CLIENTID,
                                        MASTER_ID,
                                        AGENCYID
                        FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MATCH_LIST
                        WHERE CLIENTID NOT IN (SELECT CLIENTID
                                               FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST)
                          AND AGENCYID = 8485))
        SELECT distinct
            MD5(inv.AGENCYID || ''-'' ||
                   TO_VARCHAR(COALESCE(vs.scheduledate, inv.datefrom, ''1/1/1900''), ''YYYYMMDD'') || ''-'' ||
                   inv.INVOICELINEID || ''-'' || COALESCE(VISIT_KEY, ''-1'') || ''-'' ||
                   ''SANDATAIMPORT'')                                      AS REVENUE_KEY
                ,
               COALESCE(VS.VISIT_KEY, ''-1'')                              AS VISIT_KEY
                ,
               ''TBD''                                                     AS VISITID
                ,
               COALESCE(VS.scheduledate, INV.datefrom)                     AS SERVICE_DATE
                ,
               inv.AGENCYID                                                AS SYSTEM_CODE
                ,
               ''4''                                                       AS SOURCE_SYSTEM_ID
                ,
               :STR_ETL_TASK_KEY                                           AS ETL_TASK_KEY
                ,
               :STR_ETL_TASK_KEY                                           AS ETL_INSERTED_TASK_KEY
                ,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
                ,
               CURRENT_USER                                                as ETL_INSERTED_BY
                ,
               convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
                ,
               CURRENT_USER                                                as ETL_LAST_UPDATED_BY
                ,
               0                                                           as ETL_DELETED_FLAG
        FROM INVOICES INV
                 left join visits vs on VS.CLIENTID = INV.CLIENTID AND
                                        VS.ADMISSIONID = INV.ADMISSIONID AND --VS.SCHEDULEDATE = DTE.CALENDAR_DATE
                                        inv.DATEFROM <= vs.scheduledate AND inv.DATETHRU >= vs.scheduledate
                 LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS cle
                           ON inv.ADMISSIONID = cle.ADMISSIONID
                               AND CASE
                                       WHEN INV.SERVICEID IN (''CARECO'', ''VBPCG'')
                                           THEN inv.AGENCYID = ''CC_'' || cle.AGENCYID
                                       ELSE inv.AGENCYID = cle.AGENCYID END
        WHERE inv.AGENCYID in (''8485'', ''CC_8485'');

        RETURN ''SUCCESS'';
    END ;
';