CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.SP_TIMESHEET_CONFIRMATION_RESPONSES("EVALUATE_DATE" DATE)
RETURNS TABLE ("ID" NUMBER(38,0), "ENAME" VARCHAR(16777216))
LANGUAGE SQL
EXECUTE AS OWNER
AS '
  DECLARE
    res RESULTSET;
    sql_query VARCHAR;
  BEGIN
 --   IFNULL(EVALUATE_DATE, CURRENT_DATE, EVALUATE_DATE); 
    EVALUATE_DATE := CURRENT_DATE;
--SET EVALUATE_DATE = TO_DATE("2024-01-12");
    sql_query := ''ALTER SESSION SET WEEK_START = 0; 
    SET LAST_SUNDAY = DATEADD(DAY, -7, LAST_DAY('' || EVALUATE_DATE || '', "week"));

WITH hha_all_visit_records AS (
SELECT DISTINCT
b.visitid AS VISIT_ID,
b.duties AS DUTY_PERFORMED,
b.evvtypestarttime as EVV_TYPE_IN,
b.evvtypeendtime as EVV_TYPE_OUT,
a.caregiverid AS CAREGIVER_ID,
a.caregivercode AS CAREGIVER_CODE,
e.officecode AS OFFICE_CODE,
a.firstname AS FirstName, 
a.lastname AS LastName, 
a.firstname AS CAREGIVER_FIRST_NAME, 
a.lastname AS CAREGIVER_LAST_NAME,
a.notificationtextnumber AS Phone,
a.notificationemail as Email,
b.visitdate AS VISIT_DATE, 
b.visitstarttime AS VISIT_START_TIME, 
b.visitendtime AS VISIT_END_TIME, 
b.lastmodifieddate AS LAST_MODIFIED_DATE,
c.patientid AS PATIENT_ID, 
c.firstname AS PATIENT_FIRST_NAME, 
c.admissionid AS PATIENT_ADMISSION_ID,
c.lastname AS PATIENT_LAST_NAME, 
c.address1 AS PATIENT_ADDRESS_LINE1, 
c.address2 AS PATIENT_ADDRESS_LINE2, 
c.city AS PATIENT_CITY,
c.state AS PATIENT_STATE, 
c.zip5 AS PATIENT_ZIP
FROM 
DISC_PROD.HHAEXCHANGEOSHAH.CAREGIVERS a,
DISC_PROD.HHAEXCHANGEOSHAH.VISITS b,
DISC_PROD.HHAEXCHANGEOSHAH.PATIENTS c,
DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_OFFICES_REPL e
WHERE 
((b.visitdate > DATEADD(DAY, -7, $LAST_SUNDAY) AND b.visitdate <= $LAST_SUNDAY) OR (b.lastmodifieddate > DATEADD(DAY, -7, $LAST_SUNDAY) AND b.lastmodifieddate <= $LAST_SUNDAY))
and a.caregiverid = b.aideid
and b.patientid = c.patientid
and a.officeid = e.officeid
and c.state in ("PA")
and a.caregiverid not in ("3563294") --care coordination
and b.visitstarttime is not null and b.visitendtime is not null
),
hha_visit_records as (select * from hha_all_visit_records where visit_id in (select visitid from DISC_PROD.HHAEXCHANGEOSHAH.VISITEDITREASONNOTESHISTORY where createddate > DATEADD(DAY, -7, $LAST_SUNDAY) AND createddate <= $LAST_SUNDAY))
,
hha_duties as (select taskname, visitid from DISC_PROD.HHAEXCHANGEOSHAH.DUTYSHEET where visitid in (select visit_id from hha_visit_records)) 
,
hha_visit_duties_concatenated AS (select visitid, listagg(taskname, ", ") within group (order by visitid) as AGGREGATED_DUTIES
FROM (
SELECT DISTINCT visitid, taskname
FROM hha_duties)
GROUP BY visitid
ORDER BY visitid
) 
,
tabular_output AS (
SELECT
CONCAT(a.CAREGIVER_ID,"-",a.PATIENT_ID) as CAREGIVER_PATIENT_ID,
a.VISIT_ID,
CONCAT(a.OFFICE_CODE, "-", a.CAREGIVER_CODE) as CAREGIVER_CODE,
a.FirstName, 
a.LastName, 
CONCAT("1",REPLACE(a.Phone,"-","")) as Phone,
a.Email,
a.VISIT_START_TIME, 
a.VISIT_END_TIME, 
a.EVV_TYPE_IN,
a.EVV_TYPE_OUT,
a.LAST_MODIFIED_DATE,
a.PATIENT_FIRST_NAME, 
a.PATIENT_LAST_NAME, 
a.PATIENT_ADMISSION_ID,
a.PATIENT_ADDRESS_LINE1, 
a.PATIENT_ADDRESS_LINE2, 
a.PATIENT_CITY,
a.PATIENT_STATE, 
a.PATIENT_ZIP,
b.AGGREGATED_DUTIES
FROM hha_visit_records a left outer join
hha_visit_duties_concatenated b
  on a.visit_id = b.visitid

) 
select * from tabular_output order by caregiver_patient_id'';
     
    res := (EXECUTE IMMEDIATE :sql_query);
    RETURN TABLE(res);
  END;
';