create or replace view DW_PROD.REPORT.VW_COVID_19_ON_HOLD_CLIENTS(
	STATE,
	OFFICE_NUMBER,
	OFFICE_NAME,
	ON_HOLD_START_DATE,
	CLIENT_COUNT,
	BRANCH_KEY,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	OFFICENUMBER
) as
select onholdclient.* from 
(select *,CASE WHEN STATE = 'PA' THEN 0 ELSE OFFICE_NUMBER END AS OFFICENUMBER from report.COVID_19_ON_HOLD_CLIENTS where state != 'PA')onholdclient
inner join
(select * from hah.dim_branch where OFFICE_STATE_CODE != 'PA')branch 
on onholdclient.state = branch.OFFICE_STATE_CODE 
and 
onholdclient.OFFICENUMBER = branch.OFFICE_NUMBER 
and branch.OFFICE_STATE_CODE != 'PA';