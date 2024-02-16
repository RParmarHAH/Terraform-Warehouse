resource "snowflake_view" "DISC_FILEPRO_VW_EMPCALL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "FILEPRO"
	name = "VW_EMPCALL"
	statement = <<-SQL
	 select t.$1 AS Emp_Number,
t.$2 AS Reverse_Index_Key,
t.$3 AS Emp_Name,
t.$4 AS ReverseIndexKey,
t.$5 AS Date,
t.$6 AS Created_On,
t.$7 AS Created_By,
t.$8 AS Created_At,
t.$9 AS C1,
t.$10 AS C2,
t.$11 AS C3,
t.$12 AS C4,
t.$13 AS C5,
t.$14 AS C6,
t.$15 AS C7,
t.$16 AS C8,
t.$17 AS C9,
t.$18 AS C10,
t.$19 AS Locked,
t.$20 AS Admin_Code,
t.$21 AS Followup,
t.$22 AS Desk,
t.$23 AS Phone,
t.$24 AS Workmans_Comp_Claim,
t.$25 AS Refused_Hours,
t.$26 AS Posted_to_empWC,
t.$27 AS Fkeys_TXcode
from @DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/FilePro/empcall(file_format => DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT ) AS T;
SQL
	or_replace = true 
	is_secure = false 
}

