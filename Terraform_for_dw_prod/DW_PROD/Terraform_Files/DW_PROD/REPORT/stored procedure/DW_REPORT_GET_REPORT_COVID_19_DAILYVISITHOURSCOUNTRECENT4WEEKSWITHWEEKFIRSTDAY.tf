resource "snowflake_procedure" "DW_REPORT_GET_REPORT_COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY" {
	name ="GET_REPORT_COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
    return_result_temp VARCHAR;
BEGIN        
    INSERT OVERWRITE INTO REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY
                                 
with SD_Visits as 
(
    SELECT 
    "DATE" as Service_Date,
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Visits visit
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID and  TYP = ''L''
     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EID.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
        ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 38004 THEN ''IN'' ELSE ''8485'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485  THEN 
        case when nvl(EID.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(EID.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EID.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
    WHERE "DATE" >= CAST( ''2019-11-01'' AS DATE)
  and "DATE" <= CURRENT_DATE()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN)) 
    AND AGENCYID IN (8380, 8485, 38004)  
 and nvl(Visit.LOCATIONID,'''') <> ''''
     
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,BRANCH_KEY
),
allmasterdata as
(
  SELECT DISTINCT WEEK_OF_YEAR,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM 
    (
    SELECT DISTINCT  WEEK_OF_YEAR,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY
   from 
    HAH.DIM_DATE 
    where week_of_year >= 1 and year >= 2020
      and calendar_date <= current_date()

    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT 
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || HAH_CURRENT_WEEK_FIRST_DAY || '' - '' || HAH_CURRENT_WEEK_LAST_DAY || '' )'' AS Week,
 allmasterdata.HAH_CURRENT_WEEK_FIRST_DAY AS WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus,
 SUM(CURRENTWEEK.Hours) as CurrentWeekHours,
 0 as PREVIOUS4THWEEKHOURS,
 0 AS ROLLING4WEEKSHOURS,
 0 AS PREVIOUSROLLING4WEEKSHOURS,
 0 AS PREVIOUSTOPREVIOUSROLLING4WEEKS
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits where service_date <= current_date()
) CurrentWeek
on CurrentWeek.Service_Date >= AllmasterDAta.HAH_CURRENT_WEEK_FIRST_DAY
and CurrentWeek.Service_Date <= AllmasterDAta.HAH_CURRENT_WEEK_LAST_DAY
and CURRENTWEEK.STATE = AllmasterDAta.STATE
and CURRENTWEEK.BRANCH_KEY = AllmasterDAta.BRANCH_KEY
and CURRENTWEEK.EVENTSTATUS = AllmasterDAta.EVENTSTATUS
GROUP BY
 WEEK_OF_YEAR,
 Week,
 WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 allmasterdata.BRANCH_KEY,
 allmasterdata.eventstatus;
 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

INSERT INTO REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY
with SD_Visits as 
(
    SELECT 
    "DATE" as Service_Date,
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Visits visit
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID and  TYP = ''L''
     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EID.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
        ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 38004 THEN ''IN'' ELSE ''8485'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485  THEN 
        case when nvl(EID.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(EID.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EID.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
    WHERE "DATE" >= CAST( ''2019-11-01'' AS DATE)
  and "DATE" <= CURRENT_DATE()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN)) 
    AND AGENCYID IN (8380, 8485, 38004)  
 and nvl(Visit.LOCATIONID,'''') <> ''''
     
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,BRANCH_KEY
),
allmasterdata as
(
  SELECT DISTINCT WEEK_OF_YEAR,
      PREVIOUS_4TH_WEEK_FIRST_DAY,PREVIOUS_4TH_WEEK_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM 
    (
    SELECT WEEK_OF_YEAR,
      PREVIOUS_4TH_WEEK_FIRST_DAY,PREVIOUS_4TH_WEEK_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY
   from 
    HAH.DIM_DATE
      
      
       where week_of_year >= 1 and year >= 2020
      and calendar_date <= current_date()

    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT 
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || HAH_CURRENT_WEEK_FIRST_DAY || '' - '' || HAH_CURRENT_WEEK_LAST_DAY || '' )'' AS Week,
 allmasterdata.HAH_CURRENT_WEEK_FIRST_DAY AS WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus,
 0 as CurrentWeekHours,
 SUM(PreviousWeek.HOURS) as PREVIOUS4THWEEKHOURS,
 0 AS ROLLING4WEEKSHOURS,
 0 AS PREVIOUSROLLING4WEEKSHOURS,
 0 AS PREVIOUSTOPREVIOUSROLLING4WEEKS
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits
) PreviousWeek
on PreviousWeek.Service_Date >= AllmasterDAta.PREVIOUS_4TH_WEEK_FIRST_DAY
and PreviousWeek.Service_Date <= AllmasterDAta.PREVIOUS_4TH_WEEK_LAST_DAY
and PreviousWeek.STATE = AllmasterDAta.STATE
and PreviousWeek.BRANCH_KEY = AllmasterDAta.BRANCH_KEY
and PreviousWeek.EVENTSTATUS = AllmasterDAta.EVENTSTATUS

--AND 
GROUP BY
 WEEK_OF_YEAR,
 Week,
 WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus;

 SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
return_result:=CONCAT(return_result,'' & '',return_result_temp);
 
INSERT INTO REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY
with SD_Visits as 
(
     SELECT 
    "DATE" as Service_Date,
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Visits visit
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID and  TYP = ''L''
     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EID.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
         ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 38004 THEN ''IN'' ELSE ''8485'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485  THEN 
        case when nvl(EID.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(EID.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EID.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
    WHERE "DATE" >= CAST( ''2019-11-01'' AS DATE)
  and "DATE" <= CURRENT_DATE()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN)) 
    AND AGENCYID IN (8380, 8485, 38004)  
 and nvl(Visit.LOCATIONID,'''') <> ''''
     
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,BRANCH_KEY
),
allmasterdata as
(
  SELECT DISTINCT WEEK_OF_YEAR,
      PREVIOUS_ROLLING_4_WEEKS_FIRST_DAY,PREVIOUS_ROLLING_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM 
    (
    SELECT WEEK_OF_YEAR,
      PREVIOUS_ROLLING_4_WEEKS_FIRST_DAY,PREVIOUS_ROLLING_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY
   from 
    HAH.DIM_DATE 
       where week_of_year >= 1 and year >= 2020
      and calendar_date <= current_date()

    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT 
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || HAH_CURRENT_WEEK_FIRST_DAY || '' - '' || HAH_CURRENT_WEEK_LAST_DAY || '' )'' AS Week,
 allmasterdata.HAH_CURRENT_WEEK_FIRST_DAY AS WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus,
 0 as CurrentWeekHours,
 0 as PREVIOUS4THWEEKHOURS,
 0 AS ROLLING4WEEKSHOURS,
 SUM(PreviousWeek.HOURS) AS PREVIOUSROLLING4WEEKSHOURS,
 0 AS PREVIOUSTOPREVIOUSROLLING4WEEKS
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits
) PreviousWeek
on PreviousWeek.Service_Date >= AllmasterDAta.PREVIOUS_ROLLING_4_WEEKS_FIRST_DAY
and PreviousWeek.Service_Date <= AllmasterDAta.PREVIOUS_ROLLING_4_WEEKS_LAST_DAY
and PreviousWeek.STATE = AllmasterDAta.STATE
and PreviousWeek.BRANCH_KEY = AllmasterDAta.BRANCH_KEY
and PreviousWeek.EVENTSTATUS = AllmasterDAta.EVENTSTATUS

--AND 
GROUP BY
 WEEK_OF_YEAR,
 Week,
 WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 allmasterdata.BRANCH_KEY,
 allmasterdata.eventstatus;
 
SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
return_result:=CONCAT(return_result,'' & '',return_result_temp);

INSERT INTO REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY
with SD_Visits as 
(
     SELECT 
    "DATE" as Service_Date,
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Visits visit
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID and  TYP = ''L''
     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EID.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
         ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 38004 THEN ''IN'' ELSE ''8485'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485  THEN 
        case when nvl(EID.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(EID.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EID.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
    WHERE "DATE" >= CAST( ''2019-11-01'' AS DATE)
  and "DATE" <= CURRENT_DATE()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN)) 
    AND AGENCYID IN (8380, 8485, 38004)  
 and nvl(Visit.LOCATIONID,'''') <> ''''
     
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,BRANCH_KEY
),
allmasterdata as
(
  SELECT DISTINCT WEEK_OF_YEAR,
      MOST_RECENT_4_WEEKS_FIRST_DAY,MOST_RECENT_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM 
    (
    SELECT WEEK_OF_YEAR,
      MOST_RECENT_4_WEEKS_FIRST_DAY,MOST_RECENT_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY
   from 
    HAH.DIM_DATE 
       where week_of_year >= 1 and year >= 2020
      and calendar_date <= current_date()

    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT 
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || HAH_CURRENT_WEEK_FIRST_DAY || '' - '' || HAH_CURRENT_WEEK_LAST_DAY || '' )'' AS Week,
 allmasterdata.HAH_CURRENT_WEEK_FIRST_DAY AS WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus,
 0 as CurrentWeekHours,
 0 as PREVIOUS4THWEEKHOURS,
 SUM(PreviousWeek.HOURS) AS ROLLING4WEEKSHOURS,
 0 AS PREVIOUSROLLING4WEEKSHOURS,
 0 AS PREVIOUSTOPREVIOUSROLLING4WEEKS
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits
) PreviousWeek
on PreviousWeek.Service_Date >= AllmasterDAta.MOST_RECENT_4_WEEKS_FIRST_DAY
and PreviousWeek.Service_Date <= AllmasterDAta.MOST_RECENT_4_WEEKS_LAST_DAY
and PreviousWeek.STATE = AllmasterDAta.STATE
and PreviousWeek.BRANCH_KEY = AllmasterDAta.BRANCH_KEY
and PreviousWeek.EVENTSTATUS = AllmasterDAta.EVENTSTATUS

--AND 
GROUP BY
 WEEK_OF_YEAR,
 Week,
 WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 allmasterdata.BRANCH_KEY,
 allmasterdata.eventstatus;

SELECT CONCAT('''',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
return_result:=CONCAT(return_result,'' & '',return_result_temp);

INSERT INTO REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKSWITHWEEKFIRSTDAY
with SD_Visits as 
(
     SELECT 
    "DATE" as Service_Date,
    CASE EVENTSTATUS WHEN ''02'' THEN ''CONFIRMED'' WHEN ''03'' THEN ''BILLABLE'' WHEN ''04'' THEN ''BILLED'' ELSE ''HOLD'' END AS EVENTSTATUS,
    CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 8485 THEN ''PA'' WHEN AGENCYID = 38004 THEN ''IN'' END AS STATE,
    nvl(eid.LstNam,LocationId) AS BRANCH_NAME,
    BRANCH.BRANCH_KEY,
    count(1) as TotalVisit,
    sum(Adjustedduration) AS Hours
    FROM DISC_${var.SF_ENVIRONMENT}.SandataImport.Sandata_Visits visit
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_Repository.EXTERNALIDS eid
        ON visit.LocationId = eid.ExtID and  TYP = ''L''
     LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EID.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
         ON BRANCH.SYSTEM_CODE  = CASE WHEN AGENCYID = 8380 THEN ''IL'' WHEN AGENCYID = 38004 THEN ''IN'' ELSE ''8485'' END
        AND BRANCH.OFFICE_NUMBER = CASE WHEN AGENCYID = 8485  THEN 
        case when nvl(EID.LstNam,visit.LocationId) = ''ERIE'' then 508
                when nvl(EID.LstNam,visit.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EID.LstNam,visit.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE visit.LOCATIONID END 
    WHERE "DATE" >= CAST( ''2019-11-01'' AS DATE)
  and "DATE" <= CURRENT_DATE()
  -- Start data gathering with the 1st week of the year
    AND EVENTSTATUS IN (''02'', ''03'', ''04'',''09'')         -- Limit visits that are "Confirmed", "In-Process" or "Closed"
  --  AND AGENCYID IN (8380 (IL), 8485 (PA), 38004(IN)) 
    AND AGENCYID IN (8380, 8485, 38004)  
 and nvl(Visit.LOCATIONID,'''') <> ''''
     
    group by SERVICE_DATE,nvl(eid.LstNam,LocationId),AGENCYID,EVENTSTATUS,BRANCH_KEY
),
allmasterdata as
(
  SELECT DISTINCT WEEK_OF_YEAR,
      PREVIOUS_4_WEEKS_FIRST_DAY,PREVIOUS_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY,
    STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
    FROM 
    (
    SELECT WEEK_OF_YEAR,
      PREVIOUS_4_WEEKS_FIRST_DAY,PREVIOUS_4_WEEKS_LAST_DAY,HAH_CURRENT_WEEK_FIRST_DAY,HAH_CURRENT_WEEK_LAST_DAY
   from 
    HAH.DIM_DATE 
       where week_of_year >= 1 and year >= 2020
      and calendar_date <= current_date()

    ) Calendar
    CROSS JOIN
    (
	    SELECT DISTINCT STATE,BRANCH_NAME,EVENTSTATUS,BRANCH_KEY
	    FROM SD_Visits
    )allstateandbranch
)
SELECT 
 WEEK_OF_YEAR as WEEK_OF_YEAR,
 ''Week '' || WEEK_OF_YEAR || '' ('' || HAH_CURRENT_WEEK_FIRST_DAY || '' - '' || HAH_CURRENT_WEEK_LAST_DAY || '' )'' AS Week,
 allmasterdata.HAH_CURRENT_WEEK_FIRST_DAY AS WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 ALLMASTERDATA.BRANCH_KEY,
 allmasterdata.eventstatus,
 0 as CurrentWeekHours,
 0 as PREVIOUS4THWEEKHOURS,
 0 AS ROLLING4WEEKSHOURS,
 0 AS PREVIOUSROLLING4WEEKSHOURS,
 SUM(PreviousWeek.HOURS) AS PREVIOUSTOPREVIOUSROLLING4WEEKS
FROM allmasterdata
LEFT OUTER JOIN
(
   SELECT * FROM SD_Visits
) PreviousWeek
on PreviousWeek.Service_Date >= AllmasterDAta.PREVIOUS_4_WEEKS_FIRST_DAY
and PreviousWeek.Service_Date <= AllmasterDAta.PREVIOUS_4_WEEKS_LAST_DAY
and PreviousWeek.STATE = AllmasterDAta.STATE
and PreviousWeek.BRANCH_KEY = AllmasterDAta.BRANCH_KEY
and PreviousWeek.EVENTSTATUS = AllmasterDAta.EVENTSTATUS

--AND 
GROUP BY
 WEEK_OF_YEAR,
 Week,
 WEEK_FIRST_DAY,
 allmasterdata.STATE,
 allmasterdata.BRANCH_NAME,
 allmasterdata.BRANCH_KEY,
 allmasterdata.eventstatus;
 
 SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
return CONCAT(return_result,'' & '',return_result_temp);
END;

 EOT
}

