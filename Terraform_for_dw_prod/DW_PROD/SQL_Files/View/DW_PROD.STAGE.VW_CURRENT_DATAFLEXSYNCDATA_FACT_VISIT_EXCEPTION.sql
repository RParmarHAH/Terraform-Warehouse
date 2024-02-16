create or replace view DW_PROD.STAGE.VW_CURRENT_DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION(
	VISIT_EXCEPTION_KEY
) as
WITH DF_IMPORT_VISITS AS 																-- Using only 1 record from multiple records per scheduleid just for mapping between DF and SD
(
	SELECT ROW_NUMBER() OVER (PARTITION BY VISITKEY, TRACKINGID, WEEKENDDATE, STATE, SERVICEDATE ORDER BY IMPORTTASKID DESC, LINEID DESC) RNO,
		VISITKEY, 
		TRACKINGID, 
		WEEKENDDATE, 
		STATE, 
		SERVICEDATE AS SERVICEDATE, 
		SPLIT_PART(VISITKEY, '_',  3)::NUMBER AS SANDATA_SCHEDULEID, 
		SPLIT_PART(VISITKEY, '_',  2) SANDATA_AGENCYID
	FROM DISC_PROD.SANDATAEXCHANGE.DFIMPORT_IMPORTVISITS 
	WHERE ISIMPORTED = TRUE AND NVL(TRACKINGID,0) <> 0
	QUALIFY RNO = 1
)
, VISITS_WITH_EXCEPTIONS AS (
	SELECT
		VISITS.AGENCYID,
		VISITS.SCHEDULEID,
		VISITS.SCHEDULEDATE::TIMESTAMP_NTZ AS SCHEDULEDATE,
		TRIM(exc.value)::STRING AS EXCEPTION_CODE,
		NULLIF(TRIM(VISITS.REASONCODE),'') AS REASON_CODE, 
		NULLIF(TRIM(VISITS.RESOLUTIONCODE),'') AS RESOLUTION_CODE -- Bring Resolution description AFTER response FROM sandata
	FROM
		DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULES VISITS
	,LATERAL FLATTEN(input => SPLIT(VISITS.EXCEPTIONCODE, '|')) exc 
	WHERE 
		NULLIF(EXCEPTION_CODE,'') IS NOT NULL AND TRIM(EXCEPTIONCODE) <> '0' AND TRIM(VISITS.AGENCYID) IN ('38004','8380','8463')
	GROUP BY
		VISITS.AGENCYID, VISITS.SCHEDULEID, VISITS.SCHEDULEDATE, EXCEPTION_CODE, VISITS.REASONCODE, VISITS.RESOLUTIONCODE
	ORDER BY
		VISITS.SCHEDULEDATE
)
, EXCEPTIONS AS (
	SELECT 
	DISTINCT
		MD5(TRIM(F.DBNAME) || '-' || F.REFERENCENO || '-' || F.WEEKENDDATE::VARCHAR || '-' || F.SERVICEDATE::VARCHAR || '-' || ALL_EXC.EXCEPTION_CODE || '-' || 'DATAFLEXSYNCDATA') AS VISIT_EXCEPTION_KEY,
		3 AS SOURCE_SYSTEM_ID,
		F.DBNAME AS SYSTEM_CODE,
		ALL_EXC.EXCEPTION_CODE AS EXCEPTION_CODE
	FROM (
		SELECT
			DFI.SANDATA_AGENCYID, 
			DFI.SANDATA_SCHEDULEID,
			DFI.SERVICEDATE,
			DFI.TRACKINGID,
			DFI.WEEKENDDATE,
			DFI.STATE,
			SCH.EXCEPTION_CODE,
			SCH.REASON_CODE,
			ERC.DESCRIPTION AS REASON_NAME,
			SCH.RESOLUTION_CODE
		FROM 
			VISITS_WITH_EXCEPTIONS SCH
		INNER JOIN
			DF_IMPORT_VISITS DFI
			ON DFI.SANDATA_SCHEDULEID = SCH.SCHEDULEID
				AND DFI.SANDATA_AGENCYID = SCH.AGENCYID
				AND DFI.SERVICEDATE = SCH.SCHEDULEDATE
		LEFT JOIN 
			DISC_PROD.SANDATAIMPORT.SANDATA_EXTERNALREASONCODES ERC 
			ON ERC.AGENCYID = SCH.AGENCYID
				AND ERC.CODE = SCH.REASON_CODE
--		LEFT JOIN -- Need to know if the manual resolution table can work for all agencies (Currently provided for PA - 8485)
--			DISC_PROD.SANDATAIMPORT.SANDATA_MANUAL_EXTERNALRESOLUTIONCODES MERC 
--			ON MERC.AGENCYID = SCH.AGENCYID
--				AND MERC.CODE = SCH.RESOLUTION_CODE
		WHERE
			DFI.SANDATA_SCHEDULEID IS NOT NULL
	) ALL_EXC
	LEFT JOIN 
		DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS
		ON TS.TRACKINGID = ALL_EXC.TRACKINGID 
			AND TS.WEEKENDDATE = ALL_EXC.WEEKENDDATE 
			AND TS.DBNAME = ALL_EXC.STATE
	INNER JOIN
		DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS F
		ON F.DBNAME = TS.DBNAME
		    AND F.REFERENCENO = TS.REFERENCENO
		    AND F.WEEKENDDATE = TS.WEEKENDDATE
		    AND F.SERVICEDATE::TIMESTAMP_NTZ = ALL_EXC.SERVICEDATE
)
SELECT
	DATA.VISIT_EXCEPTION_KEY
FROM
	EXCEPTIONS DATA
LEFT JOIN 
	HAH.DIM_VISIT_EXCEPTION VE 
	ON VE.EXCEPTION_CODE = DATA.EXCEPTION_CODE 
	AND VE.SOURCE_SYSTEM_ID = DATA.SOURCE_SYSTEM_ID 
	AND VE.SYSTEM_CODE = DATA.SYSTEM_CODE;