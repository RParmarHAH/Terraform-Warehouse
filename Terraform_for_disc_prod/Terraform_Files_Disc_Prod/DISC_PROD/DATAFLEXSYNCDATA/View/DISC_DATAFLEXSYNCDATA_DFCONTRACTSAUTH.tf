resource "snowflake_view" "DISC_DATAFLEXSYNCDATA_DFCONTRACTSAUTH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFCONTRACTSAUTH"
	statement = <<-SQL
	 
--************************************************************************************************************************
--This view is created after receiving multiple weekly auth type contract in jira ticket  ---IDDOX-554
-- 2023-11-30			KDHOKAI				Changed Database DISC_${var.SF_ENVIRONMENT} to DISC_${var.SF_ENVIRONMENT}
--************************************************************************************************************************
SELECT *, 'Weekly' AS AUTHTYPE FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS  
WHERE (CONTRACTCODE ILIKE  ANY
('OE','OR','OS','V','OG','OF','ON','OT','OP') AND DBNAME IN ('MO')OR
CONTRACTCODE ILIKE  ANY
('SV','B3','P8','VF','VE','VI','3D','P6','P7','B2','O4','O1','AQ','A3','A1','P5','B1','VC','3R','3'
,'O3','VM','VT','K','VD','O2','V1','AR','3A','A2','2','VA','VS','71','3B') AND DBNAME IN ('IL'))
UNION ALL
SELECT *, 'Monthly' AS AUTHTYPE FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS  
WHERE NOT(CONTRACTCODE ILIKE  ANY
('OE','OR','OS','V','OG','OF','ON','OT','OP') AND DBNAME IN ('MO')OR
CONTRACTCODE ILIKE  ANY
('SV','B3','P8','VF','VE','VI','3D','P6','P7','B2','O4','O1','AQ','A3','A1','P5','B1','VC','3R','3'
,'O3','VM','VT','K','VD','O2','V1','AR','3A','A2','2','VA','VS','71','3B') AND DBNAME IN ('IL'));
SQL
	or_replace = true 
	is_secure = false 
}

