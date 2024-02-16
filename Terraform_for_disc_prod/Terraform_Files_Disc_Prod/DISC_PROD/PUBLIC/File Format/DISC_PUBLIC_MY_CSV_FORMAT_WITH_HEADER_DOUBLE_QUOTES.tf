resource "snowflake_file_format" "DISC_PUBLIC_MY_CSV_FORMAT_WITH_HEADER_DOUBLE_QUOTES" {
	name = "MY_CSV_FORMAT_WITH_HEADER_DOUBLE_QUOTES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	format_type = "csv"
	compression = "AUTO"
	record_delimiter = "NONE"
	field_delimiter = "NONE"
	file_extension = "NONE"
	skip_header = 0
	skip_blank_lines = false
	date_format = "AUTO"
	time_format = "AUTO"
	timestamp_format = "AUTO"
	binary_format = "HEX"
	escape = "NONE"
	escape_unenclosed_field = "\\"
	trim_space = false
	field_optionally_enclosed_by = "\""
	null_if = ["\\n"]
	error_on_column_count_mismatch = true
	replace_invalid_characters = false
	empty_field_as_null = true
	skip_byte_order_mark = true
	encoding = "UTF8"
}

