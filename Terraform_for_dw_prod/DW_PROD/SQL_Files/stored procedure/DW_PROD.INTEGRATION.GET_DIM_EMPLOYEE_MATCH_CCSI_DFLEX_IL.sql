CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_DIM_EMPLOYEE_MATCH_CCSI_DFLEX_IL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
	return_result_temp varchar(1000);
BEGIN
delete FROM DW_PROD.INTEGRATION.DIM_EMPLOYEE_MATCH WHERE (SOURCE_SYSTEM_ID=3 AND SYSTEM_CODE= ''IL'') OR SOURCE_SYSTEM_ID=8;

SELECT CONCAT(''Message : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

INSERT INTO DW_PROD.INTEGRATION.DIM_EMPLOYEE_MATCH (
with dedupe_record_ids as 
(
select record_id,cluster_id,filename
from DISC_DEDUPE_PROD.CCSI.DF_CCSI_EMP_DEDUPE_SOURCE
where cluster_id in (select cluster_id
from DISC_DEDUPE_PROD.CCSI.DF_CCSI_EMP_DEDUPE_SOURCE
group by cluster_id
having count(cluster_id)>1
)
),
emp_Master as
(
select record_id,cluster_id,filename
		,ccsi_emp.EMPLOYEE_LAST_WORKED_DATE
    	,ccsi_emp.EMPLOYEE_HIRE_DATE
,ccsi_emp.EMPLOYEE_KEY MASTER_KEY
,row_number() over(partition by dedupe.cluster_id order by nvl(EMPLOYEE_LAST_WORKED_DATE, ''9999-12-31'') DESC,ccsi_emp.EMPLOYEE_HIRE_DATE DESC) Max_record_id
from DISC_DEDUPE_PROD.CCSI.DF_CCSI_EMP_DEDUPE_SOURCE dedupe
INNER JOIN DW_PROD.HAH.DIM_EMPLOYEE ccsi_emp on
dedupe.record_id = ccsi_emp.EMPLOYEE_KEY
)
select dedupe.record_id original_key 
		,M.MASTER_KEY 
        ,dedupe.cluster_id
        ,row_number() over(partition by dedupe.cluster_id 
		 order by nvl(ccsi_emp.EMPLOYEE_LAST_WORKED_DATE, ''9999-12-31'') DESC,ccsi_emp.EMPLOYEE_HIRE_DATE DESC) record_order
,ccsi_emp.SOURCE_SYSTEM_ID
,ccsi_emp.SYSTEM_CODE
,ccsi_emp.EMPLOYEE_FIRST_NAME
,ccsi_emp.EMPLOYEE_LAST_NAME
,ccsi_emp.EMPLOYEE_DOB
,ccsi_emp.EMPLOYEE_PID
,ccsi_emp.EMPLOYEE_ADDRESS1
,ccsi_emp.EMPLOYEE_ADDRESS2
,ccsi_emp.EMPLOYEE_CITY
,ccsi_emp.EMPLOYEE_ZIP
,ccsi_emp.EMPLOYEE_HIRE_DATE
,ccsi_emp.EMPLOYEE_ID
,ccsi_emp.EMPLOYEE_NUMBER 
,ccsi_emp.ACTIVE_EMPLOYEE_FLAG
,ccsi_emp.EMPLOYEE_FIRST_CHECK_DATE
,ccsi_emp.EMPLOYEE_LAST_CHECK_DATE
,ccsi_emp.EMPLOYEE_LAST_WORKED_DATE
,ccsi_emp.EMPLOYEE_TERMINATE_DATE
,ccsi_emp.ETL_INSERTED_DATE
,ccsi_emp.ETL_LAST_UPDATED_DATE
      from DISC_DEDUPE_PROD.CCSI.DF_CCSI_EMP_DEDUPE_SOURCE dedupe
      inner join DW_PROD.HAH.DIM_EMPLOYEE ccsi_emp on
            dedupe.record_id = ccsi_emp.EMPLOYEE_KEY
      inner join dedupe_record_ids matches on
            matches.filename = dedupe.filename
            and matches.record_id = dedupe.record_id
            and matches.cluster_id = dedupe.cluster_id
      inner join emp_Master M on 
            M.cluster_id=matches.cluster_id
            and Max_record_id=1 
);

SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return CONCAT(return_result,'' | '',return_result_temp);
END;
';