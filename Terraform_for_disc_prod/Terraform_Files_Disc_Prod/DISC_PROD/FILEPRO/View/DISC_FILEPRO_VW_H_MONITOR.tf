resource "snowflake_view" "DISC_FILEPRO_VW_H_MONITOR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "FILEPRO"
	name = "VW_H_MONITOR"
	statement = <<-SQL
	 
SELECT T.$1 AS "CLIENT NAME" ,
SUBSTR(T.$2,1,4)||'-'||SUBSTR(T.$2,5,2) AS DATE,
T.$3 AS "CREATED BY",
T.$4 AS "CREATED AT",
T.$5 AS "CREATED ON",
T.$6 AS "COMMENTS",
T.$7 AS "COMMENTS #2",
T.$8 AS "COMMENTS #3",
T.$9 AS "FOLLOWUP",
T.$10 AS "DESK", 
T.$11 AS "POSTED",
T.$12 AS "EMPLOYEE NAME",
T.$13 AS "EMPLOYEE #",
T.$14 AS "FKEYS/TXCODE"
FROM 
@DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/FilePro/HMonitor
(file_format => DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT ) AS T;
SQL
	or_replace = true 
	is_secure = false 
}

