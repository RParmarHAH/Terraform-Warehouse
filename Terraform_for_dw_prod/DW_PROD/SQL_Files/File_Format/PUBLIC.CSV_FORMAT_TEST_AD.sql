CREATE OR REPLACE FILE FORMAT DW_PROD.PUBLIC.CSV_FORMAT_TEST_AD
	SKIP_HEADER = 1
	ESCAPE = '\\'
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
	COMPRESSION = NONE
	ENCODING = 'iso-8859-1'
;