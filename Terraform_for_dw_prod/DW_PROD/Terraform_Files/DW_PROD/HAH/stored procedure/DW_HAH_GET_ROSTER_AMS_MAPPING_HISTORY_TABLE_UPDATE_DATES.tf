resource "snowflake_procedure" "DW_HAH_GET_ROSTER_AMS_MAPPING_HISTORY_TABLE_UPDATE_DATES" {
	name ="GET_ROSTER_AMS_MAPPING_HISTORY_TABLE_UPDATE_DATES"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
--MOLINA
UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY H 
SET H.MATCHED_DATE=FILE_DATE
FROM (
WITH sd_mol AS (
WITH mol AS (
SELECT DISTINCT  EXTERNAL_ID,
    RIGHT(TRIM(REGEXP_REPLACE((REGEXP_REPLACE(FILENAME,''[^[:digit:]]'', '' '')) ,''( ){1,}'','''')),8) AS EXTRACTED_DATE
    ,CASE WHEN extracted_date=''04212023'' THEN TO_DATE(extracted_date,''MMDDYYYY'')
       WHEN REGEXP_LIKE(extracted_date, ''[0]{1}.*'')=TRUE THEN TO_DATE(extracted_date,''DDMMYYYY'')
       WHEN REGEXP_LIKE(extracted_date, ''[0]{1}.*'')<>TRUE THEN  TO_DATE(extracted_date,''YYYYMMDD'')
    END AS FILE_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.MOLINA.HIST_MOLINA_SOURCE_DATA 
    --WHERE  PARTNER_FILENAME<>''HAH_Roster_20231017.csv''
    ORDER BY 3)
SELECT * FROM (
SELECT *,DENSE_RANK() OVER (PARTITION BY EXTERNAL_ID ORDER BY FILE_DATE) R 
FROM mol) WHERE R=1)
SELECT * FROM sd_mol) AS s 
WHERE H.PARTNER_CLIENT_KEY=MD5(''MOLINA'' || ''-'' ||  TRIM(s.EXTERNAL_ID) || ''-'' || ''MOLINA'');
-----------------------------------------------------------------------------------------------
--CENTENE
UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY H 
SET H.MATCHED_DATE=FILE_DATE
FROM (
WITH sd_cen AS (
WITH cen AS (
SELECT DISTINCT  EXTERNAL_ID,
    RIGHT(TRIM(REGEXP_REPLACE((REGEXP_REPLACE(FILENAME,''[^[:digit:]]'', '' '')),''( ){1,}'','''')),8) AS EXTRACTED_DATE
                , CASE WHEN len(extracted_date)>=6 THEN 
                        CASE WHEN REGEXP_LIKE(extracted_date, ''[0]{1}.*'')=TRUE THEN TO_DATE(extracted_date,''DDMMYYYY'')
                        ELSE TO_DATE(extracted_date,''YYYYMMDD'')
                        END 
                END AS FILE_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.CENTENE.HIST_CENTENE_SOURCE_DATA 
    ORDER BY 3)
SELECT * FROM (
SELECT *,DENSE_RANK() OVER (PARTITION BY EXTERNAL_ID ORDER BY FILE_DATE) R 
FROM cen) WHERE R=1)
SELECT * FROM sd_cen) AS s 
WHERE H.PARTNER_CLIENT_KEY=MD5(''CENTENE'' || ''-'' ||  TRIM(s.EXTERNAL_ID) || ''-'' || ''CENTENE'');
----------------------------------------------------------------------------------------------------
--AMERIHEALTH
UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY H 
SET H.MATCHED_DATE=FILE_DATE
FROM (
WITH sd_AMI AS (
WITH AMI AS (
SELECT DISTINCT  EXTERNAL_ID,
    RIGHT(TRIM(REGEXP_REPLACE((REGEXP_REPLACE(FILENAME,''[^[:digit:]]'', '' '')),''( ){1,}'','''')),8) AS EXTRACTED_DATE,
                CASE WHEN len(extracted_date)>=6 THEN 
                        CASE WHEN REGEXP_LIKE(extracted_date, ''[0]{1}.*'')=TRUE THEN TO_DATE(extracted_date,''DDMMYYYY'')
                        ELSE TO_DATE(extracted_date,''YYYYMMDD'')
                        END 
                END AS FILE_DATE
    FROM DISC_${var.SF_ENVIRONMENT}.AMERIHEALTH.HIST_AMERIHEALTH_SOURCE_DATA 
    ORDER BY 3)
SELECT * FROM (
SELECT *,DENSE_RANK() OVER (PARTITION BY EXTERNAL_ID ORDER BY FILE_DATE) R 
FROM AMI) WHERE R=1)
SELECT * FROM sd_AMI) AS s 
WHERE H.PARTNER_CLIENT_KEY=MD5(''AMERIHEALTH'' || ''-'' ||  TRIM(s.EXTERNAL_ID) || ''-'' || ''AMERIHEALTH'');
-----------------------------------------------------------------------------------------
--OSH
--UPDATE DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY H 
--SET H.MATCHED_DATE=LOADDATE
--FROM (
--SELECT * FROM (
--SELECT DISTINCT PATIENT_ID,LOADDATE,DENSE_RANK()
--OVER (PARTITION BY PATIENT_ID ORDER BY LOADDATE) R
--FROM DISC_${var.SF_ENVIRONMENT}.OLYMPUS.HIST_OLYMPUS_SOURCE_DATA 
--ORDER BY LOADDATE ) WHERE R=1) AS s
--WHERE H.PARTNER_CLIENT_KEY=md5(  ''OSH''  ||  ''-''  ||s.PATIENT_ID||  ''-''  ||  ''OLYMPUS'' );
return ''SUCCESS'';
END;

 EOT
}

