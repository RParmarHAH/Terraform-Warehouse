create or replace view DW_PROD.STAGE.SANDATAIMPORT_FACT_INTAKE_TEMP_VIEW(
	OLD_INTAKE_KEY,
	NEW_INTAKE_KEY,
	OLD_CONTRACT_KEY,
	NEW_CONTRACT_KEY,
	OLD_SYSTEM_CODE,
	NEW_SYSTEM_CODE
) as 
WITH 
CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLIENTID, MASTER_ID,AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST
        WHERE AGENCYID=8485 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CLIENTID, MASTER_ID,AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MATCH_LIST
		WHERE CLIENTID NOT IN (SELECT CLIENTID FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST ) 
        AND AGENCYID=8485
	)
),
AD AS
    ( SELECT DISTINCT
       F.CLIENTID
      ,F.ADMISSIONID
      ,F.SOC AS CLIENT_ADMISSIONS
      ,DATE_TRUNC('week', CLIENT_ADMISSIONS) AS START_OF_WEEK
      ,F.AGENCYID
      ,F.ADMISSIONSTATUS
      ,F.ADMISSIONTYPE
      ,IFF(F.EOC IS NULL, LAST_DAY(CURRENT_DATE()),F.EOC) AS END_SERVICE_DATE
      ,LAST_DAY(END_SERVICE_DATE) AS DERIVED_END_SERVICE_DATE
 
	  ,COALESCE(BRANCH.OFFICE_CODE, f.LOCATIONID) AS OFFICE_CODE
	  ,COALESCE(BRANCH.BRANCH_NAME, f.LOCATIONID) AS BRANCH_NAME
	  ,COALESCE(BRANCH.BRANCH_NAME, f.LOCATIONID) AS INTAKE_OFFICE_NAME
      ,F.SOC AS REAUTHORIZED_DATE
      ,P.PAYORID
      ,F.COORDINATORID
	  ,F.SOC AS CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah 19042022
      ,F.EOC AS CLIENT_END_SERVICE_DATE -- Added BY PJShah 19042022
    FROM DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS F
  
	LEFT JOIN DW_PROD.HAH.DIM_BRANCH BRANCH
		ON BRANCH.SYSTEM_CODE = F.AGENCYID AND BRANCH.OFFICE_CODE = F.LOCATIONID
	JOIN DISC_PROD.SANDATAIMPORT.SANDATA_ADMISSIONSPAYORS P
	ON P.AGENCYID = F.AGENCYID
    AND P.ADMISSIONID = F.ADMISSIONID
    WHERE F.AGENCYID = '8485' AND F.ADMISSIONSTATUS IN (02,03,04)  
), max_auth AS (
    SELECT * FROM (SELECT DISTINCT AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID, DATEBEGIN
        , LEAD(DATEBEGIN,1,DATEEND) OVER (PARTITION BY AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID ORDER BY DATEBEGIN) as new_dateend
        , MAX(AUTHID) OVER (PARTITION BY AGENCYID, ADMISSIONID, PAYORID, PERIODID, SERVICEID, EVENTID, DATEBEGIN) as max_auth_ref
    FROM DISC_PROD.SANDATAIMPORT.SANDATA_AUTHORIZATIONS v
    WHERE AGENCYID = 8485)WHERE  DATEBEGIN <> new_dateend
), 
AUTHS AS
(

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
	  ,DATEDIFF('day', IFF(A.DATEBEGIN <= CAL.FIRST_DAY_OF_MONTH, CAL.FIRST_DAY_OF_MONTH, A.DATEBEGIN), IFF(A.DATEEND >= CAL.LAST_DAY_OF_MONTH, CAL.LAST_DAY_OF_MONTH, A.DATEEND))+1 AS NUMBER_DAYS -- number days in a month
	  ,NUMBER_DAYS/7 AS FULL_WEEKS -- get decimal of full weeks in month to be used in week type
	  ,DATEDIFF('day', A.DATEBEGIN, A.DATEEND)+1 AS NUMBER_DAYS_NONE -- To be used if type is none
	  ,A.DATEBEGIN AS REAUTHORIZED_DATE
	  ,IFF(A.PERIODLIMIT = 0 OR A.PERIODLIMIT IS NULL, A.MAXIMUM,PERIODLIMIT) AS CHECK_ZERO -- CHECKING IF PERIOD LIMIT IS NULL OR ZERO
	 -- ,IFF(A.PERIODLIMIT = 0 OR A.PERIODLIMIT IS NULL, A.MAXIMUM, IFF(A.LIMITTYPE = 'Month',CHECK_ZERO,FULL_WEEKS*PERIODLIMIT ) ) AS HOURS_AUTHORIZED 
	  ,CASE WHEN LIMITTYPE = 'Month' THEN CHECK_ZERO 
	        WHEN LIMITTYPE = 'Week'  THEN FULL_WEEKS * PERIODLIMIT
	        WHEN LIMITTYPE = 'None'  THEN (A.MAXIMUM/NUMBER_DAYS_NONE)*(IFF(NUMBER_DAYS_NONE < NUMBER_DAYS,1,NUMBER_DAYS))
	        WHEN LIMITTYPE = 'Year'  THEN (CHECK_ZERO/365)*NUMBER_DAYS
	        ELSE CHECK_ZERO END AS HOURS_AUTHORIZED_CALC
	  ,IFF(A.FORMAT = '03',HOURS_AUTHORIZED_CALC/4, HOURS_AUTHORIZED_CALC) AS HOURS_AUTHORIZED-- IF LIMIT TYPE = 03 THEN DIVIDE BY 4
	  ,A.ADMISSIONID AS ADMISSIONID
	  ,A.AUTHREFNO  AS PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
	  ,AD.CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah ON 19042022
	  ,AD.CLIENT_END_SERVICE_DATE -- Added BY PJShah ON 19042022
	FROM DISC_PROD.SANDATAIMPORT.SANDATA_AUTHORIZATIONS A
	JOIN max_auth m ON a.AGENCYID = m.AGENCYID AND a.ADMISSIONID = m.ADMISSIONID AND a.PAYORID = m.PAYORID
	    AND a.PERIODID = m.PERIODID AND a.SERVICEID = m.SERVICEID AND a.EVENTID = m.EVENTID
	    AND a.DATEBEGIN = m.DATEBEGIN AND a.AUTHID = m.max_auth_ref
	LEFT JOIN AD
	    ON AD.AGENCYID = A.AGENCYID
	    AND AD.ADMISSIONID = A.ADMISSIONID
	    AND AD.PAYORID = A.PAYORID
	LEFT JOIN DW_PROD.HAH.DIM_DATE CAL
	ON AD.CLIENT_ADMISSIONS <= IFF(DATE_PART('day',a.DATEBEGIN) <> 1,(DATEADD('month',1,CAL.CALENDAR_DATE)),CAL.CALENDAR_DATE)
	    AND   DATEEND >= CAL.CALENDAR_DATE
	    AND cal.CALENDAR_DATE < m.new_dateend AND m.DATEBEGIN <> m.new_dateend
	WHERE AD.AGENCYID = '8485'
	AND AD.ADMISSIONSTATUS IN (02,03,04)
	 
	AND CAL.CALENDAR_DATE BETWEEN a.DATEBEGIN AND DATEEND
	AND A.SERVICEID in ('VBPCG')
)
LIST

GROUP BY REPORT_DATE, CLIENT_CODE, DERIVED_END_SERVICE_DATE, CONTRACT_CODE, SOURCE_SYSTEM_CODE, OFFICE_CODE, BRANCH_NAME, AUTHID, PERIODID, SERVICEID, EVENTID, ADMISSIONID 
,PRE_AUTH_NUMBER -- Added BY PJShah ON 19042022
,CLIENT_BEGIN_SERVICE_DATE -- Added BY PJShah ON 19042022
,CLIENT_END_SERVICE_DATE -- Added BY PJShah ON 19042022

)

,
FirstServiceDay 
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
	FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER H
	JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS D
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
			SUM(IFF(InvoiceDetail.UnitTypeID = '05',
					InvoiceDetail.Duration / 4.0,
					InvoiceDetail.Duration)
				) HoursBilled,

			LAST_VALUE(AVG(InvoiceDetail.Rate * IFF(InvoiceDetail.UnitTypeID = '05', 4, 1))) OVER (PARTITION BY InvoiceHeader.agencyID,
																												InvoiceHeader.AdmissionID
																									ORDER BY YEAR(InvoiceDetail.DateFrom),
																											MONTH(InvoiceDetail.DateFrom)
																									ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
																									) BillRate_Past,
			FIRST_VALUE(AVG(InvoiceDetail.Rate * IFF(InvoiceDetail.UnitTypeID = '05', 4, 1))) OVER (PARTITION BY InvoiceHeader.agencyID,
																												InvoiceHeader.AdmissionID
																									ORDER BY YEAR(InvoiceDetail.DateFrom),
																											MONTH(InvoiceDetail.DateFrom)
																									ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
																									) BillRate_Future
		FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER InvoiceHeader
		JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS InvoiceDetail
			ON InvoiceDetail.agencyID = InvoiceHeader.agencyID
			AND InvoiceDetail.InvoiceNumber = InvoiceHeader.InvoiceNumber
		JOIN LastInvoices LastInvoices
			ON LastInvoices.AgencyId = InvoiceHeader.agencyID
			AND LastInvoices.AdmissionId = InvoiceHeader.AdmissionID
			AND LastInvoices.InvoiceNumber = InvoiceHeader.InvoiceNumber
			AND LastInvoices.InvoiceLineId = InvoiceDetail.InvoiceLineID
			AND LastInvoices.ScheduleDate = InvoiceDetail.DateFrom
		WHERE InvoiceDetail.UnitTypeID IN ( '01', '05' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
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
	FROM DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULESCLIENTS SchedulesClients
	JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
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
FROM DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULESSTAFFS SchedulesStaffs
JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS Staffs
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
					SchedulesClients.Rate * IFF(SchedulesClients.UnitType = '05', 4, 1))
				)
			) OVER (PARTITION BY SchedulesClients.agencyID,
								SchedulesClients.AdmissionID
					ORDER BY YEAR(Schedules.ScheduleDate),
							MONTH(Schedules.ScheduleDate)
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
				) BillRate_Past,
			FIRST_VALUE(AVG(IFF(NVL(SchedulesClients.Rate, 0) = 0,
					NULL,
					SchedulesClients.Rate * IFF(SchedulesClients.UnitType = '05', 4, 1))
				)
			) OVER (PARTITION BY SchedulesClients.agencyID,
								SchedulesClients.AdmissionID
					ORDER BY YEAR(Schedules.ScheduleDate),
							MONTH(Schedules.ScheduleDate)
					ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
					) BillRate_Future
		FROM DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULES Schedules
		INNER JOIN TopSchedulesClientsDetails SchedulesClients
			ON Schedules.agencyID = SchedulesClients.agencyID
			AND Schedules.ScheduleID = SchedulesClients.ScheduleID
			AND SchedulesClients.TopSeq=1
		INNER JOIN TopSchedulesStaffsDetails SchedulesStaffs
			ON Schedules.agencyID = SchedulesStaffs.agencyID
			AND Schedules.ScheduleID = SchedulesStaffs.ScheduleID
			AND SchedulesStaffs.TopSeq=1
		  WHERE Schedules.Status IN ( '02', '03', '04' )
                AND SchedulesClients.UnitType IN ( '01', '05' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
                AND NVL(SchedulesClients.sedUnits, 0) <> 0
                AND SchedulesStaffs.UnitType IN ( '01', '05' ) -- 01-Hourly, 02-Visit, 05-Unit, 06-PerDiem
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
  md5(NVL(AUTHS.SOURCE_SYSTEM_CODE, '') || '-' || NVL(AUTHS.REPORT_DATE::string,'') || '-' || AUTHS.BRANCH_NAME || '-' || NVL(AUTHS.CLIENT_CODE,-1) || '-' || NVL(AUTHS.CONTRACT_CODE,'') || '-'|| NVL(AUTHS.AUTHID,-1)
   || '-' || NVL(AUTHS.SERVICEID,'-1') || '-' || 'SANDATAIMPORT' ) AS OLD_INTAKE_KEY,
  
  CASE WHEN AUTHS.SERVICEID  in ('VBPCG')
  		THEN md5('CC_'||NVL(AUTHS.SOURCE_SYSTEM_CODE, '') || '-' || NVL(AUTHS.REPORT_DATE::string,'') || '-' || AUTHS.BRANCH_NAME || '-' || NVL(AUTHS.CLIENT_CODE,-1) || '-' || NVL(AUTHS.CONTRACT_CODE,'') || '-'|| NVL(AUTHS.AUTHID,-1)
               || '-' || NVL(AUTHS.SERVICEID,'-1') || '-' || 'SANDATAIMPORT' )
        ELSE  md5(NVL(AUTHS.SOURCE_SYSTEM_CODE, '') || '-' || NVL(AUTHS.REPORT_DATE::string,'') || '-' || AUTHS.BRANCH_NAME || '-' || NVL(AUTHS.CLIENT_CODE,-1) || '-' || NVL(AUTHS.CONTRACT_CODE,'') || '-'|| NVL(AUTHS.AUTHID,-1)
  				|| '-' || NVL(AUTHS.SERVICEID,'-1') || '-' || 'SANDATAIMPORT' ) END AS NEW_INTAKE_KEY,
   
 md5(nvl(AUTHS.SOURCE_SYSTEM_CODE,'S') || '-' || AUTHS.CONTRACT_CODE || '-'  ||  'SANDATAIMPORT') 
 									AS OLD_CONTRACT_KEY,
 
 CASE WHEN AUTHS.SERVICEID in ('VBPCG')
 	THEN  
 	md5('CC_'||nvl(AUTHS.SOURCE_SYSTEM_CODE,'S') || '-' || AUTHS.CONTRACT_CODE || '-'  ||  'SANDATAIMPORT')
 	ELSE
 	md5(nvl(AUTHS.SOURCE_SYSTEM_CODE,'S') || '-' || AUTHS.CONTRACT_CODE || '-'  ||  'SANDATAIMPORT')
 	END AS NEW_CONTRACT_KEY,
 									
 AUTHS.SOURCE_SYSTEM_CODE AS OLD_SYSTEM_CODE,
 
 CASE WHEN AUTHS.SERVICEID in ('VBPCG')
 	THEN  'CC_'||AUTHS.SOURCE_SYSTEM_CODE
 	ELSE AUTHS.SOURCE_SYSTEM_CODE
 	END AS NEW_SYSTEM_CODE
 
   FROM AUTHS
 LEFT JOIN Invoices inv
 ON AUTHS.SOURCE_SYSTEM_CODE = inv.AGENCYID
 AND AUTHS.ADMISSIONID = inv.ADMISSIONID
 AND AUTHS.REPORT_DATE = inv.ServiceBeginDate
 LEFT JOIN SchedulesStaffRates StaffRates
 ON AUTHS.SOURCE_SYSTEM_CODE = StaffRates.AGENCYID
 AND AUTHS.ADMISSIONID = StaffRates.ADMISSIONID
 AND AUTHS.REPORT_DATE = StaffRates.ServiceBeginDate
 LEFT JOIN CLIENT CL ON CL.AGENCYID= AUTHS.SOURCE_SYSTEM_CODE AND CL.CLIENTID = AUTHS.CLIENT_CODE;