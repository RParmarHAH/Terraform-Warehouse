resource "snowflake_view" "DISC_1UP_BISON_VW_FHIR_R4_COVERAGE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "1UP_BISON"
	name = "VW_FHIR_R4_COVERAGE"
	statement = <<-SQL
	 (
select 
parse_json(source_data):id::string as id,
parse_json(source_data):beneficiary:reference::string as beneficiary_reference, 
parse_json(source_data):identifier[0]:system::string as identifier_system1,
parse_json(SOURCE_DATA):identifier[0]:use::STRING AS identifier_use1,
parse_json(source_data):identifier[0]:type:coding[0]:code::string as identifier_type_coding_code1,
parse_json(source_data):identifier[0]:type:coding[0]:display::string as identifier_type_coding_display1,
parse_json(source_data):identifier[0]:type:coding[0]:system::string as identifier_type_coding_system1,
parse_json(source_data):identifier[0]:value::string as identifier_value1,

parse_json(SOURCE_DATA):identifier[1]:system::STRING AS identifier_system2,
parse_json(SOURCE_DATA):identifier[1]:use::STRING AS identifier_use2,
parse_json(source_data):identifier[1]:type:coding[0]:code::string as identifier_type_coding_code2,
parse_json(source_data):identifier[1]:type:coding[0]:display::string as identifier_type_coding_display2,
parse_json(source_data):identifier[1]:type:coding[0]:system::string as identifier_type_coding_system2,
parse_json(source_data):identifier[1]:value::string as identifier_value2,

parse_json(SOURCE_DATA):identifier[2]:system::STRING AS identifier_system3,
parse_json(SOURCE_DATA):identifier[2]:use::STRING AS identifier_use3,
parse_json(source_data):identifier[2]:type:coding[0]:code::string as identifier_type_coding_code3,
parse_json(source_data):identifier[2]:type:coding[0]:display::string as identifier_type_coding_display3,
parse_json(source_data):identifier[2]:type:coding[0]:system::string as identifier_type_coding_system3,
parse_json(source_data):identifier[2]:value::string as identifier_value3,

parse_json(SOURCE_DATA):identifier[3]:system::STRING AS identifier_system4,
parse_json(SOURCE_DATA):identifier[3]:use::STRING AS identifier_use4,
parse_json(source_data):identifier[3]:type:coding[0]:code::string as identifier_type_coding_code4,
parse_json(source_data):identifier[3]:type:coding[0]:display::string as identifier_type_coding_display4,
parse_json(source_data):identifier[3]:type:coding[0]:system::string as identifier_type_coding_system4,
parse_json(source_data):identifier[3]:value::string as identifier_value4,

parse_json(source_data):identifier[4]:system::string as identifier_system5,
parse_json(source_data):identifier[4]:use::string as identifier_use5,
parse_json(source_data):identifier[4]:value::string as identifier_value5,

PARSE_JSON(SOURCE_DATA):class[0]:name::STRING AS class_name1,
parse_json(source_data):class[0]:type:coding[0]:code::string as class_type_coding_code1,
parse_json(source_data):class[0]:type:coding[0]:display::string as class_type_coding_display1,
parse_json(source_data):class[0]:type:coding[0]:system::string as class_type_coding_system1,
parse_json(source_data):class[0]:value::string as class_value1,
parse_json(source_data):class[1]:type:coding[0]:code::string as class_type_coding_code2,
parse_json(source_data):class[1]:type:coding[0]:display::string as class_type_coding_display2,
parse_json(source_data):class[1]:type:coding[0]:system::string as class_type_coding_system2,
parse_json(source_data):class[1]:value::string as class_value2,

parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ(9) as meta_extension_valueDateTime1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_valueCodeableConcept_coding_code2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:system::string as meta_extension_valueCodeableConcept_coding_system2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_valueCodeableConcept_coding_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_extension_valueCodeableConcept_coding_system3,
parse_json(source_data):meta:extension[3]:url::string as meta_extension_url4,
parse_json(source_data):meta:extension[3]:valueDateTime::TIMESTAMP_NTZ(9) as meta_extension_valueDateTime4,
parse_json(source_data):meta:extension[4]:url::string as meta_extension_url5,
parse_json(source_data):meta:extension[4]:valueString::string as meta_extension_valueString5,
parse_json(source_data):meta:extension[5]:url::string as meta_extension_url6,
parse_json(source_data):meta:extension[5]:valueString::string as meta_extension_valueString6,
parse_json(source_data):meta:extension[6]:url::string as meta_extension_url7,
parse_json(source_data):meta:extension[6]:valueString::string as meta_extension_valueString7,
parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ(9) as meta_lastUpdated,
parse_json(source_data):meta:profile[0]::string as meta_profile,
parse_json(source_data):meta:source::string as meta_source,
parse_json(source_data):meta:tag[0]:code::string as meta_tag_code,
parse_json(source_data):meta:tag[0]:system::string as meta_tag_system,
parse_json(source_data):meta:tag[0]:version::string as meta_tag_version,
parse_json(source_data):meta:versionId::string as meta_versionId,

parse_json(source_data):order::int as "ORDER", 
parse_json(source_data):payor[0]:reference::string as payor_reference1,
parse_json(source_data):payor[1]:reference::string as payor_reference2,
parse_json(source_data):period:end::DATE as period_end, 
parse_json(source_data):period:start::DATE as period_start, 
parse_json(source_data):relationship:coding[0]:code::string as relationship_coding_code, 
parse_json(source_data):relationship:coding[0]:display::string as relationship_coding_display, 
parse_json(source_data):relationship:coding[0]:system::string as relationship_coding_system, 
parse_json(source_data):relationship:text::string as relationship_text, 
parse_json(source_data):resourceType::string as resourceType, 
parse_json(source_data):status::string as status, 
parse_json(source_data):subscriber:reference::string as subscriber_reference, 
parse_json(source_data):subscriberId::string as subscriberId, 

LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_${var.SF_ENVIRONMENT}."1UP_BISON".HIST_FHIR_R4_COVERAGE
);
SQL
	or_replace = true 
	is_secure = false 
}

