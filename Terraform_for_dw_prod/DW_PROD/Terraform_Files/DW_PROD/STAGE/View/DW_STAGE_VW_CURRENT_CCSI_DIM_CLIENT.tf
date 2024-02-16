resource "snowflake_view" "DW_STAGE_VW_CURRENT_CCSI_DIM_CLIENT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_CCSI_DIM_CLIENT"
	statement = <<-SQL
	 
WITH BASE_DATE AS 
(
	SELECT DAY_OF_SERVICE , AREA_2 , TRY_TO_DATE(PERIOD_dATE, 'MMDDYY') AS PERIOD_DATE , DAY_OF_SERVICE - DATE_PART(DAY, TRY_TO_DATE(PERIOD_dATE, 'MMDDYY')) AS MNDIFF
	, CASE WHEN DAY_OF_SERVICE IS NULL THEN TRY_TO_DATE(PERIOD_dATE, 'MMDDYY')
	ELSE DATEADD(DAY,DAY_OF_SERVICE - DATE_PART(DAY, TRY_TO_DATE(PERIOD_dATE, 'MMDDYY')),TRY_TO_DATE(PERIOD_dATE, 'MMDDYY')) END AS NEW_DATE, CLIENT_NAME 
	FROM DISC_${var.SF_ENVIRONMENT}.CCSI.RAWVRFP 
	WHERE PERIOD_DATE NOT IN ('023121','093120','043121','063119' )
)
,FINAL_DATE AS 
(
	SELECT CLIENT_NAME,AREA_2 ,MIN(NEW_DATE) AS SERVICE_START_DATE, MAX(NEW_DATE) AS SERVICE_END_DATE, MIN (PERIOD_DATE) AS BEGIN_DATE, MAX(PERIOD_DATE) AS END_DATE
	FROM BASE_DATE
	GROUP BY 1,2
)
SELECT	MD5 ( M.RECORD_NUMBER  || '-' ||  NVL(M.USED_FOR_AREA, 'CCSI') || '-' || 'CCSI' ) AS CLIENT_KEY 
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.CCSI.CLIENT_MASTER_LIST_CCSI M   
	LEFT JOIN FINAL_DATE F ON UPPER(F.CLIENT_NAME) = M.COMBINED_CLIENT_NAME AND M.USED_FOR_AREA = F.AREA_2 
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CCSI.DESKINFO D ON D.AREA = M.USED_FOR_AREA 
			AND D.DESK_DESIGNATOR = M.DESK_NO_ASSIGNED_SERV_COORD 
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CCSI.BRANCH_MAPPING B ON B.BRANCH_CODE = M.USED_FOR_AREA 
	LEFT JOIN HAH.DIM_STATE ST1 ON ST1.STATE_ISO_CODE = 'IL' 
	LEFT JOIN HAH.DIM_STATE ST2 ON ST1.STATE_ISO_CODE IS NULL AND UPPER(ST2.STATE_NAME) = 'IL'
	LEFT JOIN HAH.DIM_ZIP_CODE Z ON ST1.STATE_ISO_CODE IS NULL AND ST2.STATE_ISO_CODE IS NULL AND Z.ZIP_CODE = LEFT(TRIM(M.ZIP), 5);
SQL
	or_replace = true 
	is_secure = false 
}

