CREATE OR REPLACE FILE FORMAT DISC_PROD.STAGE.CSV_FORMAT_COLUMN_MISMATCH_TRIMSPACE
	SKIP_HEADER = 1
	ESCAPE = '\\'
	TRIM_SPACE = TRUE
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
	COMPRESSION = NONE
	VALIDATE_UTF8 = FALSE
;