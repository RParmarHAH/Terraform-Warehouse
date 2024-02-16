resource "snowflake_file_format" "DW_PUBLIC_CSV_SURVEY" {
	name = "CSV_SURVEY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	comment = "File format for Qualtrics survey CSV files."
	format_type = "CSV"
	compression = "AUTO"
	record_delimiter = "NONE"
	field_delimiter = "NONE"
	file_extension = "NONE"
	skip_header = 5
	skip_blank_lines = false
	date_format = "AUTO"
	time_format = "AUTO"
	timestamp_format = "AUTO"
	binary_format = "HEX"
	escape = "NONE"
	escape_unenclosed_field = "\\"
	trim_space = false
	field_optionally_enclosed_by = "NONE"
	null_if = ["\\n"]
	error_on_column_count_mismatch = true
	replace_invalid_characters = false
	empty_field_as_null = true
	skip_byte_order_mark = true
	encoding = "UTF8"
}

