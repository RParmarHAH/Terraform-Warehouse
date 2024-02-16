resource "snowflake_file_format" "DW_PUBLIC_CSV_FORMAT_ONE_HEAD_ROW" {
	name = "CSV_FORMAT_ONE_HEAD_ROW"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	comment = "CSV Format with one header row - Abhishek"
	format_type = "CSV"
	compression = "NONE"
	record_delimiter = "NONE"
	field_delimiter = "NONE"
	file_extension = "NONE"
	skip_header = 0
	skip_blank_lines = false
	date_format = "AUTO"
	time_format = "AUTO"
	timestamp_format = "AUTO"
	binary_format = "HEX"
	escape = "\\"
	escape_unenclosed_field = "\\"
	trim_space = true
	field_optionally_enclosed_by = "\""
	null_if = ["\\n"]
	error_on_column_count_mismatch = true
	replace_invalid_characters = false
	empty_field_as_null = true
	skip_byte_order_mark = true
	encoding = "UTF8"
}

