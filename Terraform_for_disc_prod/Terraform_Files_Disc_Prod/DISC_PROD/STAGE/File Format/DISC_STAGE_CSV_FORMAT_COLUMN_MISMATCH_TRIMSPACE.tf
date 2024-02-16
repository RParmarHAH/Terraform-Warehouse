resource "snowflake_file_format" "DISC_STAGE_CSV_FORMAT_COLUMN_MISMATCH_TRIMSPACE" {
	name = "CSV_FORMAT_COLUMN_MISMATCH_TRIMSPACE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	format_type = "CSV"
	compression = "NONE"
	record_delimiter = "NONE"
	field_delimiter = "NONE"
	file_extension = "NONE"
	skip_header = 1
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

