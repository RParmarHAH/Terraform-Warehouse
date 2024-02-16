create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_SANDATAIMPORT_DIM_SUPERVISOR(
	SUPERVISOR_KEY
) as
with coord as (
    SELECT DISTINCT f.AGENCYID, nvl(Coordinators.STAFFID::string, 'Unknown-' || nvl(f.agencyID,'S')) AS SUPERVISOR_CODE,
            TO_CHAR(Coordinators.LASTNAME) || ', ' || TO_CHAR(Coordinators.FIRSTNAME) || ' ' || TO_CHAR(Coordinators.MIDDLEINITIAL) AS SUPERVISOR_NAME,
            CASE WHEN F.AGENCYID = 8485 THEN 'PA' ELSE '' END AS SUPERVISOR_STATE_CODE
    FROM DISC_PROD.SANDATAIMPORT.HIST_SANDATA_VISITS f
    LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
        ON ClientAdmissions.agencyID = f.AgencyId
        AND ClientAdmissions.admissionID = f.AdmissionId
    LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS Coordinators
        ON Coordinators.agencyID = ClientAdmissions.agencyID
        AND Coordinators.staffID = ClientAdmissions.CoordinatorID
    WHERE f.agencyID = 8485
	AND CAST(f.ETL_LAST_UPDATED_DATE AS DATE) IN
		(SELECT MAX(cast(ETL_LAST_UPDATED_DATE AS DATE)) FROM 
		DISC_PROD.SANDATAIMPORT.HIST_SANDATA_VISITS)
		AND f.ETL_DELETED_FLAG  =TRUE
)
SELECT
	md5(nvl(f.agencyID,'S') || '-'  || f.SUPERVISOR_CODE || '-'  || 'SANDATAIMPORT') AS SUPERVISOR_KEY
FROM coord f;