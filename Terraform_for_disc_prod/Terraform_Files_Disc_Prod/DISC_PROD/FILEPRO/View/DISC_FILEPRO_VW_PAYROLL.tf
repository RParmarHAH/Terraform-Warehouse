resource "snowflake_view" "DISC_FILEPRO_VW_PAYROLL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "FILEPRO"
	name = "VW_PAYROLL"
	statement = <<-SQL
	 
SELECT  
    t.$1 AS Emp
   ,t.$2 AS Filler
   ,t.$3 AS Employee_Name
   ,t.$4 AS Regular_hours
   ,t.$5 AS Special_Hours
   ,t.$6 AS Training
   ,t.$7 AS Mileage
   ,t.$8 AS Overtime
   ,t.$9 AS Supplemental_Earnings
   ,t.$10 AS Vacation_Pay
   ,t.$11 AS Chore_Holiday_Hours 
   ,t.$12 AS Home_Holiday_Hours
   ,t.$13 AS Travel
   ,t.$14 AS Home_Private_Pay 
   ,t.$15 AS Filler_CR
   FROM
@DISC_${var.SF_ENVIRONMENT}.STAGE.AZSTAGEPROD/FilePro/Payroll (file_format => DISC_${var.SF_ENVIRONMENT}.PUBLIC.CSV_FORMAT ) t;
SQL
	or_replace = true 
	is_secure = false 
}

