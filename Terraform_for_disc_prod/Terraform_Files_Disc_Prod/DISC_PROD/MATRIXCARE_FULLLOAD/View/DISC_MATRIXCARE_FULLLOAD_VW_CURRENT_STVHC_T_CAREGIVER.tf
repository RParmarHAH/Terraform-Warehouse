resource "snowflake_view" "DISC_MATRIXCARE_FULLLOAD_VW_CURRENT_STVHC_T_CAREGIVER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "VW_CURRENT_STVHC_T_CAREGIVER"
	statement = <<-SQL
	 --*******************************************************************************************************************************
-- NAME				: VW_CURRENT_STVHC_T_Caregiver
--
-- PURPOSE			: To Populate the Caregiver data to discovery layer
--
-- DEVELOPMENT LOG	:
-- Version #	DATE			AUTHOR				NOTES:
-- ----------	------------	----------------	----------------------------------------------------------------------------
-- v001			12/28/2022		Mohit Vaghadiya		Initial version
-- v002			12/29/2022		Mohit Vaghadiya		Updated Logic to include caregivers listed under CLS Branches where the service 
--													provided from HelpAtHome/Non-CLS branch
---v003         01/12/2024    Trushali Ramoliya     added a training branch CTE in order to exclude those the branches as per IDDOX-605 Exclude Training Branches Employee for Matrixcare
--********************************************************************************************************************************
WITH
TRAININ_BRANCH AS (
SELECT BR_NAME AS OFFICE_NAME,BR_ID AS OFFICE_NUMBER,'MATRIXCARE' AS SYSTEM_CODE , 7 AS SOURCE_SYSTEM_ID, 
  CURRENT_DATE AS CUTTOFF_DATE   FROM  Matrixcare.STVHC_T_Branches
WHERE  BR_NAME ilike ANY ('%train%', '%system%', '%audit%', '%admin%', '%referral%')
),
EXCLUDE_LIST AS 
(
	SELECT DISTINCT CAR_BRANCHID
	FROM MatrixCare.HIST_STVHC_T_Caregiver br
	INNER JOIN UTIL.Migrated_Branch_By_SourceSystem BR_EX 
		ON BR_eX.OFFIcE_NUMBER = BR.CAR_BRANCHID
			AND SOURCE_SYSTEM_ID = 7
			AND SYSTEM_CODE = 'MATRIXCARE'
			UNION 
  SELECT OFFICE_NUMBER FROM TRAININ_BRANCH
),curr_v AS 
(
	SELECT DISTINCT C.car_ID
			, MAX(C.ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE
	FROM MatrixCare.HIST_STVHC_T_Caregiver C
	WHERE C.car_branchid NOT IN (SELECT DISTINCT EL.CAR_BRANCHID FROM EXCLUDE_LIST EL)
			-- Added for v002
			OR EXISTS(SELECT 1 FROM MatrixCare.HIST_STVHC_T_SCHEDULES S 
					  WHERE S.SCH_CAREGIVERID = C.CAR_ID AND S.SCH_BRANCHID = c.car_branchid 
					  		AND S.SCH_BRANCHID NOT IN (SELECT DISTINCT CAR_BRANCHID FROM EXCLUDE_LIST)
					  )
	GROUP BY C.car_ID
)
SELECT t.*
FROM MatrixCare.HIST_STVHC_T_Caregiver T
INNER JOIN curr_v v 
	ON t.car_ID = v.car_ID
		AND t.ETL_DELETED_FLAG = FALSE
		AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
SQL
	or_replace = true 
	is_secure = false 
}

