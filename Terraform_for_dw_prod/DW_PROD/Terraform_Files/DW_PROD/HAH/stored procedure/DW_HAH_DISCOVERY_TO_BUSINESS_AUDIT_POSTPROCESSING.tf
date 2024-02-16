resource "snowflake_procedure" "DW_HAH_DISCOVERY_TO_BUSINESS_AUDIT_POSTPROCESSING" {
	name ="DISCOVERY_TO_BUSINESS_AUDIT_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"

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

        var sql = `
    INSERT INTO DATA_MANAGEMENT.SNOWFLAKE.DISCOVERY_TO_BUSINESS_AUDIT
WITH   DISCOVERY AS 
(
SELECT ''SOURCE_COUNT_DIM_CLIENT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''COSTAL_DIM_CLIENT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(CLIENT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_COSTALSYNCDATA_DIM_CLIENT
UNION
SELECT ''SOURCE_COUNT_DIM_CLIENT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''DATAFLEX_DIM_CLIENT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(CLIENT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_DATAFLEXSYNCDATA_DIM_CLIENT
UNION
SELECT ''SOURCE_COUNT_DIM_CLIENT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''SANDATA_DIM_CLIENT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(CLIENT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_SANDATAIMPORT_DIM_CLIENT
UNION
SELECT ''SOURCE_COUNT_DIM_BRANCH''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''COSTAL_DIM_BRANCH'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(BRANCH_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_COSTALSYNCDATA_DIM_BRANCH
UNION
SELECT ''SOURCE_COUNT_DIM_BRANCH''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''DATAFLEX_DIM_BRANCH'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(BRANCH_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_DATAFLEXSYNCDATA_DIM_BRANCH
UNION
SELECT ''SOURCE_COUNT_DIM_BRANCH''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''SANDATA_DIM_BRANCH'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(BRANCH_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_SANDATAIMPORT_DIM_BRANCH
UNION
SELECT ''SOURCE_COUNT_FACT_VISIT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''COSTAL_FACT_VISIT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(VISIT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_COSTALSYNCDATA_FACT_VISIT
UNION
SELECT ''SOURCE_COUNT_FACT_VISIT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''DATAFLEX_FACT_VISIT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(VISIT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_DATAFLEXSYNCDATA_FACT_VISIT
UNION
SELECT ''SOURCE_COUNT_FACT_VISIT''  AS TASK,''DISC_${var.SF_ENVIRONMENT}''  AS DISC_DB,''SANDATA_FACT_VISIT'' AS DISC_${var.SF_ENVIRONMENT}_SOURCE, count(VISIT_KEY) AS DISC_TABLE_COUNT
FROM DW_${var.SF_ENVIRONMENT}."STAGE".VW_CURRENT_SANDATAIMPORT_FACT_VISIT
),
BUSSINESS AS  (
SELECT ''DIM_CLIENT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''COSTAL_DIM_CLIENT'' AS DW_SOURCE, COUNT(CLIENT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID IN (1,2)
UNION
SELECT ''DIM_CLIENT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''DATAFLEX_DIM_CLIENT'' AS DW_SOURCE, COUNT(CLIENT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID IN (3)
UNION
SELECT ''DIM_CLIENT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''SANDATA_DIM_CLIENT'' AS DW_SOURCE, COUNT(CLIENT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID IN (4)
UNION
SELECT ''DIM_BRANCH''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''COSTAL_DIM_BRANCH'' AS DW_SOURCE, COUNT(BRANCH_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID IN (1,2)
UNION
SELECT ''DIM_BRANCH''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''DATAFLEX_DIM_BRANCH'' AS DW_SOURCE, COUNT(BRANCH_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID IN (3,5)
UNION
SELECT ''DIM_BRANCH''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''SANDATA_DIM_BRANCH'' AS DW_SOURCE, COUNT(BRANCH_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID IN (4)
UNION
SELECT ''FACT_VISIT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''COSTAL_FACT_VISIT'' AS DW_SOURCE, COUNT(VISIT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)
UNION
SELECT ''FACT_VISIT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''DATAFLEX_FACT_VISIT'' AS DW_SOURCE, COUNT(VISIT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (3)
UNION
SELECT ''FACT_VISIT''  AS DW_${var.SF_ENVIRONMENT}_TABLE,''DW_${var.SF_ENVIRONMENT}''  AS DW_DB,''SANDATA_FACT_VISIT'' AS DW_SOURCE, COUNT(VISIT_KEY) AS DW_TABLE_COUNT FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (4)
)
SELECT * ,(B.DW_TABLE_COUNT- D.DISC_TABLE_COUNT) AS COUNT_DIFF, floor(100.0*(COUNT_DIFF) / D.DISC_TABLE_COUNT,4) As PercentageDiff,CURRENT_DATE AS insert_date 
FROM DISCOVERY D INNER JOIN BUSSINESS B ON D.DISC_${var.SF_ENVIRONMENT}_SOURCE = B.DW_SOURCE ORDER BY TASK;`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

