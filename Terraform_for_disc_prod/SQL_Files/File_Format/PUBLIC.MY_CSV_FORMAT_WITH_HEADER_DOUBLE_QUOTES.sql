CREATE OR REPLACE FILE FORMAT DISC_PROD.PUBLIC.MY_CSV_FORMAT_WITH_HEADER_DOUBLE_QUOTES
	TYPE = csv
	FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
	NULL_IF = ('NULL', 'null')
;