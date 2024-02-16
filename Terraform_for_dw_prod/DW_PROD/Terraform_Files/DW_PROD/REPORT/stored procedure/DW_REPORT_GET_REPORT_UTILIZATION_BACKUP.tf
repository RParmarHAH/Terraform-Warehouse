resource "snowflake_procedure" "DW_REPORT_GET_REPORT_UTILIZATION_BACKUP" {
	name ="GET_REPORT_UTILIZATION_BACKUP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
    --*****************************************************************************************************************************
-- NAME:  Report_Utilization
--
-- PURPOSE: Creates overtime data set in the reporting layer for operations dashboard
--
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/20/20   Rachel Stewart         Added flower box, and date filter for service > DEC 2019 and formatted select
-- 04/29/20   Rachel Stewart         Added Days to Service per Wasay
--*****************************************************************************************************************************

INSERT OVERWRITE INTO REPORT.UTILIZATION_BACKUP
WITH CLEAN AS
         (SELECT V.CLIENT_KEY                           AS CLIENT_KEY
               , V.BRANCH_KEY                           AS BRANCH_KEY
               , V.CONTRACT_KEY                         AS CONTRACT_KEY
               , MAX(V.SUPERVISOR_KEY)                  AS SUPERVISOR_KEY
               , SUM(V.HOURS_SERVED)                    AS HOURS_SERVED
               , SUM(IFF(V.CLEAN_SHIFT_FLAG = 1, 1, 0)) AS CLEAN_SHIFTS
               , SUM(IFF(V.CLEAN_SHIFT_FLAG = 0 ,1,0)) AS VISITS_NEED_MAINTENCE
               , COUNT(1)                               AS VISIT_COUNT
               , DATE_TRUNC(''month'', V.REPORT_DATE)     AS REPORT_DATE
          FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT V
            GROUP BY V.CLIENT_KEY
                 , DATE_TRUNC(''month'', V.REPORT_DATE)
                 , V.CLIENT_KEY
                 , V.BRANCH_KEY
                 , V.CONTRACT_KEY
                 --,V.SUPERVISOR_KEY
                 , V.CLEAN_SHIFT_FLAG

         ),
     VISIT AS (
         SELECT C.CLIENT_KEY
              , C.BRANCH_KEY
              , C.CONTRACT_KEY
              , MAX(C.SUPERVISOR_KEY) AS SUPERVISOR_KEY
              , SUM(HOURS_SERVED)     AS HOURS_SERVED
              , SUM(CLEAN_SHIFTS)     AS CLEAN_SHIFTS
              , SUM(VISITS_NEED_MAINTENCE) AS VISITS_NEED_MAINTENCE
              , SUM(VISIT_COUNT)      AS VISIT_COUNT
              , REPORT_DATE
         FROM CLEAN C
         GROUP BY C.CLIENT_KEY
                , C.BRANCH_KEY
                , C.CONTRACT_KEY
                --,C.SUPERVISOR_KEY
                , REPORT_DATE
     ),
     INTAKE AS (
         SELECT I.CLIENT_KEY                       AS CLIENT_KEY
              , I.BRANCH_KEY                       AS BRANCH_KEY
              , I.CONTRACT_KEY                     AS CONTRACT_KEY
              , DATE_TRUNC(''month'', I.REPORT_DATE) AS REPORT_DATE
              , SUM(I.HOURS_AUTHORIZED)            AS HOURS_AUTHORIZED
         FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_INTAKE I
         GROUP BY DATE_TRUNC(''month'', I.REPORT_DATE)
                , I.CLIENT_KEY
                , I.BRANCH_KEY
                , I.CONTRACT_KEY
                , I.REPORT_DATE
     )
SELECT COALESCE(V.BRANCH_KEY, I.BRANCH_KEY)                             AS BRANCH_KEY
     , COALESCE(V.CLIENT_KEY, I.CLIENT_KEY)                             AS CLIENT_KEY
     , COALESCE(V.CONTRACT_KEY, I.CONTRACT_KEY)                         AS CONTRACT_KEY
     , V.SUPERVISOR_KEY
     , COALESCE(V.REPORT_DATE, I.REPORT_DATE)                           AS REPORT_DATE
     , SUM(V.CLEAN_SHIFTS)                                              AS CLEAN_SHIFTS
     , SUM(V.VISITS_NEED_MAINTENCE)                                     AS VISITS_NEED_MAINTENCE
     , V.VISIT_COUNT
     , NVL(SUM(I.HOURS_AUTHORIZED),0)                                   AS HOURS_AUTHORIZED
     , NVL(SUM(V.HOURS_SERVED),0)                                       AS HOURS_SERVED
     , IFF(HOURS_AUTHORIZED = 0, null, HOURS_SERVED / HOURS_AUTHORIZED) AS UTILIZATION
     , IFF(UTILIZATION > 1, COUNT(DISTINCT V.CLIENT_KEY), 0)            AS OVER_AUTHED
     , IFF(HOURS_AUTHORIZED IS NULL, 1, 0)                              AS SERVED_WITHOUT_AUTH
	   , C.DAYS_TO_SERVICE                                                AS DAYS_TO_SERVICE
     , -1                                                               AS ETL_TASK_KEY
     , -1                                                               AS ETL_INSERTED_TASK_KEY
     , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz        as ETL_INSERTED_DATE
     , CURRENT_USER                                                     as ETL_INSERTED_BY
     , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz        as ETL_LAST_UPDATED_DATE
     , CURRENT_USER                                                     as ETL_LAST_UPDATED_BY
     , 0                                                                as ETL_DELETED_FLAG
     , 0                                                                as ETL_INFERRED_MEMBER_FLAG
FROM INTAKE I
         RIGHT JOIN VISIT V ON I.BRANCH_KEY = V.BRANCH_KEY AND I.CLIENT_KEY = V.CLIENT_KEY AND
                                    I.CONTRACT_KEY = V.CONTRACT_KEY AND I.REPORT_DATE = V.REPORT_DATE
		 LEFT JOIN HAH.DIM_CLIENT C
		 ON C.CLIENT_KEY = COALESCE(V.CLIENT_KEY, I.CLIENT_KEY)
WHERE COALESCE(V.REPORT_DATE, I.REPORT_DATE)     >= ''2020-01-01''
GROUP BY 1, 2, 3, 4, 5, HOURS_AUTHORIZED, HOURS_SERVED, VISIT_COUNT, C.DAYS_TO_SERVICE
`;
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

