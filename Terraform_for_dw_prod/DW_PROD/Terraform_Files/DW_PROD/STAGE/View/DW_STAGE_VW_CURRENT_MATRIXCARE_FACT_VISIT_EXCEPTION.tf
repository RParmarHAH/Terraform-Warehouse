resource "snowflake_view" "DW_STAGE_VW_CURRENT_MATRIXCARE_FACT_VISIT_EXCEPTION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_MATRIXCARE_FACT_VISIT_EXCEPTION"
	statement = <<-SQL
	 WITH CALLS AS (
	SELECT 
		DISTINCT 
		TCL_SCHEDULEID,
		EXC.value::STRING AS EXCEPTION_CODE 
	FROM (
		SELECT
			TCL_SCHEDULEID,
			TCL_FLAGS,
			CASE WHEN (BITAND(tcl_Flags, 1)) = 1 THEN (BITAND(tcl_Flags, 1))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 2)) = 2 THEN (BITAND(tcl_Flags, 2))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 4)) = 4 THEN (BITAND(tcl_Flags, 4))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 8)) = 8 THEN (BITAND(tcl_Flags, 8))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 16)) = 16 THEN (BITAND(tcl_Flags, 16))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 32)) = 32 THEN (BITAND(tcl_Flags, 32))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 64)) = 64 THEN (BITAND(tcl_Flags, 64))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 128)) = 128 THEN (BITAND(tcl_Flags, 128))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 512)) = 512 THEN (BITAND(tcl_Flags, 512))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 1024)) = 1024 THEN (BITAND(tcl_Flags, 1024))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 2048)) = 2048 THEN (BITAND(tcl_Flags, 2048))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 4096)) = 4096 THEN (BITAND(tcl_Flags, 4096))::VARCHAR || '|' ELSE '' END ||
			CASE WHEN (BITAND(tcl_Flags, 8192)) = 8192 THEN (BITAND(tcl_Flags, 8192))::VARCHAR ELSE '' END AS CODES
		--	CASE WHEN (BITAND(tcl_Flags, 1)) = 1 THEN 'ManuallyEnteredClientDoesNotMatchCallerID | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 2)) = 2 THEN 'WouldMakeScheduleOver24H | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 4)) = 4 THEN 'OutsideGeographicalThreshold | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 8)) = 8 THEN 'LocationAccuracyTooLow | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 16)) = 16 THEN 'ClientLocationNotKnown | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 32)) = 32 THEN 'CallLocationNotKnown | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 64)) = 64 THEN 'CallCertifiedWrong | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 128)) = 128 THEN 'MobileTSchWithoutTasks | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 512)) = 512 THEN 'OfflineGenerated | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 1024)) = 1024 THEN 'OutsideGeographicalThreshold_Sandata | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 2048)) = 2048 THEN 'MissingClientSignature_Sandata | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 4096)) = 4096 THEN 'LateCheckIn_Sandata | ' ELSE '' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 8192)) = 8192 THEN 'MissingClientSignature' ELSE '' END AS DESC
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_TELEPHONYCALLS VISITS
		WHERE TCL_SCHEDULEID IS NOT NULL
	) BREAKOUT
	,LATERAL FLATTEN(input => SPLIT(BREAKOUT.CODES, '|')) exc 
	WHERE NULLIF(EXCEPTION_CODE,'') IS NOT NULL
)
, EXCEPTIONS AS (
SELECT
	DISTINCT
	MD5('MATRIXCARE' || '-' || VISITS.SCH_ID || '-' || CALLS.EXCEPTION_CODE || '-' || 'MATRIXCARE') AS VISIT_EXCEPTION_KEY
FROM
	CALLS
INNER JOIN -- TO ONLY GET exceptions OF the visits that ARE IN FACT_VISIT AND EXCLUDE ORPHANS
	DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES VISITS
	ON CALLS.TCL_SCHEDULEID = VISITS.SCH_ID
)
SELECT
	DATA.VISIT_EXCEPTION_KEY
FROM
	EXCEPTIONS DATA;
SQL
	or_replace = true 
	is_secure = false 
}

