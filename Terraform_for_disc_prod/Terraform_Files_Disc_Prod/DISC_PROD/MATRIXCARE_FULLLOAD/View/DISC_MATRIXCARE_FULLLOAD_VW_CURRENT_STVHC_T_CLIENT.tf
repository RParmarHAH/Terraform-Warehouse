resource "snowflake_view" "DISC_MATRIXCARE_FULLLOAD_VW_CURRENT_STVHC_T_CLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "VW_CURRENT_STVHC_T_CLIENT"
	statement = <<-SQL
	 --*******************************************************************************************************************************
-- NAME				: VW_CURRENT_STVHC_T_Client
--
-- PURPOSE			: To Populate the Client data to discovery layer
--
-- DEVELOPMENT LOG	:
-- Version #	DATE			AUTHOR				NOTES:
-- ----------	------------	----------------	----------------------------------------------------------------------------
-- v001			12/28/2022		Mohit Vaghadiya		Initial version
-- v002			12/29/2022		Mohit Vaghadiya		Updated Logic to include clients listed under CLS Branches where the service 
--													received from HelpAtHome/Non-CLS branch
--********************************************************************************************************************************
WITH curr_v AS 
(
	SELECT cli_ID
			, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE
	FROM MatrixCare.HIST_STVHC_T_Client
	GROUP BY cli_ID
)
, EXCLUDE_LIST AS 
(
	SELECT DISTINCT CLI_BRANCHID
	FROM MatrixCare.HIST_STVHC_T_Client br
	INNER JOIN UTIL.Migrated_Branch_By_SourceSystem BR_EX 
		ON BR_eX.OFFIcE_NUMBER = BR.CLI_BRANCHID
			AND SOURCE_SYSTEM_ID = 7
			AND SYSTEM_CODE = 'MATRIXCARE'
), CLIENTS_TO_INCLUDE AS -- Added for v002
(
	SELECT S.SCH_CLIENTID AS CLI_ID
	FROM MatrixCare.HIST_STVHC_T_SCHEDULES S
	INNER JOIN curr_v v 
		ON S.SCH_CLIENTID = v.cli_ID
			AND S.ETL_DELETED_FLAG = FALSE
	WHERE S.SCH_BRANCHID NOT IN (SELECT CLI_BRANCHID FROM EXCLUDE_LIST)
	GROUP BY S.SCH_CLIENTID 
	UNION ALL
	SELECT I.INVD_CLIENTID AS CLI_ID
	FROM MatrixCare.HIST_STVHC_T_INVOICEDETAILS I
	INNER JOIN curr_v v 
		ON I.INVD_CLIENTID = v.cli_ID
			AND I.ETL_DELETED_FLAG = FALSE
	WHERE I.INVD_BRANCHID NOT IN (SELECT CLI_BRANCHID FROM EXCLUDE_LIST)
	GROUP BY I.INVD_CLIENTID	
	UNION ALL
	SELECT ADM.ADM_CLIENTID 
	FROM MATRIXCARE.HIST_STVHC_T_ADMISSIONS ADM
	INNER JOIN curr_v v 
		ON ADM.ADM_CLIENTID = v.cli_ID
			AND ADM.ETL_DELETED_FLAG = FALSE
	WHERE ADM.ADM_BRANCHID NOT IN (SELECT CLI_BRANCHID FROM EXCLUDE_LIST)
	GROUP BY ADM.ADM_CLIENTID
)
SELECT t.*
FROM MatrixCare.HIST_STVHC_T_Client T
INNER JOIN curr_v v 
ON t.cli_ID = v.cli_ID
	AND t.ETL_DELETED_FLAG = FALSE
	AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE
	AND 
	(
		t.CLI_BRANCHID NOT IN (SELECT CLI_BRANCHID FROM EXCLUDE_LIST)
		-- Added below condition for v002
		OR EXISTS(SELECT 1 FROM CLIENTS_TO_INCLUDE CTI WHERE t.CLI_ID = CTI.CLI_ID)
	);
SQL
	or_replace = true 
	is_secure = false 
}

