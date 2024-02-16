resource "snowflake_view" "DW_PUBLIC_VW_ACROSS_DEDUPE_CONFIG_FINAL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "VW_ACROSS_DEDUPE_CONFIG_FINAL"
	statement = <<-SQL
	 select C.*,R.RULES from DW_${var.SF_ENVIRONMENT}.PUBLIC.ACROSS_DEDUPE_CONFIG C 
LEFT JOIN DEDUPE_STAGE_LAYER.CONFIGURATION.RULES_CONFIG R ON C.RULE_TYPE =R.RULE_TYPE;
SQL
	or_replace = true 
	is_secure = false 
}

