resource "snowflake_view" "DW_STAGE_VW_CURRENT_COSTALSYNCDATA_DIM_CLIENT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_COSTALSYNCDATA_DIM_CLIENT"
	statement = <<-SQL
	 
WITH CLIENT_DATA AS
(
	SELECT * FROM
	(
		SELECT TRIM(DB) AS MASTER_DB, TRIM(PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(DB) AS DB, TRIM(PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT TRIM(MASTER.DB) AS MASTER_DB, TRIM(MASTER.PATIENT_NUMBER) AS MASTER_PATIENT_NUMBER, TRIM(MATCH.DB) AS DB, TRIM(MATCH.PATIENT_NUMBER) AS PATIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
), FIRST_SERVICE_DATES AS 
(
	SELECT CLIENTS.MASTER_DB AS DB, CLIENTS.MASTER_PATIENT_NUMBER AS PATIENT_NUMBER, 
        MIN(SCHEDULE_DATE) AS FirstDateOfService, MAX(SCHEDULE_DATE) AS LatestDateOfService,
        MAX(SCHEDULES.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CV_SCHEDULES AS SCHEDULES
    JOIN CLIENT_DATA AS CLIENTS
        ON CLIENTS.DB = TRIM(SCHEDULES.DB) AND CLIENTS.PATIENT_NUMBER = TRIM(SCHEDULES.PATIENT_NUMBER)
	GROUP BY CLIENTS.MASTER_DB, CLIENTS.MASTER_PATIENT_NUMBER
), ADMISSIONS AS (
    SELECT CLIENTS.MASTER_DB AS DB, CLIENTS.MASTER_PATIENT_NUMBER AS PATIENT_NUMBER, 
        MIN(A.ADMIT_DATE) AS REFERRAL_DATE,
        MAX(A.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
    FROM "DISC_${var.SF_ENVIRONMENT}"."COSTALSYNCDATA"."CV_ADMISSIONS" A
    JOIN CLIENT_DATA AS CLIENTS
        ON TRIM(CLIENTS.PATIENT_NUMBER) = TRIM(A.PATIENT_NUMBER) AND TRIM(CLIENTS.DB)=TRIM(A.DB)
    GROUP BY CLIENTS.MASTER_DB, CLIENTS.MASTER_PATIENT_NUMBER
)
  SELECT DISTINCT
      md5(TRIM(f.DB) || '-' || TRIM(f.PATIENT_NUMBER) || '-'  ||  'COSTALSYNCDATA') AS CLIENT_KEY
  FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.COSTALSYNCDATA.CLIENT_MASTER_LIST F 
  LEFT JOIN FIRST_SERVICE_DATES AS FSD
    ON TRIM(FSD.DB) = TRIM(F.DB) AND TRIM(FSD.PATIENT_NUMBER) = TRIM(F.PATIENT_NUMBER)
  LEFT JOIN "DISC_${var.SF_ENVIRONMENT}"."COSTALSYNCDATA"."CV_LOCATIONS" L ON TRIM(F.DB) = TRIM(L.DB) AND TRIM(F.LOCATION_CODE) = TRIM(L.LOCATION_CODE)
  LEFT JOIN HAH.DIM_STATE ST ON ST.STATE_ISO_CODE = NULLIF(TRIM(L.STATE_CODE), '')
  LEFT JOIN "DISC_${var.SF_ENVIRONMENT}"."COSTALSYNCDATA"."CV_DEPARTMENTS" D ON TRIM(F.DB) = TRIM(D.DB) AND TRIM(F.DEPARTMENT__CODE) = TRIM(D.DEPARTMENT__CODE)
  LEFT JOIN ADMISSIONS A ON TRIM(A.DB) = TRIM(F.DB) AND TRIM(A.PATIENT_NUMBER) = TRIM(F.PATIENT_NUMBER)
  LEFT JOIN "DATA_MANAGEMENT"."DATA_QUALITY"."INVALID_CLIENT_NUMBER" DQCN 
            ON TRIM(F.PATIENT_NUMBER,' ') = TRIM(DQCN.CLIENT_NUMBER,' ')
  LEFT JOIN "DATA_MANAGEMENT"."DATA_QUALITY"."INVALID_PHONE_NUMBER" DQP ON F.PHONE=DQP.PHONE_NUMBER
  LEFT JOIN "DATA_MANAGEMENT"."DATA_QUALITY"."INVALID_SSN" DQSSN ON F.SOCIAL_SECURITY_NUMBER=DQSSN.SSN
  LEFT JOIN "DATA_MANAGEMENT"."DATA_QUALITY"."INVALID_DATE" DQDOB ON F.BIRTH_DATE = DQDOB.DOB
  LEFT JOIN "DATA_MANAGEMENT"."DATA_QUALITY"."INVALID_DATE" DQRD ON A.Referral_date = DQRD.REFERRAL_DATE
  LEFT JOIN HAH.DIM_ZIP_CODE Z ON Z.ZIP_CODE=TRIM(F.ZIPCODE)
  LEFT JOIN HAH.DIM_STATE S ON S.STATE_ISO_CODE=UPPER(TRIM(F.STATE_CODE))
  WHERE (F.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz
        OR FSD.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz
        OR A.ETL_LAST_UPDATED_DATE >= '1900-01-01'::timestamp_ntz)
    AND DQCN.CLIENT_NUMBER IS NULL;
SQL
	or_replace = true 
	is_secure = false 
}

