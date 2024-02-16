resource "snowflake_view" "DISC_ADP_VW_ALLIANCE_BRANCH_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "VW_ALLIANCE_BRANCH_MAPPING"
	statement = <<-SQL
	 SELECT DISTINCT 
	CASE WHEN "LOCATION" = 'CORP - Corporate' THEN 'CORP'
		WHEN "LOCATION" = 'GRAND - Grand Rapids' THEN 'GRAND'
		ELSE BM.LOCATION_ID 
	END AS "LOCATION_ID",
	P."LOCATION", 
	CASE WHEN P."LOCATION" = 'GRAND - Grand Rapids' THEN 'GRAND RAPIDS'
		WHEN P."LOCATION" = 'CORP - Corporate' THEN 'CORPORATE'
	ELSE BM."NAME"
	END AS NAME,
	BM.ADDRESS1,
	BM.ADDRESS2,
	BM.PHONENUMBER,
	BM.TOLLFREEPHONE,
	BM.FAX,
	COALESCE(BM.STATE, 'MICHIGAN') AS STATE,
	BM.CITY,
	BM.ZIP,
	COALESCE(BM.STATE_CODE, 'MI') AS STATE_CODE,
	BM.PARENT_BRANCH_NAME,
	BM.PARENT_FLAG::BOOLEAN AS PARENT_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ALLIANCE.PAYROLL P
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.VW_BRANCH_MAPPING BM
	ON TRIM(UPPER(BM."NAME")) LIKE '%' || REPLACE(UPPER(TRIM(SUBSTRING(P."LOCATION", CHARINDEX('-', P."LOCATION")+2))), ' ') || '%' AND BM.PARENT_FLAG = 'true'
WHERE P."LOCATION" IS NOT NULL OR BM."NAME"
--ORDER BY BM.NAME;
;
SQL
	or_replace = true 
	is_secure = false 
}

