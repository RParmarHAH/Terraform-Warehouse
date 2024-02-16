CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_COVID_19_DAILYVISITHOURSCOUNT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    INSERT OVERWRITE INTO REPORT.COVID_19_DAILYVISITHOURSCOUNT
with SD_Visits as
(
    SELECT
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    "DATE" as Service_Date,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM Disc_Prod.SandataImport.Sandata_Visits visit
    LEFT JOIN Disc_Prod.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID AND TYP = ''L''
    LEFT JOIN DISC_Prod.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND eid.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
        ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''8485'' WHEN AGENCYID = 38004 THEN ''IN'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485 THEN 
        case when nvl(eid.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(eid.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(eid.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
WHERE nvl(visit.LOCATIONID,'''') <> ''''
    and "DATE" >= CAST( ''2020-01-06'' AS DATE)
  and "DATE" <= current_date()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN))
    AND AGENCYID IN (8380, 8485, 38004)
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,branch_key
),
allmasterdata as
(
  SELECT DISTINCT CALENDAR_DATE,PreviousWeekDate,WEEK_OF_YEAR,DAY_OF_WEEK,DAY_NAME,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM
    (
    SELECT CALENDAR_DATE,DATEADD(DAY,-7,CALENDAR_DATE) as PreviousWeekDate
    ,WEEK_OF_YEAR,DAY_OF_WEEK,DAY_NAME
    from
    HAH.DIM_DATE
    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || DATEADD(day,-6,LAST_DAY(CALENDAR_DATE,''Week'')) || '' - '' || LAST_DAY(CALENDAR_DATE,''Week'') || '' )'' AS Week,
 DAY_NAME as WeekDay,
 CASE WHEN DAY_OF_WEEK = 0 THEN 7 ELSE DAY_OF_WEEK END as dayofweek,
 allmasterdata.CALENDAR_DATE,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 ALLMASTERDATA.eventstatus,
 CURRENTWEEK.Hours as CurrentWeekHours,
 PreviousWeek.Hours as PreviousWeekHours,
 currentweek.TOTALVISIT as CurrentWeekTotalVisit,
 PreviousWeek.TOTALVISIT as PreviousWeekTotalVisit,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,
0 as ETL_DELETED_FLAG,
0 as ETL_INFERRED_MEMBER_FLAG
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits where service_date <= current_date()
) CurrentWeek
on CurrentWeek.Service_Date = AllmasterDAta.CALENDAR_DATE
and CURRENTWEEK.STATE = AllmasterDAta.STATE
and CURRENTWEEK.BRANCH_NAME = AllmasterDAta.BRANCH_NAME
AND CURRENTWEEK.EVENTSTATUS = ALLMASTERDATA.EVENTSTATUS
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits
) PreviousWeek
on PreviousWeek.Service_Date =  AllmasterDAta.PreviousWeekDate
and AllmasterDAta.BRANCH_NAME = PreviousWeek.BRANCH_NAME
and PreviousWeek.STATE = AllmasterDAta.STATE
AND PreviousWeek.EVENTSTATUS = ALLMASTERDATA.EVENTSTATUS
WHERE CALENDAR_DATE <= last_Day( CURRENT_DATE(),''Week'')
AND CALENDAR_DATE > ''2020-01-05'';

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';