create or replace view DW_PROD.INTEGRATION.VW_APPLICANT_CROSSWALK_OUTPUT_CLEANUP(
	ID,
	APPLICANT_ID,
	SOURCE,
	ETL_INSERTED_DATE
) as
select APPLICANT_ID AS ID, LINKED_ID as APPLICANT_ID   ,'WORKDAY' as source,CURRENT_TIMESTAMP AS ETL_INSERTED_DATE
from DW_PROD.stage.workday_dim_applicant where APPLICANT_ID not in (
select COALESCE(WORKDAY_INTERNAL_ID,RANDOM()) from DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_CLONE_FOR_CLEANUP
  )
union 
SELECT EMPLOYEE_ENTERPRISE_ID::VARCHAR  as id, APPLICANT_EMPLOYEE_ID as APPLICANT_ID ,'CROSSWALK' AS SOURCE , CURRENT_TIMESTAMP  AS ETL_INSERTED_DATE
  FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_CLONE_FOR_CLEANUP C
LEFT JOIN DW_PROD.HAH.DIM_EMPLOYEE E ON C.AMS_EMPLOYEE_KEY = E.EMPLOYEE_KEY 
where C.AMS_EMPLOYEE_KEY IS NOT NULL AND INACTIVE = FALSE and DUP_FLAG = FALSE
union 
SELECT distinct EMPLOYEE_ENTERPRISE_ID::VARCHAR  as id,APPLICANT_EMPLOYEE_ID as APPLICANT_ID  ,'CROSSWALK' AS SOURCE, CURRENT_TIMESTAMP AS ETL_INSERTED_DATE
  FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_CLONE_FOR_CLEANUP C
LEFT JOIN DW_PROD.HAH.DIM_EMPLOYEE E ON C.PAYROLL_EMPLOYEE_KEY = E.EMPLOYEE_KEY 
where C.AMS_EMPLOYEE_KEY IS null and C.PAYROLL_EMPLOYEE_KEY is not null  AND INACTIVE = FALSE and DUP_FLAG = FALSE ;