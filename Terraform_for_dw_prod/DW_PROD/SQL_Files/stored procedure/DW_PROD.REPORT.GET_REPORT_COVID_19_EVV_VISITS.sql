CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_COVID_19_EVV_VISITS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO REPORT.COVID_19_EVV_VISITS
	(STATE, OFFICENUMBER, OFFICENAME, SERVICEDATE, ZIP, BRANCH_KEY,
     CASECOUNT, TOTALSCHEDULES, HOURSMANAGED,
		PENDING_MISSEDSCHEDULES, ONHOLDSCHEDULES, CANCELLEDSCHEDULES, 
		VISITS_TOTALCONFIRMED, VISITS_AUTOCONFIRMED, VISITS_MANUALLYCONFIRMED,
		ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG)


WITH ListOfDates
AS (
   SELECT CALENDAR_DATE Dt
   FROM HAH.DIM_DATE
   WHERE CALENDAR_DATE BETWEEN ''2020-01-01'' AND DATEADD(DAY, -2, CURRENT_DATE())),
     ListOfStates
AS (SELECT STATE_ISO_CODE STATE,
           SANDATA_AGENCY_ID AGENCYID
    FROM HAH.DIM_STATE
    WHERE STATE_ISO_CODE IN ( ''IL'', ''IN'', ''PA'' )),
     ServiceDates
AS (SELECT ListOfDates.Dt ServiceDate,
           ListOfStates.STATE,
           ListOfStates.AGENCYID
    FROM ListOfDates,
         ListOfStates)
SELECT ServiceDates.STATE,
       SandataVisits.LocationId AS OFFICENUMBER,
       EL.LstNam OfficeName,
       ServiceDates.ServiceDate,
       LEFT(TRIM(Clients.Zip), 12) Zip,
	   BRANCH_KEY,
       COUNT(DISTINCT SandataVisits.ChartID) CaseCount,
       COUNT(DISTINCT SandataVisits.ScheduleID) TotalSchedules,
       SUM(SandataVisits.ScheduledDuration) HoursManaged,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status = ''01'' THEN
                              SandataVisits.ScheduleID
                      END
            ) Pending_MissedSchedules,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status = ''09'' THEN
                              SandataVisits.ScheduleID
                      END
            ) OnHoldSchedules,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status = ''10'' THEN
                              SandataVisits.ScheduleID
                      END
            ) CancelledSchedules,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status IN ( ''02'', ''03'', ''04'' ) THEN
                              SandataVisits.ScheduleID
                      END
            ) Visits_TotalConfirmed,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status IN ( ''02'', ''03'', ''04'' )
                               AND SandataVisits.VerificationType = ''Auto'' THEN
                              SandataVisits.ScheduleID
                      END
            ) Visits_AutoConfirmed,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status IN ( ''02'', ''03'', ''04'' ) THEN
                              SandataVisits.ScheduleID
                      END
            ) - --Visits_TotalConfirmed,
       COUNT(DISTINCT CASE
                          WHEN SandataVisits.Status IN ( ''02'', ''03'', ''04'' )
                               AND SandataVisits.VerificationType = ''Auto'' THEN
                              SandataVisits.ScheduleID
                      END
            ) --Visits_AutoConfirmed,
       Visits_ManuallyConfirmed,
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
    FROM ServiceDates ServiceDates
    JOIN DISC_PROD.BI_REPOSITORY.SANDATAVISITS SandataVisits
        ON SandataVisits.AGENCYID = ServiceDates.AGENCYID
           AND SandataVisits.SCHEDULEDATE = ServiceDates.SERVICEDATE
    JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTS Clients
        ON Clients.AGENCYID = SandataVisits.AGENCYID 
           AND Clients.CLIENTID = SandataVisits.CLIENTID 
    JOIN DISC_PROD.BI_REPOSITORY.EXTERNALIDS EL
        ON EL.DBNAME = ServiceDates.STATE
           AND EL.TYP = ''L''
           AND EL.EXTID = SandataVisits.LOCATIONID 
     LEFT JOIN DISC_Prod.DATAFLEXSYNCDATA.DFOFFICES off
        ON off.DBNAME = ''PA''
        AND EL.LSTNAM = off.OFFICENAME     
     LEFT JOIN HAH.DIM_BRANCH BRANCH
        ON BRANCH.OFFICE_STATE_CODE  = ServiceDates.STATE
        AND BRANCH.OFFICE_NUMBER = CASE WHEN ServiceDates.STATE = ''PA'' THEN 
        case when nvl(EL.LstNam,SandataVisits.LocationId) = ''ERIE'' then 508
                when nvl(EL.LstNam,SandataVisits.LocationId) = ''CHINATOWN PA'' then 509
                when nvl(EL.LstNam,SandataVisits.LocationId) = ''WILLIAMSPORT'' then 511
                else off.OFFICENUMBER end 
         ELSE SandataVisits.LOCATIONID END 
WHERE SandataVisits.LOCATIONID IS NOT NULL
      AND NVL(Clients.ZIP, '''') <> ''''
      
GROUP BY ServiceDates.STATE,
         SandataVisits.LocationId,
         EL.LSTNAM,
         ServiceDates.ServiceDate,
         Clients.ZIP,
		 BRANCH.BRANCH_KEY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';