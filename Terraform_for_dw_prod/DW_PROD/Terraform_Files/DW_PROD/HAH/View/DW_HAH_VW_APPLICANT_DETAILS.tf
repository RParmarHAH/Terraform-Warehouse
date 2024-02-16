resource "snowflake_view" "DW_HAH_VW_APPLICANT_DETAILS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "VW_APPLICANT_DETAILS"
	statement = <<-SQL
	 select * from DISC_${var.SF_ENVIRONMENT}.JAZZHR.APPLICANT_DETAILS AD where id NOT in (select id from DISC_DEDUPE_${var.SF_ENVIRONMENT}.JAZZHR.EMPLOYEE_DEDUPE_OUTPUT) and id is not null
union all
select * from DISC_${var.SF_ENVIRONMENT}.JAZZHR.APPLICANT_DETAILS AD where id in (select id from DISC_DEDUPE_${var.SF_ENVIRONMENT}.JAZZHR.EMPLOYEE_MASTER_LIST) and id is not null;
SQL
	or_replace = true 
	is_secure = false 
}

