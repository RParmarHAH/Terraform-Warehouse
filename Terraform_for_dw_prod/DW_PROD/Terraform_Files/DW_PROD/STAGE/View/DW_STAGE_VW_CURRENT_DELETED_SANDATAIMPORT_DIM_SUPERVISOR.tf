resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_SANDATAIMPORT_DIM_SUPERVISOR" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_SANDATAIMPORT_DIM_SUPERVISOR"
	statement = <<-SQL
	 with coord as (
    SELECT DISTINCT f.AGENCYID, nvl(Coordinators.STAFFID::string, 'Unknown-' || nvl(f.agencyID,'S')) AS SUPERVISOR_CODE,
            TO_CHAR(Coordinators.LASTNAME) || ', ' || TO_CHAR(Coordinators.FIRSTNAME) || ' ' || TO_CHAR(Coordinators.MIDDLEINITIAL) AS SUPERVISOR_NAME,
            CASE WHEN F.AGENCYID = 8485 THEN 'PA' ELSE '' END AS SUPERVISOR_STATE_CODE
    FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.HIST_SANDATA_VISITS f
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS ClientAdmissions
        ON ClientAdmissions.agencyID = f.AgencyId
        AND ClientAdmissions.admissionID = f.AdmissionId
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_STAFFS Coordinators
        ON Coordinators.agencyID = ClientAdmissions.agencyID
        AND Coordinators.staffID = ClientAdmissions.CoordinatorID
    WHERE f.agencyID = 8485
	AND CAST(f.ETL_LAST_UPDATED_DATE AS DATE) IN
		(SELECT MAX(cast(ETL_LAST_UPDATED_DATE AS DATE)) FROM 
		DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.HIST_SANDATA_VISITS)
		AND f.ETL_DELETED_FLAG  =TRUE
)
SELECT
	md5(nvl(f.agencyID,'S') || '-'  || f.SUPERVISOR_CODE || '-'  || 'SANDATAIMPORT') AS SUPERVISOR_KEY
FROM coord f;
SQL
	or_replace = true 
	is_secure = false 
}

