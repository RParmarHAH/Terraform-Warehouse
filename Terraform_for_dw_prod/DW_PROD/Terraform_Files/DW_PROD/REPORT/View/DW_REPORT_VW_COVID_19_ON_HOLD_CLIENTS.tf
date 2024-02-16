resource "snowflake_view" "DW_REPORT_VW_COVID_19_ON_HOLD_CLIENTS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_COVID_19_ON_HOLD_CLIENTS"
	statement = <<-SQL
	 select onholdclient.* from 
(select *,CASE WHEN STATE = 'PA' THEN 0 ELSE OFFICE_NUMBER END AS OFFICENUMBER from report.COVID_19_ON_HOLD_CLIENTS where state != 'PA')onholdclient
inner join
(select * from hah.dim_branch where OFFICE_STATE_CODE != 'PA')branch 
on onholdclient.state = branch.OFFICE_STATE_CODE 
and 
onholdclient.OFFICENUMBER = branch.OFFICE_NUMBER 
and branch.OFFICE_STATE_CODE != 'PA';
SQL
	or_replace = true 
	is_secure = false 
}

