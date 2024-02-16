CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_FACT_REVENUE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
            --*****************************************************************************************************************************
-- NAME:  SandataImport_FACT_REVENUE
--
-- PURPOSE: Creates one row per invoice detail by day according to SandataImport
--
-- NOTE: Still need to do Unit testing
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/11/20		Mohd Kamaludin		 Initial Development
-- 02/17/20     Mohd Kamaludin       Updated per model changes and join with Visits, ScheduleStaff, External IDs
-- 02/18/20     Mohd Kamaludin       Added BillCode as part of Revenue Key to remove duplicate keys
-- 02/19/20     Mohd Kamaludin       Aggregate employee timesheets by day in cases for multiple submissions
-- 02/20/20     Mohd Kamaludin       CHanged timesheet to use ratio to ensure time billed is not greater than invoice hour billed
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 05/04/20     Mohd Kamaludin       Changed Employee Key to match Sandata Dim Employee and Fact Visit (StaffAgencyID)
-- 05/04/20     Mohd Kamaludin       Slightly tweaked Sandata Visit and Schedule Visit to use Max Header and Detail ID
-- 05/27/20		Mir Ali				 Removed voided, cancelled, and denied invoices
-- 06/02/20		Mir Ali				 Removed filter from previous update and updated logic to retrieve employees from Sandata_Visits table
-- 09/04/20		Mir Ali				 Updated Visits join ''vs'' to use Fact_Visit instead of Discovery layer Sandata_Visits (to include historical one-time loads) 
--									 Changed Branch_Key preference from ClientAdmissions.LocationId to Fact_Visit.Branch_Name 
--									 Added CDC check for ''vs'' Visits
-- 09/09/20		Mir Ali				 Changed Visits and Invoices to CTE, and added "Changed_Data" CTE
-- 01/04/20     Mir Ali              Changed Branch_Key to consist of Office_Code not Office_Name
-- 20/01/22		Pooja Shah			 IMPROVED INVOICE LOGIC FOR PA - MARKET REPORT
-- 03/24/23		Darshan Gosai       Seprated SANDATA CARECOORIDNATE recrds on basis of system_code
-- 06/05/23     Mitul Panchal		Changed logic for Amount Collected/Billed/outstanding
-- 07/27/23     Pinkal Panchal		Changed logic for Amount Collected,Billed and outstanding column for RCM.
-- 08/07/23		Pinkal Panchal		Changed logic of Payment_Date for RCM.
-- 11/21/23		Pinkal Panchal		Changed SANDATA_INVOICEDETAILS table to SANDATA_INVOICEDETAILS_20231102_FULL,
--									subtracting Adjustment amount from Amount Billed,Collected, and Outstanding logic,
--									and added condition to exclude statusid 8,9 and 10.
-- 11/21/23     Pinkal Panchal      Added fields to visits CTE and a second join to handle situations where the fact visit client number dosent match the dim client number.
-- 24/11/23     Pradeep Thippani    Added bill_unit_type column for RCM(Requested By Natalie)
-- 07/12/23     Muhammad Zorob      Removed Incremental Refresh and Updated Invoice Details table to resolve missing rows
-- 28/12/23     Poonit Mistry (OLLION)  Rewrite Pull from Visits, Add Filter on StatusID on Invoice Header, Invoice Detail, Remove DTE Filter
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO DW_PROD.STAGE.SANDATAIMPORT_FACT_REVENUE
        WITH INVOICES AS (SELECT CASE
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
                            and h.statusid not in (''09'', ''10'')),

             EMPLOYEE AS --Added on 20/01/23

                 (SELECT *

                  FROM (SELECT STAFFAGENCYID,

                               MASTER_ID,

                               AGENCYID

                        FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MASTER_LIST

                        WHERE AGENCYID = 8485)

                  UNION

                  SELECT *

                  FROM (SELECT DISTINCT STAFFAGENCYID,

                                        MASTER_ID,

                                        AGENCYID

                        FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MATCH_LIST

                        WHERE STAFFAGENCYID NOT IN (SELECT STAFFAGENCYID

                                                    FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MASTER_LIST)

                          AND AGENCYID = 8485)),

             all_visits AS (select agencyid,
                                   scheduleid,
                                   admissionid,
                                   serviceid,
                                   clientid,
                                   scheduledate,
                                   admissiontype                     as contract_code,
                                   scheduledduration                 as hours_served,
                                   try_cast(staffagencyid as bigint) as staffagencyid
                            from DISC_PROD.bi_repository.sandatavisits
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

                            --staffagencyid

                            from DISC_PROD.sandataimport.sandata_visits v

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
                          and vs.hours_served > ''0''),

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

                          AND AGENCYID = 8485)),
             FINAL AS (SELECT DISTINCT MD5(inv.AGENCYID || ''-'' ||
                                           TO_VARCHAR(COALESCE(vs.scheduledate, inv.datefrom, ''1/1/1900''),
                                                      ''YYYYMMDD'') || ''-'' ||
                                           inv.INVOICELINEID || ''-'' || COALESCE(VISIT_KEY, ''-1'') || ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS REVENUE_KEY

                                     , coalesce(vs.scheduledate, inv.datefrom, ''1900-01-01'')                                            AS REPORT_DATE

                                     , md5(nvl(inv.agencyID, ''S'') || ''-'' || coalesce(cle.LocationId, '''') ||
                                           ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS BRANCH_KEY

                                     , md5(nvl(STF.agencyID, ''S'') || ''-'' || upper(NVL(TRIM(STF.MASTER_ID), '''')) ||
                                           ''-'' ||
                                           ''1900-01-01'' || ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS EMPLOYEE_KEY

                                     , COALESCE(md5(CL.AGENCYID || ''-'' || CL.MASTER_ID || ''-'' || ''SANDATAIMPORT''),
                                                md5(nvl(CL.AGENCYID, ''S'') || ''-'' || NVL(cl.MASTER_ID, -1) ||
                                                    ''-'' ||
                                                    ''SANDATAIMPORT''))                                                                   AS CLIENT_KEY

                                     , md5(nvl(inv.AGENCYID, ''S'') || ''-'' || NVL(cle.ADMISSIONTYPE, ''Unknown'') ||
                                           ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS CONTRACT_KEY

                                     , md5(nvl(inv.AGENCYID, ''S'') || ''-'' || coalesce(inv.INVOICENUMBER, ''-1'') ||
                                           ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS INVOICE_KEY

                                     , 4                                                                                                  AS SOURCE_SYSTEM_ID

                                     , md5(nvl(inv.AGENCYID, ''S'') || ''-'' || NVL(cle.COORDINATORID, -1) || ''-'' ||
                                           ''SANDATAIMPORT'')                                                                             AS SUPERVISOR_KEY

                                     , NVL(inv.INVOICEDATE, ''1900-01-01'')                                                               AS REVENUE_DATE

                                     --	Changes made on 31/07/23 by Pinkal for RCM

                                     , CASE
                                           WHEN inv.CREATEDAT IS NULL
                                               THEN IFF(inv.STATUSID = ''07'', inv.STATUSCHANGEDATE, NULL)

                                           ELSE inv.CREATEDAT::DATE END                                                                   AS PAYMENT_DATE

                                     , coalesce(BRANCH.BRANCH_NAME, cle.LocationId, ''Unknown'')                                          AS BRANCH_NAME

                                     , COALESCE(STF.MASTER_ID, vs.STAFFAGENCYID, ''-1'')                                                  AS EMPLOYEE_ID

                                     , COALESCE(CL.MASTER_ID, cle.CLIENTID, ''-1'')                                                       AS CLIENT_NUMBER

                                     , NVL(cle.ADMISSIONTYPE, ''Unknown'')                                                                AS CONTRACT_CODE

                                     , inv.INVOICENUMBER                                                                                  AS INVOICE_NUMBER

                                     , ''Regular''                                                                                        AS INVOICE_TYPE

                                     , CASE inv.UNITTYPEID
                                           WHEN ''01'' THEN ''HOURLY''

                                           WHEN ''02'' THEN ''VISIT''

                                           WHEN ''05'' THEN ''HOURLY''

                                           ELSE NULL END                                                                                  AS BILL_UNIT_TYPE

                                     , 1                                                                                                  AS NUMBER_OF_CLIENTS

                                     , inv.AGENCYID                                                                                       AS SYSTEM_CODE

                                     , NVL(cle.COORDINATORID::string, ''Unknown-'' ||
                                                                      NVL(vs.agencyID, ''S''))                                            AS SUPERVISOR_CODE

                                     , COALESCE(inv.HCPCS, inv.BILLCODE, ''Unknown'')                                                     AS BILL_CODE

                                     , CASE
                                           WHEN inv.UNITTYPEID = ''01'' THEN DIV0(
                                                       inv.DURATION * NVL(VS.ratio_duration, 1),
                                                       (DATEDIFF(day, inv.DATEFROM, inv.DATETHRU) + 1)) --hourly

                                           WHEN inv.UNITTYPEID = ''05'' THEN DIV0(
                                                       inv.DURATION * .25 * NVL(VS.ratio_duration, 1),
                                                       (DATEDIFF(day, inv.DATEFROM, inv.DATETHRU) + 1)) --convert 15 mins to hour

                                           ELSE DIV0(inv.DURATION,
                                                     (DATEDIFF(day, inv.DATEFROM, inv.DATETHRU) + 1) *
                                                     NVL(VS.ratio_duration, 1)) --default

                     END                                                                                                                  AS INVOICE_HOURS

                                     , CASE
                                           WHEN inv.UNITTYPEID = ''01'' THEN inv.RATE

                                           WHEN inv.UNITTYPEID = ''05'' THEN inv.RATE * 4

                                           ELSE inv.RATE / 8 END                                                                          AS INVOICE_RATE

                                     , DIV0(INV.ADJUSTEDAMOUNT, (COUNT(1)
                                                                       OVER (PARTITION BY INV.INVOICENUMBER ORDER BY INV.INVOICENUMBER))) AS AMOUNT_BILLED
                                     , DIV0(INV.COLLECTED, (COUNT(1)
                                                                  OVER (PARTITION BY INV.INVOICENUMBER ORDER BY INV.INVOICENUMBER)))      AS AMOUNT_COLLECTED
                                     , DIV0(INV.BALANCE, (COUNT(1)
                                                                OVER (PARTITION BY INV.INVOICENUMBER ORDER BY INV.INVOICENUMBER)))        AS AMOUNT_OUTSTANDING
                                     -- ETL COLUMNS
                                     , :STR_ETL_TASK_KEY                                                                                  AS ETL_TASK_KEY
                                     , :STR_ETL_TASK_KEY                                                                                  AS ETL_INSERTED_TASK_KEY
                                     , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                                        as ETL_INSERTED_DATE
                                     , CURRENT_USER                                                                                       as ETL_INSERTED_BY
                                     , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                                        as ETL_UPDATED_DATE
                                     , CURRENT_USER                                                                                       as ETL_LAST_UPDATED_BY
                                     , 0                                                                                                  as ETL_DELETED_FLAG

                       FROM INVOICES INV

                                left join visits vs on VS.CLIENTID = INV.CLIENTID AND
                                                       VS.ADMISSIONID =
                                                       INV.ADMISSIONID AND --VS.SCHEDULEDATE = DTE.CALENDAR_DATE

                                                       inv.DATEFROM <= vs.scheduledate AND
                                                       inv.DATETHRU >= vs.scheduledate

                                LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS cle
                                          ON inv.ADMISSIONID = cle.ADMISSIONID
                                              AND CASE
                                                      WHEN INV.SERVICEID IN (''CARECO'', ''VBPCG'')
                                                          THEN inv.AGENCYID = ''CC_'' || cle.AGENCYID

                                                      ELSE inv.AGENCYID = cle.AGENCYID END

                                LEFT JOIN CLIENT CL
                                          ON INV.AGENCYID = CL.AGENCYID AND CLE.CLIENTID = CL.CLIENTID

                                LEFT JOIN EMPLOYEE STF
                                          ON INV.AGENCYID = STF.AGENCYID AND VS.STAFFAGENCYID = STF.STAFFAGENCYID

                                LEFT JOIN HAH.DIM_BRANCH BRANCH
                                          ON BRANCH.SYSTEM_CODE = cle.AGENCYID AND BRANCH.OFFICE_CODE = cle.LOCATIONID

                       WHERE INV.AGENCYID = ''8485''
                          or INV.AGENCYID = ''CC_8485''),
             max_invoice_hours as (SELECT REVENUE_KEY,
                                          max(final.EMPLOYEE_KEY) as employee_key,
                                          max(INVOICE_HOURS)      as invoice_hours
                                   from final
                                   group by revenue_key)
        SELECT final.*
        FROM final
                 join max_invoice_hours mh
                      on mh.REVENUE_KEY = final.REVENUE_KEY and mh.employee_key = final.EMPLOYEE_KEY
                          and mh.invoice_hours = final.INVOICE_HOURS;

        SELECT CONCAT(''MESSAGE : '', "number of rows inserted", '' Rows Inserted.'') into :return_result
        FROM TABLE (RESULT_SCAN(LAST_QUERY_ID ()));

        return return_result;
    END ;
';