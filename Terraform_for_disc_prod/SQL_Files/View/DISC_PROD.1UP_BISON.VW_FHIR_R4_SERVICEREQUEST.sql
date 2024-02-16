create or replace view DISC_PROD."1UP_BISON".VW_FHIR_R4_SERVICEREQUEST(
	ID,
	CODE_CODING_CODE,
	CODE_CODING_DISPLAY,
	CODE_TEXT,
	IDENTIFIER_SYSTEM1,
	IDENTIFIER_TYPE_CODING_CODE1,
	IDENTIFIER_TYPE_CODING_DISPLAY1,
	IDENTIFIER_TYPE_CODING_SYSTEM1,
	IDENTIFIER_VALUE1,
	IDENTIFIER_SYSTEM2,
	IDENTIFIER_TYPE_CODING_CODE2,
	IDENTIFIER_TYPE_CODING_DISPLAY2,
	IDENTIFIER_TYPE_CODING_SYSTEM2,
	IDENTIFIER_VALUE2,
	INTENT,
	META_EXTENSION_URL1,
	META_EXTENSION_VALUEDATETIME1,
	META_EXTENSION_URL2,
	META_EXTENSION_VALUCODEABLECONCEPT_CODING_CODE2,
	META_EXTENSION_VALUECODEABLECONCEPT_CODING_SYSTEM2,
	META_EXTENSION_URL3,
	META_EXTENSION_VALUECODEABLECONCEPT_CODING_CODE3,
	META_VALUECODEABLECONCEPT_CODING_SYSTEM3,
	META_EXTENSION_URL4,
	META_EXTENSION_VALUEDATETIME4,
	META_EXTENSION_URL5,
	META_EXTENSION_VALUESTRING5,
	META_EXTENSION_URL6,
	META_EXTENSION_VALUESTRING6,
	META_EXTENSION_URL7,
	META_EXTENSION_VALUESTRING7,
	META_LASTUPDATED,
	META_SOURCE,
	META_VERSIONID,
	OCCURRENCEDATETIME,
	REQUESTER_DISPLAY,
	REQUESTER_REFERENCE,
	RESOURCETYPE,
	STATUS,
	SUBJECT_REFERENCE,
	TEXT_DIV,
	TEXT_STATUS,
	LANDING_INSERTED_DATE,
	LANDING_INSERTED_BY,
	FILENAME,
	ETL_INSERTED_BY,
	ETL_TASK_KEY,
	ETL_INSERTED_DATE
) as (
select
parse_json(source_data):id::string as id,
parse_json(source_data):code:coding[0]:code::string as code_coding_code,
parse_json(source_data):code:coding[0]:display::string as code_coding_display,
parse_json(source_data):code:text::string as code_text,
parse_json(source_data):identifier[0]:system::string as identifier_system1,
parse_json(source_data):identifier[0]:type:coding[0]:code::string as identifier_type_coding_code1,
parse_json(source_data):identifier[0]:type:coding[0]:display::string as identifier_type_coding_display1,
parse_json(source_data):identifier[0]:type:coding[0]:system::string as identifier_type_coding_system1,
parse_json(source_data):identifier[0]:value::string as identifier_value1,
parse_json(source_data):identifier[1]:system::string as identifier_system2,
parse_json(source_data):identifier[1]:type:coding[0]:code::string as identifier_type_coding_code2,
parse_json(source_data):identifier[1]:type:coding[0]:display::string as identifier_type_coding_display2,
parse_json(source_data):identifier[1]:type:coding[0]:system::string as identifier_type_coding_system2,
parse_json(source_data):identifier[1]:value::string as identifier_value2,
parse_json(source_data):intent::string as intent,
parse_json(source_data):meta:extension[0]:url::string as meta_extension_url1,
parse_json(source_data):meta:extension[0]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime1,
parse_json(source_data):meta:extension[1]:url::string as meta_extension_url2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:code::string as meta_extension_valucodeableconcept_coding_code2,
parse_json(source_data):meta:extension[1]:valueCodeableConcept:coding[0]:system::string as meta_extension_valuecodeableconcept_coding_system2,
parse_json(source_data):meta:extension[2]:url::string as meta_extension_url3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:code::string as meta_extension_valuecodeableconcept_coding_code3,
parse_json(source_data):meta:extension[2]:valueCodeableConcept:coding[0]:system::string as meta_valuecodeableconcept_coding_system3,
parse_json(source_data):meta:extension[3]:url::string as meta_extension_url4,
parse_json(source_data):meta:extension[3]:valueDateTime::TIMESTAMP_NTZ as meta_extension_valueDateTime4,
parse_json(source_data):meta:extension[4]:url::string as meta_extension_url5,
parse_json(source_data):meta:extension[4]:valueString::string as meta_extension_valueString5,
parse_json(source_data):meta:extension[5]:url::string as meta_extension_url6,
parse_json(source_data):meta:extension[5]:valueString::string as meta_extension_valueString6,
parse_json(source_data):meta:extension[6]:url::string as meta_extension_url7,
parse_json(source_data):meta:extension[6]:valueString::string as meta_extension_valueString7,
parse_json(source_data):meta:lastUpdated::TIMESTAMP_NTZ as meta_lastUpdated,
parse_json(source_data):meta:source::string as meta_source,
parse_json(source_data):meta:versionId::string as meta_versionId,
parse_json(source_data):occurrenceDateTime::TIMESTAMP_NTZ as occurrenceDateTime,
parse_json(source_data):requester:display::string as requester_display,
parse_json(source_data):requester:reference::string as requester_reference,
parse_json(source_data):resourceType::string as resourceType,
parse_json(source_data):status::string as status,
parse_json(source_data):subject:reference::string as subject_reference,
parse_json(source_data):text:div::string as text_div,
parse_json(source_data):text:status::string as text_status,
LANDING_INSERTED_DATE,
LANDING_INSERTED_BY,
FILENAME,
ETL_INSERTED_BY,
ETL_TASK_KEY,
ETL_INSERTED_DATE
FROM DISC_PROD."1UP_BISON".HIST_FHIR_R4_SERVICEREQUEST);