resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_FACT_VISIT_EXCEPTION" {
	name ="GET_STAGE_MATRIXCARE_FACT_VISIT_EXCEPTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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


BEGIN
--*****************************************************************************************************************************
-- NAME:  MATRIXCARE_FACT_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per visit per exception according to MATRIXCARE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/1/2022	Abhishek Sunil			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.MATRIXCARE_FACT_VISIT_EXCEPTION
WITH CALLS AS (
	SELECT 
		DISTINCT 
		TCL_SCHEDULEID,
		EXC.value::STRING AS EXCEPTION_CODE 
	FROM (
		SELECT
			TCL_SCHEDULEID,
			TCL_FLAGS,
			CASE WHEN (BITAND(tcl_Flags, 1)) = 1 THEN (BITAND(tcl_Flags, 1))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 2)) = 2 THEN (BITAND(tcl_Flags, 2))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 4)) = 4 THEN (BITAND(tcl_Flags, 4))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 8)) = 8 THEN (BITAND(tcl_Flags, 8))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 16)) = 16 THEN (BITAND(tcl_Flags, 16))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 32)) = 32 THEN (BITAND(tcl_Flags, 32))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 64)) = 64 THEN (BITAND(tcl_Flags, 64))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 128)) = 128 THEN (BITAND(tcl_Flags, 128))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 512)) = 512 THEN (BITAND(tcl_Flags, 512))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 1024)) = 1024 THEN (BITAND(tcl_Flags, 1024))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 2048)) = 2048 THEN (BITAND(tcl_Flags, 2048))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 4096)) = 4096 THEN (BITAND(tcl_Flags, 4096))::VARCHAR || ''|'' ELSE '''' END ||
			CASE WHEN (BITAND(tcl_Flags, 8192)) = 8192 THEN (BITAND(tcl_Flags, 8192))::VARCHAR ELSE '''' END AS CODES
		--	CASE WHEN (BITAND(tcl_Flags, 1)) = 1 THEN ''ManuallyEnteredClientDoesNotMatchCallerID | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 2)) = 2 THEN ''WouldMakeScheduleOver24H | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 4)) = 4 THEN ''OutsideGeographicalThreshold | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 8)) = 8 THEN ''LocationAccuracyTooLow | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 16)) = 16 THEN ''ClientLocationNotKnown | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 32)) = 32 THEN ''CallLocationNotKnown | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 64)) = 64 THEN ''CallCertifiedWrong | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 128)) = 128 THEN ''MobileTSchWithoutTasks | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 512)) = 512 THEN ''OfflineGenerated | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 1024)) = 1024 THEN ''OutsideGeographicalThreshold_Sandata | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 2048)) = 2048 THEN ''MissingClientSignature_Sandata | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 4096)) = 4096 THEN ''LateCheckIn_Sandata | '' ELSE '''' END ||
		--	CASE WHEN (BITAND(tcl_Flags, 8192)) = 8192 THEN ''MissingClientSignature'' ELSE '''' END AS DESC
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_TELEPHONYCALLS VISITS
		WHERE TCL_SCHEDULEID IS NOT NULL
	) BREAKOUT
	,LATERAL FLATTEN(input => SPLIT(BREAKOUT.CODES, ''|'')) exc 
	WHERE NULLIF(EXCEPTION_CODE,'''') IS NOT NULL
)
, EXCEPTIONS AS (
SELECT
	DISTINCT
	MD5(''MATRIXCARE'' || ''-'' || VISITS.SCH_ID || ''-'' || CALLS.EXCEPTION_CODE || ''-'' || ''MATRIXCARE'') AS VISIT_EXCEPTION_KEY,
	MD5(''MATRIXCARE'' || ''-'' || VISITS.SCH_ID || ''-'' || ''MATRIXCARE'') AS VISIT_KEY,
--	VISITS.SCH_ID,
	VISITS.SCH_STARTTIME::DATE AS SERVICE_DATE, 
	7 AS SOURCE_SYSTEM_ID,
	''MATRIXCARE''  AS SYSTEM_CODE,
	CALLS.EXCEPTION_CODE AS EXCEPTION_CODE,
	NULL AS EXCEPTION_DESC,
	NULL AS ACKNOWLEDGED_FLAG,
	NULL AS RESOLVED_FLAG,
	NULL AS REASON_CODE,
	NULL AS REASON_NAME,
	NULL AS RESOLUTION_CODE,
	NULL AS RESOLUTION_NAME
FROM
	CALLS
INNER JOIN -- TO ONLY GET exceptions OF the visits that ARE IN FACT_VISIT AND EXCLUDE ORPHANS
	DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES VISITS
	ON CALLS.TCL_SCHEDULEID = VISITS.SCH_ID
--WHERE
--	VISITS.ETL_LAST_UPDATED_DATE >= (:STR_CDC_START)::timestamp_ntz
--	IFF(
--		VISITS.SCH_STARTTIME IS NULL OR VISITS.SCH_ENDTIME IS NULL, 
--		CASE 
--			WHEN 
--				VISITS.SCH_BILLRATEUNITFLAG = 0 
--				THEN CAST(VISITS.SCH_PAYUNITS/(60/NULLIF(VISITS.SCH_PAYRATEUNITFLAG, 0)) AS DECIMAL(18,3)) 
--			ELSE 
--				CAST(VISITS.SCH_UNITS/(60/NULLIF(VISITS.SCH_BILLRATEUNITFLAG, 0)) AS DECIMAL(18,3)) 
--		END,
--		CAST(DATEDIFF(MINUTE, VISITS.SCH_STARTTIME, VISITS.SCH_ENDTIME) AS DECIMAL(18, 3)) / 60.0
--	) > 0 
)
SELECT
	DATA.VISIT_EXCEPTION_KEY,
	DATA.VISIT_KEY,
	VE.EXCEPTION_KEY,
	DATA.SERVICE_DATE,
	DATA.SOURCE_SYSTEM_ID,
	DATA.SYSTEM_CODE,
	VE.EXCEPTION_CODE,
	DATA.ACKNOWLEDGED_FLAG,
	DATA.RESOLVED_FLAG,
	DATA.REASON_CODE,
	DATA.REASON_NAME,
	DATA.RESOLUTION_CODE,
	DATA.RESOLUTION_NAME,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	EXCEPTIONS DATA
LEFT JOIN 
	HAH.DIM_VISIT_EXCEPTION VE 
	ON VE.EXCEPTION_CODE = DATA.EXCEPTION_CODE 
	AND VE.SOURCE_SYSTEM_ID = DATA.SOURCE_SYSTEM_ID 
	AND VE.SYSTEM_CODE = DATA.SYSTEM_CODE;
	
RETURN ''SUCCESS'';
END;


 EOT
}

