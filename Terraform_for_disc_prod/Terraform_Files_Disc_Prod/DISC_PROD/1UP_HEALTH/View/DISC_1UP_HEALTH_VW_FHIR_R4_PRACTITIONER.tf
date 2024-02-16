resource "snowflake_view" "DISC_1UP_HEALTH_VW_FHIR_R4_PRACTITIONER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_HEALTH"
	name = "VW_FHIR_R4_PRACTITIONER"
	statement = <<-SQL
	 (
select 
parse_json(source_data):id::string as id,
parse_json(source_data):name[0]:given[0]::string as First_name,
parse_json(source_data):name[0]:given[1]::string as Middle_name,
parse_json(source_data):name[0]:family::string as Last_name,
parse_json(source_data):name[0]:text::string as Full_name,
parse_json(source_data):active::string as active_status,
parse_json(source_data):identifier[0]:period:end::TIMESTAMP_NTZ as identifier_period_end_date,
parse_json(source_data):identifier[0]:period:start::TIMESTAMP_NTZ as identifier_period_start_date,
parse_json(source_data):identifier[0]:system::string as identifier_system,
parse_json(source_data):identifier[0]:type:coding[0]:code::string as identifier_type_coding_code1,
parse_json(source_data):identifier[0]:type:coding[0]:display::string as identifier_type_coding_display1,
parse_json(source_data):identifier[0]:type:coding[0]:system::string as identifier_type_coding_system1,
parse_json(source_data):identifier[0]:value::string as identifier_value,
parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_code2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_extension_system3,
parse_json(source_data):meta:extension[3]:url::string as meta_extension_url4,
parse_json(source_data):meta:extension[3]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime4,
parse_json(source_data):meta:extension[4]:url::string as meta_extension_url5,
parse_json(source_data):meta:extension[4]:valueString::string as meta_extension_valueString5,
parse_json(source_data):meta:extension[5]:url::string as meta_extension_url6,
parse_json(source_data):meta:extension[5]:valueString::string as meta_extension_valueString6,
parse_json(source_data):meta:extension[6]:url::string as meta_extension_url7,
parse_json(source_data):meta:extension[6]:valueString::string as meta_extension_valueString7,
parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ as meta_lastUpdated,
parse_json(source_data):meta:profile::string as meta_profile,
parse_json(source_data):meta:tag[0]:code::string as meta_tag_code,
parse_json(source_data):meta:tag[0]:system::string as meta_tag_system,
parse_json(source_data):meta:tag[0]:version::string as meta_tag_version,
parse_json(source_data):meta:versionId::string as meta_versionId,
parse_json(source_data):resourceType::string as resourceType,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_HEALTH".HIST_FHIR_R4_PRACTITIONER
);
SQL
	or_replace = true 
	is_secure = false 
}

