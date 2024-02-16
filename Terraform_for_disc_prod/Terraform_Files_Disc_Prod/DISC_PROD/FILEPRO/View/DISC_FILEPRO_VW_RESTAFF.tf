resource "snowflake_view" "DISC_FILEPRO_VW_RESTAFF" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "FILEPRO"
	name = "VW_RESTAFF"
	statement = <<-SQL
	 
select t.$1	as	"Client Name"	,
t.$2	as	"Client Address"	,
t.$3	as	"Client Phone"	,
t.$4	as	"Serv. Type"	,
t.$5	as	"Hours of Service"	,
SUBSTR(t.$6,1,4)||'-'||SUBSTR(T.$6,5,2)||'-'||SUBSTR(T.$6,7,2) as "Date"		,
t.$7	as	"Action Type"	,
t.$8	as	"Service Schedule"	,
t.$9	as	"Desk"	,
t.$10	as	"Worker"	,
t.$11	as	"Worker Name"	,
t.$12	as	"Comments"	,
t.$13	as	"City"	,
t.$14	as	"Max Units"	,
SUBSTR(t.$15,1,4)||'-'||SUBSTR(T.$15,5,2)||'-'||SUBSTR(T.$15,7,2) 	as	"Created On"	,
t.$16	as	"Created By"	,
SUBSTR(t.$17,1,4)||'-'||SUBSTR(T.$17,5,2)||'-'||SUBSTR(T.$17,7,2) 	as	"Updated On"	,
t.$18	as	"Updated By"	,
t.$19	as	"Sun",
t.$20	as	"Mon"	,
t.$21	as	"Tue"	,
t.$22	as	"Wed"	,
t.$23	as	"Thu"	,
t.$24	as	"Fri"	,
t.$25	as	"Sat"	,
t.$26	as	"Zip code"	,
t.$27	as	"Printed?"	,
t.$28	as	"UniqueID"	
 from @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/FilePro/ReStaff (file_format => DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT ) as t;
SQL
	or_replace = true 
	is_secure = false 
}

