resource "snowflake_view" "DISC_1UP_BISON_VW_FHIR_R4_ORGANIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "VW_FHIR_R4_ORGANIZATION"
	statement = <<-SQL
	 
select
parse_json(source_data):id::string as id,
parse_json(source_data):identifier[0]:system::string as identifier_system,
parse_json(source_data):identifier[0]:use::string as identifier_use,
parse_json(source_data):identifier[0]:value::string as identifier_value,

parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ(9) as meta_lastUpdated,
parse_json(source_data):meta:profile[0]::string as meta_profile,
PARSE_JSON(source_data):meta:tag[0].code::STRING AS META_Tag_Code,
PARSE_JSON(source_data):meta:tag[0].system::STRING AS META_TagSystem,
PARSE_JSON(source_data):meta:tag[0].version::STRING AS META_TagVersion, 
PARSE_JSON(source_data):meta:versionId::STRING AS META_TagVersion_id,
PARSE_JSON(source_data):resourceType::STRING AS META_Resourcetype,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_BISON".HIST_FHIR_R4_ORGANIZATION;
SQL
	or_replace = true 
	is_secure = false 
}

