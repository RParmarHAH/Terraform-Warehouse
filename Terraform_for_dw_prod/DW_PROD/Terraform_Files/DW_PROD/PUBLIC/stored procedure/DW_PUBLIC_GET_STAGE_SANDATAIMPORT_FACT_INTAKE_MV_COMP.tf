resource "snowflake_procedure" "DW_PUBLIC_GET_STAGE_SANDATAIMPORT_FACT_INTAKE_MV_COMP" {
	name ="GET_STAGE_SANDATAIMPORT_FACT_INTAKE_MV_COMP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

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

        var sql = `
        --*****************************************************************************************************************************
-- NAME:  Sandata_FACT_INTAKE
--
-- PURPOSE: Creates one row per INTAKE according to Sandata
--
-- NOTE: There are some records that are not true duplicates, because the service ids are different for the same day
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/24/20     Rachel Stewart      Initial development
-- 03/05/20     Mohd Kamaludin      Added a CT table to calc max auth id for records that has the same begin date and
--                                     to pick the later begindate if there is newer reauth based on authid
-- 03/18/20     Frank Noordover      Updated for Production rollout
-- 05/04/20		Mir Ali				Updated Auth selection "Partition by" clause
-- 05/06/20     Rachel Stewart      Updated to include logic for none and type of units
-- 05/19/20		Arif Ansari			Include Bill Rate logic. 
-- 05/28/20		Mir Ali				Added logic to include auths that cover partial months 
--									Added logic for auths based on individual auths
--									Added/fixed logic to calculate untis vs hours						
-- 01/04/21		Mir Ali				Changed Branch_Key to consist of Office_Code not Office_Name
-- 04/19/22		Pooja Shah			Enhancement to include Auth Dates & PreAuthNo.	
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.PUBLIC.SANDATAIMPORT_FACT_INTAKE_MV_COMP
WITH AD AS
    ( SELECT DISTINCT
       F.CLIENTID
      ,F.ADMISSIONID
      ,F.SOC AS CLIENT_ADMISSIONS
      ,DATE_TRUNC(''week'', CLIENT_ADMISSIONS) AS START_OF_WEEK
      ,F.AGENCYID
      ,F.ADMISSIONSTATUS
      ,F.ADMISSIONTYPE
      ,IFF(F.EOC IS NULL, LAST_DAY(CURRENT_DATE()),F.EOC) AS END_SERVICE_DATE
      ,LAST_DAY(END_SERVICE_DATE) AS DERIVED_END_SERVICE_DATE
    --   ,nvl(eid.LstNam,f.LocationId) AS BRANCH_NAME
    --   ,nvl(eid.LstNam,f.LocationId) AS INTAKE_OFFICE_NAME
	  ,COALESCE(BRANCH.OFFICE_CODE, f.LOCATIONID) AS OFFICE_CODE
	  ,COALESCE(BRANCH.BRANCH_NAME, f.LOCATIONID) AS BRANCH_NAME
	  ,COALESCE(BRANCH.BRANCH_NAME, f.LOCATIONID) AS INTAKE_OFFICE_NAME
      ,F.SOC AS REAUTHORIZED_DATE
      ,P.PAYORID
      ,F.COORDINATORID
	  ,F.SOC AS CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah 19042022
      ,F.EOC AS CLIENT_END_SERVICE_DATE -- Added BY PJShah 19042022
    FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS F
    -- LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
    --     ON f.LocationId = eid.ExtID AND eid.DBNAME = ''PA'' AND eid.Typ = ''L''
	LEFT JOIN HAH.DIM_BRANCH BRANCH
		ON BRANCH.SYSTEM_CODE = F.AGENCYID AND BRANCH.OFFICE_CODE = F.LOCATIONID
	JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_ADMISSIONSPAYORS P
	ON P.AGENCYID = F.AGENCYID
    AND P.ADMISSIONID = F.ADMISSIONID
    WHERE F.AGENCYID = ''8485'' AND F.ADMISSIONSTATUS IN (02,03,04) --AND CLIENTID = 6486
), max_auth AS (
    SELECT * FROM (SELECT DISTINCT AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID, DATEBEGIN
        , LEAD(DATEBEGIN,1,DATEEND) OVER (PARTITION BY AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID ORDER BY DATEBEGIN) as new_dateend
        , MAX(AUTHID) OVER (PARTITION BY AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID, DATEBEGIN) as max_auth_ref
    FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_AUTHORIZATIONS v
    WHERE AGENCYID = 8485)WHERE  DATEBEGIN <> new_dateend
), AUTHS AS(
SELECT REPORT_DATE, CLIENT_CODE, DERIVED_END_SERVICE_DATE, CONTRACT_CODE, SOURCE_SYSTEM_CODE, OFFICE_CODE, BRANCH_NAME, AUTHID, PERIODID, SERVICEID, EVENTID, ADMISSIONID,
	MIN(DATEBEGIN) DATEBEGIN,
	MAX(DATEEND) DATEEND,
	MAX(REAUTHORIZED_DATE) REAUTHORIZED_DATE,
	SUM(HOURS_AUTHORIZED) HOURS_AUTHORIZED
    ,PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
	,MAX(DATEBEGIN) LATEST_AUTH_BEGIN_DATE -- Added BY PJShah ON 19042022
	,MAX(DATEEND) LATEST_AUTH_END_DATE -- Added BY PJShah ON 19042022
	,CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah ON 19042022
	,CLIENT_END_SERVICE_DATE -- Added BY PJShah ON 19042022
FROM (
	SELECT DISTINCT 
	   CAL.FIRST_DAY_OF_MONTH AS REPORT_DATE
	  ,AD.CLIENTID AS CLIENT_CODE
	  ,DERIVED_END_SERVICE_DATE
	  ,AD.ADMISSIONTYPE AS CONTRACT_CODE
	  ,AD.AGENCYID AS SOURCE_SYSTEM_CODE
	  ,AD.OFFICE_CODE
	  ,AD.BRANCH_NAME
	  ,AUTHID
	  ,a.PERIODID
	  ,a.SERVICEID
	  ,a.EVENTID
	  ,a.DATEBEGIN
	  ,DATEEND
	  ,DATEDIFF(''day'', IFF(A.DATEBEGIN <= CAL.FIRST_DAY_OF_MONTH, CAL.FIRST_DAY_OF_MONTH, A.DATEBEGIN), IFF(A.DATEEND >= CAL.LAST_DAY_OF_MONTH, CAL.LAST_DAY_OF_MONTH, A.DATEEND))+1 AS NUMBER_DAYS -- number days in a month
	  ,NUMBER_DAYS/7 AS FULL_WEEKS -- get decimal of full weeks in month to be used in week type
	  ,DATEDIFF(''day'', A.DATEBEGIN, A.DATEEND)+1 AS NUMBER_DAYS_NONE -- To be used if type is none
	  ,A.DATEBEGIN AS REAUTHORIZED_DATE
	  ,IFF(A.PERIODLIMIT = 0 OR A.PERIODLIMIT IS NULL, A.MAXIMUM,PERIODLIMIT) AS CHECK_ZERO -- CHECKING IF PERIOD LIMIT IS NULL OR ZERO
	 -- ,IFF(A.PERIODLIMIT = 0 OR A.PERIODLIMIT IS NULL, A.MAXIMUM, IFF(A.LIMITTYPE = ''Month'',CHECK_ZERO,FULL_WEEKS*PERIODLIMIT ) ) AS HOURS_AUTHORIZED 
	  ,CASE WHEN LIMITTYPE = ''Month'' THEN CHECK_ZERO 
	        WHEN LIMITTYPE = ''Week''  THEN FULL_WEEKS * PERIODLIMIT
	        WHEN LIMITTYPE = ''None''  THEN (A.MAXIMUM/NUMBER_DAYS_NONE)*(IFF(NUMBER_DAYS_NONE < NUMBER_DAYS,1,NUMBER_DAYS))
	        WHEN LIMITTYPE = ''Year''  THEN (CHECK_ZERO/365)*NUMBER_DAYS
	        ELSE CHECK_ZERO END AS HOURS_AUTHORIZED_CALC
	  ,IFF(A.FORMAT = ''03'',HOURS_AUTHORIZED_CALC/4, HOURS_AUTHORIZED_CALC) AS HOURS_AUTHORIZED-- IF LIMIT TYPE = 03 THEN DIVIDE BY 4
	  ,A.ADMISSIONID AS ADMISSIONID
	  ,A.AUTHREFNO  AS PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
	  ,AD.CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah ON 19042022
	  ,AD.CLIENT_END_SERVICE_DATE -- Added BY PJShah ON 19042022
	FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_AUTHORIZATIONS A
	JOIN max_auth m ON a.AGENCYID = m.AGENCYID AND a.ADMISSIONID = m.ADMISSIONID AND a.PAYORID = m.PAYORID
	    AND a.PERIODID = m.PERIODID AND a.SERVICEID = m.SERVICEID AND a.EVENTID = m.EVENTID
	    AND a.DATEBEGIN = m.DATEBEGIN AND a.AUTHID = m.max_auth_ref
	LEFT JOIN AD
	    ON AD.AGENCYID = A.AGENCYID
	    AND AD.ADMISSIONID = A.ADMISSIONID
	    AND AD.PAYORID = A.PAYORID
	LEFT JOIN HAH.DIM_DATE CAL
	ON AD.CLIENT_ADMISSIONS <= IFF(DATE_PART(''day'',a.DATEBEGIN) <> 1,(DATEADD(''month'',1,CAL.CALENDAR_DATE)),CAL.CALENDAR_DATE)
	    AND   DATEEND >= CAL.CALENDAR_DATE
	    AND cal.CALENDAR_DATE < m.new_dateend AND m.DATEBEGIN <> m.new_dateend
	WHERE AD.AGENCYID = ''8485''
	AND AD.ADMISSIONSTATUS IN (02,03,04)
	--AND CAL.DAY_OF_MONTH = 1
	AND CAL.CALENDAR_DATE BETWEEN a.DATEBEGIN AND DATEEND
	AND A.ETL_LAST_UPDATED_DATE >= ''`; 
sql += STR_CDC_START
sql += `''::timestamp_ntz
) LIST
GROUP BY REPORT_DATE, CLIENT_CODE, DERIVED_END_SERVICE_DATE, CONTRACT_CODE, SOURCE_SYSTEM_CODE, OFFICE_CODE, BRANCH_NAME, AUTHID, PERIODID, SERVICEID, EVENTID, ADMISSIONID 
,PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
,CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah ON 19042022
,CLIENT_END_SERVICE_DATE -- Added BY PJShah ON 19042022
),FirstServiceDay 
AS 
(
	SELECT MIN(REPORT_DATE) AS FirstServiceDay FROM AUTHS
)
,LastInvoices (AgencyId, AdmissionId, ScheduleDate, InvoiceNumber, InvoiceLineId)
AS 
(	SELECT 
		H.agencyID,
		H.AdmissionID,
		D.DateFrom ScheduleDate,
		MAX(D.InvoiceNumber) InvoiceNumber,
		MAX(D.InvoiceLineID) InvoiceLineId
	FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEHEADER H
	JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEDETAILS D
		ON D.agencyID = H.agencyID
			AND D.InvoiceNumber = H.InvoiceNumber
	GROUP BY H.agencyID,
			H.AdmissionID,
			D.DateFrom
)
,Invoices (AgencyId, AdmissionId,ServiceBeginDate, ServiceMonth, ServiceYear, HoursBilled, BillRate_Past,
                    BillRate_Future
                    )
AS
(
	SELECT 
		*
	FROM
	(
		SELECT
			InvoiceHeader.agencyID,
			InvoiceHeader.AdmissionID,
			LAST_DAY(DATEADD(MONTH,-1,InvoiceDetail.DateFrom))+1 AS ServiceBeginDate,
			MONTH(InvoiceDetail.DateFrom) ServiceMonth,
			YEAR(InvoiceDetail.DateFrom) ServiceYear,
			SUM(IFF(InvoiceDetail.UnitTypeID = ''05'',
					InvoiceDetail.Duration / 4.0,
					InvoiceDetail.Duration)
				) HoursBilled,

			LAST_VALUE(AVG(InvoiceDetail.Rate * IFF(InvoiceDetail.UnitTypeID = ''05'', 4, 1))) OVER (PARTITION BY InvoiceHeader.agencyID,
																												InvoiceHeader.AdmissionID
																									ORDER BY YEAR(InvoiceDetail.DateFrom),
																											MONTH(InvoiceDetail.DateFrom)
																									ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
																									) BillRate_Past,
			FIRST_VALUE(AVG(InvoiceDetail.Rate * IFF(InvoiceDetail.UnitTypeID = ''05'', 4, 1))) OVER (PARTITION BY InvoiceHeader.agencyID,
																												InvoiceHeader.AdmissionID
																									ORDER BY YEAR(InvoiceDetail.DateFrom),
																											MONTH(InvoiceDetail.DateFrom)
																									ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
																									) BillRate_Future
		FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEHEADER InvoiceHeader
		JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_INVOICEDETAILS InvoiceDetail
			ON InvoiceDetail.agencyID = InvoiceHeader.agencyID
			AND InvoiceDetail.InvoiceNumber = InvoiceHeader.InvoiceNumber
		JOIN LastInvoices LastInvoices
			ON LastInvoices.AgencyId = InvoiceHeader.agencyID
			AND LastInvoices.AdmissionId = InvoiceHeader.AdmissionID
			AND LastInvoices.InvoiceNumber = InvoiceHeader.InvoiceNumber
			AND LastInvoices.InvoiceLineId = InvoiceDetail.InvoiceLineID
			AND LastInvoices.ScheduleDate = InvoiceDetail.DateFrom
		WHERE InvoiceDetail.UnitTypeID IN ( ''01'', ''05'' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
		GROUP BY InvoiceHeader.agencyID,
					InvoiceHeader.AdmissionID,
					MONTH(InvoiceDetail.DateFrom),
					YEAR(InvoiceDetail.DateFrom),
					LAST_DAY(DATEADD(MONTH,-1,InvoiceDetail.DateFrom))+1
	) Invoices
	WHERE DATEFROMPARTS(Invoices.ServiceYear, Invoices.ServiceMonth, 1) >= (SELECT FirstServiceDay FROM FirstServiceDay)
)
,TopSchedulesClientsDetails
AS
(

	SELECT 
		SchedulesClients.*
		,ClientAdmissions.AdmissionType
		,ROW_NUMBER() OVER ( PARTITION BY SchedulesClients.agencyID,SchedulesClients.ScheduleID 
							ORDER BY SchedulesClients.ClientSchedHdrID DESC,SchedulesClients.ClientSchedDtlID DESC
						) TopSeq
	FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_SCHEDULESCLIENTS SchedulesClients
	JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
	ON ClientAdmissions.agencyID = SchedulesClients.agencyID
	AND ClientAdmissions.admissionID = SchedulesClients.AdmissionID

)
, TopSchedulesStaffsDetails
AS
(
SELECT 
	SchedulesStaffs.*
	,Staffs.StaffAgencyID
	,ROW_NUMBER() OVER ( PARTITION BY SchedulesStaffs.agencyID,SchedulesStaffs.ScheduleID
							ORDER BY SchedulesStaffs.StaffSchedHdrID DESC,SchedulesStaffs.StaffSchedDtlID DESC
						) TopSeq
FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_SCHEDULESSTAFFS SchedulesStaffs
JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_STAFFS Staffs
ON Staffs.agencyID = SchedulesStaffs.agencyID
AND Staffs.staffID = SchedulesStaffs.StaffID
)
,SchedulesStaffRatesByStaffAgencyID (AgencyId, AdmissionId,StaffAgencyID,ServiceBeginDate, ServiceMonth, ServiceYear, BillRate_Past,BillRate_Future)
AS 
(		
	SELECT 
	*
	FROM
	(
		SELECT 
			SchedulesClients.agencyID,
			SchedulesClients.AdmissionID,
			SchedulesStaffs.StaffAgencyID,
			LAST_DAY(DATEADD(MONTH,-1,Schedules.ScheduleDate))+1 AS ServiceBeginDate,
			MONTH(Schedules.ScheduleDate) ServiceMonth,
			YEAR(Schedules.ScheduleDate) ServiceYear,
			LAST_VALUE(AVG(IFF(NVL(SchedulesClients.Rate, 0) = 0,
					NULL,
					SchedulesClients.Rate * IFF(SchedulesClients.UnitType = ''05'', 4, 1))
				)
			) OVER (PARTITION BY SchedulesClients.agencyID,
								SchedulesClients.AdmissionID
					ORDER BY YEAR(Schedules.ScheduleDate),
							MONTH(Schedules.ScheduleDate)
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
				) BillRate_Past,
			FIRST_VALUE(AVG(IFF(NVL(SchedulesClients.Rate, 0) = 0,
					NULL,
					SchedulesClients.Rate * IFF(SchedulesClients.UnitType = ''05'', 4, 1))
				)
			) OVER (PARTITION BY SchedulesClients.agencyID,
								SchedulesClients.AdmissionID
					ORDER BY YEAR(Schedules.ScheduleDate),
							MONTH(Schedules.ScheduleDate)
					ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
					) BillRate_Future
		FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_SCHEDULES Schedules
		INNER JOIN TopSchedulesClientsDetails SchedulesClients
			ON Schedules.agencyID = SchedulesClients.agencyID
			AND Schedules.ScheduleID = SchedulesClients.ScheduleID
			AND SchedulesClients.TopSeq=1
		INNER JOIN TopSchedulesStaffsDetails SchedulesStaffs
			ON Schedules.agencyID = SchedulesStaffs.agencyID
			AND Schedules.ScheduleID = SchedulesStaffs.ScheduleID
			AND SchedulesStaffs.TopSeq=1
		  WHERE Schedules.Status IN ( ''02'', ''03'', ''04'' )
                AND SchedulesClients.UnitType IN ( ''01'', ''05'' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
                AND NVL(SchedulesClients.sedUnits, 0) <> 0
                AND SchedulesStaffs.UnitType IN ( ''01'', ''05'' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
                AND NVL(SchedulesStaffs.Amount, 0) <> 0
                AND NVL(SchedulesStaffs.sedUnits, 0) <> 0
		GROUP BY SchedulesClients.agencyID,
                            SchedulesClients.AdmissionID,
                            SchedulesStaffs.StaffAgencyID,
                            LAST_DAY(DATEADD(MONTH,-1,Schedules.ScheduleDate))+1,
                            MONTH(Schedules.ScheduleDate),
                            YEAR(Schedules.ScheduleDate)

	) Schedules
	WHERE DATEFROMPARTS(Schedules.ServiceYear, Schedules.ServiceMonth, 1) >= (SELECT FirstServiceDay FROM FirstServiceDay)
)
,SchedulesStaffRates
AS 
(
	SELECT 
		agencyID,
		AdmissionID,
		ServiceBeginDate,
		ServiceMonth,
		ServiceYear,
		MAX(BillRate_Past) BillRate_Past,
		MAX(BillRate_Future) BillRate_Future
	FROM SchedulesStaffRatesByStaffAgencyID
	GROUP BY	agencyID,
				AdmissionID,
				ServiceBeginDate,
				ServiceMonth,
				ServiceYear
)

 SELECT
  md5(NVL(AUTHS.SOURCE_SYSTEM_CODE, '''') || ''-'' || NVL(AUTHS.REPORT_DATE::string,'''') || ''-'' || AUTHS.BRANCH_NAME || ''-'' || NVL(AUTHS.CLIENT_CODE,-1) || ''-'' || NVL(AUTHS.CONTRACT_CODE,'''') || ''-''|| NVL(AUTHS.AUTHID,-1)
   || ''-'' || NVL(AUTHS.SERVICEID,''-1'') || ''-'' || ''SANDATAIMPORT'' ) AS INTAKE_KEY
 ,AUTHS.REPORT_DATE
 ,md5(nvl(AUTHS.SOURCE_SYSTEM_CODE,''S'') || ''-'' || AUTHS.OFFICE_CODE || ''-'' ||  ''SANDATAIMPORT'')
 ,md5(nvl(AUTHS.SOURCE_SYSTEM_CODE,''S'')|| ''-'' ||  NVL(AUTHS.CLIENT_CODE, -1) || ''-''  ||  ''SANDATAIMPORT'' ) AS CLIENT_KEY
 ,md5(nvl(AUTHS.SOURCE_SYSTEM_CODE,''S'') || ''-'' || AUTHS.CONTRACT_CODE || ''-''  ||  ''SANDATAIMPORT'') AS CONTRACT_KEY
 ,4 AS SOURCE_SYSTEM_ID
,Auths.PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
  ,Auths.CLIENT_BEGIN_SERVICE_DATE  -- Added BY PJShah ON 19042022
  ,Auths.CLIENT_END_SERVICE_DATE  -- Added BY PJShah ON 19042022
  ,Auths.LATEST_AUTH_BEGIN_DATE  -- Added BY PJShah ON 19042022
  ,Auths.LATEST_AUTH_END_DATE  -- Added BY PJShah ON 19042022
 ,AUTHS.REAUTHORIZED_DATE AS REAUTHORIZED_DATE
 ,AUTHS.BRANCH_NAME AS BRANCH_NAME
 ,AUTHS.CLIENT_CODE AS CLIENT_NUMBER
 ,AUTHS.CONTRACT_CODE AS CONTRACT_CODE
 ,COALESCE(
                            NULLIF(inv.BillRate_Past, 0),
                            NULLIF(StaffRates.BillRate_Past, 0),
                            NULLIF(inv.BillRate_Future, 0),
                            NULLIF(StaffRates.BillRate_Future, 0)
                        ) AS  BILL_RATE
 ,AUTHS.SOURCE_SYSTEM_CODE AS SYSTEM_CODE
 ,null AS CASE_MANAGER
 ,AUTHS.HOURS_AUTHORIZED AS HOURS_AUTHORIZED
 ,AUTHS.HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED
 --,AUTHS.AUTHID
        ---- ETL FIELDS ___
 ,
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
     
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
        
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG
   FROM AUTHS
 LEFT JOIN Invoices inv
 ON AUTHS.SOURCE_SYSTEM_CODE = inv.AGENCYID
 AND AUTHS.ADMISSIONID = inv.ADMISSIONID
 AND AUTHS.REPORT_DATE = inv.ServiceBeginDate
 LEFT JOIN SchedulesStaffRates StaffRates
 ON AUTHS.SOURCE_SYSTEM_CODE = StaffRates.AGENCYID
 AND AUTHS.ADMISSIONID = StaffRates.ADMISSIONID
 AND AUTHS.REPORT_DATE = StaffRates.ServiceBeginDate
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

