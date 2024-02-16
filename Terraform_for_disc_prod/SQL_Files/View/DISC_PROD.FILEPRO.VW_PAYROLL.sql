create or replace view DISC_PROD.FILEPRO.VW_PAYROLL(
	EMP,
	FILLER,
	EMPLOYEE_NAME,
	REGULAR_HOURS,
	SPECIAL_HOURS,
	TRAINING,
	MILEAGE,
	OVERTIME,
	SUPPLEMENTAL_EARNINGS,
	VACATION_PAY,
	CHORE_HOLIDAY_HOURS,
	HOME_HOLIDAY_HOURS,
	TRAVEL,
	HOME_PRIVATE_PAY,
	FILLER_CR
) as 
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
@DISC_PROD.STAGE.AZSTAGEPROD/FilePro/Payroll (file_format => DISC_PROD.PUBLIC.CSV_FORMAT ) t;